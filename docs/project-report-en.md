# MailSense AI: AI-Powered Sentiment, Risk and Trend Analysis System from Email Correspondence

**Azize Rdwan**  
Student ID: 224410112  
Database Management Systems Course  
Kastamonu University  
azizaradwan08@gmail.com

---

## Abstract

In this study, an AI-powered database management system capable of performing sentiment trend analysis from email correspondence is designed. The developed system collects incoming emails, performs sentiment analysis on their content, determines risk levels, extracts keywords, and generates automatic alerts in critical cases. The database layer of the project is implemented using Microsoft SQL Server. Tables, relationships, constraints, views, triggers, and sample reporting queries are prepared as part of the system. On the automation side, an n8n workflow architecture is planned to support email collection, AI analysis, risk detection, notification, and reporting processes in a modular structure. This project aims to demonstrate relational database design, normalization, data integrity, reporting, and automation concepts within a realistic scenario for the Database Management Systems course.

**Keywords:** Database Management Systems, SQL Server, n8n, Artificial Intelligence, Sentiment Analysis, Risk Analysis, Email Analysis

---

## I. Introduction

Today, organizations communicate with customers, employees, and business partners mainly through email. These emails are not only text-based messages; they also contain important business signals such as customer satisfaction, complaints, technical issues, cancellation risks, payment requests, and legal warnings. However, manually reviewing thousands of emails is time-consuming and may cause critical messages to be missed.

This project designs a professional system that automatically analyzes email correspondence and stores the results in a relational database. With AI-supported analysis logic, the system can determine the sentiment, risk level, urgency, and important keywords of each email. As a result, organizations can detect communication trends faster and respond earlier to risky situations.

MailSense AI is not only an artificial intelligence application. It is also a comprehensive database management system project. In this project, core DBMS concepts such as data modeling, table relationships, primary keys, foreign keys, check constraints, indexes, views, and triggers are implemented.

---

## II. Problem Definition

Corporate email systems accumulate a large number of messages. These messages may include positive feedback, complaints, technical problems, payment issues, cancellation requests, and legal risks. Manually analyzing these messages is inefficient and prone to human error.

The problem can be summarized under the following points:

- Emails containing negative sentiment may be detected too late.
- Customer messages with critical risk may be overlooked.
- Regular trend reports cannot be easily generated from email content.
- Keyword and topic distribution cannot be tracked manually at scale.
- There is no early warning mechanism for customer communication risks.
- Email analysis data is not stored in a centralized relational structure.

Therefore, there is a need for a system that analyzes email content, records the results in a database, and makes them available for reporting and decision support.

---

## III. Project Objective

The main objective of this project is to develop a system that performs AI-powered sentiment, risk, and trend analysis from email correspondence. The system supports decision-making by analyzing incoming emails and storing structured results.

The sub-objectives of the project are:

1. To store incoming emails in a relational database in an organized way.
2. To classify emails as positive, negative, or neutral.
3. To determine a risk level for each email.
4. To create automatic alerts for high and critical risk emails.
5. To extract and classify important keywords.
6. To store AI-generated response suggestions.
7. To support daily and weekly reporting.
8. To design a multi-step workflow architecture using n8n.
9. To apply database management system concepts in a realistic scenario.

---

## IV. Technologies Used

The main technologies used in this project are listed below:

| Technology | Description |
|---|---|
| Microsoft SQL Server | Used as the relational database management system. |
| SQL Server Management Studio | Used to write, execute, and test SQL scripts. |
| n8n | Planned for automation and workflow management. |
| AI Model | Used for sentiment analysis, risk analysis, and response suggestion generation. |
| GitHub | Used for version control and project sharing. |
| Markdown | Used for README files and project documentation. |

---

## V. System Architecture

MailSense AI has a modular system architecture. The system consists of an email collection layer, AI analysis layer, database layer, notification layer, and reporting layer.

The general system flow is as follows:

1. n8n collects new emails from Gmail, Outlook, or IMAP.
2. Email information is stored in the `emails` table in SQL Server.
3. The AI analysis workflow processes the email content.
4. Sentiment analysis results are stored in the `sentiment_analysis` table.
5. Risk analysis results are stored in the `risk_analysis` table.
6. If the risk is high or critical, the system creates an alert record in the `alerts` table.
7. If needed, AI-generated response suggestions are stored in the `ai_response_suggestions` table.
8. Workflow processes are tracked in the `workflow_logs` table.
9. Results are analyzed through reporting queries and database views.

This architecture makes the system modular, maintainable, and extendable.

---

## VI. Database Design

The database design of the project is implemented using Microsoft SQL Server. The database name is defined as `MailSenseAI`.

The main tables used in the system are listed below:

| Table | Purpose |
|---|---|
| departments | Stores department information. |
| users | Stores system users. |
| email_accounts | Stores connected email accounts. |
| email_threads | Stores email conversation threads. |
| emails | Stores incoming email records. |
| analysis_jobs | Stores the status of analysis jobs. |
| email_categories | Stores email categories. |
| sentiment_analysis | Stores sentiment analysis results. |
| risk_analysis | Stores risk analysis results. |
| keywords | Stores extracted keywords. |
| email_keyword_map | Stores email-keyword relationships. |
| alerts | Stores alerts created for critical cases. |
| reports | Stores generated reports. |
| ai_response_suggestions | Stores AI-generated response suggestions. |
| workflow_logs | Stores n8n workflow execution logs. |

Primary keys, foreign keys, unique constraints, and check constraints are used in the database design. These structures help maintain data integrity and consistency.

---

## VII. Tables and Relationships

The database contains different types of relationships.

