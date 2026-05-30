# MailSense AI: E-posta Yazışmalarından AI Destekli Duygu, Risk ve Trend Analiz Sistemi

**Azize Rdwan**  
Öğrenci No: 224410112  
VeriTabanı Yönetim Sistemleri Dersi  
Kastamonu Üniversitesi  
azizaradwan08@gmail.com

---

## Özet

Bu çalışmada, e-posta yazışmalarından duygu trendi analizi yapabilen AI destekli bir veritabanı yönetim sistemi tasarlanmıştır. Geliştirilen sistem, gelen e-postaları toplamakta, içerikleri üzerinde duygu analizi yapmakta, risk seviyelerini belirlemekte, anahtar kelimeleri çıkarmakta ve kritik durumlarda otomatik uyarı üretmektedir. Projenin veritabanı katmanı Microsoft SQL Server üzerinde oluşturulmuş; tablolar, ilişkiler, kısıtlamalar, view yapıları, trigger mekanizmaları ve örnek raporlama sorguları hazırlanmıştır. Otomasyon tarafında n8n workflow mimarisi planlanmış ve sistemin e-posta toplama, AI analiz, risk tespiti, bildirim ve raporlama süreçleri modüler şekilde tasarlanmıştır. Bu proje, Veritabanı Yönetim Sistemleri dersi kapsamında ilişkisel veritabanı tasarımı, normalizasyon, veri bütünlüğü, raporlama ve otomasyon kavramlarını bütünleşik bir örnek üzerinde göstermeyi amaçlamaktadır.

**Anahtar Kelimeler:** Veritabanı Yönetim Sistemleri, SQL Server, n8n, Yapay Zeka, Duygu Analizi, Risk Analizi, E-posta Analizi

---

## I. Giriş

Günümüzde kurumlar müşterileriyle, çalışanlarıyla ve iş ortaklarıyla yoğun şekilde e-posta üzerinden iletişim kurmaktadır. Bu e-postalar yalnızca metin içerikleri değildir; aynı zamanda müşteri memnuniyeti, şikayetler, teknik problemler, iptal riskleri, ödeme talepleri ve hukuki uyarılar gibi önemli iş sinyalleri de taşımaktadır. Ancak manuel olarak binlerce e-postayı incelemek hem zaman kaybına neden olmakta hem de kritik mesajların gözden kaçmasına yol açabilmektedir.

Bu proje, e-posta yazışmalarını otomatik olarak analiz eden ve sonuçları ilişkisel bir veritabanında saklayan profesyonel bir sistem tasarlamaktadır. Sistem, yapay zeka destekli analiz mantığı sayesinde e-postaların duygu durumunu, risk seviyesini, aciliyet durumunu ve önemli anahtar kelimelerini belirleyebilir. Böylece kurumlar, müşteri iletişimindeki eğilimleri daha hızlı görebilir ve riskli durumlara daha erken müdahale edebilir.

MailSense AI projesi, yalnızca bir yapay zeka uygulaması değildir. Aynı zamanda güçlü bir veritabanı yönetim sistemi projesidir. Projede veri modelleme, tablo ilişkileri, primary key, foreign key, check constraint, index, view ve trigger gibi temel DBMS kavramları uygulanmıştır.

---

## II. Problem Tanımı

Kurumsal e-posta sistemlerinde çok sayıda mesaj birikmektedir. Bu mesajların içinde olumlu geri bildirimler, şikayetler, teknik sorunlar, ödeme problemleri, iptal talepleri ve hukuki riskler bulunabilir. Bu tür mesajların manuel olarak incelenmesi zaman alıcıdır ve insan hatasına açıktır.

Bu problem aşağıdaki başlıklar altında özetlenebilir:

- Negatif duygu içeren e-postaların geç fark edilmesi.
- Kritik risk taşıyan müşteri mesajlarının gözden kaçması.
- E-posta içeriklerinden düzenli trend raporu üretilememesi.
- Anahtar kelime ve konu dağılımının manuel olarak takip edilememesi.
- Müşteri iletişiminde erken uyarı sisteminin olmaması.
- Verilerin merkezi ve ilişkisel bir yapıda saklanmaması.

Bu nedenle, e-posta içeriklerini analiz eden, sonuçları veritabanına kaydeden ve raporlanabilir hale getiren bir sisteme ihtiyaç duyulmaktadır.

---

## III. Projenin Amacı

