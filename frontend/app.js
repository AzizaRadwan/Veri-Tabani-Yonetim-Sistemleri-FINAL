const authPage = document.getElementById("authPage");
const dashboardPage = document.getElementById("dashboardPage");

const loginTab = document.getElementById("loginTab");
const registerTab = document.getElementById("registerTab");
const loginForm = document.getElementById("loginForm");
const registerForm = document.getElementById("registerForm");
const authMessage = document.getElementById("authMessage");

const logoutBtn = document.getElementById("logoutBtn");
const currentUserText = document.getElementById("currentUserText");
const emailForm = document.getElementById("emailForm");

let users = JSON.parse(localStorage.getItem("mailsense_users")) || [];
let currentUser = JSON.parse(localStorage.getItem("mailsense_current_user")) || null;
let emails = JSON.parse(localStorage.getItem("mailsense_emails")) || [];
let analyses = JSON.parse(localStorage.getItem("mailsense_analyses")) || [];
let alerts = JSON.parse(localStorage.getItem("mailsense_alerts")) || [];
let replies = JSON.parse(localStorage.getItem("mailsense_replies")) || [];
let logs = JSON.parse(localStorage.getItem("mailsense_logs")) || [];
let activeFilter = "all";

function saveData() {
    localStorage.setItem("mailsense_users", JSON.stringify(users));
    localStorage.setItem("mailsense_current_user", JSON.stringify(currentUser));
    localStorage.setItem("mailsense_emails", JSON.stringify(emails));
    localStorage.setItem("mailsense_analyses", JSON.stringify(analyses));
    localStorage.setItem("mailsense_alerts", JSON.stringify(alerts));
    localStorage.setItem("mailsense_replies", JSON.stringify(replies));
    localStorage.setItem("mailsense_logs", JSON.stringify(logs));
}

function showDashboard() {
    authPage.classList.add("hidden");
    dashboardPage.classList.remove("hidden");
    currentUserText.textContent = `Logged in as ${currentUser.name}`;
    renderDashboard();
}

function showAuth() {
    authPage.classList.remove("hidden");
    dashboardPage.classList.add("hidden");
}

loginTab.addEventListener("click", () => {
    loginTab.classList.add("active");
    registerTab.classList.remove("active");
    loginForm.classList.remove("hidden");
    registerForm.classList.add("hidden");
    authMessage.textContent = "";
});

registerTab.addEventListener("click", () => {
    registerTab.classList.add("active");
    loginTab.classList.remove("active");
    registerForm.classList.remove("hidden");
    loginForm.classList.add("hidden");
    authMessage.textContent = "";
});

registerForm.addEventListener("submit", (event) => {
    event.preventDefault();

    const name = document.getElementById("registerName").value.trim();
    const email = document.getElementById("registerEmail").value.trim();
    const password = document.getElementById("registerPassword").value;

    if (users.some(user => user.email === email)) {
        authMessage.style.color = "#dc2626";
        authMessage.textContent = "This email is already registered.";
        return;
    }

    users.push({ name, email, password });
    saveData();

    authMessage.style.color = "#166534";
    authMessage.textContent = "Account created successfully. You can login now.";
    registerForm.reset();
});

loginForm.addEventListener("submit", (event) => {
    event.preventDefault();

    const email = document.getElementById("loginEmail").value.trim();
    const password = document.getElementById("loginPassword").value;

    const user = users.find(user => user.email === email && user.password === password);

    if (!user) {
        authMessage.style.color = "#dc2626";
        authMessage.textContent = "Invalid email or password.";
        return;
    }

    currentUser = user;
    saveData();
    showDashboard();
});

logoutBtn.addEventListener("click", () => {
    currentUser = null;
    localStorage.removeItem("mailsense_current_user");
    showAuth();
});

emailForm.addEventListener("submit", (event) => {
    event.preventDefault();

    const sender = document.getElementById("senderEmail").value.trim();
    const subject = document.getElementById("emailSubject").value.trim();
    const body = document.getElementById("emailBody").value.trim();

    addAndAnalyzeEmail(sender, subject, body);
    emailForm.reset();
    renderDashboard();
});

