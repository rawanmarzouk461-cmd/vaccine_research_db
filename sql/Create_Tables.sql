CREATE DATABASE IF NOT EXISTS vaccine_db;
USE vaccine_db;






CREATE TABLE vaccine_candidates (
    candidate_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    technology_platform VARCHAR(50) NOT NULL, -- e.g., mRNA, Viral Vector, Inactivated
    target_disease VARCHAR(100) NOT NULL,
    created_date DATE NOT NULL
);


CREATE TABLE antigens (
    antigen_id INT AUTO_INCREMENT PRIMARY KEY,
    antigen_name VARCHAR(100) NOT NULL UNIQUE,
    molecular_weight_kd DECIMAL(8,2) CHECK (molecular_weight_kd > 0),
    sequence_info TEXT
);


CREATE TABLE vaccine_antigens (
    candidate_id INT NOT NULL,
    antigen_id INT NOT NULL,
    expression_system VARCHAR(50) NOT NULL,
    PRIMARY KEY (candidate_id, antigen_id),
    FOREIGN KEY (candidate_id) REFERENCES vaccine_candidates(candidate_id) ON DELETE CASCADE,
    FOREIGN KEY (antigen_id) REFERENCES antigens(antigen_id) ON DELETE CASCADE
);


CREATE TABLE formulations (
    formulation_id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL,
    adjuvant_name VARCHAR(100) DEFAULT 'None',
    ph_level DECIMAL(3,2) CHECK (ph_level BETWEEN 4.0 AND 9.0),
    storage_temp_celsius INT NOT NULL,
    FOREIGN KEY (candidate_id) REFERENCES vaccine_candidates(candidate_id) ON DELETE CASCADE
);


CREATE TABLE batches (
    batch_id INT AUTO_INCREMENT PRIMARY KEY,
    formulation_id INT NOT NULL,
    lot_number VARCHAR(50) NOT NULL UNIQUE,
    production_date DATE NOT NULL,
    expiration_date DATE NOT NULL,
    quantity_produced INT CHECK (quantity_produced > 0),
    FOREIGN KEY (formulation_id) REFERENCES formulations(formulation_id) ON DELETE CASCADE,
    CONSTRAINT chk_dates CHECK (expiration_date > production_date)
);


CREATE TABLE research_sites (
    site_id INT AUTO_INCREMENT PRIMARY KEY,
    site_name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,
    facility_type VARCHAR(50) NOT NULL -- e.g., Hospital, Research Lab, University
);


CREATE TABLE clinical_studies (
    study_id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL,
    site_id INT NOT NULL,
    phase VARCHAR(20) NOT NULL CHECK (phase IN ('Phase I', 'Phase II', 'Phase III', 'Phase IV')),
    start_date DATE NOT NULL,
    end_date DATE,
    status VARCHAR(20) DEFAULT 'Ongoing' CHECK (status IN ('Pending', 'Ongoing', 'Completed', 'Terminated')),
    FOREIGN KEY (candidate_id) REFERENCES vaccine_candidates(candidate_id) ON DELETE CASCADE,
    FOREIGN KEY (site_id) REFERENCES research_sites(site_id) ON DELETE CASCADE
);


CREATE TABLE participants (
    participant_id INT AUTO_INCREMENT PRIMARY KEY,
    anonymized_code VARCHAR(20) NOT NULL UNIQUE,
    age INT CHECK (age >= 18 AND age <= 100),
    gender VARCHAR(10) CHECK (gender IN ('Male', 'Female')),
    health_status VARCHAR(50) DEFAULT 'Healthy'
);


CREATE TABLE study_participants (
    study_id INT NOT NULL,
    participant_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    dosage_group VARCHAR(50) NOT NULL, -- e.g., Low Dose, High Dose, Placebo
    PRIMARY KEY (study_id, participant_id),
    FOREIGN KEY (study_id) REFERENCES clinical_studies(study_id) ON DELETE CASCADE,
    FOREIGN KEY (participant_id) REFERENCES participants(participant_id) ON DELETE CASCADE
);


CREATE TABLE adverse_events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    study_id INT NOT NULL,
    participant_id INT NOT NULL,
    description TEXT NOT NULL,
    severity VARCHAR(20) NOT NULL CHECK (severity IN ('Mild', 'Moderate', 'Severe', 'Critical')),
    report_date DATE NOT NULL,
    FOREIGN KEY (study_id, participant_id) REFERENCES study_participants(study_id, participant_id) ON DELETE CASCADE
);


CREATE TABLE lab_tests (
    test_id INT AUTO_INCREMENT PRIMARY KEY,
    study_id INT NOT NULL,
    participant_id INT NOT NULL,
    test_type VARCHAR(50) NOT NULL, -- e.g., Antibody Titres, T-cell Response
    result_value VARCHAR(50) NOT NULL,
    test_date DATE NOT NULL,
    FOREIGN KEY (study_id, participant_id) REFERENCES study_participants(study_id, participant_id) ON DELETE CASCADE
);