Bu projenin temel amacı, e-posta yazışmalarından AI destekli duygu, risk ve trend analizi yapabilen bir sistem geliştirmektir. Sistem, gelen e-postaları analiz ederek karar destek sürecine katkı sağlar.

Projenin alt amaçları şunlardır:

1. Gelen e-postaların ilişkisel veritabanında düzenli şekilde saklanması.
2. E-postaların pozitif, negatif veya nötr olarak sınıflandırılması.
3. Her e-posta için risk seviyesi belirlenmesi.
4. Yüksek ve kritik riskli e-postalar için otomatik uyarı oluşturulması.
5. Anahtar kelimelerin çıkarılması ve sınıflandırılması.
6. AI destekli cevap önerilerinin saklanması.
7. Günlük ve haftalık raporlama yapılabilmesi.
8. n8n ile çok adımlı workflow mimarisinin kurulması.
9. Veritabanı yönetim sistemi kavramlarının gerçekçi bir senaryo üzerinde uygulanması.

---

## IV. Kullanılan Teknolojiler

Bu projede kullanılan temel teknolojiler aşağıdaki gibidir:

| Teknoloji | Açıklama |
|---|---|
| Microsoft SQL Server | Veritabanı yönetim sistemi olarak kullanılmıştır. |
| SQL Server Management Studio | SQL kodlarının yazılması ve test edilmesi için kullanılmıştır. |
| n8n | Otomasyon ve workflow yönetimi için planlanmıştır. |
| AI Model | Duygu analizi, risk analizi ve cevap önerisi üretimi için kullanılır. |
| GitHub | Proje dosyalarının paylaşılması ve versiyon kontrolü için kullanılır. |
| Markdown | README ve proje raporlarının hazırlanmasında kullanılmıştır. |

---

## V. Sistem Mimarisi

MailSense AI sistemi modüler bir mimariye sahiptir. Sistem, e-posta toplama katmanı, AI analiz katmanı, veritabanı katmanı, bildirim katmanı ve raporlama katmanından oluşmaktadır.

Genel akış şu şekildedir:

1. n8n, Gmail, Outlook veya IMAP üzerinden yeni e-postaları toplar.
2. E-posta bilgileri SQL Server veritabanındaki `emails` tablosuna kaydedilir.
3. AI analiz workflow’u e-posta içeriğini işler.
4. Duygu analizi sonucu `sentiment_analysis` tablosuna yazılır.
5. Risk analizi sonucu `risk_analysis` tablosuna kaydedilir.
6. Risk yüksek veya kritik ise sistem `alerts` tablosunda uyarı oluşturur.
7. AI cevap önerisi gerekiyorsa `ai_response_suggestions` tablosuna kayıt eklenir.
8. Workflow süreçleri `workflow_logs` tablosunda izlenir.
9. Raporlama sorguları ve view yapıları ile sonuçlar analiz edilir.

Bu mimari, sistemi genişletilebilir ve bakımı kolay hale getirmektedir.

---

## VI. Veritabanı Tasarımı

Projenin veritabanı tasarımı Microsoft SQL Server üzerinde gerçekleştirilmiştir. Veritabanı adı `MailSenseAI` olarak belirlenmiştir.

Sistemde kullanılan ana tablolar şunlardır:

| Tablo | Görevi |
|---|---|
| departments | Departman bilgilerini tutar. |
| users | Sistem kullanıcılarını tutar. |
| email_accounts | Sisteme bağlı e-posta hesaplarını tutar. |
| email_threads | E-posta konuşma zincirlerini tutar. |
| emails | Gelen e-posta kayıtlarını saklar. |
| analysis_jobs | Analiz işlerinin durumunu tutar. |
| email_categories | E-posta kategorilerini tutar. |
| sentiment_analysis | Duygu analizi sonuçlarını tutar. |
| risk_analysis | Risk analizi sonuçlarını tutar. |
| keywords | Anahtar kelimeleri tutar. |
| email_keyword_map | E-posta ve anahtar kelime ilişkisini tutar. |
| alerts | Kritik durumlarda oluşan uyarıları tutar. |
| reports | Üretilen raporları tutar. |
| ai_response_suggestions | AI cevap önerilerini tutar. |
| workflow_logs | n8n workflow çalışma kayıtlarını tutar. |

Veritabanı tasarımında primary key, foreign key, unique constraint ve check constraint yapıları kullanılmıştır. Bu sayede veri bütünlüğü korunmuştur.