There is a one-to-many relationship between `departments` and `users`. A department can have multiple users. There is also a one-to-many relationship between `users` and `email_accounts`, because one user can manage multiple email accounts.

The `emails` table is the central table of the system. It is related to the `email_accounts` and `email_threads` tables. Each email belongs to an email account and may optionally be part of an email thread.

There are one-to-many relationships between the `emails` table and the `sentiment_analysis`, `risk_analysis`, `analysis_jobs`, `alerts`, and `ai_response_suggestions` tables. This allows different analysis results and process records to be stored for each email.

There is a many-to-many relationship between `emails` and `keywords`. This relationship is implemented through the `email_keyword_map` junction table.

---

## VIII. Normalization

The database design follows normalization principles.

In the First Normal Form, atomic values are used in each table, and repeating groups are separated into different tables.

In the Second Normal Form, the `email_keyword_map` table uses a composite primary key, and all non-key attributes depend on the entire key.

In the Third Normal Form, concepts such as users, departments, email accounts, analysis results, and keywords are separated into independent tables. This reduces data duplication and prevents update anomalies.

---

## IX. SQL Queries, Views and Triggers

Several SQL queries are prepared for reporting purposes. These queries can display high-risk emails, sentiment distribution, keyword frequency, daily email volume, and general business summaries.

The prepared database views are:

- `vw_email_analysis_summary`
- `vw_high_risk_emails`
- `vw_sentiment_distribution`
- `vw_daily_email_trends`
- `vw_pending_ai_responses`

Trigger structures support automation logic at the database level. The `trg_create_alert_on_high_risk` trigger automatically creates an alert record when a high or critical risk analysis result is inserted. The `trg_log_ai_response_suggestion` trigger creates a workflow log record when a new AI response suggestion is inserted.

---

## X. n8n Workflow Design

The project is designed with a multi-step workflow structure in n8n. Each workflow performs a separate task.

| Workflow | Description |
|---|---|
| 01 - Email Collector | Collects new emails and stores them in the database. |
| 02 - AI Sentiment Analysis | Performs sentiment analysis on email content. |
| 03 - Risk Detection | Determines the risk level of an email. |
| 04 - Category Classification | Classifies the email into a topic category. |
| 05 - Trend Calculation | Calculates daily and weekly trends. |
| 06 - Alert Notification | Sends notifications for critical risks. |
| 07 - Weekly Report Generator | Generates weekly reports. |
| 08 - AI Reply Suggestion | Generates response suggestions. |

This workflow architecture makes the system modular. Each step can be tested and improved independently.

---
## XI. Web Interface Design

In the MailSense AI project, a web-based dashboard interface is designed to help users monitor analysis results more easily. This interface presents email analysis results stored in the database through summary statistics, tables, and visual components.

The main components displayed in the interface are:

- Total number of analyzed emails.
- Distribution of positive, neutral, and negative emails.
- Number of high and critical risk emails.
- Average risk score.
- Most frequent keywords.
- System alerts.
- Workflow execution logs.

The interface is developed using HTML, CSS, and JavaScript. This approach makes the project easy to run and easy to understand on GitHub. The dashboard is located under the `frontend` folder and consists of `index.html`, `style.css`, and `app.js` files.

The web interface is designed to work together with the database and n8n workflow structures. Therefore, the project becomes not only a backend analysis system, but also an integrated platform that can present results to users.

---
## XII. AI Analysis Process

In the AI analysis process, the email text is taken as input. The model is expected to generate structured output. Example output fields include:

- Sentiment label
- Sentiment score
- Anger score
- Satisfaction score
- Urgency score
- Risk level
- Risk score
- Detected risk factors
- Recommended action
- Suggested response

For example, the sentence “I am extremely angry. If this issue is not solved today, I will cancel my account and start a legal complaint.” is evaluated by the system as negative and critical risk. In this case, the system creates an automatic alert and recommends escalation to management.

---

## XIII. Test Scenarios

Several tests are performed using the sample dataset. The test scenarios are:

1. Negative email analysis.
2. Positive feedback analysis.
3. Classification of a technical support email.
4. Detection of a critical legal complaint email.
5. Keyword matching test.
6. Automatic alert trigger test.
7. AI response suggestion log trigger test.
8. Daily email trend report test.

The test results show that the system stores sample data correctly, reports analysis results successfully, and executes trigger mechanisms as expected.

---

## XIV. Security and Data Privacy

Email data may contain personal or corporate sensitive information. Therefore, security and privacy are important parts of the system design.

Real email passwords, API keys, and connection credentials should not be uploaded to GitHub. For this reason, the `.env.example` file is used only as a template. Real secrets should be stored in a local `.env` file and excluded from version control using `.gitignore`.

User roles are also defined in the system. Roles such as `admin`, `manager`, `analyst`, and `support_agent` can be used to extend access control mechanisms.

---

## XV. Conclusion

In this project, an AI-powered database management system capable of performing sentiment trend analysis from email correspondence is designed. The project includes relational database design, SQL queries, views, triggers, and n8n workflow automation.

MailSense AI is designed as a system that can help organizations analyze customer communication more effectively, detect risky situations earlier, and make data-driven decisions. The project demonstrates the application of Database Management Systems course concepts in a realistic and professional scenario.

---

## References

[1] Microsoft, “SQL Server Documentation,” Microsoft Learn.  
[2] n8n Documentation, “Workflow Automation Documentation.”  
[3] OpenAI Documentation, “AI Model Usage and Structured Outputs.”  
[4] Silberschatz, A., Korth, H. F., and Sudarshan, S., Database System Concepts.  
[5] Elmasri, R. and Navathe, S. B., Fundamentals of Database Systems.