from flask import Flask, render_template, jsonify, request
import requests
import json
import numpy as np
from typing import Dict, List
import traceback
import time

app = Flask(__name__)

# API Keys
API_KEYS = {
    'openrouteservice': 'eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6IjBiNTkxYjdkNjE0OTQ2YjRiNmIwY2NmN2JlYjFjMWVkIiwiaCI6Im11cm11cjY0In0='
}

def decode_polyline_3d(encoded):
    """Decode 3D polyline with elevation data"""
    index = 0
    lat = 0
    lng = 0
    elev = 0
    coordinates = []
    try:
        while index < len(encoded):
            for coord_type in range(3):
                shift = 0
                result = 0
                while True:
                    byte = ord(encoded[index]) - 63
                    index += 1
                    result |= (byte & 0x1f) << shift
                    shift += 5
                    if not byte >= 0x20:
                        break
                delta = (result >> 1) if (result & 1) == 0 else -(result >> 1)
                if coord_type == 0:
                    lat += delta
                elif coord_type == 1:
                    lng += delta
                else:
                    elev += delta
            coordinates.append([lat / 1e5, lng / 1e5, elev / 1000])
    except Exception as e:
        print(f"Error decoding polyline: {e}")
    return coordinates

def haversine(coord1, coord2):
    """Calculate distance between two coordinates in km"""
    R = 6371
    lat1, lon1 = np.radians([coord1[0], coord1[1]])
    lat2, lon2 = np.radians([coord2[0], coord2[1]])
    dlat, dlon = lat2 - lat1, lon2 - lon1
    a = np.sin(dlat/2)**2 + np.cos(lat1) * np.cos(lat2) * np.sin(dlon/2)**2
    c = 2 * np.arctan2(np.sqrt(a), np.sqrt(1-a))
    return R * c