---

## VII. Tablolar ve İlişkiler

Veritabanında farklı ilişki türleri bulunmaktadır.

`departments` ve `users` arasında bire-çok ilişki vardır. Bir departmanda birden fazla kullanıcı olabilir. `users` ve `email_accounts` arasında da bire-çok ilişki bulunmaktadır. Bir kullanıcı birden fazla e-posta hesabına sahip olabilir.

`emails` tablosu sistemin merkezindedir. Bu tablo, `email_accounts` ve `email_threads` tabloları ile ilişkilidir. Her e-posta bir hesaba bağlıdır ve isteğe bağlı olarak bir konuşma zincirine ait olabilir.

`emails` tablosu ile `sentiment_analysis`, `risk_analysis`, `analysis_jobs`, `alerts` ve `ai_response_suggestions` tabloları arasında bire-çok ilişkiler kurulmuştur. Böylece bir e-postanın farklı analiz sonuçları ve süreç kayıtları tutulabilir.

`emails` ve `keywords` tabloları arasında çoktan çoğa ilişki vardır. Bu ilişki `email_keyword_map` ara tablosu ile sağlanmıştır.

---

## VIII. Normalizasyon

Veritabanı tasarımı normalizasyon ilkelerine uygun olarak hazırlanmıştır.

Birinci Normal Form kapsamında, her tabloda atomik değerler kullanılmıştır. Tekrarlı alanlar ayrı tablolara bölünmüştür.

İkinci Normal Form kapsamında, birleşik anahtara sahip `email_keyword_map` tablosunda alanların anahtara tam bağımlı olması sağlanmıştır.

Üçüncü Normal Form kapsamında, kullanıcı, departman, e-posta hesabı, analiz sonucu ve anahtar kelime gibi kavramlar ayrı tablolara ayrılmıştır. Böylece veri tekrarı azaltılmış ve güncelleme anomalileri önlenmiştir.

---

## IX. SQL Sorguları, View ve Trigger Yapıları

Projede raporlama amacıyla çeşitli SQL sorguları hazırlanmıştır. Bu sorgular ile yüksek riskli e-postalar, duygu dağılımı, anahtar kelime sıklığı, günlük e-posta hacmi ve genel iş özeti görüntülenebilmektedir.

Hazırlanan view yapıları şunlardır:

- `vw_email_analysis_summary`
- `vw_high_risk_emails`
- `vw_sentiment_distribution`
- `vw_daily_email_trends`
- `vw_pending_ai_responses`

Trigger yapıları ise otomasyon mantığını veritabanı seviyesinde desteklemektedir. `trg_create_alert_on_high_risk` trigger’ı, yüksek veya kritik riskli bir analiz sonucu eklendiğinde otomatik olarak uyarı kaydı oluşturur. `trg_log_ai_response_suggestion` trigger’ı ise yeni bir AI cevap önerisi eklendiğinde workflow log kaydı üretir.

---

## X. n8n Workflow Tasarımı

Proje n8n üzerinde çok adımlı workflow yapısıyla tasarlanmıştır. Her workflow ayrı bir görevi yerine getirir.

| Workflow | Açıklama |
|---|---|
| 01 - Email Collector | Yeni e-postaları toplar ve veritabanına kaydeder. |
| 02 - AI Sentiment Analysis | E-posta içeriğinden duygu analizi yapar. |
| 03 - Risk Detection | Risk seviyesini belirler. |
| 04 - Category Classification | E-postayı konu kategorisine ayırır. |
| 05 - Trend Calculation | Günlük ve haftalık trendleri hesaplar. |
| 06 - Alert Notification | Kritik risklerde bildirim gönderir. |
| 07 - Weekly Report Generator | Haftalık rapor üretir. |
| 08 - AI Reply Suggestion | Cevap önerisi oluşturur. |

Bu workflow mimarisi, sistemi modüler hale getirir. Her adım ayrı ayrı test edilebilir ve geliştirilebilir.

---
## XI. Web Arayüz Tasarımı

MailSense AI projesinde analiz sonuçlarının kullanıcı tarafından daha kolay takip edilebilmesi için web tabanlı bir dashboard arayüzü tasarlanmıştır. Bu arayüz, veritabanında saklanan e-posta analiz sonuçlarını özet istatistikler, tablolar ve görsel bileşenler aracılığıyla sunmayı amaçlamaktadır.

