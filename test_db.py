#!/usr/bin/env python3
"""
Test script to verify database connection and table creation
"""

from config import Database

def test_database_connection():
    """Test database connection and create tables"""
    try:
        db = Database()
        
        # Test connection
        conn = db.connect()
        print("✅ Database connection successful!")
        conn.close()
        
        # Create locations table
        create_locations_table = """
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
        db.execute(create_locations_table)
        print("✅ Locations table created/verified!")
        
        # Insert sample location
        sample_location = """
        INSERT INTO locations (name, address, type, latitude, longitude) 
        VALUES ('Test Location', '123 Test St', 'warehouse', 40.7128, -74.0060)
        """
        try:
            db.execute(sample_location)
            print("✅ Sample location inserted!")
        except Exception as e:
            if "Duplicate entry" in str(e):
                print("ℹ️  Sample location already exists")
            else:
                print(f"⚠️  Could not insert sample location: {e}")
        
        # Test fetching locations
        locations = db.fetchall("SELECT * FROM locations LIMIT 5")
        print(f"✅ Found {len(locations)} locations in database")
        
        print("\n🎉 Database setup completed successfully!")
        return True
        
    except Exception as e:
        print(f"❌ Database error: {e}")
        return False

if __name__ == "__main__":
    print("Testing database connection...")
    test_database_connection()