document.querySelectorAll(".filter-btn").forEach(button => {
    button.addEventListener("click", () => {
        document.querySelectorAll(".filter-btn").forEach(btn => btn.classList.remove("active"));
        button.classList.add("active");
        activeFilter = button.dataset.filter;
        renderDashboard();
    });
});

function addAndAnalyzeEmail(sender, subject, body) {
    const email = {
        id: emails.length + 1,
        sender,
        subject,
        body,
        status: "processed",
        createdAt: new Date().toLocaleString()
    };

    emails.push(email);

    const analysis = analyzeEmail(email);
    analyses.push(analysis);

    const reply = {
        emailId: email.id,
        tone: analysis.replyTone,
        suggestedReply: generateReply(analysis.replyTone),
        status: "pending"
    };

    replies.push(reply);

    if (analysis.riskLevel === "high" || analysis.riskLevel === "critical") {
        alerts.push({
            emailId: email.id,
            message: `${analysis.riskLevel.toUpperCase()} risk detected for "${email.subject}".`,
            status: "sent"
        });
    }

    logs.push({
        workflow: "Frontend Email Analysis",
        status: "success",
        message: `Email ${email.id} analyzed. Sentiment: ${analysis.sentiment}, Risk: ${analysis.riskLevel}.`
    });

    saveData();
}

function analyzeEmail(email) {
    const text = `${email.subject} ${email.body}`.toLowerCase();

    let sentiment = "neutral";
    let riskLevel = "low";
    let category = "General";
    let replyTone = "professional";

    if (
        text.includes("unhappy") ||
        text.includes("refund") ||
        text.includes("delayed") ||
        text.includes("complaint") ||
        text.includes("angry")
    ) {
        sentiment = "negative";
        riskLevel = "high";
        category = "Complaint";
        replyTone = "apologetic";
    }

    if (
        text.includes("legal complaint") ||
        text.includes("cancel") ||
        text.includes("lawsuit")
    ) {
        sentiment = "negative";
        riskLevel = "critical";
        category = "Cancellation Risk";
        replyTone = "urgent";
    }

    if (
        text.includes("thank") ||
        text.includes("helpful") ||
        text.includes("solved") ||
        text.includes("great")
    ) {
        sentiment = "positive";
        riskLevel = "low";
        category = "Positive Feedback";
        replyTone = "friendly";
    }

    if (
        text.includes("error") ||
        text.includes("setup") ||
        text.includes("technical") ||
        text.includes("installation")
    ) {
        category = "Technical Support";
        if (riskLevel === "low") {
            riskLevel = "medium";
        }
    }

    if (
        text.includes("pricing") ||
        text.includes("enterprise") ||
        text.includes("plan")
    ) {
        category = "Sales Inquiry";
    }

    return {
        emailId: email.id,
        sentiment,
        riskLevel,
        category,
        replyTone
    };
}

function generateReply(tone) {
    if (tone === "urgent") {
        return "Dear customer, we sincerely apologize. Your issue has been escalated to the management team and will be handled with priority.";
    }

    if (tone === "apologetic") {
        return "Dear customer, we are sorry for your negative experience. Our support team will review your request immediately.";
    }

    if (tone === "friendly") {
        return "Dear customer, thank you for your positive feedback. We are happy to hear that your issue was solved.";
    }

    return "Dear customer, thank you for contacting us. Our team will review your message as soon as possible.";
}

function analyzeAgain(emailId) {
    const email = emails.find(item => item.id === emailId);

    if (!email) {
        return;
    }

    analyses = analyses.filter(item => item.emailId !== emailId);
    replies = replies.filter(item => item.emailId !== emailId);
    alerts = alerts.filter(item => item.emailId !== emailId);

    const analysis = analyzeEmail(email);
    analyses.push(analysis);

    replies.push({
        emailId: email.id,
        tone: analysis.replyTone,
        suggestedReply: generateReply(analysis.replyTone),
        status: "pending"
    });

    if (analysis.riskLevel === "high" || analysis.riskLevel === "critical") {
        alerts.push({
            emailId: email.id,
            message: `${analysis.riskLevel.toUpperCase()} risk detected for "${email.subject}".`,
            status: "sent"
        });
    }

    logs.push({
        workflow: "Analyze Again",
        status: "success",
        message: `Email ${email.id} analyzed again successfully.`
    });

    saveData();
    renderDashboard();
}

