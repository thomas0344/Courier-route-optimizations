# predict_final.py
import joblib
import numpy as np

# Load the single model
pkg = joblib.load('single_carbon_model.pkl')

# Extract components
vectorizer = pkg['size_vectorizer']
size_model = pkg['size_model']
le_size = pkg['le_size']
le_fuel = pkg['le_fuel']
co2_model = pkg['co2_model']

def predict_emission(age: int, fuel_type: str, vehicle_description: str):
    """
    Predict vehicle size class and CO₂ emissions (g/km)
    
    Parameters:
        age (int): Vehicle age in 2025 (e.g., 15 = manufactured ~2010)
        fuel_type (str): Exact fuel name like 'Petrol', 'Diesel', 'Battery Electric', 'CNG'
        vehicle_description (str): Full vehicle name, e.g. "Passenger Cars Large SUV Diesel Euro 6"
    
    Returns:
        size_class, co2_g_per_km
    """
    # Step 1: Predict size (small/medium/heavy) from text
    text_vec = vectorizer.transform([vehicle_description])
    size_encoded = size_model.predict(text_vec)[0]
    size_class = le_size.inverse_transform([size_encoded])[0]

    # Step 2: Encode fuel type
    try:
        fuel_encoded = le_fuel.transform([fuel_type])[0]
    except ValueError:
        raise ValueError(f"Unknown fuel type: '{fuel_type}'. Available: {list(le_fuel.classes_)}")

    # Step 3: Predict CO₂ (suppress warning by using correct format)
    features = np.array([[age, fuel_encoded, size_encoded]])
    co2_pred = co2_model.predict(features)[0]

    return size_class.upper(), round(co2_pred, 1)


# ————————————————————————
# REAL-WORLD EXAMPLES
# ————————————————————————
print("CO₂ EMISSION PREDICTION MODEL")
print("=" * 65)

examples = [
    (15, "Petrol", "Passenger Cars Small Petrol Euro 4"),
    (5,  "Diesel", "Passenger Cars Large-SUV-Executive Diesel Euro 6d"),
    (3,  "Battery Electric", "Passenger Cars Medium BEV Euro 6"),
    (8,  "CNG", "Urban Buses Standard 15-18 t CNG Euro VI"),
    (25, "Petrol", "Passenger Cars Mini Petrol Conventional"),
    (10, "Petrol Hybrid", "Passenger Cars Medium Petrol Hybrid Euro 6"),
    (7,  "Diesel", "Heavy Duty Trucks Rigid 20-26 t Diesel Euro VI"),
    (20, "LPG Bi-fuel", "Light Commercial Vehicles N1-II LPG Bifuel Euro 4"),
]

for age, fuel, desc in examples:
    try:
        size, co2 = predict_emission(age, fuel, desc)
        print(f"{age:2d} yr │ {fuel:18} │ {size:6} │ {desc[:45]:45} → {co2:4} g CO₂/km")
    except Exception as e:
        print(f"ERROR → {desc[:50]} → {e}")

print("=" * 65)
print("Model ready! You can now predict any vehicle in the world.")