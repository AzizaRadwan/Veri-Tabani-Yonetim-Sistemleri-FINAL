const highRiskEmails = [
    {
        sender: "customer4@example.com",
        subject: "Cancellation and legal complaint warning",
        riskLevel: "critical",
        riskScore: "0.96",
        action: "Escalate to the management team immediately."
    },
    {
        sender: "customer1@example.com",
        subject: "Refund request for delayed order",
        riskLevel: "high",
        riskScore: "0.82",
        action: "Assign to the support manager and respond within 1 hour."
    }
];

const keywords = [
    "cancel",
    "delayed",
    "enterprise",
    "error code",
    "refund",
    "urgent",
    "legal complaint",
    "technical help",
    "pricing"
];

const alerts = [
    {
        type: "Slack",
        status: "sent",
        message: "High risk refund request detected for customer1@example.com."
    },
    {
        type: "Email",
        status: "sent",
        message: "Critical legal complaint and cancellation risk detected."
    },
    {
        type: "System",
        status: "pending",
        message: "Automatic alert generated for critical risk case."
    }
];

const workflowLogs = [
    {
        workflow: "01 - Email Collector",
        status: "success",
        message: "Email collected successfully from support inbox."
    },
    {
        workflow: "02 - AI Sentiment Analysis",
        status: "success",
        message: "Sentiment analysis completed."
    },
    {
        workflow: "03 - Risk Detection",
        status: "success",
        message: "Critical risk detected and alert workflow triggered."
    },
    {
        workflow: "06 - Alert Notification",
        status: "success",
        message: "Critical alert sent to management team."
    }
];

function createRiskBadge(level) {
    if (level === "critical") {
        return `<span class="badge badge-critical">Critical</span>`;
    }

    if (level === "high") {
        return `<span class="badge badge-high">High</span>`;
    }

    return `<span class="badge">${level}</span>`;
}

function createStatusBadge(status) {
    if (status === "sent" || status === "success") {
        return `<span class="badge badge-sent">${status}</span>`;
    }

    if (status === "pending") {
        return `<span class="badge badge-pending">${status}</span>`;
    }

    return `<span class="badge">${status}</span>`;
}

function loadRiskTable() {
    const table = document.getElementById("riskTable");

    table.innerHTML = highRiskEmails
        .map(email => `
            <tr>
                <td>${email.sender}</td>
                <td>${email.subject}</td>
                <td>${createRiskBadge(email.riskLevel)}</td>
                <td>${email.riskScore}</td>
                <td>${email.action}</td>
            </tr>
        `)
        .join("");
}

function loadKeywords() {
    const keywordList = document.getElementById("keywordList");

    keywordList.innerHTML = keywords
        .map(keyword => `<span class="keyword">${keyword}</span>`)
        .join("");
}

function loadAlerts() {
    const table = document.getElementById("alertTable");

    table.innerHTML = alerts
        .map(alert => `
            <tr>
                <td>${alert.type}</td>
                <td>${createStatusBadge(alert.status)}</td>
                <td>${alert.message}</td>
            </tr>
        `)
        .join("");
}

function loadWorkflowLogs() {
    const table = document.getElementById("logTable");

    table.innerHTML = workflowLogs
        .map(log => `
            <tr>
                <td>${log.workflow}</td>
                <td>${createStatusBadge(log.status)}</td>
                <td>${log.message}</td>
            </tr>
        `)
        .join("");
}

document.addEventListener("DOMContentLoaded", () => {
    loadRiskTable();
    loadKeywords();
    loadAlerts();
    loadWorkflowLogs();
});