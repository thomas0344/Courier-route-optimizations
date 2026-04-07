# Project Workflow & Operations Guide

## 1. Initial Setup
1. **Database Configuration**:
   - Import the schema from `db_route_optimization.sql`.
   - Update `config.py` with your MySQL credentials.
2. **Environment**:
   - Install dependencies: `pip install -r requirements.txt`.
   - Set the `OPENROUTE_API_KEY` in `app.py`.
3. **ML Initialization**:
   - Ensure `route_optimizer_model.pkl` and `single_carbon_model.pkl` are present in the root directory.

## 2. Model Training Workflow
### 2.1 Carbon Model Training
If the vehicle dataset changes:
1. Run `python derive.py` to generate the new `derived_dataset.csv`.
2. Run `python capp.py` to retrain the carbon classification and regression models and update `single_carbon_model.pkl`.

### 2.2 ETA Model Training
- Open `route_optimization (1).ipynb` in a Jupyter environment.
- Run all cells to process traffic data and update `route_optimizer_model.pkl`.

## 3. Operational Workflow
### 3.1 Manager Workflow
1. **Login**: Access the manager portal.
2. **Manage Entities**: Add/Update Locations, Vehicles, Agents, and Goods.
3. **Route Assignment**:
   - Create a New Route.
   - Select a Start Location and a Vehicle.
   - Assign the route to an Agent.
   - Add delivery stops (Goods + Location combinations).

### 3.2 Agent Workflow
1. **Dashboard**: Login to see assigned routes.
2. **Optimization**:
   - Select a route and click "Optimize Route".
   - Review the ML-enhanced sequence and Carbon Footprint analysis.
   - Click "Save Optimization" to lock in the waypoints.
3. **Simulation/Navigation**:
   - Start the route simulation to log progress.
   - Use the "Start Navigation" button to open Google Maps for the current segment.

## 4. Carbon Offsetting Workflow
1. After route optimization, the system displays the "Total Carbon Footprint".
2. The "Trees to offset" metric provides a recommendation (e.g., "5 trees/year").
3. Organizations can use this data to fund tree-planting initiatives or purchase corresponding carbon credits.

---
*Workflow guide for Route Optimization Project © 2024*
