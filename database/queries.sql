-- ============================================================
-- MailSense AI
-- Sample SQL Queries
-- DBMS: Microsoft SQL Server
-- File: queries.sql
-- ============================================================

USE MailSenseAI;
GO

-- ============================================================
-- 1. List all emails with sentiment and risk results
-- ============================================================
SELECT 
    e.email_id,
    e.sender_email,
    e.receiver_email,
    e.subject,
    s.sentiment_label,
    s.sentiment_score,
    r.risk_level,
    r.risk_score,
    e.received_at
FROM emails e
LEFT JOIN sentiment_analysis s ON e.email_id = s.email_id
LEFT JOIN risk_analysis r ON e.email_id = r.email_id
ORDER BY e.received_at DESC;
GO

-- ============================================================
-- 2. Show high and critical risk emails
-- ============================================================
SELECT 
    e.email_id,
    e.sender_email,
    e.subject,
    r.risk_level,
    r.risk_score,
    r.detected_risk_factors,
    r.recommended_action
FROM emails e
INNER JOIN risk_analysis r ON e.email_id = r.email_id
WHERE r.risk_level IN ('high', 'critical')
ORDER BY r.risk_score DESC;
GO

-- ============================================================
-- 3. Sentiment distribution report
-- ============================================================
SELECT 
    sentiment_label,
    COUNT(*) AS total_emails,
    AVG(sentiment_score) AS average_sentiment_score
FROM sentiment_analysis
GROUP BY sentiment_label
ORDER BY total_emails DESC;
GO

-- ============================================================
-- 4. Average risk score by risk level
-- ============================================================
SELECT
    risk_level,
    COUNT(*) AS total_emails,
    AVG(risk_score) AS average_risk_score
FROM risk_analysis
GROUP BY risk_level
ORDER BY average_risk_score DESC;
GO

-- ============================================================
-- 5. Most frequent detected keywords
-- ============================================================
SELECT 
    k.keyword_text,
    k.keyword_type,
    SUM(ekm.frequency) AS total_frequency
FROM keywords k
INNER JOIN email_keyword_map ekm ON k.keyword_id = ekm.keyword_id
GROUP BY k.keyword_text, k.keyword_type
ORDER BY total_frequency DESC;
GO

-- ============================================================
-- 6. Emails that generated alerts
-- ============================================================
SELECT 
    a.alert_id,
    e.sender_email,
    e.subject,
    a.alert_type,
    a.alert_status,
    a.alert_message,
    a.sent_at
FROM alerts a
INNER JOIN emails e ON a.email_id = e.email_id
ORDER BY a.created_at DESC;
GO

-- ============================================================
-- 7. AI response suggestions waiting for approval
-- ============================================================
SELECT 
    ars.suggestion_id,
    e.sender_email,
    e.subject,
    ars.tone,
    ars.approval_status,
    ars.suggested_response
FROM ai_response_suggestions ars
INNER JOIN emails e ON ars.email_id = e.email_id
WHERE ars.approval_status = 'pending';
GO

-- ============================================================
-- 8. Workflow execution logs
-- ============================================================
SELECT 
    log_id,
    workflow_name,
    execution_status,
    log_message,
    executed_at
FROM workflow_logs
ORDER BY executed_at DESC;
GO

-- ============================================================
-- 9. Daily email volume
-- ============================================================
SELECT
    CAST(received_at AS DATE) AS email_date,
    COUNT(*) AS total_emails
FROM emails
GROUP BY CAST(received_at AS DATE)
ORDER BY email_date;
GO

-- ============================================================
-- 10. Critical business summary
-- ============================================================
SELECT
    COUNT(e.email_id) AS total_emails,
    SUM(CASE WHEN s.sentiment_label = 'negative' THEN 1 ELSE 0 END) AS negative_emails,
    SUM(CASE WHEN s.sentiment_label = 'positive' THEN 1 ELSE 0 END) AS positive_emails,
    SUM(CASE WHEN r.risk_level IN ('high', 'critical') THEN 1 ELSE 0 END) AS high_risk_emails,
    AVG(s.sentiment_score) AS average_sentiment_score,
    AVG(r.risk_score) AS average_risk_score
FROM emails e
LEFT JOIN sentiment_analysis s ON e.email_id = s.email_id
LEFT JOIN risk_analysis r ON e.email_id = r.email_id;
GO