
USE vaccine_db;

-- Vaccine Candidates 
INSERT INTO vaccine_candidates (name, technology_platform, target_disease, created_date) VALUES
('Comirnaty (BNT162b2)', 'mRNA', 'COVID-19', '2024-01-15'),
('Spikevax (mRNA-1273)', 'mRNA', 'COVID-19', '2024-02-10'),
('Vaxzevria (ChAdOx1-S)', 'Viral Vector', 'COVID-19', '2024-03-01'),
('Arexvy (RSVPreF3)', 'Protein Subunit', 'RSV', '2024-03-20'),
('Mosquirix (RTS,S/AS01)', 'Recombinant Protein', 'Malaria', '2024-04-05'),
('Shingrix (HZ/su)', 'Recombinant Subunit', 'Shingles', '2024-04-18'),
('Gardasil 9', 'VLP (Viral Like Particle)', 'HPV', '2024-05-02'),
('Engerix-B', 'Recombinant DNA', 'Hepatitis B', '2024-05-15'),
('Ervebo (rVSV-ZEBOV)', 'Viral Vector', 'Ebola', '2024-06-01'),
('VPM1002', 'Live Attenuated Recombinant', 'Tuberculosis', '2024-06-12');

-- Antigens 
INSERT INTO antigens (antigen_name, molecular_weight_kd, sequence_info) VALUES
('SARS-CoV-2 Spike Protein S1', 140.50, 'ATGTTTGTTTTTCTTGTTTTATTGCCACTAGTCTCTAGTCAGTGTGTTAAT'),
('Influenza A H1N1 Hemagglutinin', 56.20, 'ATGAAGACAATCATTGCTTTGAGCTACATTTTCTGTCTGGTTTTCGCCCAA'),
('Ebola Virus Glycoprotein GP', 74.80, 'ATGGGGGTGACAGGGATACTGCAATTGCCCCGGGACCGGTTCAAGAGGACG'),
('Plasmodium falciparum CSP', 42.10, 'ATGAGAAAACTGGCCATCTTGTCAATTTCTTCTTTTTTAGAAGTTGACCCG'),
('RSV Prefusion F Glycoprotein', 64.30, 'ATGGAGTTGCTAATCCTCAAGACCAATCAATCGCCACAGAACACATCAAC'),
('Varicella Zoster Glycoprotein E', 62.00, 'ATGAGAGTGAAGGAGAAATATCAGCACTTGTGGAGATGGGGGTGGAGATGG'),
('HPV Type 16 L1 Capsid Protein', 55.00, 'ATGAACCAACCAAAAAAGAGGAGAAGGGACACGCCTACCAACATGTTGTTG'),
('Hepatitis B Surface Antigen (HBsAg)', 25.40, 'ATGGAGAACATCACATCAGGATTCCTAGGACCCCTGCTCGTGTTACAGGCG'),
('Dengue Envelope Protein E', 53.50, 'ATGCGATGCGTGGGAATAGGCAACAGAGACTTCGTGGAAGGACTATCAGG'),
('Mycobacterium tuberculosis Ag85B', 30.00, 'ATGTTTTCCCGGCCCGGGCTGTCGGTCCTGGCGGCCGGTCTGACCACCGG');

-- Vaccine Antigens 
INSERT INTO vaccine_antigens (candidate_id, antigen_id, expression_system) VALUES
(1, 1, 'In Vitro Transcription'),
(2, 1, 'In Vitro Transcription'),
(3, 1, 'HEK293 Cell Line'),
(4, 5, 'CHO Cell Line'),
(5, 4, 'Yeast Expression System'),
(6, 6, 'CHO Cell Line'),
(7, 7, 'Saccharomyces cerevisiae'),
(8, 8, 'Yeast Expression System'),
(9, 3, 'Vero Cell Line'),
(10, 10, 'Recombinant Mycobacterium');

-- Formulations
INSERT INTO formulations (candidate_id, adjuvant_name, ph_level, storage_temp_celsius) VALUES
(1, 'ALC-0315 / ALC-0159 LNP', 7.40, -70),
(2, 'SM-102 LNP', 7.50, -20),
(3, 'Polysorbate 80', 7.20, 4),
(4, 'AS01E Adjuvant System', 7.00, 4),
(5, 'AS01B Adjuvant System', 6.80, 4),
(6, 'AS01B Adjuvant System', 6.90, 4),
(7, 'Amorphous Aluminium Hydroxyphosphate Sulfate', 7.10, 4),
(8, 'Aluminium Hydroxide (Alum)', 6.80, 4),
(9, 'None (Buffered Solution)', 7.30, -80),
(10, 'PBS Buffer Solution', 7.00, 4);

-- Batches 
INSERT INTO batches (formulation_id, lot_number, production_date, expiration_date, quantity_produced) VALUES
(1, 'LOT-PFIZER-2024-01', '2024-01-20', '2025-01-20', 100000),
(2, 'LOT-MODERNA-2024-02', '2024-02-15', '2025-08-15', 80000),
(3, 'LOT-AZ-2024-03', '2024-03-05', '2025-03-05', 50000),
(4, 'LOT-GSK-2024-04', '2024-03-25', '2025-09-25', 30000),
(5, 'LOT-GSK-2024-05', '2024-04-10', '2025-04-10', 25000),
(6, 'LOT-GSK-2024-06', '2024-04-22', '2025-10-22', 40000),
(7, 'LOT-MSD-2024-07', '2024-05-08', '2025-05-08', 60000),
(8, 'LOT-ENG-2024-08', '2024-05-20', '2026-05-20', 90000),
(9, 'LOT-ERV-2024-09', '2024-06-05', '2025-06-05', 15000),
(10, 'LOT-VPM-2024-10', '2024-06-18', '2025-12-18', 20000);

