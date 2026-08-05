USE vaccine_db;

-- Summary view for clinical studies
CREATE OR REPLACE VIEW vw_study_overview AS
SELECT 
    cs.study_id,
    vc.name AS vaccine_name,
    rs.site_name,
    cs.phase,
    cs.status,
    COUNT(DISTINCT sp.participant_id) AS total_participants,
    COUNT(DISTINCT ae.event_id) AS total_adverse_events
FROM clinical_studies cs
JOIN vaccine_candidates vc ON cs.candidate_id = vc.candidate_id
JOIN research_sites rs ON cs.site_id = rs.site_id
LEFT JOIN study_participants sp ON cs.study_id = sp.study_id
LEFT JOIN adverse_events ae ON cs.study_id = ae.study_id
GROUP BY cs.study_id, vc.name, rs.site_name, cs.phase, cs.status;

-- Detailed adverse events report view
CREATE OR REPLACE VIEW vw_active_adverse_events AS
SELECT 
    ae.event_id,
    p.anonymized_code,
    p.age,
    p.gender,
    vc.name AS vaccine_name,
    cs.phase,
    ae.severity,
    ae.description,
    ae.report_date
FROM adverse_events ae
JOIN participants p ON ae.participant_id = p.participant_id
JOIN clinical_studies cs ON ae.study_id = cs.study_id
JOIN vaccine_candidates vc ON cs.candidate_id = vc.candidate_id;

-- Testing the views
SELECT * FROM vw_study_overview;
SELECT * FROM vw_active_adverse_events;