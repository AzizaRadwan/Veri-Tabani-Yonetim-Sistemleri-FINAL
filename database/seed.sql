-- ============================================================
-- MailSense AI
-- Sample Data - Fixed Version
-- DBMS: Microsoft SQL Server
-- File: seed.sql
-- ============================================================

USE MailSenseAI;
GO

-- Delete old data in correct order
DELETE FROM workflow_logs;
DELETE FROM ai_response_suggestions;
DELETE FROM reports;
DELETE FROM alerts;
DELETE FROM email_keyword_map;
DELETE FROM keywords;
DELETE FROM risk_analysis;
DELETE FROM sentiment_analysis;
DELETE FROM email_categories;
DELETE FROM analysis_jobs;
DELETE FROM emails;
DELETE FROM email_threads;
DELETE FROM email_accounts;
DELETE FROM users;
DELETE FROM departments;
GO

-- ============================================================
-- Departments
-- ============================================================
SET IDENTITY_INSERT departments ON;

INSERT INTO departments (department_id, department_name, description)
VALUES
(1, 'Customer Support', 'Handles customer questions, complaints and support requests.'),
(2, 'Sales', 'Responsible for sales operations and customer conversion.'),
(3, 'Technical Support', 'Handles technical problems and product issues.'),
(4, 'Management', 'Monitors business performance and critical risks.');

SET IDENTITY_INSERT departments OFF;
GO

-- ============================================================
-- Users
-- ============================================================
SET IDENTITY_INSERT users ON;

INSERT INTO users (user_id, department_id, full_name, email, role, is_active)
VALUES
(1, 1, 'Ayşe Demir', 'ayse.demir@mailsense.local', 'support_agent', 1),
(2, 1, 'Mehmet Kaya', 'mehmet.kaya@mailsense.local', 'manager', 1),
(3, 2, 'Elif Yılmaz', 'elif.yilmaz@mailsense.local', 'analyst', 1),
(4, 3, 'Can Arslan', 'can.arslan@mailsense.local', 'support_agent', 1),
(5, 4, 'Azize Rdwan', 'ahmad.radwan@mailsense.local', 'admin', 1);

SET IDENTITY_INSERT users OFF;
GO

-- ============================================================
-- Email Accounts
-- ============================================================
SET IDENTITY_INSERT email_accounts ON;

INSERT INTO email_accounts (account_id, user_id, email_address, provider, is_active)
VALUES
(1, 1, 'support@mailsense.local', 'Gmail', 1),
(2, 2, 'manager@mailsense.local', 'Outlook', 1),
(3, 3, 'sales@mailsense.local', 'Gmail', 1),
(4, 4, 'tech@mailsense.local', 'IMAP', 1);

SET IDENTITY_INSERT email_accounts OFF;
GO

-- ============================================================
-- Email Threads
-- ============================================================
SET IDENTITY_INSERT email_threads ON;

INSERT INTO email_threads (thread_id, external_thread_id, subject, first_email_date, last_email_date)
VALUES
(1, 'thread-1001', 'Refund request for delayed order', '2026-05-10 09:15:00', '2026-05-10 10:05:00'),
(2, 'thread-1002', 'Product setup problem', '2026-05-11 14:20:00', '2026-05-11 15:40:00'),
(3, 'thread-1003', 'Positive feedback about support team', '2026-05-12 11:00:00', '2026-05-12 11:30:00'),
(4, 'thread-1004', 'Cancellation and legal complaint warning', '2026-05-13 16:45:00', '2026-05-13 17:10:00'),
(5, 'thread-1005', 'Pricing information request', '2026-05-14 10:10:00', '2026-05-14 10:25:00');

SET IDENTITY_INSERT email_threads OFF;
GO

-- ============================================================
-- Emails
-- ============================================================
SET IDENTITY_INSERT emails ON;

INSERT INTO emails (
    email_id, account_id, thread_id, external_email_id, sender_email, receiver_email,
    subject, body, received_at, processing_status
)
VALUES
(1, 1, 1, 'email-2001', 'customer1@example.com', 'support@mailsense.local',
 'Refund request for delayed order',
 'Hello, my order was delayed for more than two weeks. I am very unhappy and I want a refund immediately.',
 '2026-05-10 09:15:00', 'processed'),

