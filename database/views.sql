-- ============================================================
-- MailSense AI
-- Database Views
-- DBMS: Microsoft SQL Server
-- File: views.sql
-- ============================================================

USE MailSenseAI;
GO

-- Drop existing views if they exist
DROP VIEW IF EXISTS vw_email_analysis_summary;
GO

DROP VIEW IF EXISTS vw_high_risk_emails;
GO

DROP VIEW IF EXISTS vw_sentiment_distribution;
GO

DROP VIEW IF EXISTS vw_daily_email_trends;
GO

DROP VIEW IF EXISTS vw_pending_ai_responses;
GO

-- ============================================================
-- 1. Email Analysis Summary View
-- ============================================================
CREATE VIEW vw_email_analysis_summary AS
SELECT
    e.email_id,
    e.sender_email,
    e.receiver_email,
    e.subject,
    e.received_at,
    e.processing_status,
    s.sentiment_label,
    s.sentiment_score,
    s.anger_score,
    s.satisfaction_score,
    s.urgency_score,
    r.risk_level,
    r.risk_score,
    r.detected_risk_factors,
    r.recommended_action
FROM emails e
LEFT JOIN sentiment_analysis s ON e.email_id = s.email_id
LEFT JOIN risk_analysis r ON e.email_id = r.email_id;
GO

-- ============================================================
-- 2. High Risk Emails View
-- ============================================================
CREATE VIEW vw_high_risk_emails AS
SELECT
    e.email_id,
    e.sender_email,
    e.receiver_email,
    e.subject,
    e.body,
    e.received_at,
    r.risk_level,
    r.risk_score,
    r.detected_risk_factors,
    r.recommended_action
FROM emails e
INNER JOIN risk_analysis r ON e.email_id = r.email_id
WHERE r.risk_level IN ('high', 'critical');
GO

-- ============================================================
-- 3. Sentiment Distribution View
-- ============================================================
CREATE VIEW vw_sentiment_distribution AS
SELECT
    sentiment_label,
    COUNT(*) AS total_emails,
    AVG(sentiment_score) AS average_sentiment_score,
    MIN(sentiment_score) AS minimum_sentiment_score,
    MAX(sentiment_score) AS maximum_sentiment_score
FROM sentiment_analysis
GROUP BY sentiment_label;
GO

-- ============================================================
-- 4. Daily Email Trends View
-- ============================================================
CREATE VIEW vw_daily_email_trends AS
SELECT
    CAST(e.received_at AS DATE) AS email_date,
    COUNT(e.email_id) AS total_emails,
    SUM(CASE WHEN s.sentiment_label = 'positive' THEN 1 ELSE 0 END) AS positive_emails,
    SUM(CASE WHEN s.sentiment_label = 'neutral' THEN 1 ELSE 0 END) AS neutral_emails,
    SUM(CASE WHEN s.sentiment_label = 'negative' THEN 1 ELSE 0 END) AS negative_emails,
    SUM(CASE WHEN r.risk_level IN ('high', 'critical') THEN 1 ELSE 0 END) AS high_risk_emails,
    AVG(s.sentiment_score) AS average_sentiment_score,
    AVG(r.risk_score) AS average_risk_score
FROM emails e
LEFT JOIN sentiment_analysis s ON e.email_id = s.email_id
LEFT JOIN risk_analysis r ON e.email_id = r.email_id
GROUP BY CAST(e.received_at AS DATE);
GO

-- ============================================================
-- 5. Pending AI Response Suggestions View
-- ============================================================
CREATE VIEW vw_pending_ai_responses AS
SELECT
    ars.suggestion_id,
    e.email_id,
    e.sender_email,
    e.subject,
    ars.suggested_response,
    ars.tone,
    ars.approval_status,
    ars.created_at
FROM ai_response_suggestions ars
INNER JOIN emails e ON ars.email_id = e.email_id
WHERE ars.approval_status = 'pending';
GO

-- ============================================================
-- Test Views
-- ============================================================
SELECT * FROM vw_email_analysis_summary;
SELECT * FROM vw_high_risk_emails;
SELECT * FROM vw_sentiment_distribution;
SELECT * FROM vw_daily_email_trends;
SELECT * FROM vw_pending_ai_responses;
GO