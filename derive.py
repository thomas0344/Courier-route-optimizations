import pandas as pd

def get_intro_year(category, euro_standard):
    euro_lower = euro_standard.lower()
    cat_lower = category.lower()
    
    if 'passenger' in cat_lower or 'light commercial' in cat_lower:
        if 'pre ece' in euro_lower:
            return 1970
        elif 'ece 15/00' in euro_lower:
            return 1979
        elif 'ece 15/02' in euro_lower:
            return 1981
        elif 'ece 15/03' in euro_lower:
            return 1985
        elif 'ece 15/04' in euro_lower:
            return 1987
        elif 'improved conventional' in euro_lower:
            return 1990
        elif 'open loop' in euro_lower:
            return 1990
        elif 'conventional' in euro_lower:
            return 1980
        elif 'euro 1' in euro_lower:
            return 1992 if 'passenger' in cat_lower else 1993
        elif 'euro 2' in euro_lower:
            return 1996 if 'passenger' in cat_lower else 1997
        elif 'euro 3' in euro_lower:
            return 2000
        elif 'euro 4' in euro_lower:
            return 2005
        elif 'euro 5' in euro_lower:
            return 2009
        elif 'euro 6 a/b/c' in euro_lower:
            return 2014
        elif 'euro 6 d-temp' in euro_lower:
            return 2017
        elif 'euro 6 d' in euro_lower or 'euro 6 e' in euro_lower:
            return 2020
        elif 'euro 7' in euro_lower:
            return 2026
    elif 'heavy duty' in cat_lower or 'buses' in cat_lower:
        if 'conventional' in euro_lower:
            return 1988
        elif 'euro i' in euro_lower:
            return 1992
        elif 'euro ii' in euro_lower:
            return 1995
        elif 'euro iii' in euro_lower:
            return 2000
        elif 'euro iv' in euro_lower:
            return 2005
        elif 'euro v' in euro_lower:
            return 2008
        elif 'euro vi a/b/c' in euro_lower:
            return 2012
        elif 'euro vi d' in euro_lower:
            return 2018
        elif 'euro vii' in euro_lower:
            return 2026
        elif 'eev' in euro_lower:
            return 1999
    elif 'l-category' in cat_lower:
        if 'conventional' in euro_lower:
            return 1990
        elif 'euro 1' in euro_lower:
            return 1999
        elif 'euro 2' in euro_lower:
            return 2003
        elif 'euro 3' in euro_lower:
            return 2006
        elif 'euro 4' in euro_lower:
            return 2016
        elif 'euro 5' in euro_lower:
            return 2020
        elif 'euro 7' in euro_lower:
            return 2026
    return 1990  # default for unknown

def get_co2_g_per_km(category, fuel, segment, euro_standard):
    fuel_lower = fuel.lower()
    euro_lower = euro_standard.lower()
    cat_lower = category.lower()
    seg_lower = segment.lower()
    
    if 'electric' in fuel_lower or 'cell' in fuel_lower:
        return 0
    if 'phev' in fuel_lower or 'plug-in' in fuel_lower:
        return 42
    if 'hybrid' in fuel_lower:
        if 'petrol' in fuel_lower:
            return 92
        else:
            return 110
    
    level = 0
    if 'euro 1' in euro_lower or 'euro i' in euro_lower:
        level = 1
    elif 'euro 2' in euro_lower or 'euro ii' in euro_lower:
        level = 2
    elif 'euro 3' in euro_lower or 'euro iii' in euro_lower:
        level = 3
    elif 'euro 4' in euro_lower or 'euro iv' in euro_lower:
        level = 4
    elif 'euro 5' in euro_lower or 'euro v' in euro_lower:
        level = 5
    elif 'euro 6' in euro_lower or 'euro vi' in euro_lower:
        level = 6
    elif 'euro 7' in euro_lower or 'euro vii' in euro_lower:
        level = 7
    
    if 'passenger' in cat_lower:
        if 'petrol' in fuel_lower:
            base = 210
            reduction = 13
            return max(100, base - reduction * level)
        elif 'diesel' in fuel_lower:
            base = 170
            reduction = 6
            return max(100, base - reduction * level)
        elif 'cng' in fuel_lower:
            return max(100, 150 - 10 * level)
    elif 'light commercial' in cat_lower:
        if 'petrol' in fuel_lower:
            return max(140, 190 - 10 * level)
        elif 'diesel' in fuel_lower:
            return max(120, 170 - 5 * level)
    elif 'heavy duty' in cat_lower or 'buses' in cat_lower:
        if 'diesel' in fuel_lower or 'biodiesel' in fuel_lower:
            base = 850
            reduction = 30
            return max(500, base - reduction * level)
        if 'cng' in fuel_lower:
            return max(700, 920 - 20 * level)
    elif 'l-category' in cat_lower:
        if 'petrol' in fuel_lower:
            if 'moped' in seg_lower or '2-stroke' in seg_lower or 'micro-car' in seg_lower:
                return max(50, 70 - 2 * level)
            else:
                return max(100, 160 - 10 * level)
    return 150  # default

# Load the Excel file
file_path = './Sample_1990_2022.xlsx'
df_stock = pd.read_excel(file_path, sheet_name='STOCK')

# Get unique combinations
unique_vehicles = df_stock[['Category', 'Fuel', 'Segment', 'Euro Standard']].drop_duplicates()

# Create lists for the new dataset
vehicle_types = []
ages = []
fuel_types = []
co2_emissions = []

for _, row in unique_vehicles.iterrows():
    category = row['Category']
    fuel = row['Fuel']
    segment = row['Segment']
    euro_standard = row['Euro Standard']
    
    vehicle_type = f"{category} {segment} {fuel} {euro_standard}".replace('-', '').replace('  ', ' ').strip()
    fuel_type = fuel.replace(' (NOVC)', '').replace('Bifuel', 'Bi-fuel').strip()
    intro_year = get_intro_year(category, euro_standard)
    age = max(0, 2025 - intro_year)
    co2 = get_co2_g_per_km(category, fuel, segment, euro_standard)
    
    vehicle_types.append(vehicle_type)
    ages.append(age)
    fuel_types.append(fuel_type)
    co2_emissions.append(co2)

# Create DataFrame
df_new = pd.DataFrame({
    'vehicle_type': vehicle_types,
    'age': ages,
    'fuel_type': fuel_types,
    'co2_g_per_km': co2_emissions
})

# To ensure at least 1000 rows, sample with replacement if necessary
if len(df_new) < 1000:
    additional_rows = 1000 - len(df_new)
    df_additional = df_new.sample(n=additional_rows, replace=True)
    df_new = pd.concat([df_new, df_additional], ignore_index=True)

# Shuffle to mix duplicates
df_new = df_new.sample(frac=1).reset_index(drop=True)

# Save to CSV or print
df_new.to_csv('derived_dataset.csv', index=False)
print(f"Dataset created with {len(df_new)} rows.")
print(df_new.head(20))