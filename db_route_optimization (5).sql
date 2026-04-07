-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 16, 2026 at 08:19 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_route_optimization`
--

-- --------------------------------------------------------

--
-- Table structure for table `goods`
--

CREATE TABLE `goods` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `weight` decimal(8,2) NOT NULL,
  `category` enum('electronics','furniture','groceries','clothing','medical','other') NOT NULL,
  `description` text DEFAULT NULL,
  `status` enum('available','in_transit','delivered') DEFAULT 'available'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `goods`
--

INSERT INTO `goods` (`id`, `name`, `weight`, `category`, `description`, `status`) VALUES
(1, 'apple', 120.00, 'groceries', 'good', 'in_transit'),
(2, 'tv', 120.00, 'electronics', 'electron', 'in_transit'),
(3, 'laptop', 500.00, 'electronics', 'good one', 'in_transit'),
(4, 'dress', 800.00, 'clothing', 'cloth', 'in_transit'),
(5, 'chair', 78.00, 'furniture', 'best', 'in_transit'),
(6, 'table', 78.00, 'furniture', 'furniture', 'in_transit'),
(7, 'geans', 14.00, 'clothing', 'good', 'in_transit'),
(8, 'shirt', 12.00, 'clothing', 'good', 'in_transit'),
(9, 'top', 45.00, 'clothing', 'good', 'in_transit'),
(10, 'blue', 12.00, 'clothing', 'ddd', 'in_transit'),
(11, 'red', 12.00, 'clothing', 'fff', 'in_transit'),
(12, 'black', 25.00, 'medical', 'aa', 'in_transit'),
(13, 'cot', 25.00, 'furniture', 'ss', 'in_transit'),
(14, 'desk', 12.00, 'furniture', 'aa', 'in_transit'),
(15, 'phone', 100.00, 'electronics', 'kjj', 'in_transit'),
(16, 'oven', 10.00, 'electronics', 'hbjmk,', 'in_transit'),
(17, 'boat', 12.00, 'electronics', 'fghj', 'in_transit'),
(18, 'rice', 10.00, 'groceries', 'hjhj', 'in_transit'),
(19, 'phone', 10.00, 'electronics', 'good', 'in_transit'),
(20, 'rice', 10.00, 'groceries', 'good', 'in_transit'),
(21, 'grain', 50.00, 'groceries', 'best', 'in_transit'),
(22, 'barli', 12.00, 'groceries', 'dd', 'in_transit'),
(23, 'pickle', 12.00, 'groceries', 'ff', 'in_transit'),
(24, 'noodles', 23.00, 'groceries', 'ee', 'in_transit');

-- --------------------------------------------------------

--
-- Table structure for table `journey_child`
--

CREATE TABLE `journey_child` (
  `id` int(11) NOT NULL,
  `journey_master_id` varchar(300) NOT NULL,
  `location_id` varchar(300) NOT NULL,
  `goods_id` varchar(300) NOT NULL,
  `sequence_order` varchar(300) NOT NULL,
  `delivery_status` varchar(300) NOT NULL,
  `actual_arrival_time` timestamp NULL DEFAULT NULL,
  `stop_note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `journey_child`
--