function badge(value) {
    return `<span class="badge badge-${value}">${value}</span>`;
}

function getAnalysis(emailId) {
    return analyses.find(item => item.emailId === emailId);
}

function getFilteredEmails() {
    return emails.filter(email => {
        const analysis = getAnalysis(email.id);

        if (!analysis) {
            return true;
        }

        if (activeFilter === "negative") {
            return analysis.sentiment === "negative";
        }

        if (activeFilter === "high") {
            return analysis.riskLevel === "high" || analysis.riskLevel === "critical";
        }

        if (activeFilter === "critical") {
            return analysis.riskLevel === "critical";
        }

        return true;
    });
}

function renderDashboard() {
    document.getElementById("totalEmails").textContent = emails.length;
    document.getElementById("negativeEmails").textContent = analyses.filter(a => a.sentiment === "negative").length;
    document.getElementById("highRiskEmails").textContent = analyses.filter(a => a.riskLevel === "high" || a.riskLevel === "critical").length;
    document.getElementById("totalReplies").textContent = replies.length;

    renderEmails();
    renderAnalyses();
    renderReplies();
    renderAlerts();
    renderLogs();
    renderReport();
    renderCharts();
}

function renderEmails() {
    const table = document.getElementById("emailTable");
    const filteredEmails = getFilteredEmails();

    table.innerHTML = filteredEmails.map(email => `
        <tr>
            <td>${email.id}</td>
            <td>${email.sender}</td>
            <td>${email.subject}</td>
            <td>${badge(email.status)}</td>
            <td>
                <button class="action-btn" onclick="analyzeAgain(${email.id})">
                    Analyze Again
                </button>
            </td>
        </tr>
    `).join("");
}

function renderAnalyses() {
    const table = document.getElementById("analysisTable");

    table.innerHTML = analyses.map(item => `
        <tr>
            <td>${item.emailId}</td>
            <td>${badge(item.sentiment)}</td>
            <td>${badge(item.riskLevel)}</td>
            <td>${item.category}</td>
            <td>${badge(item.replyTone)}</td>
        </tr>
    `).join("");
}

function renderReplies() {
    const table = document.getElementById("replyTable");

    table.innerHTML = replies.map(reply => `
        <tr>
            <td>${reply.emailId}</td>
            <td>${badge(reply.tone)}</td>
            <td>${reply.suggestedReply}</td>
            <td>${badge(reply.status)}</td>
        </tr>
    `).join("");
}

function renderAlerts() {
    const table = document.getElementById("alertTable");

    table.innerHTML = alerts.map(alert => `
        <tr>
            <td>${alert.emailId}</td>
            <td>${alert.message}</td>
            <td>${badge(alert.status)}</td>
        </tr>
    `).join("");
}

function renderLogs() {
    const table = document.getElementById("logTable");

    table.innerHTML = logs.map(log => `
        <tr>
            <td>${log.workflow}</td>
            <td>${badge(log.status)}</td>
            <td>${log.message}</td>
        </tr>
    `).join("");
}

function renderReport() {
    const reportBox = document.getElementById("reportBox");

    const positive = analyses.filter(a => a.sentiment === "positive").length;
    const neutral = analyses.filter(a => a.sentiment === "neutral").length;
    const negative = analyses.filter(a => a.sentiment === "negative").length;
    const highRisk = analyses.filter(a => a.riskLevel === "high" || a.riskLevel === "critical").length;
    const critical = analyses.filter(a => a.riskLevel === "critical").length;

    reportBox.textContent = `
MailSense AI Summary Report

Total Emails: ${emails.length}
Positive Emails: ${positive}
Neutral Emails: ${neutral}
Negative Emails: ${negative}
High/Critical Risk Emails: ${highRisk}
Critical Risk Emails: ${critical}
AI Reply Suggestions: ${replies.length}
Total Alerts: ${alerts.length}

Evaluation:
The system analyzes customer emails, detects negative sentiment, classifies risk levels, generates alerts and creates AI-style reply suggestions.
`;
}