def get_route_from_api(start_coord, end_coord):
    """Get route from OpenRouteService API"""
    try:
        params = {
            'coordinates': [[start_coord['lon'], start_coord['lat']], [end_coord['lon'], end_coord['lat']]],
            'elevation': True,
            'preference': 'fastest'
        }
        
        response = requests.post(
            'https://api.openrouteservice.org/v2/directions/driving-car',
            headers={
                'Authorization': API_KEYS['openrouteservice'],
                'Content-Type': 'application/json'
            },
            json=params,
            timeout=30
        )
        
        if response.status_code != 200:
            print(f"OpenRouteService error: {response.status_code}")
            return None
        
        route_data = response.json()
        return route_data.get('routes', [])[0] if route_data.get('routes') else None
        
    except Exception as e:
        print(f"Error fetching route: {e}")
        return None

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/route', methods=['POST'])
def calculate_route():
    try:
        data = request.json
        start_lat = float(data.get('start_lat'))
        start_lon = float(data.get('start_lon'))
        end_lat = float(data.get('end_lat'))
        end_lon = float(data.get('end_lon'))
        
        start_coord = {'lat': start_lat, 'lon': start_lon}
        end_coord = {'lat': end_lat, 'lon': end_lon}
        
        route_data = get_route_from_api(start_coord, end_coord)
        
        if not route_data:
            return jsonify({'success': False, 'error': 'Could not fetch route'}), 500
            
        geometry = route_data['geometry']
        all_points = decode_polyline_3d(geometry)
        
        if not all_points:
            return jsonify({'success': False, 'error': 'No points in route'}), 500
            
        # Calculate intermediate points (5 points)
        # We'll sample 5 points excluding start and end
        intermediate_points = []
        if len(all_points) > 2:
            # Calculate cumulative distances to sample evenly by distance
            cum_dists = [0.0]
            for i in range(1, len(all_points)):
                dist = haversine(all_points[i-1][:2], all_points[i][:2])
                cum_dists.append(cum_dists[-1] + dist)
            
            total_dist = cum_dists[-1]
            if total_dist > 0:
                # Sample at 20%, 40%, 60%, 80%, and maybe middle or spread them out
                # Let's do 1/6, 2/6, 3/6, 4/6, 5/6 of the distance
                sample_fractions = [1/6, 2/6, 3/6, 4/6, 5/6]
                for frac in sample_fractions:
                    target_dist = total_dist * frac
                    idx = np.argmin(np.abs(np.array(cum_dists) - target_dist))
                    pt = all_points[idx]
                    intermediate_points.append({'lat': pt[0], 'lon': pt[1], 'elev': pt[2]})

        return jsonify({
            'success': True,
            'route_coordinates': [[pt[0], pt[1]] for pt in all_points],
            'intermediate_points': intermediate_points,
            'summary': route_data['summary']
        })
        
    except Exception as e:
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/api/eta', methods=['POST'])
def get_eta():
    """
    Get Estimated Time of Arrival (ETA) between two locations.
    
    Request JSON body:
    {
        "start_lat": 12.9716,
        "start_lon": 77.5946,
        "end_lat": 13.0827,
        "end_lon": 80.2707
    }
    
    Response:
    {
        "success": true,
        "eta": {
            "duration_seconds": 18000,
            "duration_minutes": 300,
            "duration_hours": 5.0,
            "formatted_time": "5 hours 0 minutes",
            "distance_km": 350.5,
            "distance_meters": 350500
        },
        "start_location": {"lat": 12.9716, "lon": 77.5946},
        "end_location": {"lat": 13.0827, "lon": 80.2707}
    }
    """
    try:
        data = request.json
        
        # Validate required fields
        required_fields = ['start_lat', 'start_lon', 'end_lat', 'end_lon']
        for field in required_fields:
            if field not in data:
                return jsonify({
                    'success': False, 
                    'error': f'Missing required field: {field}'
                }), 400
        
        start_lat = float(data.get('start_lat'))
        start_lon = float(data.get('start_lon'))
        end_lat = float(data.get('end_lat'))
        end_lon = float(data.get('end_lon'))
        
        # Validate coordinate ranges
        if not (-90 <= start_lat <= 90) or not (-90 <= end_lat <= 90):
            return jsonify({
                'success': False, 
                'error': 'Latitude must be between -90 and 90'
            }), 400
            
        if not (-180 <= start_lon <= 180) or not (-180 <= end_lon <= 180):
            return jsonify({
                'success': False, 
                'error': 'Longitude must be between -180 and 180'
            }), 400
        
        # Call OpenRouteService API
        params = {
            'coordinates': [[start_lon, start_lat], [end_lon, end_lat]],
            'preference': 'fastest'
        }
        
        response = requests.post(
            'https://api.openrouteservice.org/v2/directions/driving-car',
            headers={
                'Authorization': API_KEYS['openrouteservice'],
                'Content-Type': 'application/json'
            },
            json=params,
            timeout=30
        )
        
        if response.status_code != 200:
            error_msg = f"OpenRouteService API error: {response.status_code}"
            try:
                error_data = response.json()
                if 'error' in error_data:
                    error_msg = error_data['error'].get('message', error_msg)
            except:
                pass
            return jsonify({'success': False, 'error': error_msg}), 500
        
        route_data = response.json()
        
        if not route_data.get('routes'):
            return jsonify({
                'success': False, 
                'error': 'No route found between the given locations'
            }), 404
        
        # Extract summary data
        summary = route_data['routes'][0]['summary']
        duration_seconds = summary.get('duration', 0)  # Duration in seconds
        distance_meters = summary.get('distance', 0)   # Distance in meters
        
        # Calculate formatted time
        hours = int(duration_seconds // 3600)
        minutes = int((duration_seconds % 3600) // 60)
        
        if hours > 0:
            formatted_time = f"{hours} hour{'s' if hours > 1 else ''} {minutes} minute{'s' if minutes != 1 else ''}"
        else:
            formatted_time = f"{minutes} minute{'s' if minutes != 1 else ''}"
        
        # Calculate ETA (current time + duration)
        from datetime import datetime, timedelta
        current_time = datetime.now()
        eta_time = current_time + timedelta(seconds=duration_seconds)
        
        return jsonify({
            'success': True,
            'eta': {
                'duration_seconds': duration_seconds,
                'duration_minutes': round(duration_seconds / 60, 2),
                'duration_hours': round(duration_seconds / 3600, 2),
                'formatted_duration': formatted_time,
                'distance_km': round(distance_meters / 1000, 2),
                'distance_meters': distance_meters,
                'estimated_arrival_time': eta_time.strftime('%Y-%m-%d %H:%M:%S'),
                'departure_time': current_time.strftime('%Y-%m-%d %H:%M:%S')
            },
            'start_location': {'lat': start_lat, 'lon': start_lon},
            'end_location': {'lat': end_lat, 'lon': end_lon}
        })
        
    except ValueError as e:
        return jsonify({
            'success': False, 
            'error': 'Invalid coordinate values. Please provide valid numbers.'
        }), 400
    except Exception as e:
        traceback.print_exc()
        return jsonify({'success': False, 'error': str(e)}), 500


if __name__ == '__main__':
    app.run(debug=True, port=5000)
