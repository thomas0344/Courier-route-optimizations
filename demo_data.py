#!/usr/bin/env python3
"""
Demo data script to populate the database with sample data
"""

from config import Database

def create_demo_data():
    """Create demo data for testing"""
    try:
        db = Database()
        
        # Create tables
        print("Creating database tables...")
        
        # Locations table
        create_locations = """
        CREATE TABLE IF NOT EXISTS locations (
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(255) NOT NULL,
            address TEXT,
            type VARCHAR(50),
            latitude DECIMAL(10, 8) NOT NULL,
            longitude DECIMAL(11, 8) NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
        """
        db.execute(create_locations)
        print("✅ Locations table created")
        
        # Login table (if not exists)
        create_login = """
        CREATE TABLE IF NOT EXISTS tbl_login (
            id INT AUTO_INCREMENT PRIMARY KEY,
            username VARCHAR(50) NOT NULL UNIQUE,
            password VARCHAR(255) NOT NULL,
            role ENUM('manager', 'agent') NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
        """
        db.execute(create_login)
        print("✅ Login table created")
        
        # Routes table
        create_routes = """
        CREATE TABLE IF NOT EXISTS routes (
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(255) NOT NULL,
            agent_id INT,
            status ENUM('pending', 'active', 'paused', 'completed') DEFAULT 'pending',
            distance DECIMAL(8, 2),
            estimated_time VARCHAR(50),
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        )
        """
        db.execute(create_routes)
        print("✅ Routes table created")
        
        # Insert demo users
        print("Inserting demo users...")
        users = [
            ("manager", "password123", "manager"),
            ("agent1", "password123", "agent"),
            ("agent2", "password123", "agent")
        ]
        
        for username, password, role in users:
            try:
                insert_user = f"""
                INSERT INTO tbl_login (username, password, role) 
                VALUES ('{username}', '{password}', '{role}')
                """
                db.execute(insert_user)
                print(f"✅ User {username} created")
            except Exception as e:
                if "Duplicate entry" in str(e):
                    print(f"ℹ️  User {username} already exists")
                else:
                    print(f"⚠️  Error creating user {username}: {e}")
        
        # Insert demo locations
        print("Inserting demo locations...")
        locations = [
            ("Central Warehouse", "123 Industrial Blvd, New York, NY", "warehouse", 40.7128, -74.0060),
            ("Downtown Office", "456 Main St, New York, NY", "office", 40.7589, -73.9851),
            ("Customer A", "789 Oak Ave, New York, NY", "delivery", 40.7505, -73.9934),
            ("Customer B", "321 Pine St, New York, NY", "delivery", 40.7614, -73.9776),
            ("Customer C", "654 Elm St, New York, NY", "pickup", 40.7282, -73.7949),
            ("Customer D", "987 Maple Dr, New York, NY", "delivery", 40.7831, -73.9712),
            ("Customer E", "147 Cedar Ln, New York, NY", "pickup", 40.6892, -74.0445)
        ]
        
        for name, address, loc_type, lat, lng in locations:
            try:
                insert_location = f"""
                INSERT INTO locations (name, address, type, latitude, longitude) 
                VALUES ('{name}', '{address}', '{loc_type}', {lat}, {lng})
                """
                db.execute(insert_location)
                print(f"✅ Location {name} created")
            except Exception as e:
                if "Duplicate entry" in str(e):
                    print(f"ℹ️  Location {name} already exists")
                else:
                    print(f"⚠️  Error creating location {name}: {e}")
        
        # Insert demo routes
        print("Inserting demo routes...")
        routes = [
            ("Morning Delivery Route", 2, "active", 15.2, "2.5 hours"),
            ("Afternoon Pickup Route", 3, "pending", 8.7, "1.5 hours")
        ]
        
        for name, agent_id, status, distance, time in routes:
            try:
                insert_route = f"""
                INSERT INTO routes (name, agent_id, status, distance, estimated_time) 
                VALUES ('{name}', {agent_id}, '{status}', {distance}, '{time}')
                """
                db.execute(insert_route)
                print(f"✅ Route {name} created")
            except Exception as e:
                if "Duplicate entry" in str(e):
                    print(f"ℹ️  Route {name} already exists")
                else:
                    print(f"⚠️  Error creating route {name}: {e}")
        
        print("\n🎉 Demo data setup completed successfully!")
        print("\nLogin credentials:")
        print("Manager: username='manager', password='password123'")
        print("Agent 1: username='agent1', password='password123'")
        print("Agent 2: username='agent2', password='password123'")
        
        return True
        
    except Exception as e:
        print(f"❌ Error setting up demo data: {e}")
        return False

if __name__ == "__main__":
    print("Setting up demo data for Route Optimization System...")
    create_demo_data()

