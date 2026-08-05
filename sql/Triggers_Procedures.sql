USE vaccine_db;

DROP PROCEDURE IF EXISTS sp_get_study_summary;
DROP FUNCTION IF EXISTS fn_get_study_count;

DELIMITER //

-- Stored Procedure to get summary for a specific study
CREATE PROCEDURE sp_get_study_summary(IN p_study_id INT)
BEGIN
    SELECT 
        cs.study_id,
        vc.name AS vaccine_name,
        cs.phase,
        cs.status,
        COUNT(sp.participant_id) AS total_participants
    FROM clinical_studies cs
    JOIN vaccine_candidates vc ON cs.candidate_id = vc.candidate_id
    LEFT JOIN study_participants sp ON cs.study_id = sp.study_id
    WHERE cs.study_id = p_study_id
    GROUP BY cs.study_id, vc.name, cs.phase, cs.status;
END //

-- Stored Function to calculate total studies for a candidate
CREATE FUNCTION fn_get_study_count(p_candidate_id INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE study_count INT;
    SELECT COUNT(*) INTO study_count 
    FROM clinical_studies 
    WHERE candidate_id = p_candidate_id;
    RETURN study_count;
END //

DELIMITER ;

-- Test Execution
CALL sp_get_study_summary(1);
SELECT fn_get_study_count(1) AS total_candidate_studies;