Arayüzde gösterilen temel bileşenler şunlardır:

- Toplam analiz edilen e-posta sayısı.
- Pozitif, nötr ve negatif e-posta dağılımı.
- Yüksek ve kritik riskli e-posta sayısı.
- Ortalama risk skoru.
- En sık geçen anahtar kelimeler.
- Sistem uyarıları.
- Workflow çalışma logları.

Arayüz HTML, CSS ve JavaScript kullanılarak geliştirilmiştir. Bu tercih, projenin kolay çalıştırılabilir ve GitHub üzerinde anlaşılır olmasını sağlamaktadır. Dashboard, `frontend` klasörü altında `index.html`, `style.css` ve `app.js` dosyaları ile hazırlanmıştır.

Web arayüz, veritabanı ve n8n workflow yapılarıyla birlikte çalışacak şekilde tasarlanmıştır. Böylece proje yalnızca arka planda çalışan bir analiz sistemi değil, aynı zamanda sonuçları kullanıcıya sunabilen bütünleşik bir platform haline gelmektedir.

---
## XII. AI Analiz Süreci

AI analiz sürecinde e-posta metni sisteme giriş olarak alınır. Modelden yapılandırılmış bir çıktı üretmesi beklenir. Örnek çıktı alanları şunlardır:

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

Örneğin, “I am extremely angry. If this issue is not solved today, I will cancel my account and start a legal complaint.” cümlesi sistem tarafından negatif ve kritik riskli olarak değerlendirilir. Bu durumda sistem otomatik uyarı üretir ve yönetime eskalasyon önerir.

---

## XIII. Test Senaryoları

Projede örnek veri seti kullanılarak çeşitli testler yapılmıştır. Test senaryoları şu şekildedir:

1. Negatif e-posta analizi.
2. Pozitif geri bildirim analizi.
3. Teknik destek e-postasının sınıflandırılması.
4. Kritik riskli hukuki şikayet e-postasının tespiti.
5. Anahtar kelime eşleştirme testi.
6. Otomatik alert trigger testi.
7. AI cevap önerisi log trigger testi.
8. Günlük e-posta trend raporu testi.

Test sonuçlarında sistemin örnek verileri doğru şekilde sakladığı, analiz sonuçlarını raporlayabildiği ve trigger mekanizmalarının çalıştığı görülmüştür.

---

## XIV. Güvenlik ve Veri Gizliliği

E-posta verileri kişisel veya kurumsal hassas bilgiler içerebilir. Bu nedenle sistem tasarımında güvenlik ve gizlilik önemli bir unsur olarak ele alınmıştır.

Gerçek e-posta şifreleri, API anahtarları ve bağlantı bilgileri GitHub’a yüklenmemelidir. Bu nedenle `.env.example` dosyası yalnızca örnek yapı olarak kullanılmıştır. Gerçek gizli bilgiler `.env` dosyasında saklanmalı ve `.gitignore` ile versiyon kontrolünden çıkarılmalıdır.

Ayrıca sistemde kullanıcı rolleri tanımlanmıştır. `admin`, `manager`, `analyst` ve `support_agent` gibi roller sayesinde erişim kontrolü genişletilebilir.

---

## XV. Sonuç

Bu proje kapsamında, e-posta yazışmalarından duygu trendi analizi yapabilen AI destekli bir veritabanı yönetim sistemi tasarlanmıştır. Proje, ilişkisel veritabanı tasarımı, SQL sorguları, view yapıları, trigger mekanizmaları ve n8n workflow otomasyonu ile kapsamlı bir yapıya sahiptir.

MailSense AI, kurumların müşteri iletişimlerini daha etkili analiz etmesini, riskli durumları erken fark etmesini ve veriye dayalı kararlar almasını sağlayabilecek bir sistem olarak tasarlanmıştır. Proje, Veritabanı Yönetim Sistemleri dersinde öğrenilen kavramların gerçekçi ve profesyonel bir senaryo üzerinde uygulanmasını göstermektedir.

---

## Kaynakça

[1] Microsoft, “SQL Server Documentation,” Microsoft Learn.  
[2] n8n Documentation, “Workflow Automation Documentation.”  
[3] OpenAI Documentation, “AI Model Usage and Structured Outputs.”  
[4] Silberschatz, A., Korth, H. F., and Sudarshan, S., Database System Concepts.  
[5] Elmasri, R. and Navathe, S. B., Fundamentals of Database Systems.