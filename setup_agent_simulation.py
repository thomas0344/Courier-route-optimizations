"""
Agent Route Simulation System - Quick Setup Script
Runs the database updates needed for the agent route simulation system
"""

from config import Database

def setup_database():
    """Create the new tables and update existing ones"""
    
    print("🚀 Starting Agent Route Simulation Database Setup...")
    print("=" * 60)
    
    db = Database()
    
    try:
        # Test connection
        print("\n1. Testing database connection...")
        conn = db.connect()
        print("   ✅ Database connection successful!")
        conn.close()
        
        # Create route_simulation table
        print("\n2. Creating route_simulation table...")
        create_simulation_table = """
        CREATE TABLE IF NOT EXISTS `route_simulation` (
          `id` int(11) NOT NULL AUTO_INCREMENT,
          `journey_master_id` int(11) NOT NULL,
          `agent_id` int(11) NOT NULL,
          `current_location` varchar(500) DEFAULT NULL,
          `current_latitude` decimal(10,8) DEFAULT NULL,
          `current_longitude` decimal(11,8) DEFAULT NULL,
          `current_stop_index` int(11) DEFAULT 0,
          `simulation_status` enum('not_started','in_progress','paused','completed') DEFAULT 'not_started',
          `started_at` datetime DEFAULT NULL,
          `paused_at` datetime DEFAULT NULL,
          `completed_at` datetime DEFAULT NULL,
          `pause_duration_seconds` int(11) DEFAULT 0,
          `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
          PRIMARY KEY (`id`),
          KEY `journey_master_id` (`journey_master_id`),
          KEY `agent_id` (`agent_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
        """
        db.execute(create_simulation_table)
        print("   ✅ route_simulation table created/verified!")
        
        # Create agent_messages table
        print("\n3. Creating agent_messages table...")
        create_messages_table = """
        CREATE TABLE IF NOT EXISTS `agent_messages` (
          `id` int(11) NOT NULL AUTO_INCREMENT,
          `agent_id` int(11) NOT NULL,
          `admin_id` int(11) DEFAULT NULL,
          `message` text NOT NULL,
          `sender_type` enum('agent','admin') NOT NULL,
          `journey_master_id` int(11) DEFAULT NULL,
          `is_read` tinyint(1) DEFAULT 0,
          `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
          PRIMARY KEY (`id`),
          KEY `agent_id` (`agent_id`),
          KEY `journey_master_id` (`journey_master_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
        """
        db.execute(create_messages_table)
        print("   ✅ agent_messages table created/verified!")
        
        # Create route_stop_tracking table
        print("\n4. Creating route_stop_tracking table...")
        create_tracking_table = """
        CREATE TABLE IF NOT EXISTS `route_stop_tracking` (
          `id` int(11) NOT NULL AUTO_INCREMENT,
          `journey_child_id` int(11) NOT NULL,
          `journey_master_id` int(11) NOT NULL,
          `arrived_at` datetime DEFAULT NULL,
          `departed_at` datetime DEFAULT NULL,
          `status` enum('pending','in_transit','arrived','completed','skipped') DEFAULT 'pending',
          `notes` text DEFAULT NULL,
          `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
          PRIMARY KEY (`id`),
          KEY `journey_child_id` (`journey_child_id`),
          KEY `journey_master_id` (`journey_master_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
        """
        db.execute(create_tracking_table)
        print("   ✅ route_stop_tracking table created/verified!")
        
        # Update journey_master table - Add columns if they don't exist
        print("\n5. Updating journey_master table...")
        try:
            # Check if columns exist
            check_columns = "SHOW COLUMNS FROM journey_master LIKE 'estimated_time_minutes'"
            result = db.fetchone(check_columns)
            
            if not result:
                alter_journey_master = """
                ALTER TABLE `journey_master` 
                ADD COLUMN `estimated_time_minutes` int(11) DEFAULT NULL COMMENT 'Estimated time in minutes',
                ADD COLUMN `estimated_distance_km` decimal(8,2) DEFAULT NULL COMMENT 'Estimated distance in kilometers'
                """
                db.execute(alter_journey_master)
                print("   ✅ journey_master table updated with new columns!")
            else:
                print("   ℹ️  journey_master columns already exist, skipping...")
        except Exception as e:
            print(f"   ⚠️  Could not update journey_master: {e}")
            print("   ℹ️  This is okay if columns already exist")
        
        # Update journey_child table
        print("\n6. Updating journey_child table...")
        try:
            check_columns = "SHOW COLUMNS FROM journey_child LIKE 'actual_delivery_time'"
            result = db.fetchone(check_columns)
            
            if not result:
                alter_journey_child = """
                ALTER TABLE `journey_child` 
                ADD COLUMN `actual_delivery_time` datetime DEFAULT NULL,
                ADD COLUMN `delivery_notes` text DEFAULT NULL
                """
                db.execute(alter_journey_child)
                print("   ✅ journey_child table updated with new columns!")
            else:
                print("   ℹ️  journey_child columns already exist, skipping...")
        except Exception as e:
            print(f"   ⚠️  Could not update journey_child: {e}")
            print("   ℹ️  This is okay if columns already exist")
        
        # Verify tables were created
        print("\n7. Verifying table creation...")
        tables_query = "SHOW TABLES LIKE 'route_%' OR SHOW TABLES LIKE 'agent_messages'"
        
        verify_queries = [
            ("route_simulation", "SELECT COUNT(*) as count FROM route_simulation"),
            ("agent_messages", "SELECT COUNT(*) as count FROM agent_messages"),
            ("route_stop_tracking", "SELECT COUNT(*) as count FROM route_stop_tracking")
        ]
        
        for table_name, query in verify_queries:
            try:
                result = db.fetchone(query)
                print(f"   ✅ {table_name} verified - {result['count']} records")
            except Exception as e:
                print(f"   ❌ {table_name} verification failed: {e}")
        
        print("\n" + "=" * 60)
        print("🎉 Database setup completed successfully!")
        print("\nNext steps:")
        print("  1. Run: python app.py")
        print("  2. Login as an agent")
        print("  3. Navigate to /agent/routes")
        print("  4. Select a route and start simulation!")
        print("\n📖 See AGENT_ROUTE_SIMULATION_README.md for full documentation")
        print("=" * 60)
        
        return True
        
    except Exception as e:
        print(f"\n❌ Error during setup: {e}")
        import traceback
        traceback.print_exc()
        return False

if __name__ == "__main__":
    print("""
    ╔════════════════════════════════════════════════════════════╗
    ║   Agent Route Simulation System - Database Setup          ║
    ║                                                            ║
    ║   This will create 3 new tables and update 2 existing     ║
    ║   tables in your db_route_optimization database           ║
    ╚════════════════════════════════════════════════════════════╝
    """)
    
    confirmation = input("\n⚠️  Continue with database setup? (yes/no): ")
    
    if confirmation.lower() in ['yes', 'y']:
        success = setup_database()
        if not success:
            print("\n⚠️  Setup encountered errors. Please check the messages above.")
    else:
        print("\n❌ Setup cancelled by user")
