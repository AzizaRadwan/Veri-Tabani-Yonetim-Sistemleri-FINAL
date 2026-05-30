# MailSense AI

## AI-Powered Email Sentiment, Risk and Trend Analysis System

MailSense AI is a database management system project that analyzes email correspondence using AI-supported workflows. The system collects emails, performs sentiment analysis, detects risk levels, extracts keywords, creates alerts for critical cases, and stores all results in Microsoft SQL Server for reporting and decision support.

This project was developed for the **Database Management Systems** course. It combines Microsoft SQL Server, n8n workflow automation, and AI-based analysis logic.

---

## Project Topic

The selected project topic is:

**Sentiment Trend Analysis from Email Correspondence**

The professional project name is:

**MailSense AI: AI-Powered Email Sentiment, Risk and Trend Analysis System**

---

## Project Objective

The main objective of this project is to extract meaningful insights from incoming emails and help organizations monitor customer satisfaction, risky communication, and sentiment trends.

The system answers questions such as:

- Which emails contain negative sentiment?
- Which emails have high or critical risk levels?
- Which emails require urgent action?
- How does sentiment change over time?
- Which keywords appear most frequently?
- Which emails need AI-generated response suggestions?

---

## Technologies Used

| Technology | Description |
|---|---|
| Microsoft SQL Server | Database management system |
| SQL Server Management Studio | SQL development and testing environment |
| n8n | Workflow automation platform |
| AI Model | Sentiment analysis, risk detection and response suggestion |
| GitHub | Version control and project sharing |
| Markdown | Project documentation |

---

## System Modules

1. **Email Collection Module**
   - Collects emails from Gmail, Outlook or IMAP.
   - Stores sender, receiver, subject, body and date information.

2. **AI Sentiment Analysis Module**
   - Classifies emails as positive, neutral or negative.
   - Produces sentiment, anger, satisfaction and urgency scores.

3. **Risk Analysis Module**
   - Detects the risk level of each email.
   - Risk levels are low, medium, high and critical.

4. **Keyword Analysis Module**
   - Extracts important keywords from email content.
   - Groups keywords into complaint, payment, technical, legal, urgent and general categories.

5. **Alert System**
   - Creates alerts when high or critical risk is detected.
   - Alerts can be designed for Slack, email, Telegram or internal system notifications.

6. **AI Response Suggestion Module**
   - Generates draft response suggestions for important emails.
   - Suggested replies are stored for approval and are not sent automatically.

7. **Reporting Module**
   - Produces daily, weekly and monthly reports.
   - Shows sentiment distribution, risk levels and communication trends.

8. **Web Interface / Dashboard Module**
   - Displays summary statistics of analyzed emails.
   - Visualizes sentiment distribution, risky emails, keywords, and workflow logs.
   - Presents project results through a user-friendly dashboard.

---

## Database Design

The project includes the following main tables:

| Table | Description |
|---|---|
| departments | Stores department information |
| users | Stores system users |
| email_accounts | Stores connected email accounts |
| email_threads | Stores email conversation threads |
| emails | Stores incoming emails |
| analysis_jobs | Stores analysis job statuses |
| email_categories | Stores email categories |
| sentiment_analysis | Stores sentiment analysis results |
| risk_analysis | Stores risk analysis results |
| keywords | Stores extracted keywords |
| email_keyword_map | Stores email-keyword relationships |
| alerts | Stores system alerts |
| reports | Stores generated reports |
| ai_response_suggestions | Stores AI-generated response suggestions |
| workflow_logs | Stores n8n workflow execution logs |

---

## Database Features

The following database concepts are implemented:

- Primary Key
- Foreign Key
- Unique Constraint
- Check Constraint
- Identity Column
- Index
- View
- Trigger
- One-to-Many Relationship
- Many-to-Many Relationship
- Normalization
- Reporting Queries

---

## Project Structure

```text
MailSense-AI/
│
├── README.md
├── README_TR.md
│
├── database/
│   ├── schema.sql
│   ├── seed.sql
│   ├── queries.sql
│   ├── views.sql
│   └── triggers.sql
│
├── docs/
│   ├── proje-raporu-tr.md
│   ├── project-report-en.md
│   ├── veritabani-tasarimi-tr.md
│   └── database-design-en.md
│
├── workflows/
│   ├── 01-email-collector.json
│   ├── 02-ai-sentiment-analysis.json
│   ├── 03-risk-detection.json
│   ├── 04-category-classification.json
│   ├── 05-trend-calculation.json
│   ├── 06-alert-notification.json
│   ├── 07-weekly-report-generator.json
│   └── 08-ai-reply-suggestion.json
│
├── reports/
│   ├── sample-weekly-report-tr.md
│   └── sample-weekly-report-en.md
├── frontend/
│   ├── index.html
│   ├── style.css
│   ├── app.js
│   └── README.md
│
├── assets/
│   ├── er-diagram.png
│   ├── architecture-diagram.png
│   └── workflow-overview.png
│
├── .env.example
├── .gitignore
└── LICENSE