(2, 4, 2, 'email-2002', 'customer2@example.com', 'tech@mailsense.local',
 'Product setup problem',
 'Hi, I cannot complete the product installation. The setup page gives an error code and I need technical help.',
 '2026-05-11 14:20:00', 'processed'),

(3, 1, 3, 'email-2003', 'customer3@example.com', 'support@mailsense.local',
 'Positive feedback about support team',
 'Your support team solved my problem quickly. Thank you for the helpful and friendly service.',
 '2026-05-12 11:00:00', 'processed'),

(4, 1, 4, 'email-2004', 'customer4@example.com', 'support@mailsense.local',
 'Cancellation and legal complaint warning',
 'I am extremely angry. If this issue is not solved today, I will cancel my account and start a legal complaint.',
 '2026-05-13 16:45:00', 'processed'),

(5, 3, 5, 'email-2005', 'customer5@example.com', 'sales@mailsense.local',
 'Pricing information request',
 'Hello, I would like to get more information about your enterprise pricing plans.',
 '2026-05-14 10:10:00', 'processed');

SET IDENTITY_INSERT emails OFF;
GO

-- ============================================================
-- Analysis Jobs
-- ============================================================
SET IDENTITY_INSERT analysis_jobs ON;

INSERT INTO analysis_jobs (job_id, email_id, job_type, job_status, started_at, finished_at)
VALUES
(1, 1, 'sentiment', 'completed', '2026-05-10 09:16:00', '2026-05-10 09:16:08'),
(2, 1, 'risk', 'completed', '2026-05-10 09:16:10', '2026-05-10 09:16:15'),
(3, 2, 'sentiment', 'completed', '2026-05-11 14:21:00', '2026-05-11 14:21:07'),
(4, 3, 'sentiment', 'completed', '2026-05-12 11:01:00', '2026-05-12 11:01:05'),
(5, 4, 'risk', 'completed', '2026-05-13 16:46:00', '2026-05-13 16:46:10');

SET IDENTITY_INSERT analysis_jobs OFF;
GO

-- ============================================================
-- Email Categories
-- ============================================================
SET IDENTITY_INSERT email_categories ON;

INSERT INTO email_categories (category_id, category_name, description)
VALUES
(1, 'Complaint', 'Emails containing dissatisfaction or complaint intent.'),
(2, 'Technical Support', 'Emails related to technical errors or installation problems.'),
(3, 'Positive Feedback', 'Emails containing satisfaction and appreciation.'),
(4, 'Cancellation Risk', 'Emails that may lead to customer churn.'),
(5, 'Sales Inquiry', 'Emails requesting pricing or product information.');

SET IDENTITY_INSERT email_categories OFF;
GO

-- ============================================================
-- Sentiment Analysis
-- ============================================================
SET IDENTITY_INSERT sentiment_analysis ON;

INSERT INTO sentiment_analysis (
    sentiment_id, email_id, sentiment_label, sentiment_score,
    anger_score, satisfaction_score, urgency_score, summary
)
VALUES
(1, 1, 'negative', -0.78, 0.70, 0.10, 0.85,
 'Customer is unhappy because of delivery delay and requests a refund urgently.'),

(2, 2, 'neutral', -0.10, 0.20, 0.30, 0.60,
 'Customer reports a technical setup issue and requests help.'),

(3, 3, 'positive', 0.92, 0.00, 0.95, 0.20,
 'Customer thanks the support team and gives positive feedback.'),

(4, 4, 'negative', -0.95, 0.95, 0.05, 0.98,
 'Customer is very angry and threatens cancellation and legal complaint.'),

(5, 5, 'neutral', 0.15, 0.00, 0.50, 0.30,
 'Customer requests pricing information about enterprise plans.');

SET IDENTITY_INSERT sentiment_analysis OFF;
GO

-- ============================================================
-- Risk Analysis
-- ============================================================
SET IDENTITY_INSERT risk_analysis ON;

INSERT INTO risk_analysis (
    risk_id, email_id, risk_level, risk_score, detected_risk_factors, recommended_action
)
VALUES
(1, 1, 'high', 0.82, 'refund request; delayed order; urgent language',
 'Assign to support manager and respond within 1 hour.'),

