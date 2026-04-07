import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.ensemble import RandomForestClassifier, RandomForestRegressor
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
import joblib

# Function to categorize vehicle_type into small, medium, heavy (for initial labeling)
def get_vehicle_size(vehicle_type):
    vt_lower = vehicle_type.lower()
    if any(keyword in vt_lower for keyword in ['mini', 'small', 'n1i', 'moped', '<250', 'microcar', '2stroke', '4stroke <250']):
        return 'small'
    elif any(keyword in vt_lower for keyword in ['medium', 'n1ii', '250750']):
        return 'medium'
    elif any(keyword in vt_lower for keyword in ['large', 'heavy', 'bus', 'truck', 'n1iii', '>750', 'suv', 'articulated', 'coaches']):
        return 'heavy'
    return 'other'

# Load the derived dataset
df = pd.read_csv('derived_dataset.csv')

# Add initial vehicle_size column using the function
df['vehicle_size'] = df['vehicle_type'].apply(get_vehicle_size)

# Now, train a model to predict vehicle_size from vehicle_type string
# Vectorize vehicle_type
vectorizer = TfidfVectorizer()
X_text = vectorizer.fit_transform(df['vehicle_type'])

le_size_target = LabelEncoder()
y_size = le_size_target.fit_transform(df['vehicle_size'])

# Train size predictor model
X_train_size, X_test_size, y_train_size, y_test_size = train_test_split(X_text, y_size, test_size=0.2, random_state=42)
size_model = RandomForestClassifier(random_state=42)
size_model.fit(X_train_size, y_train_size)

# Now, for CO2 model: encode features
le_fuel = LabelEncoder()
df['fuel_type_encoded'] = le_fuel.fit_transform(df['fuel_type'])

# Use the encoded vehicle_size for CO2 model (from initial labels)
df['vehicle_size_encoded'] = le_size_target.transform(df['vehicle_size'])  # same encoder as target

X_co2 = df[['age', 'fuel_type_encoded', 'vehicle_size_encoded']]
y_co2 = df['co2_g_per_km']

X_train_co2, X_test_co2, y_train_co2, y_test_co2 = train_test_split(X_co2, y_co2, test_size=0.2, random_state=42)

co2_model = RandomForestRegressor(random_state=42)
co2_model.fit(X_train_co2, y_train_co2)

# Save everything in one single PKL file
single_model = {
    'size_vectorizer': vectorizer,
    'size_model': size_model,
    'le_size': le_size_target,
    'le_fuel': le_fuel,
    'co2_model': co2_model
}

joblib.dump(single_model, 'single_carbon_model.pkl')

print("Single model saved as 'single_carbon_model.pkl'")