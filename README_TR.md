# MailSense AI

## AI Destekli E-posta Duygu, Risk ve Trend Analiz Sistemi

MailSense AI, kurumsal e-posta iletişimlerini yapay zeka destekli olarak analiz eden bir veritabanı yönetim sistemi projesidir. Sistem; e-postaları toplar, duygu analizi yapar, risk seviyesini belirler, anahtar kelimeleri çıkarır, kritik durumlarda uyarı üretir ve raporlama için verileri SQL Server üzerinde saklar.

Bu proje, **Veritabanı Yönetim Sistemleri** dersi kapsamında geliştirilmiştir. Projede Microsoft SQL Server, n8n otomasyon platformu ve yapay zeka destekli analiz mantığı birlikte kullanılmıştır.

---

## Proje Amacı

Bu projenin amacı, gelen e-postalardan anlamlı bilgiler çıkararak işletmelerin müşteri memnuniyetini, riskli iletişimleri ve duygu trendlerini takip etmesini sağlamaktır.

Sistem özellikle şu sorulara cevap verir:

- Hangi e-postalar negatif duygu içeriyor?
- Hangi müşteriler yüksek risk taşıyor?
- Hangi e-postalar acil müdahale gerektiriyor?
- Haftalık duygu trendi nasıl değişiyor?
- Hangi anahtar kelimeler daha sık kullanılıyor?
- AI hangi e-postalara cevap önerisi üretebilir?

---

## Kullanılan Teknolojiler

| Teknoloji | Açıklama |
|---|---|
| Microsoft SQL Server | Veritabanı yönetim sistemi |
| SQL Server Management Studio | SQL geliştirme ve test ortamı |
| n8n | Otomasyon ve workflow yönetimi |
| AI Model | Duygu analizi, risk tespiti ve cevap önerisi |
| GitHub | Versiyon kontrolü ve proje paylaşımı |
| Markdown | Proje dokümantasyonu |

---

## Sistem Modülleri

Proje aşağıdaki temel modüllerden oluşur:

1. **E-posta Toplama Modülü**
   - Gmail, Outlook veya IMAP üzerinden gelen e-postaları toplar.
   - E-posta içeriğini, göndereni, alıcıyı, konuyu ve tarih bilgisini veritabanına kaydeder.

2. **AI Duygu Analizi Modülü**
   - E-postaları pozitif, negatif veya nötr olarak sınıflandırır.
   - Duygu skoru, öfke skoru, memnuniyet skoru ve aciliyet skoru üretir.

3. **Risk Analizi Modülü**
   - E-postadaki risk seviyesini belirler.
   - Risk seviyeleri: low, medium, high, critical.

4. **Anahtar Kelime Analizi Modülü**
   - E-posta içeriğinden önemli anahtar kelimeleri çıkarır.
   - Şikayet, ödeme, teknik destek, hukuki risk ve aciliyet gibi türlere ayırır.

5. **Uyarı Sistemi**
   - Yüksek veya kritik risk tespit edildiğinde otomatik uyarı üretir.
   - Uyarılar Slack, e-posta, Telegram veya sistem içi bildirim olarak tasarlanabilir.

6. **AI Cevap Önerisi Modülü**
   - Önemli e-postalar için otomatik cevap taslağı üretir.
   - Cevaplar doğrudan gönderilmez, onay bekleyen öneri olarak saklanır.

7. **Raporlama Modülü**
   - Günlük, haftalık ve aylık analiz raporları üretir.
   - Duygu dağılımı, risk oranı ve trend sonuçlarını gösterir.
   
8. **Web Arayüz / Dashboard Modülü**
   - Analiz edilen e-postaların özet istatistiklerini gösterir.
   - Duygu dağılımı, riskli e-postalar, anahtar kelimeler ve workflow loglarını görselleştirir.
   - Projenin sonuçlarını kullanıcı dostu bir panel üzerinden sunar.

---

## Veritabanı Tasarımı

Projede aşağıdaki ana tablolar kullanılmıştır:

| Tablo | Açıklama |
|---|---|
| departments | Departman bilgilerini tutar |
| users | Sistem kullanıcılarını tutar |
| email_accounts | E-posta hesaplarını tutar |
| email_threads | E-posta konuşma zincirlerini tutar |
| emails | Gelen e-postaları saklar |
| analysis_jobs | Analiz işlem durumlarını tutar |
| email_categories | E-posta kategorilerini tutar |
| sentiment_analysis | Duygu analizi sonuçlarını tutar |
| risk_analysis | Risk analizi sonuçlarını tutar |
| keywords | Anahtar kelimeleri tutar |
| email_keyword_map | E-posta ve anahtar kelime ilişkisini tutar |
| alerts | Sistem uyarılarını tutar |
| reports | Rapor kayıtlarını tutar |
| ai_response_suggestions | AI cevap önerilerini tutar |
| workflow_logs | n8n workflow çalışma loglarını tutar |

---

## Veritabanı Özellikleri

Bu projede aşağıdaki veritabanı kavramları uygulanmıştır:

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
- Normalizasyon
- Raporlama Sorguları

---

## Dosya Yapısı

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
│├── frontend/
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