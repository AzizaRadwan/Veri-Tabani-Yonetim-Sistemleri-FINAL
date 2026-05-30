-- ============================================================
-- MailSense AI
-- AI-Powered Email Sentiment, Risk and Trend Analysis System
-- DBMS: Microsoft SQL Server
-- File: schema.sql
-- ============================================================

IF DB_ID('MailSenseAI') IS NULL
BEGIN
    CREATE DATABASE MailSenseAI;
END
GO

USE MailSenseAI;
GO

-- Drop tables if they already exist
DROP TABLE IF EXISTS workflow_logs;
DROP TABLE IF EXISTS ai_response_suggestions;
DROP TABLE IF EXISTS reports;
DROP TABLE IF EXISTS alerts;
DROP TABLE IF EXISTS email_keyword_map;
DROP TABLE IF EXISTS keywords;
DROP TABLE IF EXISTS risk_analysis;
DROP TABLE IF EXISTS sentiment_analysis;
DROP TABLE IF EXISTS email_category_map;
DROP TABLE IF EXISTS email_categories;
DROP TABLE IF EXISTS analysis_jobs;
DROP TABLE IF EXISTS emails;
DROP TABLE IF EXISTS email_threads;
DROP TABLE IF EXISTS email_accounts;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS departments;
GO

CREATE TABLE departments (
    department_id INT IDENTITY(1,1) PRIMARY KEY,
    department_name NVARCHAR(100) NOT NULL UNIQUE,
    description NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    department_id INT NULL,
    full_name NVARCHAR(150) NOT NULL,
    email NVARCHAR(150) NOT NULL UNIQUE,
    role NVARCHAR(50) NOT NULL,
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_users_departments 
        FOREIGN KEY (department_id) REFERENCES departments(department_id)
        ON DELETE SET NULL,

    CONSTRAINT CK_users_role 
        CHECK (role IN ('admin', 'manager', 'analyst', 'support_agent'))
);

CREATE TABLE email_accounts (
    account_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    email_address NVARCHAR(150) NOT NULL UNIQUE,
    provider NVARCHAR(50) NOT NULL,
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_email_accounts_users
        FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE
);

CREATE TABLE email_threads (
    thread_id INT IDENTITY(1,1) PRIMARY KEY,
    external_thread_id NVARCHAR(255) UNIQUE,
    subject NVARCHAR(255),
    first_email_date DATETIME,
    last_email_date DATETIME,
    created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE emails (
    email_id INT IDENTITY(1,1) PRIMARY KEY,
    account_id INT NOT NULL,
    thread_id INT NULL,
    external_email_id NVARCHAR(255) UNIQUE,
    sender_email NVARCHAR(150) NOT NULL,
    receiver_email NVARCHAR(150) NOT NULL,
    subject NVARCHAR(255),
    body NVARCHAR(MAX) NOT NULL,
    received_at DATETIME NOT NULL,
    processing_status NVARCHAR(30) DEFAULT 'pending',
    created_at DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_emails_accounts
        FOREIGN KEY (account_id) REFERENCES email_accounts(account_id)
        ON DELETE CASCADE,

    CONSTRAINT FK_emails_threads
        FOREIGN KEY (thread_id) REFERENCES email_threads(thread_id)
        ON DELETE SET NULL,

    CONSTRAINT CK_emails_processing_status
        CHECK (processing_status IN ('pending', 'processed', 'failed'))
);

CREATE TABLE analysis_jobs (
    job_id INT IDENTITY(1,1) PRIMARY KEY,
    email_id INT NOT NULL,
    job_type NVARCHAR(50) NOT NULL,
    job_status NVARCHAR(30) DEFAULT 'waiting',
    started_at DATETIME NULL,
    finished_at DATETIME NULL,
    error_message NVARCHAR(MAX),

    CONSTRAINT FK_analysis_jobs_emails
        FOREIGN KEY (email_id) REFERENCES emails(email_id)
        ON DELETE CASCADE,

    CONSTRAINT CK_analysis_jobs_type
        CHECK (job_type IN ('sentiment', 'risk', 'category', 'keyword', 'reply_suggestion')),

    CONSTRAINT CK_analysis_jobs_status
        CHECK (job_status IN ('waiting', 'running', 'completed', 'failed'))
);

CREATE TABLE email_categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    category_name NVARCHAR(100) NOT NULL UNIQUE,
    description NVARCHAR(MAX)
);

CREATE TABLE email_category_map (
    map_id INT IDENTITY(1,1) PRIMARY KEY,
    email_id INT NOT NULL,
    category_id INT NOT NULL,
    classified_at DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_email_category_map_emails
        FOREIGN KEY (email_id) REFERENCES emails(email_id)
        ON DELETE CASCADE,

    CONSTRAINT FK_email_category_map_categories
        FOREIGN KEY (category_id) REFERENCES email_categories(category_id)
        ON DELETE CASCADE
);

CREATE TABLE sentiment_analysis (
    sentiment_id INT IDENTITY(1,1) PRIMARY KEY,
    email_id INT NOT NULL,
    sentiment_label NVARCHAR(20) NOT NULL,
    sentiment_score DECIMAL(5,2) NOT NULL,
    anger_score DECIMAL(5,2) DEFAULT 0,
    satisfaction_score DECIMAL(5,2) DEFAULT 0,
    urgency_score DECIMAL(5,2) DEFAULT 0,
    summary NVARCHAR(MAX),
    analyzed_at DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_sentiment_emails
        FOREIGN KEY (email_id) REFERENCES emails(email_id)
        ON DELETE CASCADE,

    CONSTRAINT CK_sentiment_label
        CHECK (sentiment_label IN ('positive', 'neutral', 'negative')),

    CONSTRAINT CK_sentiment_score
        CHECK (sentiment_score BETWEEN -1.00 AND 1.00),

    CONSTRAINT CK_anger_score
        CHECK (anger_score BETWEEN 0.00 AND 1.00),

    CONSTRAINT CK_satisfaction_score
        CHECK (satisfaction_score BETWEEN 0.00 AND 1.00),

    CONSTRAINT CK_urgency_score
        CHECK (urgency_score BETWEEN 0.00 AND 1.00)
);