INSERT INTO `journey_child` (`id`, `journey_master_id`, `location_id`, `goods_id`, `sequence_order`, `delivery_status`, `actual_arrival_time`, `stop_note`) VALUES
(1, '1', '3', '6', '1', 'pending', '2025-12-29 07:19:50', 'Arrived at delivery stop: Perumbavoor'),
(2, '1', '4', '1', '2', 'pending', '2025-12-29 07:20:30', 'Arrived at delivery stop: Aluva'),
(3, '1', '9', '2', '3', 'pending', NULL, NULL),
(4, '2', '2', '4', '1', 'pending', '2025-12-29 07:23:55', 'Arrived at delivery stop: kothamangalam'),
(5, '2', '4', '9', '2', 'pending', '2025-12-29 07:21:28', 'Arrived at delivery stop: Aluva'),
(6, '2', '6', '8', '3', 'pending', '2025-12-29 07:22:02', 'Arrived at delivery stop: Ernakulam'),
(9, '4', '2', '15', '1', 'pending', NULL, NULL),
(10, '4', '3', '11', '2', 'pending', NULL, NULL),
(11, '4', '4', '7', '3', 'pending', NULL, NULL),
(12, '4', '5', '17', '4', 'pending', NULL, NULL),
(13, '5', '3', '12', '1', 'pending', NULL, NULL),
(14, '5', '5', '14', '2', 'pending', NULL, NULL),
(15, '6', '2', '16', '1', 'pending', NULL, NULL),
(16, '6', '3', '18', '2', 'pending', NULL, NULL),
(17, '6', '4', '5', '3', 'pending', NULL, NULL),
(18, '7', '3', '3', '1', 'pending', NULL, NULL),
(19, '7', '4', '13', '2', 'pending', NULL, NULL),
(20, '7', '5', '10', '3', 'pending', NULL, NULL),
(21, '8', '3', '21', '1', 'pending', NULL, NULL),
(22, '8', '4', '20', '2', 'pending', NULL, NULL),
(23, '8', '5', '19', '3', 'pending', NULL, NULL),
(24, '9', '2', '23', '1', 'pending', NULL, NULL),
(25, '9', '3', '22', '2', 'pending', NULL, NULL),
(26, '9', '4', '24', '3', 'pending', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `journey_master`
--

CREATE TABLE `journey_master` (
  `id` int(11) NOT NULL,
  `route_name` varchar(300) NOT NULL,
  `start_location_id` varchar(300) NOT NULL,
  `vehicel_id` varchar(255) NOT NULL,
  `assigned_person_id` varchar(300) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `status` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `journey_master`
--

INSERT INTO `journey_master` (`id`, `route_name`, `start_location_id`, `vehicel_id`, `assigned_person_id`, `created_at`, `status`) VALUES
(1, 'first step', '2', '3', '3', '0000-00-00 00:00:00', 'pending'),
(2, '2 step', '5', '3', '3', '0000-00-00 00:00:00', 'pending'),
(4, '3 step', '7', '2', '3', '0000-00-00 00:00:00', 'pending'),
(5, '4 steps', '9', '3', '3', '0000-00-00 00:00:00', 'pending'),
(6, '5 step', '9', '1', '3', '0000-00-00 00:00:00', 'pending'),
(7, '6step', '2', '1', '3', '0000-00-00 00:00:00', 'pending'),
(8, '7 steps', '7', '3', '3', '0000-00-00 00:00:00', 'pending'),
(9, '8 steps', '6', '3', '3', '2026-01-16 12:46:53', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `journey_optimization_metadata`
--

CREATE TABLE `journey_optimization_metadata` (
  `id` int(11) NOT NULL,
  `journey_master_id` int(11) NOT NULL,
  `carbon_data` text DEFAULT NULL,
  `route_comparison` text DEFAULT NULL,
  `risk_analysis` text DEFAULT NULL,
  `recommended_analysis` text DEFAULT NULL,
  `segment_breakdown` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `journey_optimization_metadata`
--

INSERT INTO `journey_optimization_metadata` (`id`, `journey_master_id`, `carbon_data`, `route_comparison`, `risk_analysis`, `recommended_analysis`, `segment_breakdown`, `created_at`) VALUES
(1, 1, '{\"co2_g_per_km\": 0, \"has_prediction\": true, \"size_class\": \"MEDIUM\", \"total_carbon_kg\": 0, \"vehicle_age\": 3}', '[{\"type\": \"Optimized\", \"dist\": 154.01, \"time\": 185, \"eta\": 204}, {\"type\": \"Alternative (1)\", \"dist\": 177.11149999999998, \"time\": 213, \"eta\": 231}, {\"type\": \"Alternative (2)\", \"dist\": 192.5125, \"time\": 231, \"eta\": 259}]', '{\"optimized\": {\"road\": 35, \"surface\": 28, \"terrain\": 25}, \"alt1\": {\"road\": 45, \"surface\": 40, \"terrain\": 55}, \"alt2\": {\"road\": 50, \"surface\": 45, \"terrain\": 60}}', '{\"safety\": \"Low to medium risk factors detected. Route is safe for most vehicle types.\", \"time\": \"Estimated travel time: 185 minutes. Adjusted ETA accounts for traffic and road conditions.\", \"terrain\": \"Moderate terrain with minor elevation changes. Suitable for all vehicle types.\"}', '[{\"distance\": 18.14, \"duration\": 17.1, \"from\": \"kothamangalam\", \"to\": \"Perumbavoor\"}, {\"distance\": 17.38, \"duration\": 18.1, \"from\": \"Perumbavoor\", \"to\": \"Aluva\"}, {\"distance\": 118.49, \"duration\": 124.7, \"from\": \"Aluva\", \"to\": \"Kayamkulam\"}]', '2025-12-26 06:30:11'),
(2, 2, '{\"co2_g_per_km\": 0, \"has_prediction\": true, \"size_class\": \"MEDIUM\", \"total_carbon_kg\": 0, \"vehicle_age\": 3}', '[{\"type\": \"Optimized\", \"dist\": 84.19, \"time\": 101, \"eta\": 111}, {\"type\": \"Alternative (1)\", \"dist\": 96.81849999999999, \"time\": 116, \"eta\": 126}, {\"type\": \"Alternative (2)\", \"dist\": 105.2375, \"time\": 126, \"eta\": 141}]', '{\"optimized\": {\"road\": 35, \"surface\": 28, \"terrain\": 25}, \"alt1\": {\"road\": 45, \"surface\": 40, \"terrain\": 55}, \"alt2\": {\"road\": 50, \"surface\": 45, \"terrain\": 60}}', '{\"safety\": \"Low to medium risk factors detected. Route is safe for most vehicle types.\", \"time\": \"Estimated travel time: 101 minutes. Adjusted ETA accounts for traffic and road conditions.\", \"terrain\": \"Moderate terrain with minor elevation changes. Suitable for all vehicle types.\"}', '[{\"distance\": 12.98, \"duration\": 16.1, \"from\": \"Kalady\", \"to\": \"Aluva\"}, {\"distance\": 18.04, \"duration\": 25.5, \"from\": \"Aluva\", \"to\": \"Ernakulam\"}, {\"distance\": 53.17, \"duration\": 54.6, \"from\": \"Ernakulam\", \"to\": \"kothamangalam\"}]', '2025-12-26 06:33:16'),
(10, 4, '{\"co2_g_per_km\": 148.9, \"has_prediction\": true, \"size_class\": \"SMALL\", \"total_carbon_kg\": 6.32, \"vehicle_age\": 23}', '[{\"type\": \"Optimized\", \"dist\": 42.42, \"time\": 51, \"eta\": 56}, {\"type\": \"Alternative (1)\", \"dist\": 48.783, \"time\": 59, \"eta\": 64}, {\"type\": \"Alternative (2)\", \"dist\": 53.025000000000006, \"time\": 64, \"eta\": 71}]', '{\"optimized\": {\"road\": 35, \"surface\": 28, \"terrain\": 25}, \"alt1\": {\"road\": 45, \"surface\": 40, \"terrain\": 55}, \"alt2\": {\"road\": 50, \"surface\": 45, \"terrain\": 60}}', '{\"safety\": \"Low to medium risk factors detected. Route is safe for most vehicle types.\", \"time\": \"Estimated travel time: 51 minutes. Adjusted ETA accounts for traffic and road conditions.\", \"terrain\": \"Moderate terrain with minor elevation changes. Suitable for all vehicle types.\"}', '[{\"distance\": 7.3883, \"from\": \"kalamaseery\", \"to\": \"Aluva\"}, {\"distance\": 11.126, \"from\": \"Aluva\", \"to\": \"Kalady\"}, {\"distance\": 7.1609, \"from\": \"Kalady\", \"to\": \"Perumbavoor\"}, {\"distance\": 16.7434, \"from\": \"Perumbavoor\", \"to\": \"kothamangalam\"}]', '2025-12-29 18:52:29'),
(16, 7, '{\"co2_g_per_km\": 149.7, \"has_prediction\": true, \"size_class\": \"HEAVY\", \"total_carbon_kg\": 5.8, \"vehicle_age\": 17}', '[{\"type\": \"Optimized\", \"dist\": 38.75, \"time\": 47, \"eta\": 52}, {\"type\": \"Alternative (1)\", \"dist\": 44.5625, \"time\": 54, \"eta\": 59}, {\"type\": \"Alternative (2)\", \"dist\": 48.4375, \"time\": 59, \"eta\": 66}]', '{\"optimized\": {\"road\": 35, \"surface\": 28, \"terrain\": 25}, \"alt1\": {\"road\": 45, \"surface\": 40, \"terrain\": 55}, \"alt2\": {\"road\": 50, \"surface\": 45, \"terrain\": 60}}', '{\"safety\": \"Low to medium risk factors detected. Route is safe for most vehicle types.\", \"time\": \"Estimated travel time: 47 minutes. Adjusted ETA accounts for traffic and road conditions.\", \"terrain\": \"Moderate terrain with minor elevation changes. Suitable for all vehicle types.\"}', '[{\"adjusted_duration\": 39.2, \"distance\": 18.14, \"duration\": 17.1, \"factors\": {\"accident_risk\": {\"description\": \"Moderate accident risk\", \"impact_minutes\": 1.5, \"multiplier\": 1.09, \"name\": \"Accident-Prone Zone\", \"ratio\": 0.35}, \"road_quality\": {\"description\": \"Local road - Moderate speed\", \"impact_minutes\": 4.3, \"multiplier\": 1.25, \"name\": \"Road Quality\", \"score\": 0.5}, \"rush_hour\": {\"description\": \"Off-peak hours\", \"impact_minutes\": 0, \"multiplier\": 1, \"name\": \"Rush Hour\"}, \"surface_condition\": {\"description\": \"Gravel surface - Reduced speed\", \"impact_minutes\": 3, \"multiplier\": 1.18, \"name\": \"Surface Condition\", \"score\": 0.5}, \"terrain\": {\"description\": \"Flat terrain\", \"impact_minutes\": 0.5, \"multiplier\": 1.03, \"name\": \"Terrain\", \"score\": 0.1}, \"traffic_congestion\": {\"description\": \"Moderate Traffic\", \"impact_minutes\": 3.4, \"level\": \"medium\", \"multiplier\": 1.2, \"name\": \"Traffic Congestion\"}, \"weather\": {\"description\": \"Cloudy/overcast\", \"impact_minutes\": 2.7, \"multiplier\": 1.16, \"name\": \"Weather Conditions\", \"score\": 0.4}}, \"from\": \"kothamangalam\", \"road_score\": 50, \"surface_score\": 50, \"terrain_score\": 10, \"to\": \"Perumbavoor\", \"total_delay\": 22.1, \"weather_score\": 40}, {\"adjusted_duration\": 20.8, \"distance\": 7.63, \"duration\": 9.1, \"factors\": {\"accident_risk\": {\"description\": \"Moderate accident risk\", \"impact_minutes\": 0.8, \"multiplier\": 1.09, \"name\": \"Accident-Prone Zone\", \"ratio\": 0.35}, \"road_quality\": {\"description\": \"Local road - Moderate speed\", \"impact_minutes\": 2.3, \"multiplier\": 1.25, \"name\": \"Road Quality\", \"score\": 0.5}, \"rush_hour\": {\"description\": \"Off-peak hours\", \"impact_minutes\": 0, \"multiplier\": 1, \"name\": \"Rush Hour\"}, \"surface_condition\": {\"description\": \"Gravel surface - Reduced speed\", \"impact_minutes\": 1.6, \"multiplier\": 1.18, \"name\": \"Surface Condition\", \"score\": 0.5}, \"terrain\": {\"description\": \"Flat terrain\", \"impact_minutes\": 0.3, \"multiplier\": 1.03, \"name\": \"Terrain\", \"score\": 0.1}, \"traffic_congestion\": {\"description\": \"Moderate Traffic\", \"impact_minutes\": 1.8, \"level\": \"medium\", \"multiplier\": 1.2, \"name\": \"Traffic Congestion\"}, \"weather\": {\"description\": \"Cloudy/overcast\", \"impact_minutes\": 1.5, \"multiplier\": 1.16, \"name\": \"Weather Conditions\", \"score\": 0.4}}, \"from\": \"Perumbavoor\", \"road_score\": 50, \"surface_score\": 50, \"terrain_score\": 10, \"to\": \"Kalady\", \"total_delay\": 11.7, \"weather_score\": 40}, {\"adjusted_duration\": 36.9, \"distance\": 12.98, \"duration\": 16.1, \"factors\": {\"accident_risk\": {\"description\": \"Moderate accident risk\", \"impact_minutes\": 1.4, \"multiplier\": 1.09, \"name\": \"Accident-Prone Zone\", \"ratio\": 0.35}, \"road_quality\": {\"description\": \"Local road - Moderate speed\", \"impact_minutes\": 4, \"multiplier\": 1.25, \"name\": \"Road Quality\", \"score\": 0.5}, \"rush_hour\": {\"description\": \"Off-peak hours\", \"impact_minutes\": 0, \"multiplier\": 1, \"name\": \"Rush Hour\"}, \"surface_condition\": {\"description\": \"Gravel surface - Reduced speed\", \"impact_minutes\": 2.8, \"multiplier\": 1.18, \"name\": \"Surface Condition\", \"score\": 0.5}, \"terrain\": {\"description\": \"Flat terrain\", \"impact_minutes\": 0.5, \"multiplier\": 1.03, \"name\": \"Terrain\", \"score\": 0.1}, \"traffic_congestion\": {\"description\": \"Moderate Traffic\", \"impact_minutes\": 3.2, \"level\": \"medium\", \"multiplier\": 1.2, \"name\": \"Traffic Congestion\"}, \"weather\": {\"description\": \"Cloudy/overcast\", \"impact_minutes\": 2.6, \"multiplier\": 1.16, \"name\": \"Weather Conditions\", \"score\": 0.4}}, \"from\": \"Kalady\", \"road_score\": 50, \"surface_score\": 50, \"terrain_score\": 10, \"to\": \"Aluva\", \"total_delay\": 20.8, \"weather_score\": 40}]', '2026-01-08 06:06:24'),
(18, 8, '{\"co2_g_per_km\": 0, \"has_prediction\": true, \"size_class\": \"MEDIUM\", \"total_carbon_kg\": 0, \"vehicle_age\": 3}', '[{\"type\": \"Optimized\", \"dist\": 28.35, \"time\": 34, \"eta\": 37}, {\"type\": \"Alternative (1)\", \"dist\": 32.6025, \"time\": 39, \"eta\": 43}, {\"type\": \"Alternative (2)\", \"dist\": 35.4375, \"time\": 43, \"eta\": 48}]', '{\"optimized\": {\"road\": 35, \"surface\": 28, \"terrain\": 25}, \"alt1\": {\"road\": 45, \"surface\": 40, \"terrain\": 55}, \"alt2\": {\"road\": 50, \"surface\": 45, \"terrain\": 60}}', '{\"safety\": \"Low to medium risk factors detected. Route is safe for most vehicle types.\", \"time\": \"Estimated travel time: 34 minutes. Adjusted ETA accounts for traffic and road conditions.\", \"terrain\": \"Moderate terrain with minor elevation changes. Suitable for all vehicle types.\"}', '[{\"adjusted_duration\": 18.7, \"distance\": 7.86, \"duration\": 9.1, \"factors\": {\"accident_risk\": {\"description\": \"Moderate accident risk\", \"impact_minutes\": 0.8, \"multiplier\": 1.09, \"name\": \"Accident-Prone Zone\", \"ratio\": 0.35}, \"road_quality\": {\"description\": \"Local road - Moderate speed\", \"impact_minutes\": 2.3, \"multiplier\": 1.25, \"name\": \"Road Quality\", \"score\": 0.5}, \"rush_hour\": {\"description\": \"Off-peak hours\", \"impact_minutes\": 0, \"multiplier\": 1, \"name\": \"Rush Hour\"}, \"surface_condition\": {\"description\": \"Gravel surface - Reduced speed\", \"impact_minutes\": 1.6, \"multiplier\": 1.18, \"name\": \"Surface Condition\", \"score\": 0.5}, \"terrain\": {\"description\": \"Flat terrain\", \"impact_minutes\": 0.3, \"multiplier\": 1.03, \"name\": \"Terrain\", \"score\": 0.1}, \"traffic_congestion\": {\"description\": \"Moderate Traffic\", \"impact_minutes\": 1.8, \"level\": \"medium\", \"multiplier\": 1.2, \"name\": \"Traffic Congestion\"}, \"weather\": {\"description\": \"Clear conditions\", \"impact_minutes\": 0.4, \"multiplier\": 1.04, \"name\": \"Weather Conditions\", \"score\": 0.1}}, \"from\": \"kalamaseery\", \"road_score\": 50, \"surface_score\": 50, \"terrain_score\": 10, \"to\": \"Aluva\", \"total_delay\": 9.6, \"weather_score\": 10}, {\"adjusted_duration\": 33.5, \"distance\": 13.02, \"duration\": 16.3, \"factors\": {\"accident_risk\": {\"description\": \"Moderate accident risk\", \"impact_minutes\": 1.4, \"multiplier\": 1.09, \"name\": \"Accident-Prone Zone\", \"ratio\": 0.35}, \"road_quality\": {\"description\": \"Local road - Moderate speed\", \"impact_minutes\": 4.1, \"multiplier\": 1.25, \"name\": \"Road Quality\", \"score\": 0.5}, \"rush_hour\": {\"description\": \"Off-peak hours\", \"impact_minutes\": 0, \"multiplier\": 1, \"name\": \"Rush Hour\"}, \"surface_condition\": {\"description\": \"Gravel surface - Reduced speed\", \"impact_minutes\": 2.9, \"multiplier\": 1.18, \"name\": \"Surface Condition\", \"score\": 0.5}, \"terrain\": {\"description\": \"Flat terrain\", \"impact_minutes\": 0.5, \"multiplier\": 1.03, \"name\": \"Terrain\", \"score\": 0.1}, \"traffic_congestion\": {\"description\": \"Moderate Traffic\", \"impact_minutes\": 3.3, \"level\": \"medium\", \"multiplier\": 1.2, \"name\": \"Traffic Congestion\"}, \"weather\": {\"description\": \"Clear conditions\", \"impact_minutes\": 0.7, \"multiplier\": 1.04, \"name\": \"Weather Conditions\", \"score\": 0.1}}, \"from\": \"Aluva\", \"road_score\": 50, \"surface_score\": 50, \"terrain_score\": 10, \"to\": \"Kalady\", \"total_delay\": 17.2, \"weather_score\": 10}, {\"adjusted_duration\": 17.9, \"distance\": 7.47, \"duration\": 8.7, \"factors\": {\"accident_risk\": {\"description\": \"Moderate accident risk\", \"impact_minutes\": 0.8, \"multiplier\": 1.09, \"name\": \"Accident-Prone Zone\", \"ratio\": 0.35}, \"road_quality\": {\"description\": \"Local road - Moderate speed\", \"impact_minutes\": 2.2, \"multiplier\": 1.25, \"name\": \"Road Quality\", \"score\": 0.5}, \"rush_hour\": {\"description\": \"Off-peak hours\", \"impact_minutes\": 0, \"multiplier\": 1, \"name\": \"Rush Hour\"}, \"surface_condition\": {\"description\": \"Gravel surface - Reduced speed\", \"impact_minutes\": 1.5, \"multiplier\": 1.18, \"name\": \"Surface Condition\", \"score\": 0.5}, \"terrain\": {\"description\": \"Flat terrain\", \"impact_minutes\": 0.3, \"multiplier\": 1.03, \"name\": \"Terrain\", \"score\": 0.1}, \"traffic_congestion\": {\"description\": \"Moderate Traffic\", \"impact_minutes\": 1.7, \"level\": \"medium\", \"multiplier\": 1.2, \"name\": \"Traffic Congestion\"}, \"weather\": {\"description\": \"Clear conditions\", \"impact_minutes\": 0.3, \"multiplier\": 1.04, \"name\": \"Weather Conditions\", \"score\": 0.1}}, \"from\": \"Kalady\", \"road_score\": 50, \"surface_score\": 50, \"terrain_score\": 10, \"to\": \"Perumbavoor\", \"total_delay\": 9.2, \"weather_score\": 10}]', '2026-01-16 07:01:17');

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` text DEFAULT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `name`, `address`, `latitude`, `longitude`, `created_at`) VALUES
(2, 'kothamangalam', 'Hospital Road, Kothamangalam, Ernakulam, Kerala, 686666, India', 10.06403400, 76.62181900, '2025-12-18 09:24:28'),
(3, 'Perumbavoor', 'MC Road, Perumbavoor, Kunnathunad, Ernakulam, Kerala, 683500, India', 10.11475500, 76.47781500, '2025-12-18 09:25:10'),
(4, 'Aluva', 'High Mast Lamp, Railway Station Road, Thottakkattukara, Aluva, Ernakulam, Kerala, 683101, India', 10.10776800, 76.35685300, '2025-12-18 09:25:36'),
(5, 'Kalady', 'Sugantha Flower Mart, Kalady-Malayattoor Road, Mattoor Harijan Colony, Kalady, Aluva, Ernakulam, Kerala, 683550, India', 10.16663100, 76.43904900, '2025-12-18 10:17:46'),
(6, 'Ernakulam', 'Kunnathunad, Ernakulam, Kerala, 683541, India', 9.98372600, 76.27400000, '2025-12-18 10:18:15'),
(7, 'kalamaseery', 'Kalamassery, Kanayannur, Ernakulam, Kerala, 683104, India', 10.05216800, 76.31990300, '2025-12-18 10:19:48'),
(8, 'thiruvananthapuram', 'Eliyavoor Colony, Kattakkada, Thiruvananthapuram, Kerala, 695543, India', 8.48822700, 76.94755100, '2025-12-26 04:31:25'),
(9, 'Kayamkulam', 'secondary road, Puthankadam General Colony, Kayamkulam, Karthikappally, Alappuzha, Kerala, 690502, India', 9.17236000, 76.50006100, '2025-12-26 04:32:23');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `route_id` int(11) NOT NULL,
  `sender_type` enum('agent','admin','system') NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `route_id`, `sender_type`, `message`, `is_read`, `created_at`) VALUES
(1, 2, 'agent', 'hai', 0, '2025-12-26 06:41:33'),
(2, 2, 'admin', 'good thing', 1, '2025-12-26 14:19:52'),
(3, 2, 'system', '⚠️ AUTOMATIC ALERT: Agent has been paused for 1 minute!', 0, '2025-12-27 13:48:19'),
(4, 2, 'admin', 'We received your alert in the system. Please resume when ready or contact support if you need assistance.', 1, '2025-12-27 13:48:19'),
(5, 2, 'system', '⚠️ AUTOMATIC ALERT: CRITICAL MISSION UPDATE: Agent initiated a path change to mitigate operational risk. \n                       Trajectory reassigned from Optimized Route to Alt 1 Route.', 0, '2025-12-29 07:15:07'),
(6, 2, 'admin', 'We received your alert in the system. Please resume when ready or contact support if you need assistance.', 1, '2025-12-29 07:15:07'),
(7, 2, 'system', '⚠️ AUTOMATIC ALERT: CRITICAL MISSION UPDATE: Agent initiated a path change to mitigate operational risk. \n                       Trajectory reassigned from Optimized Route to Alt 1 Route.', 0, '2025-12-29 07:17:47'),
(8, 2, 'admin', 'We received your alert in the system. Please resume when ready or contact support if you need assistance.', 1, '2025-12-29 07:17:47'),
(9, 2, 'admin', 'reroute', 1, '2025-12-29 07:18:40'),
(10, 1, 'system', '⚠️ AUTOMATIC ALERT: CRITICAL MISSION UPDATE: Agent initiated a path change to mitigate operational risk. \n                       Trajectory reassigned from Optimized Route to Alt 1 Route.', 0, '2025-12-29 07:20:00'),
(11, 1, 'admin', 'We received your alert in the system. Please resume when ready or contact support if you need assistance.', 1, '2025-12-29 07:20:00'),
(12, 2, 'system', '⚠️ AUTOMATIC ALERT: CRITICAL MISSION UPDATE: Agent initiated a path change to mitigate operational risk. \n                       Trajectory reassigned from Optimized Route to Alt 1 Route.', 0, '2025-12-29 07:22:57'),
(13, 2, 'admin', 'We received your alert in the system. Please resume when ready or contact support if you need assistance.', 1, '2025-12-29 07:22:57'),
(14, 2, 'agent', '⚠️ AUTOMATIC ALERT: CRITICAL MISSION UPDATE: Agent initiated a path change to mitigate operational risk. \n                       Trajectory reassigned from Optimized Route to Alt1 Route.', 0, '2025-12-29 18:23:19'),
(15, 4, 'agent', '⚠️ AUTOMATIC ALERT: CRITICAL MISSION UPDATE: Agent initiated a path change to mitigate operational risk. \n                       Trajectory reassigned from Optimized Route to Alt2 Route.', 0, '2025-12-30 02:13:04'),
(16, 4, 'agent', '⚠️ AUTOMATIC ALERT: CRITICAL MISSION UPDATE: Agent initiated a path change to mitigate operational risk. \n                       Trajectory reassigned from Optimized Route to Alt2 Route.', 0, '2025-12-30 04:50:58'),
(17, 4, 'admin', 'ok\n', 0, '2025-12-30 04:55:57'),
(18, 1, 'agent', '⚠️ AUTOMATIC ALERT: CRITICAL MISSION UPDATE: Agent initiated a path change to mitigate operational risk. \n                       Trajectory reassigned from Optimized Route to Alt2 Route.', 0, '2026-01-05 10:02:14'),
(19, 1, 'agent', '⚠️ AUTOMATIC ALERT: CRITICAL MISSION UPDATE: Agent initiated a path change to mitigate operational risk. \n                       Trajectory reassigned from Optimized Route to Alt1 Route.', 0, '2026-01-07 10:32:25'),
(20, 7, 'agent', '⚠️ AUTOMATIC ALERT: CRITICAL MISSION UPDATE: Agent initiated a path change to mitigate operational risk. \n                       Trajectory reassigned from Optimized Route to Alt2 Route.', 0, '2026-01-08 06:33:07'),
(21, 8, 'agent', '⚠️ AUTOMATIC ALERT: CRITICAL MISSION UPDATE: Agent initiated a path change to mitigate operational risk. \n                       Trajectory reassigned from Optimized Route to Alt2 Route.', 0, '2026-01-16 07:03:41');

-- --------------------------------------------------------

--
-- Table structure for table `optimize_route`
--

CREATE TABLE `optimize_route` (
  `id` int(11) NOT NULL,
  `optimizejourney_child` varchar(255) NOT NULL,
  `visit_id` varchar(255) NOT NULL,
  `created_at` varchar(300) NOT NULL,
  `optimization1` varchar(500) NOT NULL,
  `optimization2` varchar(500) NOT NULL,
  `optimization3` varchar(500) NOT NULL,
  `optimization4` varchar(1000) NOT NULL,
  `optimization5` varchar(1000) NOT NULL,
  `optimization6` varchar(1000) DEFAULT '',
  `optimization7` varchar(1000) DEFAULT '',
  `optimization8` varchar(1000) DEFAULT '',
  `optimization9` varchar(1000) DEFAULT '',
  `optimization10` varchar(1000) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `optimize_route`
--

INSERT INTO `optimize_route` (`id`, `optimizejourney_child`, `visit_id`, `created_at`, `optimization1`, `optimization2`, `optimization3`, `optimization4`, `optimization5`, `optimization6`, `optimization7`, `optimization8`, `optimization9`, `optimization10`) VALUES
(28, '11', '4', '2025-12-30 00:22:22', '{\"lat\": 10.05943, \"lon\": 76.32216, \"elev\": 1.8}', '{\"lat\": 10.06417, \"lon\": 76.32632, \"elev\": 1.6}', '{\"lat\": 10.06976, \"lon\": 76.33084, \"elev\": 1.01}', '{\"lat\": 10.07492, \"lon\": 76.33568, \"elev\": 1.71}', '{\"lat\": 10.08164, \"lon\": 76.33971, \"elev\": 0.85}', '{\"lat\": 10.08666, \"lon\": 76.34239, \"elev\": 0.82}', '{\"lat\": 10.09313, \"lon\": 76.34602, \"elev\": 1.01}', '{\"lat\": 10.09986, \"lon\": 76.34807, \"elev\": 0.93}', '{\"lat\": 10.10569, \"lon\": 76.35134, \"elev\": 1.13}', '{\"lat\": 10.10554, \"lon\": 76.35453, \"elev\": 2.13}'),
(29, '12', '5', '2025-12-30 00:22:25', '{\"lat\": 10.10822, \"lon\": 76.36834, \"elev\": 0.91}', '{\"lat\": 10.11485, \"lon\": 76.37664, \"elev\": 1.35}', '{\"lat\": 10.12536, \"lon\": 76.37871, \"elev\": 1.35}', '{\"lat\": 10.12757, \"lon\": 76.3897, \"elev\": 1.23}', '{\"lat\": 10.13141, \"lon\": 76.39831, \"elev\": 1.63}', '{\"lat\": 10.13767, \"lon\": 76.40825, \"elev\": 2.94}', '{\"lat\": 10.14252, \"lon\": 76.41807, \"elev\": 1.55}', '{\"lat\": 10.14889, \"lon\": 76.42605, \"elev\": 1.75}', '{\"lat\": 10.15939, \"lon\": 76.43015, \"elev\": 1.71}', '{\"lat\": 10.16315, \"lon\": 76.43489, \"elev\": 1.56}'),
(30, '10', '3', '2025-12-30 00:22:27', '{\"lat\": 10.16109, \"lon\": 76.4424, \"elev\": 0.5}', '{\"lat\": 10.1561, \"lon\": 76.44676, \"elev\": 1.51}', '{\"lat\": 10.15167, \"lon\": 76.45198, \"elev\": 1.57}', '{\"lat\": 10.1481, \"lon\": 76.45745, \"elev\": 1.72}', '{\"lat\": 10.14306, \"lon\": 76.46189, \"elev\": 1.72}', '{\"lat\": 10.13765, \"lon\": 76.46617, \"elev\": 1.23}', '{\"lat\": 10.13321, \"lon\": 76.46957, \"elev\": 1.43}', '{\"lat\": 10.1276, \"lon\": 76.47327, \"elev\": 1.84}', '{\"lat\": 10.12158, \"lon\": 76.47393, \"elev\": 2.64}', '{\"lat\": 10.11817, \"lon\": 76.47611, \"elev\": 3.15}'),
(31, '9', '2', '2025-12-30 00:22:28', '{\"lat\": 10.11647, \"lon\": 76.49412, \"elev\": 3.31}', '{\"lat\": 10.11339, \"lon\": 76.50938, \"elev\": 3.21}', '{\"lat\": 10.11229, \"lon\": 76.52484, \"elev\": 3.32}', '{\"lat\": 10.10536, \"lon\": 76.5382, \"elev\": 3.83}', '{\"lat\": 10.09733, \"lon\": 76.55176, \"elev\": 6.35}', '{\"lat\": 10.09051, \"lon\": 76.56637, \"elev\": 5.79}', '{\"lat\": 10.08175, \"lon\": 76.57899, \"elev\": 3.86}', '{\"lat\": 10.07775, \"lon\": 76.59374, \"elev\": 4.08}', '{\"lat\": 10.07069, \"lon\": 76.6075, \"elev\": 3.69}', '{\"lat\": 10.06963, \"lon\": 76.61524, \"elev\": 2.47}'),
(38, '1', '3', '2026-01-07 16:04:26', '{\"lat\": 10.06888, \"lon\": 76.6078, \"elev\": 3.42}', '{\"lat\": 10.07623, \"lon\": 76.59454, \"elev\": 4.03}', '{\"lat\": 10.08064, \"lon\": 76.57933, \"elev\": 3.55}', '{\"lat\": 10.09011, \"lon\": 76.56731, \"elev\": 6.24}', '{\"lat\": 10.09697, \"lon\": 76.55278, \"elev\": 6.31}', '{\"lat\": 10.10541, \"lon\": 76.5386, \"elev\": 3.53}', '{\"lat\": 10.11204, \"lon\": 76.52695, \"elev\": 3.39}', '{\"lat\": 10.11339, \"lon\": 76.51177, \"elev\": 3.3}', '{\"lat\": 10.11677, \"lon\": 76.49619, \"elev\": 3.41}', '{\"lat\": 10.11681, \"lon\": 76.48815, \"elev\": 2.92}'),
(39, '2', '4', '2026-01-07 16:04:27', '{\"lat\": 10.11406, \"lon\": 76.46397, \"elev\": 2.01}', '{\"lat\": 10.10144, \"lon\": 76.45678, \"elev\": 1.43}', '{\"lat\": 10.09222, \"lon\": 76.44512, \"elev\": 4.14}', '{\"lat\": 10.08881, \"lon\": 76.43115, \"elev\": 3.75}', '{\"lat\": 10.09016, \"lon\": 76.4165, \"elev\": 3.56}', '{\"lat\": 10.0903, \"lon\": 76.40124, \"elev\": 2.68}', '{\"lat\": 10.08919, \"lon\": 76.38741, \"elev\": 3.6}', '{\"lat\": 10.08767, \"lon\": 76.37317, \"elev\": 2.81}', '{\"lat\": 10.09676, \"lon\": 76.36235, \"elev\": 2.42}', '{\"lat\": 10.10309, \"lon\": 76.36137, \"elev\": 3.26}'),
(40, '3', '9', '2026-01-07 16:04:29', '{\"lat\": 10.021, \"lon\": 76.31249, \"elev\": 1.17}', '{\"lat\": 9.91412, \"lon\": 76.31879, \"elev\": 0.8}', '{\"lat\": 9.8151, \"lon\": 76.31614, \"elev\": 0.84}', '{\"lat\": 9.71085, \"lon\": 76.31988, \"elev\": 1.29}', '{\"lat\": 9.61564, \"lon\": 76.33352, \"elev\": 1.13}', '{\"lat\": 9.51397, \"lon\": 76.33486, \"elev\": 0.98}', '{\"lat\": 9.41662, \"lon\": 76.35542, \"elev\": 1.12}', '{\"lat\": 9.32716, \"lon\": 76.39861, \"elev\": 0.78}', '{\"lat\": 9.27433, \"lon\": 76.46142, \"elev\": 1.24}', '{\"lat\": 9.22977, \"lon\": 76.48376, \"elev\": 1.76}'),
(44, '5', '4', '2026-01-08 11:16:36', '{\"lat\": 10.15936, \"lon\": 76.43026, \"elev\": 1.66}', '{\"lat\": 10.14905, \"lon\": 76.42634, \"elev\": 1.72}', '{\"lat\": 10.14293, \"lon\": 76.41858, \"elev\": 1.53}', '{\"lat\": 10.13825, \"lon\": 76.40893, \"elev\": 2.93}', '{\"lat\": 10.13218, \"lon\": 76.39918, \"elev\": 1.64}', '{\"lat\": 10.12848, \"lon\": 76.39071, \"elev\": 1.24}', '{\"lat\": 10.1264, \"lon\": 76.38049, \"elev\": 1.42}', '{\"lat\": 10.11713, \"lon\": 76.379, \"elev\": 1.47}', '{\"lat\": 10.10987, \"lon\": 76.37009, \"elev\": 0.97}', '{\"lat\": 10.10873, \"lon\": 76.36436, \"elev\": 2.67}'),
(45, '6', '6', '2026-01-08 11:16:38', '{\"lat\": 10.0978, \"lon\": 76.34742, \"elev\": 0.81}', '{\"lat\": 10.08353, \"lon\": 76.34109, \"elev\": 0.78}', '{\"lat\": 10.07105, \"lon\": 76.33242, \"elev\": 1.23}', '{\"lat\": 10.05785, \"lon\": 76.32256, \"elev\": 1.73}', '{\"lat\": 10.04425, \"lon\": 76.31847, \"elev\": 1.75}', '{\"lat\": 10.02948, \"lon\": 76.3116, \"elev\": 1.16}', '{\"lat\": 10.01611, \"lon\": 76.30422, \"elev\": 0.88}', '{\"lat\": 10.00319, \"lon\": 76.30237, \"elev\": 0.49}', '{\"lat\": 9.99302, \"lon\": 76.28982, \"elev\": 0.86}', '{\"lat\": 9.98841, \"lon\": 76.28404, \"elev\": 0.81}'),
(46, '4', '2', '2026-01-08 11:16:40', '{\"lat\": 9.968, \"lon\": 76.30634, \"elev\": 1.01}', '{\"lat\": 9.95519, \"lon\": 76.34352, \"elev\": 1.27}', '{\"lat\": 9.95021, \"lon\": 76.3794, \"elev\": 1.81}', '{\"lat\": 9.9667, \"lon\": 76.41424, \"elev\": 4.77}', '{\"lat\": 9.97897, \"lon\": 76.45661, \"elev\": 4.25}', '{\"lat\": 9.97736, \"lon\": 76.50001, \"elev\": 2.53}', '{\"lat\": 9.98346, \"lon\": 76.54276, \"elev\": 2.25}', '{\"lat\": 9.99587, \"lon\": 76.58526, \"elev\": 2.24}', '{\"lat\": 10.02792, \"lon\": 76.60937, \"elev\": 3.27}', '{\"lat\": 10.04991, \"lon\": 76.61559, \"elev\": 3.52}'),
(50, '18', '3', '2026-01-08 13:33:31', '{\"lat\": 10.06888, \"lon\": 76.6078, \"elev\": 3.42}', '{\"lat\": 10.07623, \"lon\": 76.59454, \"elev\": 4.03}', '{\"lat\": 10.08064, \"lon\": 76.57933, \"elev\": 3.55}', '{\"lat\": 10.09011, \"lon\": 76.56731, \"elev\": 6.24}', '{\"lat\": 10.09697, \"lon\": 76.55278, \"elev\": 6.31}', '{\"lat\": 10.10541, \"lon\": 76.5386, \"elev\": 3.53}', '{\"lat\": 10.11204, \"lon\": 76.52695, \"elev\": 3.39}', '{\"lat\": 10.11339, \"lon\": 76.51177, \"elev\": 3.3}', '{\"lat\": 10.11677, \"lon\": 76.49619, \"elev\": 3.41}', '{\"lat\": 10.11681, \"lon\": 76.48815, \"elev\": 2.92}'),
(51, '20', '5', '2026-01-08 13:33:33', '{\"lat\": 10.11916, \"lon\": 76.47486, \"elev\": 2.76}', '{\"lat\": 10.12559, \"lon\": 76.47373, \"elev\": 2.31}', '{\"lat\": 10.13142, \"lon\": 76.47065, \"elev\": 1.52}', '{\"lat\": 10.13686, \"lon\": 76.46697, \"elev\": 1.22}', '{\"lat\": 10.14222, \"lon\": 76.46273, \"elev\": 1.88}', '{\"lat\": 10.14735, \"lon\": 76.45882, \"elev\": 1.53}', '{\"lat\": 10.15143, \"lon\": 76.45286, \"elev\": 1.59}', '{\"lat\": 10.15559, \"lon\": 76.44805, \"elev\": 1.74}', '{\"lat\": 10.16104, \"lon\": 76.44347, \"elev\": 0.54}', '{\"lat\": 10.16392, \"lon\": 76.44155, \"elev\": 1.14}'),
(52, '19', '4', '2026-01-08 13:33:34', '{\"lat\": 10.15936, \"lon\": 76.43026, \"elev\": 1.66}', '{\"lat\": 10.14905, \"lon\": 76.42634, \"elev\": 1.72}', '{\"lat\": 10.14293, \"lon\": 76.41858, \"elev\": 1.53}', '{\"lat\": 10.13825, \"lon\": 76.40893, \"elev\": 2.93}', '{\"lat\": 10.13218, \"lon\": 76.39918, \"elev\": 1.64}', '{\"lat\": 10.12848, \"lon\": 76.39071, \"elev\": 1.24}', '{\"lat\": 10.1264, \"lon\": 76.38049, \"elev\": 1.42}', '{\"lat\": 10.11713, \"lon\": 76.379, \"elev\": 1.47}', '{\"lat\": 10.10987, \"lon\": 76.37009, \"elev\": 0.97}', '{\"lat\": 10.10873, \"lon\": 76.36436, \"elev\": 2.67}'),
(53, '22', '4', '2026-01-16 12:31:12', '{\"lat\": 10.05943, \"lon\": 76.32216, \"elev\": 1.8}', '{\"lat\": 10.06417, \"lon\": 76.32632, \"elev\": 1.6}', '{\"lat\": 10.06976, \"lon\": 76.33084, \"elev\": 1.01}', '{\"lat\": 10.07492, \"lon\": 76.33568, \"elev\": 1.71}', '{\"lat\": 10.08164, \"lon\": 76.33971, \"elev\": 0.85}', '{\"lat\": 10.08666, \"lon\": 76.34239, \"elev\": 0.82}', '{\"lat\": 10.09313, \"lon\": 76.34602, \"elev\": 1.01}', '{\"lat\": 10.09986, \"lon\": 76.34807, \"elev\": 0.93}', '{\"lat\": 10.10569, \"lon\": 76.35134, \"elev\": 1.13}', '{\"lat\": 10.10554, \"lon\": 76.35453, \"elev\": 2.13}'),
(54, '23', '5', '2026-01-16 12:31:15', '{\"lat\": 10.10822, \"lon\": 76.36834, \"elev\": 0.91}', '{\"lat\": 10.11485, \"lon\": 76.37664, \"elev\": 1.35}', '{\"lat\": 10.12536, \"lon\": 76.37871, \"elev\": 1.35}', '{\"lat\": 10.12757, \"lon\": 76.3897, \"elev\": 1.23}', '{\"lat\": 10.13141, \"lon\": 76.39831, \"elev\": 1.63}', '{\"lat\": 10.13767, \"lon\": 76.40825, \"elev\": 2.94}', '{\"lat\": 10.14252, \"lon\": 76.41807, \"elev\": 1.55}', '{\"lat\": 10.14889, \"lon\": 76.42605, \"elev\": 1.75}', '{\"lat\": 10.15939, \"lon\": 76.43015, \"elev\": 1.71}', '{\"lat\": 10.16315, \"lon\": 76.43489, \"elev\": 1.56}'),
(55, '21', '3', '2026-01-16 12:31:17', '{\"lat\": 10.16109, \"lon\": 76.4424, \"elev\": 0.5}', '{\"lat\": 10.1561, \"lon\": 76.44676, \"elev\": 1.51}', '{\"lat\": 10.15167, \"lon\": 76.45198, \"elev\": 1.57}', '{\"lat\": 10.1481, \"lon\": 76.45745, \"elev\": 1.72}', '{\"lat\": 10.14306, \"lon\": 76.46189, \"elev\": 1.72}', '{\"lat\": 10.13765, \"lon\": 76.46617, \"elev\": 1.23}', '{\"lat\": 10.13321, \"lon\": 76.46957, \"elev\": 1.43}', '{\"lat\": 10.1276, \"lon\": 76.47327, \"elev\": 1.84}', '{\"lat\": 10.12158, \"lon\": 76.47393, \"elev\": 2.64}', '{\"lat\": 10.11817, \"lon\": 76.47611, \"elev\": 3.15}');

-- --------------------------------------------------------

--
-- Table structure for table `routes`
--

CREATE TABLE `routes` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `agent_id` int(11) DEFAULT NULL,
  `status` enum('pending','active','paused','completed') DEFAULT 'pending',
  `distance` decimal(8,2) DEFAULT NULL,
  `estimated_time` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `route_messages`
--

CREATE TABLE `route_messages` (
  `id` int(11) NOT NULL,
  `route_id` int(11) NOT NULL,
  `sender_type` enum('agent','admin','system') NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `route_simulation`
--

CREATE TABLE `route_simulation` (
  `id` int(11) NOT NULL,
  `journey_master_id` int(11) NOT NULL,
  `agent_id` int(11) NOT NULL,
  `simulation_status` enum('idle','in_progress','paused','completed') DEFAULT 'idle',
  `selected_route_type` varchar(50) DEFAULT 'optimized',
  `current_stop_index` int(11) DEFAULT 0,
  `current_latitude` decimal(10,8) DEFAULT NULL,
  `current_longitude` decimal(11,8) DEFAULT NULL,
  `started_at` timestamp NULL DEFAULT NULL,
  `paused_at` timestamp NULL DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `pause_duration_seconds` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `route_simulation`
--

INSERT INTO `route_simulation` (`id`, `journey_master_id`, `agent_id`, `simulation_status`, `selected_route_type`, `current_stop_index`, `current_latitude`, `current_longitude`, `started_at`, `paused_at`, `completed_at`, `pause_duration_seconds`, `created_at`, `updated_at`) VALUES
(1, 1, 3, 'in_progress', 'optimized', 0, NULL, NULL, '2026-01-07 10:30:39', NULL, '2026-01-05 10:06:18', 0, '2025-12-26 06:36:08', '2026-01-07 10:30:39'),
(2, 2, 3, 'in_progress', 'optimized', 0, NULL, NULL, '2025-12-30 02:23:23', NULL, '2025-12-29 18:10:24', 0, '2025-12-26 06:41:16', '2025-12-30 02:23:23'),
(3, 4, 3, 'completed', 'optimized', 0, NULL, NULL, '2025-12-30 04:50:04', NULL, '2025-12-30 04:51:42', 0, '2025-12-30 02:12:19', '2025-12-30 04:51:42'),
(4, 7, 3, 'completed', 'optimized', 0, NULL, NULL, '2026-01-08 06:32:17', NULL, '2026-01-08 06:33:36', 0, '2026-01-08 06:32:17', '2026-01-08 06:33:36'),
(5, 8, 3, 'completed', 'optimized', 0, NULL, NULL, '2026-01-16 07:02:23', NULL, '2026-01-16 07:04:12', 0, '2026-01-16 07:02:23', '2026-01-16 07:04:12');

-- --------------------------------------------------------

--
-- Table structure for table `simulation_incidents`
--

CREATE TABLE `simulation_incidents` (
  `id` int(11) NOT NULL,
  `route_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `simulation_incidents`
--

INSERT INTO `simulation_incidents` (`id`, `route_id`, `type`, `description`, `created_at`) VALUES
(1, 2, 'Simulation Stopped', 'Mission simulation ended by agent.', '2025-12-26 06:43:34'),
(2, 1, 'Simulation Stopped', 'Mission simulation ended by agent.', '2025-12-26 07:28:54'),
(3, 1, 'Reroute Triggered', 'System detected incident - Reroute initiated', '2025-12-26 08:10:52'),
(4, 1, 'Reroute Triggered', 'System detected incident - Reroute initiated', '2025-12-26 08:46:45'),
(5, 1, 'Simulation Stopped', 'Mission simulation ended by agent.', '2025-12-26 08:46:52'),
(6, 2, 'Incident Detected', 'System automatically paused simulation due to path obstacle.', '2025-12-26 09:20:53'),
(7, 2, 'Incident Acknowledged', 'Agent acknowledged incident and continued on current path.', '2025-12-26 09:36:08'),
(8, 2, 'Simulation Stopped', 'Mission simulation ended by agent.', '2025-12-26 09:38:11'),
(9, 2, 'Manual Report', 'Driver reported: Accident Occurred', '2025-12-26 14:02:10'),
(10, 2, 'Real-time Incident', 'Driver Reported: Accident Occurred', '2025-12-26 14:02:10'),
(11, 2, 'Manual Report', 'Driver reported: Road Work', '2025-12-26 14:02:33'),
(12, 2, 'Real-time Incident', 'System detected incident ahead.', '2025-12-26 14:04:03'),
(13, 2, 'Real-time Incident', 'System detected incident ahead.', '2025-12-26 14:06:02'),
(14, 2, 'Manual Report', 'Driver reported: Accident Occurred', '2025-12-26 14:17:08'),
(15, 2, 'Real-time Incident', 'Driver Reported: Accident Occurred', '2025-12-26 14:17:08'),
(16, 2, 'Real-time Incident', 'System detected incident ahead.', '2025-12-26 14:18:12'),
(17, 2, 'Simulation Stopped', 'Mission simulation ended by agent.', '2025-12-29 09:59:17'),
(18, 2, 'Reroute Triggered', 'System detected incident - Reroute initiated', '2025-12-29 12:05:15'),
(19, 2, 'Reroute Triggered', 'System detected incident - Reroute initiated', '2025-12-29 18:08:41'),
(20, 2, 'Simulation Stopped', 'Mission simulation ended by agent.', '2025-12-29 18:10:24'),
(21, 2, 'Reroute Triggered', 'System detected incident - Reroute initiated', '2025-12-29 18:11:47'),
(22, 2, 'Reroute Triggered', 'System detected incident - Reroute initiated', '2025-12-29 18:23:19'),
(23, 4, 'Reroute Triggered', 'System detected incident - Reroute initiated', '2025-12-30 02:13:04'),
(24, 4, 'Simulation Stopped', 'Mission simulation ended by agent.', '2025-12-30 02:14:25'),
(25, 4, 'Reroute Triggered', 'System detected incident - Reroute initiated', '2025-12-30 04:50:58'),
(26, 4, 'Simulation Stopped', 'Mission simulation ended by agent.', '2025-12-30 04:51:42'),
(27, 1, 'Reroute Triggered', 'System detected incident - Reroute initiated', '2026-01-05 10:02:14'),
(28, 1, 'Simulation Stopped', 'Mission simulation ended by agent.', '2026-01-05 10:06:18'),
(29, 1, 'Reroute Triggered', 'System detected incident - Reroute initiated', '2026-01-07 10:32:25'),
(30, 7, 'Reroute Triggered', 'System detected incident - Reroute initiated', '2026-01-08 06:33:07'),
(31, 7, 'Simulation Stopped', 'Mission simulation ended by agent.', '2026-01-08 06:33:36'),
(32, 8, 'Reroute Triggered', 'System detected incident - Reroute initiated', '2026-01-16 07:03:41'),
(33, 8, 'Simulation Stopped', 'Mission simulation ended by agent.', '2026-01-16 07:04:12');

-- --------------------------------------------------------

--
-- Table structure for table `simulation_path_history`
--

CREATE TABLE `simulation_path_history` (
  `id` int(11) NOT NULL,
  `route_id` int(11) NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_login`
--

CREATE TABLE `tbl_login` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `password` varchar(50) NOT NULL,
  `role` varchar(50) NOT NULL,
  `last_active` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_login`
--

INSERT INTO `tbl_login` (`id`, `username`, `email`, `phone`, `password`, `role`, `last_active`) VALUES
(1, 'manager', 'admin@gmail.com', '7894561230', 'manager1', 'manager', ''),
(3, 'agent1', 'agent1@gmail.com', '7894561230', 'password123', 'agent', '2025-12-18 14:59:58'),
(4, 'agent2', 'agent1@gmail.com', '7894561230', 'password123', 'agent', '2025-12-18 15:00:17');

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `number` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `average_mileage` varchar(50) DEFAULT NULL,
  `registereddate` varchar(300) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `fuel_type` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`id`, `name`, `number`, `type`, `average_mileage`, `registereddate`, `notes`, `created_at`, `fuel_type`) VALUES
(1, 'truck', '12345678', 'heavy', '20', '2009-07-11', 'good', '2025-12-18 09:26:07', 'Petrol'),
(2, 'pickup', 'kl 663443', 'small', '25', '2002-11-20', 'good', '2025-12-18 09:27:17', 'Diesel'),
(3, 'van', 'kl 7895', 'medium', '30', '2023-11-18', 'medium', '2025-12-18 09:28:51', 'Electric');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `goods`
--
ALTER TABLE `goods`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `journey_child`
--
ALTER TABLE `journey_child`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `journey_master`
--
ALTER TABLE `journey_master`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `journey_optimization_metadata`
--
ALTER TABLE `journey_optimization_metadata`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_journey` (`journey_master_id`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `optimize_route`
--
ALTER TABLE `optimize_route`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `routes`
--
ALTER TABLE `routes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `route_messages`
--
ALTER TABLE `route_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `route_simulation`
--
ALTER TABLE `route_simulation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_journey_agent` (`journey_master_id`,`agent_id`);

--
-- Indexes for table `simulation_incidents`
--
ALTER TABLE `simulation_incidents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `simulation_path_history`
--
ALTER TABLE `simulation_path_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_login`
--
ALTER TABLE `tbl_login`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `goods`
--
ALTER TABLE `goods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `journey_child`
--
ALTER TABLE `journey_child`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `journey_master`
--
ALTER TABLE `journey_master`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `journey_optimization_metadata`
--
ALTER TABLE `journey_optimization_metadata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `optimize_route`
--
ALTER TABLE `optimize_route`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `routes`
--
ALTER TABLE `routes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `route_messages`
--
ALTER TABLE `route_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `route_simulation`
--
ALTER TABLE `route_simulation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `simulation_incidents`
--
ALTER TABLE `simulation_incidents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `simulation_path_history`
--
ALTER TABLE `simulation_path_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_login`
--
ALTER TABLE `tbl_login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
