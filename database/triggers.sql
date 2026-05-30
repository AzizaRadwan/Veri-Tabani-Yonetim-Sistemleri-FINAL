-- ============================================================
-- MailSense AI
-- Database Triggers
-- DBMS: Microsoft SQL Server
-- File: triggers.sql
-- ============================================================

USE MailSenseAI;
GO

-- Drop existing triggers if they exist
DROP TRIGGER IF EXISTS trg_create_alert_on_high_risk;
GO

DROP TRIGGER IF EXISTS trg_log_ai_response_suggestion;
GO

-- ============================================================
-- 1. Trigger: Create Alert When High or Critical Risk Is Inserted
-- ============================================================
CREATE TRIGGER trg_create_alert_on_high_risk
ON risk_analysis
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO alerts (
        email_id,
        risk_id,
        alert_type,
        alert_message,
        alert_status,
        created_at
    )
    SELECT
        i.email_id,
        i.risk_id,
        'system',
        CONCAT(
            'Automatic alert: ',
            i.risk_level,
            ' risk detected with score ',
            CAST(i.risk_score AS NVARCHAR(20)),
            '. Action: ',
            ISNULL(i.recommended_action, 'No action provided.')
        ),
        'pending',
        GETDATE()
    FROM inserted i
    WHERE i.risk_level IN ('high', 'critical');
END;
GO

-- ============================================================
-- 2. Trigger: Log AI Response Suggestion Creation
-- ============================================================
CREATE TRIGGER trg_log_ai_response_suggestion
ON ai_response_suggestions
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO workflow_logs (
        workflow_name,
        email_id,
        execution_status,
        log_message,
        executed_at
    )
    SELECT
        '08 - AI Reply Suggestion',
        i.email_id,
        'success',
        CONCAT(
            'AI response suggestion created with tone: ',
            i.tone
        ),
        GETDATE()
    FROM inserted i;
END;
GO

-- ============================================================
-- Test Trigger 1: Insert a new critical risk record
-- ============================================================
INSERT INTO risk_analysis (
    email_id,
    risk_level,
    risk_score,
    detected_risk_factors,
    recommended_action
)
VALUES (
    2,
    'critical',
    0.91,
    'repeated technical failure; urgent escalation',
    'Escalate to technical manager immediately.'
);
GO

-- Check automatic alert
SELECT TOP 5
    alert_id,
    email_id,
    risk_id,
    alert_type,
    alert_message,
    alert_status,
    created_at
FROM alerts
ORDER BY alert_id DESC;
GO

-- ============================================================
-- Test Trigger 2: Insert a new AI response suggestion
-- ============================================================
INSERT INTO ai_response_suggestions (
    email_id,
    suggested_response,
    tone,
    approval_status
)
VALUES (
    2,
    'Dear customer, thank you for informing us about the setup issue. Our technical support team will review the error code and contact you shortly.',
    'technical',
    'pending'
);
GO

-- Check automatic workflow log
SELECT TOP 5
    log_id,
    workflow_name,
    email_id,
    execution_status,
    log_message,
    executed_at
FROM workflow_logs
ORDER BY log_id DESC;
GO