CREATE TABLE risk_analysis (
    risk_id INT IDENTITY(1,1) PRIMARY KEY,
    email_id INT NOT NULL,
    risk_level NVARCHAR(20) NOT NULL,
    risk_score DECIMAL(5,2) NOT NULL,
    detected_risk_factors NVARCHAR(MAX),
    recommended_action NVARCHAR(MAX),
    analyzed_at DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_risk_emails
        FOREIGN KEY (email_id) REFERENCES emails(email_id)
        ON DELETE CASCADE,

    CONSTRAINT CK_risk_level
        CHECK (risk_level IN ('low', 'medium', 'high', 'critical')),

    CONSTRAINT CK_risk_score
        CHECK (risk_score BETWEEN 0.00 AND 1.00)
);

CREATE TABLE keywords (
    keyword_id INT IDENTITY(1,1) PRIMARY KEY,
    keyword_text NVARCHAR(100) NOT NULL UNIQUE,
    keyword_type NVARCHAR(50) NOT NULL,

    CONSTRAINT CK_keyword_type
        CHECK (keyword_type IN ('complaint', 'payment', 'technical', 'legal', 'urgent', 'general'))
);

CREATE TABLE email_keyword_map (
    email_id INT NOT NULL,
    keyword_id INT NOT NULL,
    frequency INT DEFAULT 1,

    PRIMARY KEY (email_id, keyword_id),

    CONSTRAINT FK_email_keyword_map_emails
        FOREIGN KEY (email_id) REFERENCES emails(email_id)
        ON DELETE CASCADE,

    CONSTRAINT FK_email_keyword_map_keywords
        FOREIGN KEY (keyword_id) REFERENCES keywords(keyword_id)
        ON DELETE CASCADE,

    CONSTRAINT CK_keyword_frequency
        CHECK (frequency > 0)
);

CREATE TABLE alerts (
    alert_id INT IDENTITY(1,1) PRIMARY KEY,
    email_id INT NOT NULL,
    risk_id INT NULL,
    alert_type NVARCHAR(50) NOT NULL,
    alert_message NVARCHAR(MAX) NOT NULL,
    alert_status NVARCHAR(30) DEFAULT 'pending',
    sent_at DATETIME NULL,
    created_at DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_alerts_emails
        FOREIGN KEY (email_id) REFERENCES emails(email_id)
        ON DELETE CASCADE,

    CONSTRAINT FK_alerts_risk
        FOREIGN KEY (risk_id) REFERENCES risk_analysis(risk_id)
        ON DELETE NO ACTION,

    CONSTRAINT CK_alert_type
        CHECK (alert_type IN ('email', 'slack', 'telegram', 'system')),

    CONSTRAINT CK_alert_status
        CHECK (alert_status IN ('pending', 'sent', 'failed'))
);

CREATE TABLE reports (
    report_id INT IDENTITY(1,1) PRIMARY KEY,
    report_title NVARCHAR(255) NOT NULL,
    report_type NVARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    report_content NVARCHAR(MAX),
    generated_by INT NULL,
    generated_at DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_reports_users
        FOREIGN KEY (generated_by) REFERENCES users(user_id)
        ON DELETE SET NULL,

    CONSTRAINT CK_report_type
        CHECK (report_type IN ('daily', 'weekly', 'monthly'))
);

CREATE TABLE ai_response_suggestions (
    suggestion_id INT IDENTITY(1,1) PRIMARY KEY,
    email_id INT NOT NULL,
    suggested_response NVARCHAR(MAX) NOT NULL,
    tone NVARCHAR(50) NOT NULL,
    approval_status NVARCHAR(30) DEFAULT 'pending',
    created_at DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_ai_response_emails
        FOREIGN KEY (email_id) REFERENCES emails(email_id)
        ON DELETE CASCADE,

    CONSTRAINT CK_response_tone
        CHECK (tone IN ('formal', 'friendly', 'apologetic', 'technical', 'urgent')),

    CONSTRAINT CK_approval_status
        CHECK (approval_status IN ('pending', 'approved', 'rejected'))
);

CREATE TABLE workflow_logs (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    workflow_name NVARCHAR(150) NOT NULL,
    email_id INT NULL,
    execution_status NVARCHAR(30) NOT NULL,
    log_message NVARCHAR(MAX),
    executed_at DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_workflow_logs_emails
        FOREIGN KEY (email_id) REFERENCES emails(email_id)
        ON DELETE SET NULL,

    CONSTRAINT CK_workflow_execution_status
        CHECK (execution_status IN ('success', 'failed', 'running'))
);
GO

-- Indexes for performance
CREATE INDEX idx_emails_received_at ON emails(received_at);
CREATE INDEX idx_emails_processing_status ON emails(processing_status);
CREATE INDEX idx_sentiment_email_id ON sentiment_analysis(email_id);
CREATE INDEX idx_risk_email_id ON risk_analysis(email_id);
CREATE INDEX idx_risk_level ON risk_analysis(risk_level);
CREATE INDEX idx_email_category_map_email_id ON email_category_map(email_id);
CREATE INDEX idx_email_category_map_category_id ON email_category_map(category_id);
CREATE INDEX idx_alert_status ON alerts(alert_status);
CREATE INDEX idx_workflow_name ON workflow_logs(workflow_name);
GO