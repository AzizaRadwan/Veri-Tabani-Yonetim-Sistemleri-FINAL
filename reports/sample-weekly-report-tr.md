# MailSense AI - Haftalık E-posta Duygu ve Risk Raporu

## Rapor Bilgileri

| Alan | Değer |
|---|---|
| Rapor Türü | Haftalık |
| Rapor Dönemi | 10 Mayıs 2026 - 16 Mayıs 2026 |
| Sistem | MailSense AI |
| Veritabanı | MailSenseAI |
| Hazırlayan | Azize Rdwan |

---

## 1. Genel Özet

Bu rapor, MailSense AI sistemi tarafından analiz edilen e-posta verilerinin haftalık özetini sunmaktadır. Rapor döneminde toplam 5 e-posta analiz edilmiştir. E-postalar duygu durumu, risk seviyesi, anahtar kelimeler ve önerilen aksiyonlar açısından değerlendirilmiştir.

---

## 2. Genel İstatistikler

| Metrik | Değer |
|---|---:|
| Toplam E-posta | 5 |
| Pozitif E-posta | 1 |
| Nötr E-posta | 2 |
| Negatif E-posta | 2 |
| Yüksek Riskli E-posta | 1 |
| Kritik Riskli E-posta | 1 |
| Ortalama Duygu Skoru | -0.15 |
| Ortalama Risk Skoru | 0.48 |

---

## 3. Duygu Dağılımı

| Duygu Durumu | E-posta Sayısı | Ortalama Skor |
|---|---:|---:|
| Negative | 2 | -0.865 |
| Neutral | 2 | 0.025 |
| Positive | 1 | 0.920 |

Bu dağılıma göre haftalık e-posta iletişiminde negatif ve nötr mesajların ağırlıkta olduğu görülmektedir. Negatif e-postaların müşteri memnuniyeti açısından dikkatle takip edilmesi önerilir.

---

## 4. Risk Dağılımı

| Risk Seviyesi | E-posta Sayısı | Ortalama Risk Skoru |
|---|---:|---:|
| Critical | 1 | 0.96 |
| High | 1 | 0.82 |
| Medium | 1 | 0.45 |
| Low | 2 | 0.075 |

Bu sonuçlara göre rapor döneminde 2 adet yüksek öncelikli risk tespit edilmiştir. Özellikle kritik risk seviyesine sahip e-posta için hızlı müdahale gerekmektedir.

---

## 5. Yüksek ve Kritik Riskli E-postalar

| Gönderen | Konu | Risk Seviyesi | Risk Skoru | Önerilen Aksiyon |
|---|---|---|---:|---|
| customer4@example.com | Cancellation and legal complaint warning | Critical | 0.96 | Yönetim ekibine hemen eskale edilmeli. |
| customer1@example.com | Refund request for delayed order | High | 0.82 | Destek yöneticisine atanmalı ve 1 saat içinde cevaplanmalı. |

---

## 6. En Sık Geçen Anahtar Kelimeler

| Anahtar Kelime | Tür | Frekans |
|---|---|---:|
| cancel | complaint | 1 |
| delayed | complaint | 1 |
| enterprise | general | 1 |
| error code | technical | 1 |
| refund | payment | 1 |
| urgent | urgent | 1 |
| legal complaint | legal | 1 |

Anahtar kelimeler, haftalık iletişimde şikayet, teknik sorun ve ödeme konularının öne çıktığını göstermektedir.

---

## 7. Sistem Uyarıları

| Uyarı Türü | Durum | Mesaj |
|---|---|---|
| Slack | Sent | High risk refund request detected for customer1@example.com. |
| Email | Sent | Critical legal complaint and cancellation risk detected. |
| System | Pending | Automatic alert generated for critical risk case. |

---

## 8. AI Cevap Önerileri

| E-posta | Ton | Durum | Öneri Özeti |
|---|---|---|---|
| customer1@example.com | Apologetic | Pending | Gecikme için özür dilenmesi ve iade talebinin inceleneceği belirtilmiştir. |
| customer4@example.com | Urgent | Pending | Konunun yönetime aktarıldığı ve öncelikli olarak ele alınacağı belirtilmiştir. |

---

## 9. Değerlendirme

Haftalık analiz sonuçları, müşteri iletişiminde bazı riskli durumların bulunduğunu göstermektedir. Özellikle iptal tehdidi, hukuki şikayet ve iade talebi içeren e-postalar hızlı aksiyon gerektirmektedir.

Sistemin trigger mekanizması sayesinde yüksek ve kritik riskli durumlar otomatik olarak uyarı kayıtlarına dönüştürülmüştür. Bu durum, MailSense AI sisteminin erken uyarı mekanizması olarak kullanılabileceğini göstermektedir.

---

## 10. Öneriler

- Kritik riskli e-postalara aynı gün içinde dönüş yapılmalıdır.
- Negatif duygu içeren e-postalar destek yöneticisi tarafından incelenmelidir.
- Teknik sorun içeren mesajlar teknik destek ekibine yönlendirilmelidir.
- Haftalık duygu trendleri düzenli olarak takip edilmelidir.
- AI cevap önerileri onay mekanizmasıyla kullanılmalıdır.

---

## Sonuç

Bu haftalık rapor, MailSense AI sisteminin e-posta yazışmalarından anlamlı analizler üretebildiğini göstermektedir. Sistem; duygu analizi, risk tespiti, anahtar kelime çıkarımı, otomatik uyarı ve raporlama özellikleriyle kurumsal iletişim yönetimine katkı sağlayabilecek bir yapı sunmaktadır.