(2, 2, 'medium', 0.45, 'technical issue; setup error',
 'Assign to technical support team.'),

(3, 3, 'low', 0.05, 'positive feedback',
 'No urgent action required. Store as positive customer feedback.'),

(4, 4, 'critical', 0.96, 'legal complaint; cancellation threat; angry language; urgent deadline',
 'Escalate to management immediately and create priority support ticket.'),

(5, 5, 'low', 0.10, 'pricing inquiry',
 'Forward to sales team.');

SET IDENTITY_INSERT risk_analysis OFF;
GO

-- ============================================================
-- Keywords
-- ============================================================
SET IDENTITY_INSERT keywords ON;

INSERT INTO keywords (keyword_id, keyword_text, keyword_type)
VALUES
(1, 'refund', 'payment'),
(2, 'delayed', 'complaint'),
(3, 'urgent', 'urgent'),
(4, 'technical help', 'technical'),
(5, 'error code', 'technical'),
(6, 'thank you', 'general'),
(7, 'legal complaint', 'legal'),
(8, 'cancel', 'complaint'),
(9, 'pricing', 'payment'),
(10, 'enterprise', 'general');

SET IDENTITY_INSERT keywords OFF;
GO

-- ============================================================
-- Email Keyword Map
-- ============================================================
INSERT INTO email_keyword_map (email_id, keyword_id, frequency)
VALUES
(1, 1, 1),
(1, 2, 1),
(1, 3, 1),
(2, 4, 1),
(2, 5, 1),
(3, 6, 1),
(4, 7, 1),
(4, 8, 1),
(5, 9, 1),
(5, 10, 1);
GO

-- ============================================================
-- Alerts
-- ============================================================
SET IDENTITY_INSERT alerts ON;

INSERT INTO alerts (alert_id, email_id, risk_id, alert_type, alert_message, alert_status, sent_at)
VALUES
(1, 1, 1, 'slack', 'High risk refund request detected for customer1@example.com.', 'sent', '2026-05-10 09:17:00'),
(2, 4, 4, 'email', 'Critical legal complaint and cancellation risk detected.', 'sent', '2026-05-13 16:47:00');

SET IDENTITY_INSERT alerts OFF;
GO

-- ============================================================
-- Reports
-- ============================================================
SET IDENTITY_INSERT reports ON;

INSERT INTO reports (
    report_id, report_title, report_type, start_date, end_date, report_content, generated_by
)
VALUES
(1, 'Weekly Email Sentiment and Risk Report', 'weekly', '2026-05-10', '2026-05-16',
 'This weekly report summarizes sentiment distribution, high-risk emails and customer communication trends.',
 5);

SET IDENTITY_INSERT reports OFF;
GO

-- ============================================================
-- AI Response Suggestions
-- ============================================================
SET IDENTITY_INSERT ai_response_suggestions ON;

INSERT INTO ai_response_suggestions (
    suggestion_id, email_id, suggested_response, tone, approval_status
)
VALUES
(1, 1,
 'Dear customer, we are sorry for the delay in your order. We understand your frustration and will review your refund request immediately.',
 'apologetic', 'pending'),

(2, 4,
 'Dear customer, we sincerely apologize for the inconvenience. Your issue has been escalated to our management team and will be handled with priority today.',
 'urgent', 'pending');

SET IDENTITY_INSERT ai_response_suggestions OFF;
GO

-- ============================================================
-- Workflow Logs
-- ============================================================
SET IDENTITY_INSERT workflow_logs ON;

INSERT INTO workflow_logs (
    log_id, workflow_name, email_id, execution_status, log_message
)
VALUES
(1, '01 - Email Collector', 1, 'success', 'Email collected successfully from support inbox.'),
(2, '02 - AI Sentiment Analysis', 1, 'success', 'Sentiment analysis completed.'),
(3, '03 - Risk Detection', 4, 'success', 'Critical risk detected and alert workflow triggered.'),
(4, '06 - Alert Notification', 4, 'success', 'Critical alert sent to management team.');

SET IDENTITY_INSERT workflow_logs OFF;
GO

-- ============================================================
-- Test Output
-- ============================================================
SELECT 'Seed data inserted successfully.' AS result;
GO