-- Research Sites 
INSERT INTO research_sites (site_name, location, facility_type) VALUES
('Kasr Al Ainy Hospital - Cairo University', 'Cairo, Egypt', 'Hospital'),
('Ain Shams University Hospitals', 'Cairo, Egypt', 'Hospital'),
('Theodor Bilharz Research Institute (TBRI)', 'Giza, Egypt', 'Research Lab'),
('National Research Centre (NRC)', 'Giza, Egypt', 'Research Lab'),
('Mansoura University Main Hospital', 'Mansoura, Egypt', 'Hospital'),
('Alexandria University Main Hospital', 'Alexandria, Egypt', 'Hospital'),
('Suez Canal University Hospital', 'Ismailia, Egypt', 'University'),
('Assiut University Main Hospital', 'Assiut, Egypt', 'Hospital'),
('Tanta University Hospital', 'Tanta, Egypt', 'Hospital'),
('Childrens Cancer Hospital 57357', 'Cairo, Egypt', 'Hospital');

-- Clinical Studies 
INSERT INTO clinical_studies (candidate_id, site_id, phase, start_date, end_date, status) VALUES
(1, 1, 'Phase I', '2024-02-01', '2024-05-01', 'Completed'),
(1, 2, 'Phase II', '2024-05-15', NULL, 'Ongoing'),
(2, 3, 'Phase I', '2024-03-01', '2024-06-01', 'Completed'),
(3, 4, 'Phase I', '2024-03-15', NULL, 'Ongoing'),
(4, 5, 'Phase I', '2024-04-01', NULL, 'Ongoing'),
(5, 6, 'Phase I', '2024-04-20', NULL, 'Pending'),
(6, 7, 'Phase II', '2024-05-01', NULL, 'Ongoing'),
(7, 8, 'Phase I', '2024-05-15', NULL, 'Ongoing'),
(8, 9, 'Phase I', '2024-06-01', NULL, 'Pending'),
(9, 10, 'Phase III', '2024-06-15', NULL, 'Ongoing');

-- Participants 
INSERT INTO participants (anonymized_code, age, gender, health_status) VALUES
('PART-1001', 24, 'Male', 'Healthy'),
('PART-1002', 31, 'Female', 'Healthy'),
('PART-1003', 45, 'Male', 'Healthy'),
('PART-1004', 29, 'Female', 'Healthy'),
('PART-1005', 52, 'Male', 'Healthy'),
('PART-1006', 38, 'Female', 'Healthy'),
('PART-1007', 22, 'Male', 'Healthy'),
('PART-1008', 60, 'Female', 'Healthy'),
('PART-1009', 27, 'Male', 'Healthy'),
('PART-1010', 35, 'Female', 'Healthy');

-- Study Participants
INSERT INTO study_participants (study_id, participant_id, enrollment_date, dosage_group) VALUES
(1, 1, '2024-02-05', '30 mcg'),
(1, 2, '2024-02-05', '100 mcg'),
(2, 3, '2024-05-20', '100 mcg'),
(3, 4, '2024-03-05', 'Placebo'),
(4, 5, '2024-03-20', 'Low Dose'),
(5, 6, '2024-04-05', 'High Dose'),
(7, 7, '2024-05-05', 'Low Dose'),
(8, 8, '2024-05-20', 'Placebo'),
(10, 9, '2024-06-20', 'High Dose'),
(10, 10, '2024-06-20', 'Low Dose');

-- Adverse Events
INSERT INTO adverse_events (study_id, participant_id, description, severity, report_date) VALUES
(1, 1, 'Mild fever and fatigue post vaccination', 'Mild', '2024-02-06'),
(1, 2, 'Slight pain at injection site', 'Mild', '2024-02-06'),
(2, 3, 'Moderate headache lasting 24 hours', 'Moderate', '2024-05-21'),
(3, 4, 'No adverse effects reported', 'Mild', '2024-03-06'),
(4, 5, 'Mild nausea', 'Mild', '2024-03-21'),
(5, 6, 'Severe chills and elevated temperature', 'Severe', '2024-04-06'),
(7, 7, 'Localized redness at injection site', 'Mild', '2024-05-06'),
(8, 8, 'Mild dizziness', 'Mild', '2024-05-21'),
(10, 9, 'Moderate muscle pain', 'Moderate', '2024-06-21'),
(10, 10, 'Mild fatigue', 'Mild', '2024-06-21');

-- Lab Tests
INSERT INTO lab_tests (study_id, participant_id, test_type, result_value, test_date) VALUES
(1, 1, 'Antibody Titres', '1:1280', '2024-02-20'),
(1, 2, 'Antibody Titres', '1:2560', '2024-02-20'),
(2, 3, 'T-cell Response', 'Positive (High)', '2024-06-05'),
(3, 4, 'Antibody Titres', '1:40', '2024-03-20'),
(4, 5, 'Neutralization Assay', '85% Neutralization', '2024-04-05'),
(5, 6, 'T-cell Response', 'Positive (Moderate)', '2024-04-25'),
(7, 7, 'Antibody Titres', '1:640', '2024-05-20'),
(8, 8, 'Neutralization Assay', '10% Neutralization', '2024-06-05'),
(10, 9, 'Antibody Titres', '1:3200', '2024-07-05'),
(10, 10, 'T-cell Response', 'Positive (High)', '2024-07-05');