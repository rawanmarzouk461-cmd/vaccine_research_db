USE vaccine_db;

-- Get mRNA vaccines
SELECT candidate_id, name, target_disease, created_date
FROM vaccine_candidates
WHERE technology_platform = 'mRNA';

-- Studies with vaccine and site info
SELECT 
    cs.study_id,
    vc.name AS vaccine_name,
    rs.site_name,
    cs.phase,
    cs.status,
    cs.start_date
FROM clinical_studies cs
JOIN vaccine_candidates vc ON cs.candidate_id = vc.candidate_id
JOIN research_sites rs ON cs.site_id = rs.site_id;

-- Adverse events details
SELECT 
    ae.event_id,
    p.anonymized_code,
    vc.name AS vaccine_name,
    ae.severity,
    ae.description,
    ae.report_date
FROM adverse_events ae
JOIN participants p ON ae.participant_id = p.participant_id
JOIN clinical_studies cs ON ae.study_id = cs.study_id
JOIN vaccine_candidates vc ON cs.candidate_id = vc.candidate_id;

-- Count participants per study
SELECT 
    cs.study_id,
    vc.name AS vaccine_name,
    cs.phase,
    COUNT(sp.participant_id) AS total_participants
FROM clinical_studies cs
JOIN vaccine_candidates vc ON cs.candidate_id = vc.candidate_id
LEFT JOIN study_participants sp ON cs.study_id = sp.study_id
GROUP BY cs.study_id, vc.name, cs.phase;

-- Sites with ongoing studies
SELECT 
    rs.site_name,
    rs.location,
    COUNT(cs.study_id) AS total_studies
FROM research_sites rs
JOIN clinical_studies cs ON rs.site_id = cs.site_id
GROUP BY rs.site_id, rs.site_name, rs.location
HAVING COUNT(cs.study_id) >= 1;

-- Participants with severe side effects
SELECT participant_id, anonymized_code, age, gender
FROM participants
WHERE participant_id IN (
    SELECT participant_id 
    FROM adverse_events 
    WHERE severity = 'Severe'
);

-- Vaccines with ongoing trials
SELECT candidate_id, name, target_disease
FROM vaccine_candidates vc
WHERE EXISTS (
    SELECT 1 
    FROM clinical_studies cs 
    WHERE cs.candidate_id = vc.candidate_id 
      AND cs.status = 'Ongoing'
);

-- Add lab test record
INSERT INTO lab_tests (study_id, participant_id, test_type, result_value, test_date)
VALUES (1, 1, 'Neutralization Assay', '95% Neutralization', '2024-08-01');

-- Update study status
UPDATE clinical_studies
SET status = 'Completed', end_date = '2024-08-01'
WHERE study_id = 2;

-- Delete low result record using Primary Key
DELETE FROM lab_tests
WHERE test_id = 4;