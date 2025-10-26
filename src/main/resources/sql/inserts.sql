-- Sample data for Power Grid Management System

-- 1. Grid Operators
INSERT INTO grid_user.grid_operators (id, name, region) VALUES
  (1, 'NorthGrid ISO', 'North Region'),
  (2, 'SouthGrid ISO', 'South Region'),
  (3, 'EastGrid ISO', 'East Region'),
  (4, 'WestGrid ISO', 'West Region');

-- 2. Power Plants
INSERT INTO grid_user.power_plants (id, name, type, capacity_mw, grid_operator_id, location) VALUES
  (1, 'North Solar Farm', 'Solar', 150.00, 1, 'North City'),
  (2, 'North Wind Park', 'Wind', 200.00, 1, 'North Plains'),
  (3, 'South Gas Plant', 'Gas', 300.00, 2, 'South City'),
  (4, 'West Hydro Station', 'Hydro', 250.00, 4, 'West River'),
  (5, 'West Coal Plant', 'Coal', 400.00, 4, 'West Hills');

-- 3. Substations
INSERT INTO grid_user.substations (id, name, location, grid_operator_id) VALUES
  (1, 'North Substation A', 'North City', 1),
  (2, 'North Substation B', 'North Plains', 1),
  (3, 'South Substation A', 'South City', 2),
  (4, 'West Substation A', 'West River', 4);

-- 4. Transmission Lines
INSERT INTO grid_user.transmission_lines (id, name, from_substation_id, to_substation_id, capacity_mw, status) VALUES
  (1, 'North Line 1', 1, 2, 250.00, 'Active'),
  (2, 'Interconnect Line', 2, 3, 150.00, 'Active'),
  (3, 'West Line 1', 4, 1, 200.00, 'Inactive');

-- 5. Market Participants
INSERT INTO grid_user.market_participants (id, name, type, grid_operator_id) VALUES
  (1, 'NorthGen', 'Generator', 1),
  (2, 'SouthRetail', 'Retailer', 2),
  (3, 'BigConsumer', 'Consumer', 1),
  (4, 'WestEnergy', 'Generator', 4);

-- 6. Market Transactions see 10k data script
-- (This section is intentionally left blank as per instruction)

-- 7. Meters
INSERT INTO grid_user.meters (id, participant_id, timestamp, epoch, reading_mwh, updated_at) VALUES
  (1, 1, '2025-10-20 08:00:00', 1750338000, 100.00, CURRENT_TIMESTAMP),
  (2, 2, '2025-10-20 09:00:00', 1750341600, 50.00, CURRENT_TIMESTAMP),
  (3, 3, '2025-10-20 10:00:00', 1750345200, 20.00, CURRENT_TIMESTAMP),
  (4, 4, '2025-10-20 11:00:00', 1750348800, 80.00, CURRENT_TIMESTAMP);

-- 8. Outages
INSERT INTO grid_user.outages (id, affected_asset_type, affected_asset_id, timestamp, epoch, end_time, end_epoch, description, updated_at) VALUES
  (1, 'PowerPlant', 2, '2025-10-19 12:00:00', 1750250400, '2025-10-19 18:00:00', 1750272000, 'Wind park maintenance', CURRENT_TIMESTAMP),
  (2, 'TransmissionLine', 2, '2025-10-18 09:00:00', 1750160400, NULL, NULL, 'Unexpected outage', CURRENT_TIMESTAMP),
  (3, 'Substation', 3, '2025-10-17 14:00:00', 1750082400, '2025-10-17 20:00:00', 1750104000, 'Transformer failure', CURRENT_TIMESTAMP);

-- 9. Forecasts
INSERT INTO grid_user.forecasts (id, grid_operator_id, timestamp, epoch, forecast_type, value_mw, updated_at) VALUES
  (1, 1, '2025-10-21 00:00:00', 1750370400, 'Load', 400.00, CURRENT_TIMESTAMP),
  (2, 2, '2025-10-21 00:00:00', 1750370400, 'Generation', 300.00, CURRENT_TIMESTAMP);
