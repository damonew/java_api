-- Table creation for Power Grid Management System (ISO-like, generic)

-- Grid Operator table
CREATE TABLE grid_user.grid_operators (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    region VARCHAR(100) NOT NULL
);

-- Power Plant table
CREATE TABLE grid_user.power_plants (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(50) NOT NULL, -- e.g., Solar, Wind, Gas, Nuclear
    capacity_mw DECIMAL(10,2) NOT NULL,
    grid_operator_id BIGINT NOT NULL,
    location VARCHAR(255),
    FOREIGN KEY (grid_operator_id) REFERENCES grid_user.grid_operators(id)
);

-- Substation table
CREATE TABLE grid_user.substations (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(255),
    grid_operator_id BIGINT NOT NULL,
    FOREIGN KEY (grid_operator_id) REFERENCES grid_user.grid_operators(id)
);

-- Transmission Line table
CREATE TABLE grid_user.transmission_lines (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    from_substation_id BIGINT NOT NULL,
    to_substation_id BIGINT NOT NULL,
    capacity_mw DECIMAL(10,2) NOT NULL,
    status VARCHAR(30) NOT NULL, -- e.g., Active, Maintenance, Outage
    FOREIGN KEY (from_substation_id) REFERENCES grid_user.substations(id),
    FOREIGN KEY (to_substation_id) REFERENCES grid_user.substations(id)
);

-- Market Participant table
CREATE TABLE grid_user.market_participants (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(50) NOT NULL, -- e.g., Generator, Retailer, Consumer
    grid_operator_id BIGINT NOT NULL,
    FOREIGN KEY (grid_operator_id) REFERENCES grid_user.grid_operators(id)
);

-- Market Transaction table
CREATE TABLE grid_user.market_transactions (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    participant_id BIGINT NOT NULL,
    transaction_type VARCHAR(30) NOT NULL, -- e.g., Buy, Sell
    amount_mwh DECIMAL(10,2) NOT NULL,
    price_per_mwh DECIMAL(10,2) NOT NULL,
    timestamp TIMESTAMP NOT NULL,
    epoch BIGINT NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (participant_id) REFERENCES grid_user.market_participants(id)
);

-- Meter table
CREATE TABLE grid_user.meters (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    participant_id BIGINT NOT NULL,
    timestamp TIMESTAMP NOT NULL,
    epoch BIGINT NOT NULL,
    reading_mwh DECIMAL(10,2) NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (participant_id) REFERENCES grid_user.market_participants(id)
);

-- Outage table
CREATE TABLE grid_user.outages (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    affected_asset_type VARCHAR(30) NOT NULL, -- e.g., PowerPlant, TransmissionLine, Substation
    affected_asset_id BIGINT NOT NULL,
    timestamp TIMESTAMP NOT NULL,
    epoch BIGINT NOT NULL,
    end_time TIMESTAMP,
    end_epoch BIGINT,
    description TEXT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Forecast table
CREATE TABLE grid_user.forecasts (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    grid_operator_id BIGINT NOT NULL,
    timestamp TIMESTAMP NOT NULL,
    epoch BIGINT NOT NULL,
    forecast_type VARCHAR(30) NOT NULL, -- e.g., Load, Generation
    value_mw DECIMAL(10,2) NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (grid_operator_id) REFERENCES grid_user.grid_operators(id)
);