function renderCharts() {
    renderSentimentChart();
    renderRiskChart();
}

function renderSentimentChart() {
    const chart = document.getElementById("sentimentChart");

    const data = {
        positive: analyses.filter(a => a.sentiment === "positive").length,
        neutral: analyses.filter(a => a.sentiment === "neutral").length,
        negative: analyses.filter(a => a.sentiment === "negative").length
    };

    chart.innerHTML = Object.entries(data).map(([label, value]) => {
        const percent = emails.length ? Math.max((value / emails.length) * 100, value > 0 ? 8 : 0) : 0;

        return `
            <div class="chart-row">
                <span>${label}</span>
                <div class="chart-track">
                    <div class="chart-bar chart-${label}" style="width:${percent}%"></div>
                </div>
                <strong>${value}</strong>
            </div>
        `;
    }).join("");
}

function renderRiskChart() {
    const chart = document.getElementById("riskChart");

    const data = {
        low: analyses.filter(a => a.riskLevel === "low").length,
        medium: analyses.filter(a => a.riskLevel === "medium").length,
        high: analyses.filter(a => a.riskLevel === "high").length,
        critical: analyses.filter(a => a.riskLevel === "critical").length
    };

    chart.innerHTML = Object.entries(data).map(([label, value]) => {
        const percent = emails.length ? Math.max((value / emails.length) * 100, value > 0 ? 8 : 0) : 0;

        return `
            <div class="chart-row">
                <span>${label}</span>
                <div class="chart-track">
                    <div class="chart-bar chart-${label}" style="width:${percent}%"></div>
                </div>
                <strong>${value}</strong>
            </div>
        `;
    }).join("");
}

function loadDemoDataIfEmpty() {
    if (users.length === 0) {
        users.push({
            name: "Azize Rdwan",
            email: "azizaradwan08@gmail.com",
            password: "123456"
        });
    }

    if (emails.length === 0) {
        addDemoEmail(
            "customer1@example.com",
            "Urgent refund request",
            "Hello, I am very unhappy with the delayed service. I want a refund urgently."
        );

        addDemoEmail(
            "customer2@example.com",
            "Thank you for your helpful support",
            "Thank you, your team was very helpful and solved my issue."
        );

        addDemoEmail(
            "customer3@example.com",
            "Technical setup error",
            "I have an installation error and I need technical support."
        );

        addDemoEmail(
            "customer4@example.com",
            "Legal complaint and cancellation",
            "I am angry and I will cancel my account. I will start a legal complaint."
        );
    }

    saveData();
}

function addDemoEmail(sender, subject, body) {
    const email = {
        id: emails.length + 1,
        sender,
        subject,
        body,
        status: "processed",
        createdAt: new Date().toLocaleString()
    };

    emails.push(email);

    const analysis = analyzeEmail(email);
    analyses.push(analysis);

    replies.push({
        emailId: email.id,
        tone: analysis.replyTone,
        suggestedReply: generateReply(analysis.replyTone),
        status: "pending"
    });

    if (analysis.riskLevel === "high" || analysis.riskLevel === "critical") {
        alerts.push({
            emailId: email.id,
            message: `${analysis.riskLevel.toUpperCase()} risk detected for "${email.subject}".`,
            status: "sent"
        });
    }

    logs.push({
        workflow: "Demo Data Loader",
        status: "success",
        message: `Demo email ${email.id} loaded and analyzed.`
    });
}

loadDemoDataIfEmpty();

if (currentUser) {
    showDashboard();
} else {
    showAuth();
}