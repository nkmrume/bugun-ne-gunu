-- ========================================================
-- Bugün Ne Günü? (Special Days Directory)
-- Complete Database Schema with 50+ Real Special Days
-- ========================================================

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DROP TABLE IF EXISTS special_days;

CREATE TABLE special_days (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    slug TEXT NOT NULL UNIQUE,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    content TEXT NOT NULL,
    celebration_date DATE NOT NULL,
    month_no INTEGER NOT NULL CHECK (month_no >= 1 AND month_no <= 12),
    day_no INTEGER NOT NULL CHECK (day_no >= 1 AND day_no <= 31),
    category TEXT NOT NULL,
    hashtags TEXT[] DEFAULT '{}',
    affiliate_keywords TEXT[] DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

CREATE INDEX idx_special_days_slug ON special_days(slug);
CREATE INDEX idx_special_days_today ON special_days(month_no, day_no);
CREATE INDEX idx_special_days_month ON special_days(month_no);
CREATE INDEX idx_special_days_category ON special_days(category);
CREATE INDEX idx_special_days_celebration_date ON special_days(celebration_date);
CREATE INDEX idx_special_days_fts ON special_days USING gin(to_tsvector('simple', title || ' ' || description));

ALTER TABLE special_days ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read access for special_days"
    ON special_days FOR SELECT USING (true);

CREATE POLICY "Service role full access"
    ON special_days USING (auth.role() = 'service_role');

-- Trigger
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_special_days_updated_at
    BEFORE UPDATE ON special_days
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- INSERT ALL DAYS
INSERT INTO special_days (id, slug, title, description, content, celebration_date, month_no, day_no, category, hashtags, affiliate_keywords) VALUES
('f8b9a112-9844-48f8-b3f1-000000000001', 'dunya-hijyen-gunu', '16 Ocak Dünya Hijyen Günü', 'Kişisel temizlik, el yıkama ve halk sağlığını koruma alışkanlıklarını hatırlatan gün.', '## 16 Ocak Dünya Hijyen Günü Nedir?
Kişisel hijyenin salgın hastalıklardan korunmadaki en etkili ve ucuz yöntem olduğunu vurgulamak amacıyla kutlanır.

### Tarihçesi ve Önemi
Kişisel hijyenin salgın hastalıklardan korunmadaki en etkili ve ucuz yöntem olduğunu vurgulamak amacıyla kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 16 Ocak Dünya Hijyen Günü Nasıl Kutlanır?
1. Ellerinizi en az 20 saniye sabunla doğru şekilde yıkayın.
2. Yaşam alanlarınızı düzenli havalandırın ve temizleyin.
3. Çocuklara hijyen kurallarını öğretin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Temizlik imandandır ve sağlığın başıdır! 16 Ocak Dünya Hijyen Günü kutlu olsun. 🧼🫧"
* "16 Ocak Dünya Hijyen Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #HijyenGunu #ElYikama #Temizlik"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-hijyen-gunu"', '2026-01-16', 1, 16, 'Sağlık', ARRAY['#HijyenGunu','#ElYikama','#Temizlik','#HalkSagligi'], ARRAY['otomatik sabunluk sensörlü','antibakteriyel el dezenfektanı','bambu banyo havlusu']),
('f8b9a112-9844-48f8-b3f1-000000000002', 'dunya-gumruk-gunu', '26 Ocak Dünya Gümrük Günü', 'Uluslararası ticaretin güvenliği ve gümrük çalışanlarının fedakarlıklarını onurlandıran gün.', '## 26 Ocak Dünya Gümrük Günü Nedir?
Dünya Gümrük Örgütü''nün ilk toplantısını yaptığı 26 Ocak 1953 anısına küresel ticaretin güvenliğini kutlar.

### Tarihçesi ve Önemi
Dünya Gümrük Örgütü''nün ilk toplantısını yaptığı 26 Ocak 1953 anısına küresel ticaretin güvenliğini kutlar. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 26 Ocak Dünya Gümrük Günü Nasıl Kutlanır?
1. Gümrük emekçilerine teşekkür edin.
2. Yasal ve kayıtlı ticaretin önemini öğrenin.
3. Kaçakçılıkla mücadeleye dikkat çekin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Sınırlarımızın ve ekonomimizin bekçisi tüm gümrük çalışanlarımızın Dünya Gümrük Günü kutlu olsun! 🛃🚢"
* "26 Ocak Dünya Gümrük Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #GumrukGunu #26Ocak #GumrukMuhafaza"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-gumruk-gunu"', '2026-01-26', 1, 26, 'Mesleki', ARRAY['#GumrukGunu','#26Ocak','#GumrukMuhafaza','#Ticaret'], ARRAY['seyahat pasaport kılıfı','valiz bavul seti','bagaj tartısı dijital']),
('f8b9a112-9844-48f8-b3f1-000000000003', 'sivil-savunma-gunu', '28 Şubat Sivil Savunma Günü', 'Deprem, yangın ve afetlere karşı hazırlıklı olma ve sivil savunma bilincini artıran gün.', '## 28 Şubat Sivil Savunma Günü Nedir?
7126 sayılı Sivil Savunma Kanunu''nun yürürlüğe girdiği 28 Şubat, afetlere karşı bilinçli toplum inşası için kutlanır.

### Tarihçesi ve Önemi
7126 sayılı Sivil Savunma Kanunu''nun yürürlüğe girdiği 28 Şubat, afetlere karşı bilinçli toplum inşası için kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 28 Şubat Sivil Savunma Günü Nasıl Kutlanır?
1. Evinizde ve iş yerinizde deprem çantanızı güncelleyin.
2. Ailenizle afet toplanma alanınızı kontrol edin.
3. Yangın ve tahliye tatbikatlarına katılın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Afetlere hazırlıklı olmak hayat kurtarır! 28 Şubat Sivil Savunma Günü kutlu olsun. 🚨🎒"
* "28 Şubat Sivil Savunma Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #SivilSavunmaGunu #AfetBilinci #DepremeHazirlik"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #sivil-savunma-gunu"', '2026-02-28', 2, 28, 'Resmi', ARRAY['#SivilSavunmaGunu','#AfetBilinci','#DepremeHazirlik','#AFAD'], ARRAY['deprem acil durum çantası','el feneri şarjlı','düdük pusula çok amaçlı','ilk yardım çantası']),
('f8b9a112-9844-48f8-b3f1-000000000004', 'dunya-tuketici-haklari-gunu', '15 Mart Dünya Tüketici Hakları Günü', 'Tüketicilerin güvenlik, bilgilendirilme ve zararların tazmini haklarını savunan uluslararası gün.', '## 15 Mart Dünya Tüketici Hakları Günü Nedir?
1962 yılında ABD Başkanı John F. Kennedy''nin Tüketici Hakları Bildirgesi''ni açıkladığı günün anısına kutlanır.

### Tarihçesi ve Önemi
1962 yılında ABD Başkanı John F. Kennedy''nin Tüketici Hakları Bildirgesi''ni açıkladığı günün anısına kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 15 Mart Dünya Tüketici Hakları Günü Nasıl Kutlanır?
1. Alışverişlerinizde fatura ve fiş almayı ihmal etmeyin.
2. Tüketici Hakem Heyetleri''ne başvurma haklarınızı öğrenin.
3. Yanıltıcı reklamlara karşı bilinçli olun.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Bilinçli tüketici güçlü toplum demektir! 15 Mart Dünya Tüketici Hakları Günü kutlu olsun. 🛍️⚖️"
* "15 Mart Dünya Tüketici Hakları Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #TuketiciHaklariGunu #BilincliTuketici #HaklariniBil"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-tuketici-haklari-gunu"', '2026-03-15', 3, 15, 'Farkındalık', ARRAY['#TuketiciHaklariGunu','#BilincliTuketici','#HaklariniBil','#15Mart'], ARRAY['tüketici hukuku el kitabı','para yönetim bütçe defteri']),
('f8b9a112-9844-48f8-b3f1-000000000005', 'dunya-siir-gunu', '21 Mart Dünya Şiir Günü', 'Duyguların en saf ifadesi olan şiir sanatını, şairleri ve sözcüklerin büyüsünü kutlayan UNESCO günü.', '## 21 Mart Dünya Şiir Günü Nedir?
UNESCO tarafından 1999 yılında şiirin diller arası köprü kurma gücünü onurlandırmak amacıyla kabul edilmiştir.

### Tarihçesi ve Önemi
UNESCO tarafından 1999 yılında şiirin diller arası köprü kurma gücünü onurlandırmak amacıyla kabul edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 21 Mart Dünya Şiir Günü Nasıl Kutlanır?
1. En sevdiğiniz şairden bir şiir okuyup paylaşın.
2. Kendi duygularınızı mısralara dökün.
3. Şiir dinletilerine katılın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Şiir hayatın nefesidir. 21 Mart Dünya Şiir Günü''nde yüreğinizden şiirler eksik olmasın! 📜🖋️"
* "21 Mart Dünya Şiir Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaSiirGunu #SiirSokakta #NazimHikmet"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-siir-gunu"', '2026-03-21', 3, 21, 'Kültür & Sanat', ARRAY['#DunyaSiirGunu','#SiirSokakta','#NazimHikmet','#CemalSureya','#Siir'], ARRAY['türk şiir antolojisi','nazım hikmet şiirleri','cemal süreya sevda sözleri','dolma kalem']),
('f8b9a112-9844-48f8-b3f1-000000000006', 'dunya-meteoroloji-gunu', '23 Mart Dünya Meteoroloji Günü', 'Hava durumu tahminleri, iklim bilimi ve erken uyarı sistemlerinin hayat kurtarıcı rolünü kutlayan gün.', '## 23 Mart Dünya Meteoroloji Günü Nedir?
Dünya Meteoroloji Örgütü''nün (WMO) 1950''de yürürlüğe giren sözleşmesinin yıl dönümü anısına kutlanır.

### Tarihçesi ve Önemi
Dünya Meteoroloji Örgütü''nün (WMO) 1950''de yürürlüğe giren sözleşmesinin yıl dönümü anısına kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 23 Mart Dünya Meteoroloji Günü Nasıl Kutlanır?
1. İklim değişikliğinin hava olayları üzerindeki etkilerini inceleyin.
2. Afet erken uyarı bildirimlerini takip edin.
3. Meteoroloji çalışanlarına teşekkür edin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Hava şartları ne olursa olsun kalbiniz güneşli olsun! 23 Mart Dünya Meteoroloji Günü kutlu olsun. ☀️🌧️🌈"
* "23 Mart Dünya Meteoroloji Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #MeteorolojiGunu #HavaDurumu #IklimBilimi"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-meteoroloji-gunu"', '2026-03-23', 3, 23, 'Çevre & Doğa', ARRAY['#MeteorolojiGunu','#HavaDurumu','#IklimBilimi','#WMO'], ARRAY['ev tipi meteoroloji istasyonu','dijital termometre higrometre','barometre']),
('f8b9a112-9844-48f8-b3f1-000000000007', 'dunya-saka-gunu', '1 Nisan Şaka Günü', 'Tüm dünyada insanların birbirine zararsız, neşeli ve zekice şakalar yaptığı kahkaha dolu gün.', '## 1 Nisan Şaka Günü Nedir?
Kökeni 16. yüzyıl Fransa takvim reformuna dayanan 1 Nisan, asırlardır dünya genelinde şakalarla kutlanmaktadır.

### Tarihçesi ve Önemi
Kökeni 16. yüzyıl Fransa takvim reformuna dayanan 1 Nisan, asırlardır dünya genelinde şakalarla kutlanmaktadır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 1 Nisan Şaka Günü Nasıl Kutlanır?
1. Arkadaşlarınıza kırıcı olmayan sevimli bir şaka yapın.
2. Bol bol gülün ve mizahın tadını çıkarın.
3. Size yapılan şakalara tebessümle karşılık verin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Gülmek en güzel şifadır! 1 Nisan Şaka Günü''nüz bol tebessümlü ve kahkahalı geçsin! 🎭😄"
* "1 Nisan Şaka Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #1Nisan #SakaGunu #AprilFools"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-saka-gunu"', '2026-04-01', 4, 1, 'Eğlence', ARRAY['#1Nisan','#SakaGunu','#AprilFools','#Gulumse'], ARRAY['zararsız şaka malzemeleri','esprili kupa bardak','parti şaka oyunları']),
('f8b9a112-9844-48f8-b3f1-000000000008', 'polis-teskilati-kurulus-gunu', '10 Nisan Türk Polis Teşkilatı Kuruluş Günü', 'Huzur, güvenlik ve asayişimizin teminatı olan Türk Polis Teşkilatı''nın kuruluşunu kutlayan gün.', '## 10 Nisan Türk Polis Teşkilatı Kuruluş Günü Nedir?
10 Nisan 1845''te kurulan Türk Polis Teşkilatı, milletimizin can ve mal emniyetini sağlamak için görev yapmaktadır.

### Tarihçesi ve Önemi
10 Nisan 1845''te kurulan Türk Polis Teşkilatı, milletimizin can ve mal emniyetini sağlamak için görev yapmaktadır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 10 Nisan Türk Polis Teşkilatı Kuruluş Günü Nasıl Kutlanır?
1. Görev başındaki polis memurlarına kolaylıklar dileyin.
2. Şehit polislerimizi dualarla anın.
3. Trafik ve asayiş kurallarına uyun.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Huzurumuzun ve güvenliğimizin teminatı kahraman polislerimizin 10 Nisan Polis Haftası kutlu olsun! 👮‍♂️🇹🇷"
* "10 Nisan Türk Polis Teşkilatı Kuruluş Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #PolisHaftasi #10Nisan #TurkPolisTeskilati"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #polis-teskilati-kurulus-gunu"', '2026-04-10', 4, 10, 'Mesleki', ARRAY['#PolisHaftasi','#10Nisan','#TurkPolisTeskilati','#PolisimizinYanindayiz'], ARRAY['polis temalı hediye kupa','taktik fener','deri polis cüzdan rozet']),
('f8b9a112-9844-48f8-b3f1-000000000009', 'dunya-pilotlar-gunu', '26 Nisan Dünya Pilotlar Günü', 'Türkiye''nin 1 numaralı pilot brövesi sahibi Fesa Evrensev''in anısına tüm dünyada kutlanan havacılık günü.', '## 26 Nisan Dünya Pilotlar Günü Nedir?
Türkiye Havayolu Pilotları Derneği''nin (TALPA) önerisiyle IFALPA tarafından Fesa Evrensev''in ilk uçuş günü kabul edilmiştir.

### Tarihçesi ve Önemi
Türkiye Havayolu Pilotları Derneği''nin (TALPA) önerisiyle IFALPA tarafından Fesa Evrensev''in ilk uçuş günü kabul edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 26 Nisan Dünya Pilotlar Günü Nasıl Kutlanır?
1. Gökyüzünün cesur kaptanlarına teşekkür edin.
2. Havacılık müzelerini gezin.
3. Uçuş simülasyonu deneyin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "İstikbal göklerdedir! Kanatlarıyla dünyayı birbirine bağlayan tüm pilotlarımızın günü kutlu olsun! ✈️👨‍✈️👩‍✈️"
* "26 Nisan Dünya Pilotlar Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaPilotlarGunu #WorldPilotsDay #Goklerdeyiz"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-pilotlar-gunu"', '2026-04-26', 4, 26, 'Mesleki', ARRAY['#DunyaPilotlarGunu','#WorldPilotsDay','#Goklerdeyiz','#Havacilik'], ARRAY['uçak maketi metal','pilot güneş gözlüğü aviator','havacılık temalı saat']),
('f8b9a112-9844-48f8-b3f1-000000000010', 'uluslararasi-caz-gunu', '30 Nisan Uluslararası Caz Günü', 'Özgürlüğün, doğaçlamanın ve diyalogun müziği olan cazı onurlandıran UNESCO günü.', '## 30 Nisan Uluslararası Caz Günü Nedir?
UNESCO iyi niyet elçisi caz efsanesi Herbie Hancock öncülüğünde 2011 yılında ilan edilmiştir.

### Tarihçesi ve Önemi
UNESCO iyi niyet elçisi caz efsanesi Herbie Hancock öncülüğünde 2011 yılında ilan edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 30 Nisan Uluslararası Caz Günü Nasıl Kutlanır?
1. Miles Davis, Louis Armstrong veya Türk caz sanatçılarını dinleyin.
2. Bir caz kulübünü ziyaret edin.
3. Plak dinleme gecesi yapın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Caz özgürlüğün sesidir. 30 Nisan Uluslararası Caz Günü''nde notaların büyüsüne kapılın! 🎷🎺🎶"
* "30 Nisan Uluslararası Caz Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #CazGunu #JazzDay #MuzikOzgurluktur"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #uluslararasi-caz-gunu"', '2026-04-30', 4, 30, 'Kültür & Sanat', ARRAY['#CazGunu','#JazzDay','#MuzikOzgurluktur','#Jazz'], ARRAY['plak çalar pikap bluetooth','caz plakları efsane','saksafon başlangıç']),
('f8b9a112-9844-48f8-b3f1-000000000011', 'basin-ozgurlugu-gunu', '3 Mayıs Dünya Basın Özgürlüğü Günü', 'Bağımsız, sansürsüz ve özgür basının demokrasilerdeki hayati önemini hatırlatan BM günü.', '## 3 Mayıs Dünya Basın Özgürlüğü Günü Nedir?
1993 yılında BM Genel Kurulu tarafından hükümetlere basın özgürlüğünü koruma taahhüdünü hatırlatmak için ilan edilmiştir.

### Tarihçesi ve Önemi
1993 yılında BM Genel Kurulu tarafından hükümetlere basın özgürlüğünü koruma taahhüdünü hatırlatmak için ilan edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 3 Mayıs Dünya Basın Özgürlüğü Günü Nasıl Kutlanır?
1. Bağımsız gazetecileri ve medya kuruluşlarını destekleyin.
2. Dezenformasyona karşı doğru haberi teyit edin.
3. Sansüre karşı düşünce özgürlüğünü savunun.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Özgür basın halkın nefes borusudur. 3 Mayıs Dünya Basın Özgürlüğü Günü kutlu olsun! 📰✍️"
* "3 Mayıs Dünya Basın Özgürlüğü Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #BasinOzgurluguGunu #WorldPressFreedomDay #OzgurBasin"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #basin-ozgurlugu-gunu"', '2026-05-03', 5, 3, 'Farkındalık', ARRAY['#BasinOzgurluguGunu','#WorldPressFreedomDay','#OzgurBasin','#HaberHakki'], ARRAY['gazetecilik etik kitapları','basın tarihi araştırmaları']),
('f8b9a112-9844-48f8-b3f1-000000000012', 'hidirellez', '5 Mayıs Hıdırellez Kültür Bayramı', 'Hızır ve İlyas peygamberlerin yeryüzünde buluştuğu gün olarak kabul edilen köklü bahar bayramı.', '## 5 Mayıs Hıdırellez Kültür Bayramı Nedir?
UNESCO İnsanlığın Somut Olmayan Kültürel Mirası Temsili Listesi''nde yer alan Hıdırellez, baharın ve bereketin müjdecisidir.

### Tarihçesi ve Önemi
UNESCO İnsanlığın Somut Olmayan Kültürel Mirası Temsili Listesi''nde yer alan Hıdırellez, baharın ve bereketin müjdecisidir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 5 Mayıs Hıdırellez Kültür Bayramı Nasıl Kutlanır?
1. Gül ağacının altına dileklerinizi çizin veya asın.
2. Ateşin üzerinden atlayarak yeni başlangıçlara niyet edin.
3. Doğada sevdiklerinizle piknik yapın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Hızır yoldaşınız, dilekleriniz gerçek olsun! Hıdırellez Bayramınız bereket ve sağlık getirsin. 🌾🔥🌸"
* "5 Mayıs Hıdırellez Kültür Bayramı kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #Hidirellez #BaharBayrami #DileklerKabulOlsun"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #hidirellez"', '2026-05-05', 5, 5, 'Kültür & Sanat', ARRAY['#Hidirellez','#BaharBayrami','#DileklerKabulOlsun','#5Mayis'], ARRAY['tütsü seti doğal','dilek feneri renkli','hasır piknik sepeti']),
('f8b9a112-9844-48f8-b3f1-000000000013', 'dunya-psikologlar-gunu', '10 Mayıs Dünya Psikologlar Günü', 'İnsan ruhunu anlamak, iyileştirmek ve toplumsal esenliği sağlamak için çalışan psikologlara adanan gün.', '## 10 Mayıs Dünya Psikologlar Günü Nedir?
Ruh sağlığı alanında çalışan psikologların mesleki dayanışmasını güçlendirmek amacıyla kutlanır.

### Tarihçesi ve Önemi
Ruh sağlığı alanında çalışan psikologların mesleki dayanışmasını güçlendirmek amacıyla kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 10 Mayıs Dünya Psikologlar Günü Nasıl Kutlanır?
1. Psikolog dostlarınıza tebrik mesajı iletin.
2. Psikolojik sağlığın önemini çevrenize anlatın.
3. Kendinize şefkat göstermeyi öğrenin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Ruhumuza ayna tutan, karanlık yollarımızı aydınlatan tüm psikologlarımızın günü kutlu olsun! 🧠🛋️"
* "10 Mayıs Dünya Psikologlar Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #PsikologlarGunu #10Mayis #RuhSagligi"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-psikologlar-gunu"', '2026-05-10', 5, 10, 'Mesleki', ARRAY['#PsikologlarGunu','#10Mayis','#RuhSagligi','#Psikoloji'], ARRAY['psikoloji temalı kupa','terapi not defteri','freud biblo masa üstü']),
('f8b9a112-9844-48f8-b3f1-000000000014', 'eczacilik-gunu', '14 Mayıs Eczacılık Günü', 'Türkiye''de bilimsel eczacılık eğitiminin başladığı günün anısına sağlık danışmanımız eczacılara adanan gün.', '## 14 Mayıs Eczacılık Günü Nedir?
14 Mayıs 1839''da Mekteb-i Tıbbiye-i Adliye-i Şahane bünyesinde ilk eczacı sınıfının açılmasıyla bilimsel eczacılık başlamıştır.

### Tarihçesi ve Önemi
14 Mayıs 1839''da Mekteb-i Tıbbiye-i Adliye-i Şahane bünyesinde ilk eczacı sınıfının açılmasıyla bilimsel eczacılık başlamıştır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 14 Mayıs Eczacılık Günü Nasıl Kutlanır?
1. Mahallenizin eczacısına teşekkür edin.
2. İlaçları mutlaka hekim ve eczacı kontrolünde kullanın.
3. Akılcı ilaç kullanımına özen gösterin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Sağlığımızın en yakın danışmanı olan tüm fedakar eczacılarımızın 14 Mayıs Eczacılık Günü kutlu olsun! 💊⚕️"
* "14 Mayıs Eczacılık Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #EczacilikGunu #14Mayis #EczacimizaTesekkurler"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #eczacilik-gunu"', '2026-05-14', 5, 14, 'Sağlık', ARRAY['#EczacilikGunu','#14Mayis','#EczacimizaTesekkurler','#Saglik'], ARRAY['eczacı hediye seti kupa','havan biblo seramik','ilaç saklama kutusu haftalık']),
('f8b9a112-9844-48f8-b3f1-000000000015', 'uluslararasi-aile-gunu', '15 Mayıs Uluslararası Aile Günü', 'Toplumun temel taşı olan ailenin korunması, sevgi ve dayanışmanın güçlendirilmesi için kutlanan BM günü.', '## 15 Mayıs Uluslararası Aile Günü Nedir?
1993 yılında BM Genel Kurulu tarafından aile kurumunun önemine dikkat çekmek için kabul edilmiştir.

### Tarihçesi ve Önemi
1993 yılında BM Genel Kurulu tarafından aile kurumunun önemine dikkat çekmek için kabul edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 15 Mayıs Uluslararası Aile Günü Nasıl Kutlanır?
1. Ailenizle birlikte televizyonsuz ve ekransız bir akşam yemeği yiyin.
2. Eski aile fotoğraflarını birlikte inceleyin.
3. Birbirinize olan sevginizi sözlerle ifade edin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Hayattaki en büyük zenginlik huzurlu bir ailedir. 15 Mayıs Uluslararası Aile Günü kutlu olsun! 👨‍👩‍👧‍👦🏡❤️"
* "15 Mayıs Uluslararası Aile Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #AileGunu #FamilyDay #AilemHerSeyim"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #uluslararasi-aile-gunu"', '2026-05-15', 5, 15, 'Farkındalık', ARRAY['#AileGunu','#FamilyDay','#AilemHerSeyim','#SevgiYuvasi'], ARRAY['aile fotoğraf çerçevesi çoklu','kutu kutu aile oyunu','büyük boy piknik örtüsü']),
('f8b9a112-9844-48f8-b3f1-000000000016', 'muzeler-gunu', '18 Mayıs Müzeler Günü', 'Kültürel mirasımızı koruyan, geçmiş ile gelecek arasında köprü kuran müzelerin uluslararası kutlaması.', '## 18 Mayıs Müzeler Günü Nedir?
Uluslararası Müzeler Konseyi (ICOM) tarafından 1977 yılından bu yana toplumda müze bilincini yaymak için kutlanır.

### Tarihçesi ve Önemi
Uluslararası Müzeler Konseyi (ICOM) tarafından 1977 yılından bu yana toplumda müze bilincini yaymak için kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 18 Mayıs Müzeler Günü Nasıl Kutlanır?
1. Bugün en yakın müzeyi ücretsiz veya indirimli gezin.
2. Tarihi eserlerin korunması bilincini çocuklara aktarın.
3. Arkeolojik kazılar hakkında bilgi edinin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Geçmişini bilmeyen geleceğini inşa edemez. 18 Mayıs Müzeler Günü kutlu olsun! 🏛️🏺🗿"
* "18 Mayıs Müzeler Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #MuzelerGunu #InternationalMuseumDay #KulturelMiras"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #muzeler-gunu"', '2026-05-18', 5, 18, 'Kültür & Sanat', ARRAY['#MuzelerGunu','#InternationalMuseumDay','#KulturelMiras','#MuzeleriGez'], ARRAY['müze kart kılıfı','türkiye arkeoloji atlası','sanat tarihi el kitabı']),
('f8b9a112-9844-48f8-b3f1-000000000017', 'dunya-sut-gunu', '21 Mayıs Dünya Süt Günü', 'Sağlıklı kemik ve kas gelişimi için sütün beslenmedeki vazgeçilmez yerini vurgulayan FAO günü.', '## 21 Mayıs Dünya Süt Günü Nedir?
BM Gıda ve Tarım Örgütü (FAO) tarafından süt sektörünü ve sağlıklı beslenmeyi desteklemek için ilan edilmiştir.

### Tarihçesi ve Önemi
BM Gıda ve Tarım Örgütü (FAO) tarafından süt sektörünü ve sağlıklı beslenmeyi desteklemek için ilan edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 21 Mayıs Dünya Süt Günü Nasıl Kutlanır?
1. Günde en az bir bardak süt veya süt ürünü tüketin.
2. Çocuklara süt içme alışkanlığı kazandırın.
3. Yerel süt üreticilerini destekleyin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Sağlıklı nesiller için her gün bir bardak süt! 21 Mayıs Dünya Süt Günü kutlu olsun. 🥛🐮"
* "21 Mayıs Dünya Süt Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaSutGunu #WorldMilkDay #SutIcSaglikBul"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-sut-gunu"', '2026-05-21', 5, 21, 'Sağlık', ARRAY['#DunyaSutGunu','#WorldMilkDay','#SutIcSaglikBul','#KemikSagligi'], ARRAY['süt köpürtücü otomatik','cam süt şişesi retro','yoğurt yapma makinesi']),
('f8b9a112-9844-48f8-b3f1-000000000018', 'biyocesitlilik-gunu', '22 Mayıs Uluslararası Biyoçeşitlilik Günü', 'Gezegenimizdeki tüm türlerin, ekosistemlerin ve genetik zenginliğin korunması için BM tarafından kutlanır.', '## 22 Mayıs Uluslararası Biyoçeşitlilik Günü Nedir?
1992 Biyolojik Çeşitlilik Sözleşmesi''nin kabul edildiği gün olan 22 Mayıs, ekolojik dengenin korunması için kutlanır.

### Tarihçesi ve Önemi
1992 Biyolojik Çeşitlilik Sözleşmesi''nin kabul edildiği gün olan 22 Mayıs, ekolojik dengenin korunması için kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 22 Mayıs Uluslararası Biyoçeşitlilik Günü Nasıl Kutlanır?
1. Endemik bitki ve hayvan türlerini tanıyın.
2. Doğal yaşam alanlarına zarar vermekten kaçının.
3. Kimyasal kirliliği azaltın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Doğadaki her canlı hayat zincirinin vazgeçilmez bir halkasıdır. 22 Mayıs Biyoçeşitlilik Günü kutlu olsun! 🌿🦋🦜"
* "22 Mayıs Uluslararası Biyoçeşitlilik Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #BiyocesitlilikGunu #BiodiversityDay #DogayiKoru"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #biyocesitlilik-gunu"', '2026-05-22', 5, 22, 'Çevre & Doğa', ARRAY['#BiyocesitlilikGunu','#BiodiversityDay','#DogayiKoru','#TurlerYokOlmasin'], ARRAY['kuş yemliği bahçe tipi','endemik bitkiler kitabı türkiye','doğa günlüğü']),
('f8b9a112-9844-48f8-b3f1-000000000019', 'dunya-tutunsuz-gunu', '31 Mayıs Dünya Tütünsüz Günü', 'Tütün salgınının yol açtığı ölümlere dikkat çeken ve dumansız bir dünya hedefleyen DSÖ günü.', '## 31 Mayıs Dünya Tütünsüz Günü Nedir?
Dünya Sağlık Örgütü tarafından tütün tüketimini azaltmak ve pasif içiciliği önlemek için 1987''de kabul edilmiştir.

### Tarihçesi ve Önemi
Dünya Sağlık Örgütü tarafından tütün tüketimini azaltmak ve pasif içiciliği önlemek için 1987''de kabul edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 31 Mayıs Dünya Tütünsüz Günü Nasıl Kutlanır?
1. Bugün 24 saat boyunca sigara içmeyin ve bırakmaya ilk adımı atın.
2. Pasif içiciliğin zararlarından çocukları koruyun.
3. Dumansız alanları destekleyin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Nefes al, hayatı hisset! 31 Mayıs Dünya Tütünsüz Günü''nde temiz bir havaya adım at. 🚭🫁💚"
* "31 Mayıs Dünya Tütünsüz Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #TutunsuzGun #WorldNoTobaccoDay #DumansizHava"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-tutunsuz-gunu"', '2026-05-31', 5, 31, 'Sağlık', ARRAY['#TutunsuzGun','#WorldNoTobaccoDay','#DumansizHava','#SigarayiBirak'], ARRAY['nefes egzersizi cihazı','stres topu seti','bitki çayı rahatlatıcı']),
('f8b9a112-9844-48f8-b3f1-000000000020', 'dunya-cocuk-gunu', '1 Haziran Dünya Çocuk Günü', 'Çocukların refahını, güvenliğini ve mutluluğunu kutlayan uluslararası çocuk günü.', '## 1 Haziran Dünya Çocuk Günü Nedir?
1925 yılında Cenevre Çocukların Refahı Dünya Konferansı''nda ilan edilen ilk uluslararası çocuk günüdür.

### Tarihçesi ve Önemi
1925 yılında Cenevre Çocukların Refahı Dünya Konferansı''nda ilan edilen ilk uluslararası çocuk günüdür. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 1 Haziran Dünya Çocuk Günü Nasıl Kutlanır?
1. Bir çocuğu sevindirin ve ona hediye verin.
2. Çocukların oyun ve eğlence hakkına saygı gösterin.
3. İhtiyaç sahibi çocuklara destek olun.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Dünya çocukların güldüğü kadar güzeldir! 1 Haziran Dünya Çocuk Günü kutlu olsun! 🎈👶👧"
* "1 Haziran Dünya Çocuk Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #1Haziran #DunyaCocukGunu #CocuklarGulsun"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-cocuk-gunu"', '2026-06-01', 6, 1, 'Farkındalık', ARRAY['#1Haziran','#DunyaCocukGunu','#CocuklarGulsun','#CocukHaklari'], ARRAY['akıl ve zeka oyunları çocuk','scooter çocuk 3 tekerlekli','çocuk hikaye kitabı seti']),
('f8b9a112-9844-48f8-b3f1-000000000021', 'turk-isaret-dili-gunu', '7 Haziran Türk İşaret Dili Günü', 'İşitme engelli bireylerin iletişim dili olan Türk İşaret Dili''nin yasal olarak tanındığı gün.', '## 7 Haziran Türk İşaret Dili Günü Nedir?
5378 sayılı Engelliler Kanunu''nda Türk İşaret Dili''nin resmi olarak yer aldığı 7 Haziran 2005 tarihinin anısına kutlanır.

### Tarihçesi ve Önemi
5378 sayılı Engelliler Kanunu''nda Türk İşaret Dili''nin resmi olarak yer aldığı 7 Haziran 2005 tarihinin anısına kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 7 Haziran Türk İşaret Dili Günü Nasıl Kutlanır?
1. Türk İşaret Dili''nde temel selamlaşma ve teşekkür kelimelerini öğrenin.
2. Kamusal yayınlarda işaret dili çevirisi talep edin.
3. İşitme engellilerin toplumsal hayata katılımını destekleyin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Ellerimiz konuşsun, kalplerimiz buluşsun! 7 Haziran Türk İşaret Dili Günü kutlu olsun. 🤟🤲✨"
* "7 Haziran Türk İşaret Dili Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #TurkIsaretDiliGunu #TID #IsitmeEngelliler"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #turk-isaret-dili-gunu"', '2026-06-07', 6, 7, 'Farkındalık', ARRAY['#TurkIsaretDiliGunu','#TID','#IsitmeEngelliler','#EngelsizIletisim'], ARRAY['türk işaret dili öğrenme kitabı','işitme cihazı pili','görsel sözlük kartları']),
('f8b9a112-9844-48f8-b3f1-000000000022', 'dunya-yoga-gunu', '21 Haziran Dünya Yoga Günü', 'Beden, zihin ve ruh dengesini kuran kadim yoga öğretisinin evrensel faydalarını kutlayan BM günü.', '## 21 Haziran Dünya Yoga Günü Nedir?
2014 yılında BM Genel Kurulu tarafından kabul edilen gün, içsel huzur ve bütünsel sağlığı teşvik eder.

### Tarihçesi ve Önemi
2014 yılında BM Genel Kurulu tarafından kabul edilen gün, içsel huzur ve bütünsel sağlığı teşvik eder. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 21 Haziran Dünya Yoga Günü Nasıl Kutlanır?
1. Açık havada veya evinizde 20 dakikalık bir yoga seansı yapın.
2. Derin nefes egzersizleriyle zihninizi dinlendirin.
3. Bedeninizin esnekliğine kulak verin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "İçindeki huzuru keşfet. 21 Haziran Dünya Yoga Günü kutlu olsun! 🧘‍♀️🕉️🧘‍♂️"
* "21 Haziran Dünya Yoga Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaYogaGunu #YogaDay #ZihinBedenRuh"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-yoga-gunu"', '2026-06-21', 6, 21, 'Sağlık', ARRAY['#DunyaYogaGunu','#YogaDay','#ZihinBedenRuh','#Namaste'], ARRAY['yoga matı kaydırmaz tpe','yoga bloğu köpük','meditasyon çanı','yoga taytı']),
('f8b9a112-9844-48f8-b3f1-000000000023', 'dunya-sosyal-medya-gunu', '30 Haziran Dünya Sosyal Medya Günü', 'İnsanları kıtalar ötesinde birbirine bağlayan dijital iletişim devrimini kutlayan küresel gün.', '## 30 Haziran Dünya Sosyal Medya Günü Nedir?
2010 yılında Mashable tarafından sosyal medyanın dünyayı küresel bir köye dönüştürmesini kutlamak için başlatılmıştır.

### Tarihçesi ve Önemi
2010 yılında Mashable tarafından sosyal medyanın dünyayı küresel bir köye dönüştürmesini kutlamak için başlatılmıştır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 30 Haziran Dünya Sosyal Medya Günü Nasıl Kutlanır?
1. Sosyal medyada pozitif ve ilham verici içerikler üretin.
2. Uzun süredir görüşmediğiniz bir eski dostunuza mesaj atın.
3. Sosyal medya kullanım sürenizi bilinçli yönetin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Mesafeleri kaldıran, sesimizi dünyaya duyuran platformların günü kutlu olsun! 30 Haziran Dünya Sosyal Medya Günü! 📱🌐💬"
* "30 Haziran Dünya Sosyal Medya Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #SosyalMedyaGunu #SocialMediaDay #DijitalDunya"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-sosyal-medya-gunu"', '2026-06-30', 6, 30, 'Eğlence', ARRAY['#SosyalMedyaGunu','#SocialMediaDay','#DijitalDunya','#Baglanti'], ARRAY['ring light halka ışık tripodlu','yaka mikrofonu kablosuz','telefon sabitleyici gimbal']),
('f8b9a112-9844-48f8-b3f1-000000000024', 'uluslararasi-dostluk-gunu', '30 Temmuz Uluslararası Dostluk Günü', 'Halklar, ülkeler, kültürler ve bireyler arasındaki dostluk köprülerinin barış getireceğini savunan BM günü.', '## 30 Temmuz Uluslararası Dostluk Günü Nedir?
Birleşmiş Milletler tarafından toplumlar arasında güven ve dayanışma tesis etmek için ilan edilmiştir.

### Tarihçesi ve Önemi
Birleşmiş Milletler tarafından toplumlar arasında güven ve dayanışma tesis etmek için ilan edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 30 Temmuz Uluslararası Dostluk Günü Nasıl Kutlanır?
1. En yakın arkadaşınızı arayıp ona değer verdiğinizi söyleyin.
2. Birlikte kahve için veya anılarınızı yad edin.
3. Yeni insanlarla samimi dostluklar kurun.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "İyi bir dost dünyalara bedeldir. Tüm vefakar dostların 30 Temmuz Uluslararası Dostluk Günü kutlu olsun! 🤝☕❤️"
* "30 Temmuz Uluslararası Dostluk Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DostlukGunu #FriendshipDay #CanDostum"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #uluslararasi-dostluk-gunu"', '2026-07-30', 7, 30, 'Eğlence', ARRAY['#DostlukGunu','#FriendshipDay','#CanDostum','#Dostluk'], ARRAY['arkadaşlık bilekliği çift','anı albümü yapışkanlı','arkadaşa esprili hediye']),
('f8b9a112-9844-48f8-b3f1-000000000025', 'dunya-insani-yardim-gunu', '19 Ağustos Dünya İnsani Yardım Günü', 'Kriz ve savaş bölgelerinde canları pahasına insanlara yardım eli uzatan yardım çalışanlarını anma günü.', '## 19 Ağustos Dünya İnsani Yardım Günü Nedir?
2003 yılında BM Bağdat merkezine yapılan saldırıda hayatını kaybeden 22 yardım görevlisinin anısına kutlanır.

### Tarihçesi ve Önemi
2003 yılında BM Bağdat merkezine yapılan saldırıda hayatını kaybeden 22 yardım görevlisinin anısına kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 19 Ağustos Dünya İnsani Yardım Günü Nasıl Kutlanır?
1. Güvenilir yardım kuruluşlarına bağışta bulunun.
2. Gönüllü yardım projelerinde aktif rol alın.
3. İnsani değerleri savunun.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "İnsanlık yardımlaşmayla yaşar. Tüm fedakar insani yardım çalışanlarına sonsuz minnetle! 19 Ağustos kutlu olsun. 🤝🕊️"
* "19 Ağustos Dünya İnsani Yardım Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #InsaniYardimGunu #WorldHumanitarianDay #YardimEli"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-insani-yardim-gunu"', '2026-08-19', 8, 19, 'Uluslararası', ARRAY['#InsaniYardimGunu','#WorldHumanitarianDay','#YardimEli','#Dayanisma'], ARRAY['kızılay bağış kartı','yardım vakfı sertifikası','çelik matara']),
('f8b9a112-9844-48f8-b3f1-000000000026', 'gaziler-gunu', '19 Eylül Gaziler Günü', 'Mustafa Kemal Atatürk''e ''Gazi'' unvanı ve Mareşal rütbesinin verildiği günün anısına kutlanan milli vefa günü.', '## 19 Eylül Gaziler Günü Nedir?
19 Eylül 1921''de Sakarya Meydan Muharebesi sonrası TBMM tarafından Atatürk''e Gazilik unvanı tevcih edilmiştir.

### Tarihçesi ve Önemi
19 Eylül 1921''de Sakarya Meydan Muharebesi sonrası TBMM tarafından Atatürk''e Gazilik unvanı tevcih edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 19 Eylül Gaziler Günü Nasıl Kutlanır?
1. Muharip gazi derneklerini ziyaret edin.
2. Kahraman gazilerimize şükran ve saygılarınızı sunun.
3. Vatan fedakarlıklarını gençlere aktarın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Şehit nurlanmış, gazi onurlanmış askerdir. Başta Gazi Mustafa Kemal Atatürk olmak üzere tüm gazilerimize minnetle! 🇹🇷🎖️"
* "19 Eylül Gaziler Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #GazilerGunu #19Eylul #KahramanGazilerimiz"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #gaziler-gunu"', '2026-09-19', 9, 19, 'Resmi', ARRAY['#GazilerGunu','#19Eylul','#KahramanGazilerimiz','#Ataturk'], ARRAY['türk bayrağı masa üstü pirinç','atatürk biyografisi ciltli','rozet']),
('f8b9a112-9844-48f8-b3f1-000000000027', 'dunya-turizm-gunu', '27 Eylül Dünya Turizm Günü', 'Farklı kültürleri tanıma, seyahat özgürlüğü ve sürdürülebilir turizmin ekonomik gücünü kutlayan BM günü.', '## 27 Eylül Dünya Turizm Günü Nedir?
Dünya Turizm Örgütü (UNWTO) tüzüğünün kabul edildiği gün olan 27 Eylül, küresel seyahat bilincini artırır.

### Tarihçesi ve Önemi
Dünya Turizm Örgütü (UNWTO) tüzüğünün kabul edildiği gün olan 27 Eylül, küresel seyahat bilincini artırır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 27 Eylül Dünya Turizm Günü Nasıl Kutlanır?
1. Yeni bir şehri veya tarihi bir mekanı keşfe çıkın.
2. Yerel esnafı ve eko-turizmi destekleyin.
3. Gezdiğiniz yerlerin doğasına ve kültürüne saygı gösterin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Dünya bir kitaptır ve seyahat etmeyenler sadece bir sayfasını okur. 27 Eylül Dünya Turizm Günü kutlu olsun! ✈️🗺️🧳"
* "27 Eylül Dünya Turizm Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaTurizmGunu #WorldTourismDay #Gezgin"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-turizm-gunu"', '2026-09-27', 9, 27, 'Kültür & Sanat', ARRAY['#DunyaTurizmGunu','#WorldTourismDay','#Gezgin','#Seyahat'], ARRAY['seyahat sırt çantası kabin boy','boyun yastığı hafızalı sünger','evrensel priz dönüştürücü']),
('f8b9a112-9844-48f8-b3f1-000000000028', 'dunya-yaslilar-gunu', '1 Ekim Dünya Yaşlılar Günü', 'Tecrübeleriyle topluma ışık tutan kıymetli büyüklerimizin haklarını ve refahını koruyan BM günü.', '## 1 Ekim Dünya Yaşlılar Günü Nedir?
Birleşmiş Milletler tarafından yaşlanan nüfusun haklarına, bakımına ve kuşaklar arası dayanışmaya dikkat çekmek için ilan edilmiştir.

### Tarihçesi ve Önemi
Birleşmiş Milletler tarafından yaşlanan nüfusun haklarına, bakımına ve kuşaklar arası dayanışmaya dikkat çekmek için ilan edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 1 Ekim Dünya Yaşlılar Günü Nasıl Kutlanır?
1. Ailenizdeki ve çevrenizdeki yaşlıları ziyaret edip ellerini öpün.
2. Huzurevlerine ziyarette bulunun.
3. Onların hayat tecrübelerini ve hatıralarını dinleyin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Büyüklerimiz geçmişimizin hafızası, geleceğimizin duasıdır. 1 Ekim Dünya Yaşlılar Günü kutlu olsun! 👵🧓🤍"
* "1 Ekim Dünya Yaşlılar Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaYaslilarGunu #BuyuklerimizeSaygi #YasliHaklari"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-yaslilar-gunu"', '2026-10-01', 10, 1, 'Farkındalık', ARRAY['#DunyaYaslilarGunu','#BuyuklerimizeSaygi','#YasliHaklari','#1Ekim'], ARRAY['ortopedik baston ışıklı','yaşlılar için tansiyon aleti konuşan','ısıtmalı ayak masaj aleti']),
('f8b9a112-9844-48f8-b3f1-000000000029', 'dunya-ogretmenler-gunu-unesco', '5 Ekim Dünya Öğretmenler Günü (UNESCO)', 'Dünya genelinde öğretmenlerin statüsü ve haklarını savunan UNESCO ve ILO ortak kutlama günü.', '## 5 Ekim Dünya Öğretmenler Günü (UNESCO) Nedir?
1966 yılında Öğretmenlerin Statüsüne İlişkin Tavsiye Kararı''nın kabul edildiği gün olup tüm dünyada eğitimcileri onurlandırır.

### Tarihçesi ve Önemi
1966 yılında Öğretmenlerin Statüsüne İlişkin Tavsiye Kararı''nın kabul edildiği gün olup tüm dünyada eğitimcileri onurlandırır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 5 Ekim Dünya Öğretmenler Günü (UNESCO) Nasıl Kutlanır?
1. Dünyanın dört bir yanındaki öğretmenlerin emeğini takdir edin.
2. Eğitime bütçe ayrılmasını destekleyin.
3. Öğretmenlerinize mesaj gönderin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Karanlığı aydınlatan tüm fedakar öğretmenlerimizin 5 Ekim Dünya Öğretmenler Günü kutlu olsun! 📚🌍🧑‍🏫"
* "5 Ekim Dünya Öğretmenler Günü (UNESCO) kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaOgretmenlerGunu #WorldTeachersDay #5Ekim"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-ogretmenler-gunu-unesco"', '2026-10-05', 10, 5, 'Mesleki', ARRAY['#DunyaOgretmenlerGunu','#WorldTeachersDay','#5Ekim','#Ogretmen'], ARRAY['lazer sunum kumandası','öğretmen ajandası 2026','isme özel kupa']),
('f8b9a112-9844-48f8-b3f1-000000000030', 'dunya-gida-gunu', '16 Ekim Dünya Gıda Günü', 'Açlıkla mücadele, sürdürülebilir tarım ve gıda israfını önleme bilincini artıran FAO günü.', '## 16 Ekim Dünya Gıda Günü Nedir?
1945 yılında BM Gıda ve Tarım Örgütü''nün (FAO) kuruluş yıl dönümünde herkese yeterli ve güvenli gıda hakkını savunur.

### Tarihçesi ve Önemi
1945 yılında BM Gıda ve Tarım Örgütü''nün (FAO) kuruluş yıl dönümünde herkese yeterli ve güvenli gıda hakkını savunur. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 16 Ekim Dünya Gıda Günü Nasıl Kutlanır?
1. Tabağınıza yiyebileceğiniz kadar yemek alın, israfı önleyin.
2. Artan yemekleri değerlendirme tarifleri uygulayın.
3. Gıda bankalarına ve aşevlerine bağış yapın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Gıda haktır, israf etme! 16 Ekim Dünya Gıda Günü''nde soframızı ve dünyamızı adaletle paylaşalım. 🌾🍞🍲"
* "16 Ekim Dünya Gıda Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaGidaGunu #WorldFoodDay #GidaIsrafinaSon"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-gida-gunu"', '2026-10-16', 10, 16, 'Çevre & Doğa', ARRAY['#DunyaGidaGunu','#WorldFoodDay','#GidaIsrafinaSon','#AcligaSon'], ARRAY['vakumlu saklama kabı seti','hava geçirmez kavanoz','gıda kurutucu makine']),
('f8b9a112-9844-48f8-b3f1-000000000031', 'dunya-tasarruf-gunu', '31 Ekim Dünya Tasarruf Günü', 'Finansal okuryazarlık, para biriktirme ve kaynakları verimli kullanma alışkanlığını teşvik eden gün.', '## 31 Ekim Dünya Tasarruf Günü Nedir?
1924 yılında Milano''da yapılan 1. Uluslararası Tasarruf Bankası Kongresi''nde tasarruf bilincini aşılamak için kabul edilmiştir.

### Tarihçesi ve Önemi
1924 yılında Milano''da yapılan 1. Uluslararası Tasarruf Bankası Kongresi''nde tasarruf bilincini aşılamak için kabul edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 31 Ekim Dünya Tasarruf Günü Nasıl Kutlanır?
1. Aylık bütçenizi ve gereksiz harcamalarınızı gözden geçirin.
2. Çocuklara kumbara alıp birikim yapmayı öğretin.
3. Enerji ve su tüketiminde tasarrufa gidin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Damlaya damlaya göl olur! 31 Ekim Dünya Tasarruf Günü''nde geleceğin için biriktirmeye başla. 🪙💰📈"
* "31 Ekim Dünya Tasarruf Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaTasarrufGunu #Tasarruf #FinansalOkuryazarlik"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-tasarruf-gunu"', '2026-10-31', 10, 31, 'Eğlence', ARRAY['#DunyaTasarrufGunu','#Tasarruf','#FinansalOkuryazarlik','#BirimYap'], ARRAY['dijital para sayan kumbara','finansal özgürlük kitapları','akıllı priz enerji ölçer']),
('f8b9a112-9844-48f8-b3f1-000000000032', 'dunya-sehircilik-gunu', '8 Kasım Dünya Şehircilik Günü', 'Planlı, yaşanabilir, yeşil ve afetlere dayanıklı kentler inşa etme bilincini artıran gün.', '## 8 Kasım Dünya Şehircilik Günü Nedir?
1949 yılında Buenos Aires Üniversitesi profesörü Carlos Maria della Paolera tarafından kent planlamasının önemini anlatmak için başlatılmıştır.

### Tarihçesi ve Önemi
1949 yılında Buenos Aires Üniversitesi profesörü Carlos Maria della Paolera tarafından kent planlamasının önemini anlatmak için başlatılmıştır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 8 Kasım Dünya Şehircilik Günü Nasıl Kutlanır?
1. Kentinizdeki yeşil alanların ve bisiklet yollarının artmasını talep edin.
2. Kentsel dönüşüm ve deprem güvenliği bilincini yaygınlaştırın.
3. Şehir plancılarına teşekkür edin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Daha yeşil, daha adil ve afetlere dirençli şehirler için 8 Kasım Dünya Şehircilik Günü kutlu olsun! 🏙️🌳🚲"
* "8 Kasım Dünya Şehircilik Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaSehircilikGunu #SehirPlanciligi #YasanabilirKentler"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-sehircilik-gunu"', '2026-11-08', 11, 8, 'Mesleki', ARRAY['#DunyaSehircilikGunu','#SehirPlanciligi','#YasanabilirKentler','#8Kasim'], ARRAY['şehir planlama ve mimarlık kitapları','teknik çizim kalemi seti','maket bıçağı seti']),
('f8b9a112-9844-48f8-b3f1-000000000033', 'uluslararasi-hosgoru-gunu', '16 Kasım Uluslararası Hoşgörü Günü', 'Farklılıklara saygı, empati, diyalog ve barış içinde bir arada yaşama kültürünü kutlayan UNESCO günü.', '## 16 Kasım Uluslararası Hoşgörü Günü Nedir?
1995 UNESCO Hoşgörü İlkeleri Bildirgesi''nin imzalanmasıyla nefret söylemi ve ayrımcılıkla mücadele için kabul edilmiştir.

### Tarihçesi ve Önemi
1995 UNESCO Hoşgörü İlkeleri Bildirgesi''nin imzalanmasıyla nefret söylemi ve ayrımcılıkla mücadele için kabul edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 16 Kasım Uluslararası Hoşgörü Günü Nasıl Kutlanır?
1. ''Gel, ne olursan ol yine gel'' anlayışıyla herkese önyargısız yaklaşın.
2. Farklı fikirleri sabırla dinleyin.
3. Hoşgörüyü ve nezaketi yayın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Farklılıklarımız zenginliğimizdir. 16 Kasım Uluslararası Hoşgörü Günü kutlu olsun! 🤝🌈🕊️"
* "16 Kasım Uluslararası Hoşgörü Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #HosgoruGunu #Mevlana #FarkliliklarZenginliktir"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #uluslararasi-hosgoru-gunu"', '2026-11-16', 11, 16, 'Farkındalık', ARRAY['#HosgoruGunu','#Mevlana','#FarkliliklarZenginliktir','#Empati'], ARRAY['mevlana mesnevi seti','felsefe ve empati kitapları','meditasyon müziği cd']),
('f8b9a112-9844-48f8-b3f1-000000000034', 'dunya-televizyon-gunu', '21 Kasım Dünya Televizyon Günü', 'Görsel habercilik, kamuoyu oluşturma ve kültürel etkileşimdeki televizyonun gücünü kutlayan BM günü.', '## 21 Kasım Dünya Televizyon Günü Nedir?
1996 yılında 1. Dünya Televizyon Forumu''nun yapıldığı tarih olup medyanın küresel sorunlara dikkat çekme rolünü onurlandırır.

### Tarihçesi ve Önemi
1996 yılında 1. Dünya Televizyon Forumu''nun yapıldığı tarih olup medyanın küresel sorunlara dikkat çekme rolünü onurlandırır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 21 Kasım Dünya Televizyon Günü Nasıl Kutlanır?
1. Kaliteli belgeseller ve eğitici programlar izleyin.
2. Televizyon haberciliğinin tarihini inceleyin.
3. Ekran sürenizi dengede tutun.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Dünyayı salonumuza getiren ekranın günü! 21 Kasım Dünya Televizyon Günü kutlu olsun! 📺📡🎬"
* "21 Kasım Dünya Televizyon Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #TelevizyonGunu #WorldTelevisionDay #Medya"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-televizyon-gunu"', '2026-11-21', 11, 21, 'Kültür & Sanat', ARRAY['#TelevizyonGunu','#WorldTelevisionDay','#Medya','#Yayin'], ARRAY['akıllı tv kumandası','led tv arka aydınlatma ambiyans','soundbar ses sistemi']),
('f8b9a112-9844-48f8-b3f1-000000000035', 'dunya-aids-gunu', '1 Aralık Dünya AIDS Günü', 'HIV/AIDS konusunda doğru bilinci yaymak, ön yargıları kırmak ve hastalara destek olmak için kutlanan küresel gün.', '## 1 Aralık Dünya AIDS Günü Nedir?
1988 yılından bu yana Dünya Sağlık Örgütü öncülüğünde kırmızı kurdele sembolüyle HIV farkındalığı için düzenlenir.

### Tarihçesi ve Önemi
1988 yılından bu yana Dünya Sağlık Örgütü öncülüğünde kırmızı kurdele sembolüyle HIV farkındalığı için düzenlenir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 1 Aralık Dünya AIDS Günü Nasıl Kutlanır?
1. HIV''in bulaşma ve korunma yolları hakkında doğru bilgi edinin.
2. HIV ile yaşayan bireylere karşı ayrımcılığa dur deyin.
3. Düzenli test yaptırın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Bilinç hayat kurtarır, ön yargı öldürür. 1 Aralık Dünya AIDS Günü''nde farkında olalım. 🎗️❤️"
* "1 Aralık Dünya AIDS Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaAIDSGunu #KirmiziKurdele #FarkindaOl"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-aids-gunu"', '2026-12-01', 12, 1, 'Sağlık', ARRAY['#DunyaAIDSGunu','#KirmiziKurdele','#FarkindaOl','#OnYargiyiKir'], ARRAY['kırmızı kurdele yaka iğnesi','bağışıklık güçlendirici vitamin']),
('f8b9a112-9844-48f8-b3f1-000000000036', 'dunya-toprak-gunu', '5 Aralık Dünya Toprak Günü', 'Besinlerimizin yüzde 95''ini sağlayan toprağın erozyondan ve kirlilikten korunması için BM tarafından kutlanır.', '## 5 Aralık Dünya Toprak Günü Nedir?
BM Gıda ve Tarım Örgütü (FAO) tarafından sağlıklı toprakların ve gıda güvenliğinin önemini vurgulamak için ilan edilmiştir.

### Tarihçesi ve Önemi
BM Gıda ve Tarım Örgütü (FAO) tarafından sağlıklı toprakların ve gıda güvenliğinin önemini vurgulamak için ilan edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 5 Aralık Dünya Toprak Günü Nasıl Kutlanır?
1. Organik atıklarınızı kompost yaparak toprağa geri kazandırın.
2. Erozyonla mücadele eden TEMA Vakfı gibi STK''lara destek olun.
3. Toprağı kimyasallarla kirletmeyin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Toprak varsa hayat var! 5 Aralık Dünya Toprak Günü''nde bereketli toprağımızı koruyalım. 🌱🌍🌾"
* "5 Aralık Dünya Toprak Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaToprakGunu #WorldSoilDay #TopragiKoru"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-toprak-gunu"', '2026-12-05', 12, 5, 'Çevre & Doğa', ARRAY['#DunyaToprakGunu','#WorldSoilDay','#TopragiKoru','#TEMA'], ARRAY['organik kompost gübre','solucan gübresi','bahçıvan kürek seti']),
('f8b9a112-9844-48f8-b3f1-000000000037', 'uluslararasi-dag-gunu', '11 Aralık Uluslararası Dağ Günü', 'Tatlı su kaynaklarımızın ve eşsiz dağ biyoçeşitliliğinin korunmasını savunan BM günü.', '## 11 Aralık Uluslararası Dağ Günü Nedir?
2003 yılında BM Genel Kurulu tarafından dağ ekosistemlerinin kırılganlığına ve dağ topluluklarının sürdürülebilirliğine dikkat çekmek için kabul edilmiştir.

### Tarihçesi ve Önemi
2003 yılında BM Genel Kurulu tarafından dağ ekosistemlerinin kırılganlığına ve dağ topluluklarının sürdürülebilirliğine dikkat çekmek için kabul edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 11 Aralık Uluslararası Dağ Günü Nasıl Kutlanır?
1. Dağ yürüyüşü veya trekking yapın.
2. Dağlık bölgelerdeki doğal yaşam alanlarını koruyun.
3. Dağ köylerinin yerel ürünlerini destekleyin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Göğe uzanan zirvelerimiz doğanın kalbidir. 11 Aralık Uluslararası Dağ Günü kutlu olsun! ⛰️🏔️🌲"
* "11 Aralık Uluslararası Dağ Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #UluslararasiDagGunu #InternationalMountainDay #Daglar"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #uluslararasi-dag-gunu"', '2026-12-11', 12, 11, 'Çevre & Doğa', ARRAY['#UluslararasiDagGunu','#InternationalMountainDay','#Daglar','#Doga'], ARRAY['trekking batonları katlanır','termal dağcı çorabı','kamp termos paslanmaz']),
('f8b9a112-9844-48f8-b3f1-000000000038', 'uluslararasi-gocmenler-gunu', '18 Aralık Uluslararası Göçmenler Günü', 'Dünya çapında göçmenlerin insan hakları, emekleri ve toplumsal katkılarını onurlandıran BM günü.', '## 18 Aralık Uluslararası Göçmenler Günü Nedir?
1990''da Tüm Göçmen İşçilerin ve Aile Fertlerinin Haklarının Korunmasına Dair Uluslararası Sözleşme''nin kabul günü anısına kutlanır.

### Tarihçesi ve Önemi
1990''da Tüm Göçmen İşçilerin ve Aile Fertlerinin Haklarının Korunmasına Dair Uluslararası Sözleşme''nin kabul günü anısına kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 18 Aralık Uluslararası Göçmenler Günü Nasıl Kutlanır?
1. Göçmenlerin temel insan haklarına ve onuruna saygı duyun.
2. Irkçılığa ve yabancı düşmanlığına karşı durun.
3. Farklı kültürlerin topluma kattığı zenginliği takdir edin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Hepimiz aynı gökyüzünün altındayız. 18 Aralık Uluslararası Göçmenler Günü kutlu olsun! 🕊️🌍🤝"
* "18 Aralık Uluslararası Göçmenler Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #GocmenlerGunu #InternationalMigrantsDay #InsanOnuru"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #uluslararasi-gocmenler-gunu"', '2026-12-18', 12, 18, 'Farkındalık', ARRAY['#GocmenlerGunu','#InternationalMigrantsDay','#InsanOnuru','#Goc'], ARRAY['kültürlerarası sosyoloji kitapları','dünya dilleri sözlükleri']),
('f8b9a112-9844-48f8-b3f1-000000000039', 'yilbasi', '1 Ocak Yılbaşı', 'Yeni bir yılın başlangıcını simgeleyen ve tüm dünyada umutla kutlanan resmi tatil günü.', '## 1 Ocak Yılbaşı Nedir?
Yılbaşı, Miladi takvime göre bir yılın bitip yeni bir yılın başladığı 1 Ocak günüdür. Yeni umutlar, hedefler ve başlangıçlarla tüm dünyada resmi tatil olarak kutlanır.

### Tarihçesi ve Önemi
Yılbaşı, Miladi takvime göre bir yılın bitip yeni bir yılın başladığı 1 Ocak günüdür. Yeni umutlar, hedefler ve başlangıçlarla tüm dünyada resmi tatil olarak kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 1 Ocak Yılbaşı Nasıl Kutlanır?
1. Aileniz ve dostlarınızla yeni yıl hedeflerinizi paylaşın.
2. Sevdiklerinize anlamlı tebrik kartları ve hediyeler verin.
3. Yeni yılda kendinize sağlıklı alışkanlıklar edinin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Yeni yılın size ve sevdiklerinize sağlık, mutluluk ve başarı getirmesini dilerim! Mutlu Yıllar! 🎉✨"
* "1 Ocak Yılbaşı kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #Yilbasi #YeniYil #Hosgeldin2026"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #yilbasi"', '2026-01-01', 1, 1, 'Resmi', ARRAY['#Yilbasi','#YeniYil','#Hosgeldin2026','#MutluYillar'], ARRAY['yılbaşı hediyesi','yeni yıl ajandası','kutu kutlama oyunu','kar küresi']),
('f8b9a112-9844-48f8-b3f1-000000000040', 'dunya-braille-gunu', '4 Ocak Dünya Braille Günü', 'Görme engellilerin okuma yazmasını sağlayan kabartma Braille alfabesinin mucidi Louis Braille anısına kutlanır.', '## 4 Ocak Dünya Braille Günü Nedir?
Dünya Braille Günü, görme engelli bireylerin bağımsızlığı ve bilgiye erişimi için geliştirilen Braille alfabesinin önemini vurgulamak amacıyla her yıl Louis Braille''in doğum gününde kutlanır.

### Tarihçesi ve Önemi
Dünya Braille Günü, görme engelli bireylerin bağımsızlığı ve bilgiye erişimi için geliştirilen Braille alfabesinin önemini vurgulamak amacıyla her yıl Louis Braille''in doğum gününde kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 4 Ocak Dünya Braille Günü Nasıl Kutlanır?
1. Çevrenizdeki kamusal alanların ve web sitelerinin görme engelliler için erişilebilirliğini denetleyin.
2. Braille alfabesi hakkında bilgi edinin.
3. Görme engelliler kütüphanelerine gönüllü kitap okuma desteği verin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Erişilebilir bir dünya herkesin hakkıdır! 4 Ocak Dünya Braille Günü kutlu olsun. ⠃⠗⠁⠊⠇⠇⠑"
* "4 Ocak Dünya Braille Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #BrailleGunu #GormeEngelliler #Erisilebilirlik"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-braille-gunu"', '2026-01-04', 1, 4, 'Farkındalık', ARRAY['#BrailleGunu','#GormeEngelliler','#Erisilebilirlik','#Farkindalik'], ARRAY['braille alfabesi kabartma tablet','sesli kitap aboneliği','akıllı baston','kabartmalı saat']),
('f8b9a112-9844-48f8-b3f1-000000000041', 'calisan-gazeteciler-gunu', '10 Ocak Çalışan Gazeteciler Günü', 'Basın emekçilerinin haklarını güvence altına alan 212 sayılı yasanın kabul edildiği günün anısına kutlanır.', '## 10 Ocak Çalışan Gazeteciler Günü Nedir?
10 Ocak 1961''de yürürlüğe giren ve gazetecilerin çalışma haklarını iyileştiren kanunun ardından Türkiye''de Gazeteciler Günü olarak kutlanmaya başlanmıştır.

### Tarihçesi ve Önemi
10 Ocak 1961''de yürürlüğe giren ve gazetecilerin çalışma haklarını iyileştiren kanunun ardından Türkiye''de Gazeteciler Günü olarak kutlanmaya başlanmıştır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 10 Ocak Çalışan Gazeteciler Günü Nasıl Kutlanır?
1. Tarafsız ve cesur haber yapan basın mensuplarını tebrik edin.
2. Bağımsız gazetecilik platformlarına abonelikle destek olun.
3. Yerel basının önemini vurgulayan paylaşımlar yapın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Doğru ve tarafsız habercilik uğruna gece gündüz emek veren tüm gazetecilerin 10 Ocak Çalışan Gazeteciler Günü kutlu olsun! 📰📸"
* "10 Ocak Çalışan Gazeteciler Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #CalisanGazetecilerGunu #10Ocak #BasinEmekcileri"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #calisan-gazeteciler-gunu"', '2026-01-10', 1, 10, 'Mesleki', ARRAY['#CalisanGazetecilerGunu','#10Ocak','#BasinEmekcileri','#OzgurBasin'], ARRAY['ses kayıt cihazı profesyonel','gazeteci çantası','fotoğraf makinesi tripodu','not defteri deri']),
('f8b9a112-9844-48f8-b3f1-000000000042', 'dunya-sarilma-gunu', '21 Ocak Dünya Sarılma Günü', 'İnsanlar arasındaki sevgi bağını güçlendirmek ve sarılmanın iyileştirici gücünü hatırlatmak için kutlanır.', '## 21 Ocak Dünya Sarılma Günü Nedir?
1986 yılında Kevin Zaborney tarafından başlatılan bu özel gün, insanların birbirine duygusal destek vermesini ve sarılmanın yarattığı oksitosin hormonunun sağlığa faydalarını hatırlatır.

### Tarihçesi ve Önemi
1986 yılında Kevin Zaborney tarafından başlatılan bu özel gün, insanların birbirine duygusal destek vermesini ve sarılmanın yarattığı oksitosin hormonunun sağlığa faydalarını hatırlatır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 21 Ocak Dünya Sarılma Günü Nasıl Kutlanır?
1. Ailenize, dostlarınıza ve evcil hayvanlarınıza sımsıkı sarılın.
2. Uzaktaki sevdiklerinize sanal bir sarılma mesajı gönderin.
3. Çevrenize tebessüm ve pozitif enerji yayın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Bir sarılma bin ilaca bedeldir! Sevdiklerinize sarılmayı ihmal etmeyin, 21 Ocak Dünya Sarılma Günü kutlu olsun! 🤗❤️"
* "21 Ocak Dünya Sarılma Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaSarilmaGunu #SarilmakGuzeldir #HugDay"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-sarilma-gunu"', '2026-01-21', 1, 21, 'Eğlence', ARRAY['#DunyaSarilmaGunu','#SarilmakGuzeldir','#HugDay','#Sevgi'], ARRAY['yumuşak peluş oyuncak','ağırlaştırılmış battaniye','kupa bardak kalpli','sarılma yastığı']),
('f8b9a112-9844-48f8-b3f1-000000000043', 'uluslararasi-egitim-gunu', '24 Ocak Uluslararası Eğitim Günü', 'Barış ve kalkınma için eğitimin vazgeçilmez rolünü kutlamak amacıyla Birleşmiş Milletler tarafından kabul edilen gün.', '## 24 Ocak Uluslararası Eğitim Günü Nedir?
UNESCO ve BM Genel Kurulu tarafından ilan edilen gün, dünyadaki tüm çocukların eşit ve kaliteli eğitime erişim hakkını savunur.

### Tarihçesi ve Önemi
UNESCO ve BM Genel Kurulu tarafından ilan edilen gün, dünyadaki tüm çocukların eşit ve kaliteli eğitime erişim hakkını savunur. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 24 Ocak Uluslararası Eğitim Günü Nasıl Kutlanır?
1. İhtiyaç sahibi okullara ve öğrencilere kırtasiye/kitap bağışında bulunun.
2. Eğitimin fırsat eşitliği üzerindeki etkilerini tartışın.
3. Kendinize yeni bir öğrenme hedefi belirleyin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Eğitim dünyayı değiştirebilecek en güçlü silahtır. 24 Ocak Uluslararası Eğitim Günü kutlu olsun! 📚🎓"
* "24 Ocak Uluslararası Eğitim Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #EgitimGunu #EducationDay #NitelikliEgitim"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #uluslararasi-egitim-gunu"', '2026-01-24', 1, 24, 'Farkındalık', ARRAY['#EgitimGunu','#EducationDay','#NitelikliEgitim','#Gelecek'], ARRAY['eğitici tablet çocuk','dünya atlası','online eğitim kursu','çalışma masası lambası']),
('f8b9a112-9844-48f8-b3f1-000000000044', 'veri-koruma-gunu', '28 Ocak Veri Koruma Günü', 'Dijital çağda kişisel verilerin gizliliği ve siber güvenlik bilincini artırmak amacıyla kutlanan küresel gün.', '## 28 Ocak Veri Koruma Günü Nedir?
Avrupa Konseyi''nin 108 sayılı Veri Koruma Sözleşmesi''nin imzalandığı günün anısına dijital hakları savunmak için kutlanır.

### Tarihçesi ve Önemi
Avrupa Konseyi''nin 108 sayılı Veri Koruma Sözleşmesi''nin imzalandığı günün anısına dijital hakları savunmak için kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 28 Ocak Veri Koruma Günü Nasıl Kutlanır?
1. Hesap şifrelerinizi iki aşamalı doğrulama (2FA) ile güçlendirin.
2. İnternette paylaştığınız kişisel verileri gözden geçirin.
3. Sosyal medya gizlilik ayarlarınızı kontrol edin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Verileriniz sizin dijital kimliğinizdir, koruyun! 28 Ocak Veri Koruma Günü kutlu olsun. 🔒💻"
* "28 Ocak Veri Koruma Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #VeriKorumaGunu #KVKK #SiberGuvenlik"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #veri-koruma-gunu"', '2026-01-28', 1, 28, 'Farkındalık', ARRAY['#VeriKorumaGunu','#KVKK','#SiberGuvenlik','#DataPrivacy'], ARRAY['şifreli flash bellek','donanım cüzdanı','webcam gizlilik kapağı','vpn aboneliği']),
('f8b9a112-9844-48f8-b3f1-000000000045', 'dunya-kanser-gunu', '4 Şubat Dünya Kanser Günü', 'Kanser konusunda küresel farkındalık oluşturmak, erken teşhisin hayat kurtardığını hatırlatmak için düzenlenir.', '## 4 Şubat Dünya Kanser Günü Nedir?
Uluslararası Kanser Kontrol Örgütü (UICC) öncülüğünde her yıl düzenlenen küresel bir farkındalık günüdür. Kanser türlerinin erken teşhisle tedavi edilebilirliğine odaklanır.

### Tarihçesi ve Önemi
Uluslararası Kanser Kontrol Örgütü (UICC) öncülüğünde her yıl düzenlenen küresel bir farkındalık günüdür. Kanser türlerinin erken teşhisle tedavi edilebilirliğine odaklanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 4 Şubat Dünya Kanser Günü Nasıl Kutlanır?
1. Düzenli sağlık taramalarınızı ve kontrollerinizi yaptırın.
2. Sağlıklı beslenme ve hareketli yaşam tarzını benimseyin.
3. Kanserle mücadele eden vakıf ve derneklere destek olun.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Korkma, farkında ol! Erken teşhis hayat kurtarır. 4 Şubat Dünya Kanser Günü''nde sağlığımıza sahip çıkalım. 🎗️💪"
* "4 Şubat Dünya Kanser Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaKanserGunu #ErkenTeshisHayatKurtarir #KanserleMucadele"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kanser-gunu"', '2026-02-04', 2, 4, 'Sağlık', ARRAY['#DunyaKanserGunu','#ErkenTeshisHayatKurtarir','#KanserleMucadele','#Saglik'], ARRAY['sağlıklı beslenme kitabı','antioksidan yeşil çay','spor matı','su matarası']),
('f8b9a112-9844-48f8-b3f1-000000000046', 'sigarayi-birakma-gunu', '9 Şubat Dünya Sigarayı Bırakma Günü', 'Tütün bağımlılığının zararlarına dikkat çekmek ve dumansız hava sahasını desteklemek amacıyla kutlanır.', '## 9 Şubat Dünya Sigarayı Bırakma Günü Nedir?
Dünya Sağlık Örgütü tarafından tütün kullanımının azaltılması ve sigarasız bir yaşama teşvik etmek için ilan edilen gündür.

### Tarihçesi ve Önemi
Dünya Sağlık Örgütü tarafından tütün kullanımının azaltılması ve sigarasız bir yaşama teşvik etmek için ilan edilen gündür. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 9 Şubat Dünya Sigarayı Bırakma Günü Nasıl Kutlanır?
1. Bugün sigarayı bırakmak için kesin bir karar alın ve tarih belirleyin.
2. Sigara bırakma polikliniklerinden profesyonel destek alın.
3. Sevdiklerinizi bırakmaları konusunda motive edin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Ciğerlerine ve geleceğine bir şans ver! 9 Şubat Dünya Sigarayı Bırakma Günü''nde temiz bir nefes al. 🚭🫁"
* "9 Şubat Dünya Sigarayı Bırakma Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #SigarayiBirakmaGunu #DumansizHavaSahasi #SigarayiBirak"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #sigarayi-birakma-gunu"', '2026-02-09', 2, 9, 'Sağlık', ARRAY['#SigarayiBirakmaGunu','#DumansizHavaSahasi','#SigarayiBirak','#SaglikliYasam'], ARRAY['nikotin sakızı','stres çarkı topu','koşu ayakkabısı','hava temizleyici cihaz']),
('f8b9a112-9844-48f8-b3f1-000000000047', 'bilimde-kadinlar-gunu', '11 Şubat Bilimde Kadınlar ve Kız Çocukları Günü', 'Bilim ve teknoloji alanında kadınların ve kız çocuklarının tam ve eşit erişimini teşvik eden BM günü.', '## 11 Şubat Bilimde Kadınlar ve Kız Çocukları Günü Nedir?
UNESCO ve UN Women ortaklığında kadınların STEM (bilim, teknoloji, mühendislik, matematik) alanlarındaki rolünü güçlendirmek için kutlanır.

### Tarihçesi ve Önemi
UNESCO ve UN Women ortaklığında kadınların STEM (bilim, teknoloji, mühendislik, matematik) alanlarındaki rolünü güçlendirmek için kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 11 Şubat Bilimde Kadınlar ve Kız Çocukları Günü Nasıl Kutlanır?
1. Başarılı kadın bilim insanlarının ilham verici hayatlarını çocuklara anlatın.
2. Kız çocuklarını bilimsel projelere teşvik edin.
3. Bilimde cinsiyet eşitliğini destekleyin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Bilimin cinsiyeti yoktur! Geleceği aydınlatan tüm kadın bilim insanlarının günü kutlu olsun! 🔬👩‍🔬"
* "11 Şubat Bilimde Kadınlar ve Kız Çocukları Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #BilimdeKadinlar #WomenInScience #KizCocuklari"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #bilimde-kadinlar-gunu"', '2026-02-11', 2, 11, 'Farkındalık', ARRAY['#BilimdeKadinlar','#WomenInScience','#KizCocuklari','#STEM'], ARRAY['mikroskop seti bilimsel','marie curie kitabı','robotik kodlama kiti','teleskop başlangıç']),
('f8b9a112-9844-48f8-b3f1-000000000048', 'sevgililer-gunu', '14 Şubat Sevgililer Günü', 'Tüm dünyada sevgi ve aşkın paylaşıldığı, Aziz Valentin''in anısına ithaf edilen romantik kutlama günü.', '## 14 Şubat Sevgililer Günü Nedir?
Kökeni Roma dönemine ve Aziz Valentine efsanesine dayanan 14 Şubat Sevgililer Günü, sevginin jestlerle ifade edildiği evrensel gündür.

### Tarihçesi ve Önemi
Kökeni Roma dönemine ve Aziz Valentine efsanesine dayanan 14 Şubat Sevgililer Günü, sevginin jestlerle ifade edildiği evrensel gündür. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 14 Şubat Sevgililer Günü Nasıl Kutlanır?
1. Sevdiğinize duygularınızı samimiyetle anlatan bir mektup yazın.
2. Baş başa romantik bir akşam yemeği planlayın.
3. Birlikte unutulmaz bir anı albümü oluşturun.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Seninle geçen her gün bir bayram! 14 Şubat Sevgililer Günümüz kutlu olsun sevgilim. ❤️🌹"
* "14 Şubat Sevgililer Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #14Subat #SevgililerGunu #ValentinesDay"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #sevgililer-gunu"', '2026-02-14', 2, 14, 'Eğlence', ARRAY['#14Subat','#SevgililerGunu','#ValentinesDay','#Ask','#Hediye'], ARRAY['sevgililer günü hediye kutusu','gümüş kolye','çikolata kutusu lüks','akıllı saat unisex']),
('f8b9a112-9844-48f8-b3f1-000000000049', 'dunya-kediler-gunu', '17 Şubat Dünya Kediler Günü', 'Miyavlayan sevimli dostlarımızın yaşam haklarını ve sokak kedilerinin refahını hatırlatan özel gün.', '## 17 Şubat Dünya Kediler Günü Nedir?
İlk kez İtalya''da başlayan ve Avrupa genelinde kabul gören 17 Şubat Kediler Günü, kedilerin bağımsız doğasına ve sokaktaki canlara saygıyı kutlar.

### Tarihçesi ve Önemi
İlk kez İtalya''da başlayan ve Avrupa genelinde kabul gören 17 Şubat Kediler Günü, kedilerin bağımsız doğasına ve sokaktaki canlara saygıyı kutlar. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 17 Şubat Dünya Kediler Günü Nasıl Kutlanır?
1. Mahallenizdeki sokak kedilerine bir kap mama ve taze su bırakın.
2. Evinizdeki kedinize ekstra sevgi ve oyun zamanı ayırın.
3. Barınaktaki bir kediyi sahiplenmeyi değerlendirin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Pati izleri kalbimizde! Dünyayı güzelleştiren tüm minik dostlarımızın 17 Şubat Dünya Kediler Günü kutlu olsun! 🐾🐱"
* "17 Şubat Dünya Kediler Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaKedilerGunu #CatDay #KediSeverler"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kediler-gunu"', '2026-02-17', 2, 17, 'Çevre & Doğa', ARRAY['#DunyaKedilerGunu','#CatDay','#KediSeverler','#SatinAlmaSahiplen'], ARRAY['kedi tırmalama tahtası','kedi ödül maması','otomatik kedi su pınarı','kedi taşıma çantası']),
('f8b9a112-9844-48f8-b3f1-000000000050', 'dunya-sosyal-adalet-gunu', '20 Şubat Dünya Sosyal Adalet Günü', 'Yoksulluk, dışlanma, işsizlik ve eşitsizlikle mücadele ederek adil bir toplum inşasını savunan BM günü.', '## 20 Şubat Dünya Sosyal Adalet Günü Nedir?
Birleşmiş Milletler tarafından ilan edilen gün, tüm insanların onurlu çalışma, sosyal koruma ve adalet içinde yaşaması gerektiğini hatırlatır.

### Tarihçesi ve Önemi
Birleşmiş Milletler tarafından ilan edilen gün, tüm insanların onurlu çalışma, sosyal koruma ve adalet içinde yaşaması gerektiğini hatırlatır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 20 Şubat Dünya Sosyal Adalet Günü Nasıl Kutlanır?
1. Toplumdaki dezavantajlı grupların haklarını destekleyin.
2. Adil ücret ve eşit işe eşit ücret ilkelerini savunun.
3. Dayanışma ağlarına katılın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Barış ancak adaletle mümkündür. 20 Şubat Dünya Sosyal Adalet Günü kutlu olsun! ⚖️🤝"
* "20 Şubat Dünya Sosyal Adalet Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #SosyalAdaletGunu #Esitlik #Adalet"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-sosyal-adalet-gunu"', '2026-02-20', 2, 20, 'Farkındalık', ARRAY['#SosyalAdaletGunu','#Esitlik','#Adalet','#SocialJustice'], ARRAY['insan hakları kitapları','sosyoloji temel eserler','felsefe klasikleri seti']),
('f8b9a112-9844-48f8-b3f1-000000000051', 'dunya-anadili-gunu', '21 Şubat Uluslararası Anadili Günü', 'Dünyadaki tüm dillerin kültürel çeşitliliğini korumak ve çok dilliliği teşvik etmek için UNESCO tarafından kutlanır.', '## 21 Şubat Uluslararası Anadili Günü Nedir?
1952 yılında Bangladeş''te anadili hakkını savunan öğrencilerin anısına UNESCO tarafından 1999''da kabul edilmiş küresel bir gündür.

### Tarihçesi ve Önemi
1952 yılında Bangladeş''te anadili hakkını savunan öğrencilerin anısına UNESCO tarafından 1999''da kabul edilmiş küresel bir gündür. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 21 Şubat Uluslararası Anadili Günü Nasıl Kutlanır?
1. Anadilinizdeki zengin deyimleri, atasözlerini ve edebiyatı keşfedin.
2. Farklı kültürlerin dillerine saygı gösterin.
3. Kaybolma tehlikesindeki yerel diller hakkında bilgi edinin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Dil, bir milletin hafızasıdır. 21 Şubat Uluslararası Anadili Günü kutlu olsun! 🗣️📖"
* "21 Şubat Uluslararası Anadili Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #AnadiliGunu #MotherLanguageDay #KulturelCesitlilik"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-anadili-gunu"', '2026-02-21', 2, 21, 'Kültür & Sanat', ARRAY['#AnadiliGunu','#MotherLanguageDay','#KulturelCesitlilik','#Dilimiz'], ARRAY['türkçe sözlük tdk','dünya edebiyatı klasikleri','etimoloji sözlüğü']),
('f8b9a112-9844-48f8-b3f1-000000000052', 'yesilay-haftasi', '1 Mart Yeşilay Haftası', 'Alkol, uyuşturucu, tütün ve teknoloji bağımlılığıyla mücadeleyi destekleyen ulusal farkındalık haftası.', '## 1 Mart Yeşilay Haftası Nedir?
1920 yılında kurulan Hilal-i Ahdar (Yeşilay) Cemiyeti''nin öncülüğünde bağımlılıklarla mücadele etmek amacıyla her yıl Mart ayının ilk haftasında kutlanır.

### Tarihçesi ve Önemi
1920 yılında kurulan Hilal-i Ahdar (Yeşilay) Cemiyeti''nin öncülüğünde bağımlılıklarla mücadele etmek amacıyla her yıl Mart ayının ilk haftasında kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 1 Mart Yeşilay Haftası Nasıl Kutlanır?
1. Yeşilay''ın bağımlılıkla mücadele seminerlerine katılın.
2. Dijital detoks yaparak ekran sürenizi azaltın.
3. Çocuklara zararlı alışkanlıklardan uzak durmayı öğretin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Bağımlılıklardan uzak, sağlıklı ve özgür bir yaşam için Yeşilay Haftası kutlu olsun! 🟢🌿"
* "1 Mart Yeşilay Haftası kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #YesilayHaftasi #BagimsizYasa #Yesilay"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #yesilay-haftasi"', '2026-03-01', 3, 1, 'Sağlık', ARRAY['#YesilayHaftasi','#BagimsizYasa','#Yesilay','#Saglik'], ARRAY['akıllı bileklik adımsayar','spor matı yoga','sağlıklı yaşam rehberi kitabı']),
('f8b9a112-9844-48f8-b3f1-000000000053', 'dunya-yaban-hayati-gunu', '3 Mart Dünya Yaban Hayatı Günü', 'Nesli tükenmekte olan yabani hayvan ve bitki türlerini koruma bilincini artırmak amacıyla kutlanır.', '## 3 Mart Dünya Yaban Hayatı Günü Nedir?
CITES sözleşmesinin imzalandığı gün olan 3 Mart, vahşi yaşamın korunması ve kaçak avcılıkla mücadele için BM tarafından kabul edilmiştir.

### Tarihçesi ve Önemi
CITES sözleşmesinin imzalandığı gün olan 3 Mart, vahşi yaşamın korunması ve kaçak avcılıkla mücadele için BM tarafından kabul edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 3 Mart Dünya Yaban Hayatı Günü Nasıl Kutlanır?
1. Yaban hayatı koruma projelerine destek verin.
2. Doğal yaşam alanlarını kirletmeyin ve koruyun.
3. Egzotik hayvan ticaretine karşı bilinçli olun.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Doğa canlılarıyla güzeldir! 3 Mart Dünya Yaban Hayatı Günü''nde tüm türlerin yaşam hakkını koruyalım. 🦁🌿🦉"
* "3 Mart Dünya Yaban Hayatı Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #YabanHayatiGunu #WorldWildlifeDay #DogaDostu"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-yaban-hayati-gunu"', '2026-03-03', 3, 3, 'Çevre & Doğa', ARRAY['#YabanHayatiGunu','#WorldWildlifeDay','#DogaDostu','#BiyoCesitlilik'], ARRAY['dürbün doğa gözlem','doğa belgeselleri seti','kamp çadırı','kuş rehberi kitabı']),
('f8b9a112-9844-48f8-b3f1-000000000054', 'dunya-kadinlar-gunu', '8 Mart Dünya Kadınlar Günü', 'Kadınların sosyal, ekonomik, kültürel ve siyasi başarılarını kutlayan ve cinsiyet eşitliğini savunan küresel gün.', '## 8 Mart Dünya Kadınlar Günü Nedir?
1857''de New York''ta hak mücadelesi başlatan kadın işçilerin anısına Birleşmiş Milletler tarafından kabul edilen küresel gündür.

### Tarihçesi ve Önemi
1857''de New York''ta hak mücadelesi başlatan kadın işçilerin anısına Birleşmiş Milletler tarafından kabul edilen küresel gündür. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 8 Mart Dünya Kadınlar Günü Nasıl Kutlanır?
1. Kadın girişimcileri ve kadın kooperatiflerini destekleyin.
2. Çevrenizdeki kadınlara saygı ve sevginizi gösterin.
3. Eşit haklar için farkındalık yaratın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Dünyayı güzelleştiren, emekleriyle hayat veren tüm güçlü kadınların 8 Mart Dünya Kadınlar Günü kutlu olsun! 🌸💪"
* "8 Mart Dünya Kadınlar Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #8Mart #DunyaKadinlarGunu #GucluKadinlar"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kadinlar-gunu"', '2026-03-08', 3, 8, 'Uluslararası', ARRAY['#8Mart','#DunyaKadinlarGunu','#GucluKadinlar','#KadinHaklari'], ARRAY['kadın parfümü','özel hediye seti','orkide saksı çiçeği','tasarım takı kolye']),
('f8b9a112-9844-48f8-b3f1-000000000055', 'istiklal-marsinin-kabulu', '12 Mart İstiklal Marşı''nın Kabulü', 'Mehmet Akif Ersoy''un kaleme aldığı milli marşımızın TBMM tarafından kabul edilişinin anma günü.', '## 12 Mart İstiklal Marşı''nın Kabulü Nedir?
12 Mart 1921''de Türkiye Büyük Millet Meclisi tarafından kabul edilen İstiklal Marşı, milletimizin bağımsızlık azminin ebedi simgesidir.

### Tarihçesi ve Önemi
12 Mart 1921''de Türkiye Büyük Millet Meclisi tarafından kabul edilen İstiklal Marşı, milletimizin bağımsızlık azminin ebedi simgesidir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 12 Mart İstiklal Marşı''nın Kabulü Nasıl Kutlanır?
1. İstiklal Marşı''nın 10 kıtasını dikkatle okuyun ve anlamını düşünün.
2. Mehmet Akif Ersoy''un Safahat eserini inceleyin.
3. Okullarda düzenlenen anma programlarına katılın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Allah bu millete bir daha İstiklal Marşı yazdırmasın! 12 Mart İstiklal Marşı''nın kabulü kutlu olsun. 🇹🇷📜"
* "12 Mart İstiklal Marşı''nın Kabulü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #12Mart #IstiklalMarsi #MehmetAkifErsoy"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #istiklal-marsinin-kabulu"', '2026-03-12', 3, 12, 'Resmi', ARRAY['#12Mart','#IstiklalMarsi','#MehmetAkifErsoy','#Korkma'], ARRAY['safahat özel baskı','mehmet akif ersoy biyografisi','türk bayrağı çerçeveli']),
('f8b9a112-9844-48f8-b3f1-000000000056', 'tip-bayrami', '14 Mart Tıp Bayramı', 'Türkiye''de modern tıp eğitiminin başladığı günün anısına tüm sağlık çalışanlarını onurlandıran gün.', '## 14 Mart Tıp Bayramı Nedir?
14 Mart 1827''de Tıphane-i Amire''nin kuruluşu ve 1919''da tıp öğrencilerinin işgale karşı direnişi anısına Tıp Bayramı olarak kutlanır.

### Tarihçesi ve Önemi
14 Mart 1827''de Tıphane-i Amire''nin kuruluşu ve 1919''da tıp öğrencilerinin işgale karşı direnişi anısına Tıp Bayramı olarak kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 14 Mart Tıp Bayramı Nasıl Kutlanır?
1. Doktorlarınıza ve sağlık personeline teşekkür mesajı iletin.
2. Sağlıkta şiddete karşı farkındalık oluşturun.
3. Sağlık taramalarınızı ihmal etmeyin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Hayatımızı emanet ettiğimiz fedakar hekimlerimizin ve tüm sağlık çalışanlarımızın 14 Mart Tıp Bayramı kutlu olsun! 🩺🤍"
* "14 Mart Tıp Bayramı kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #TipBayrami #14Mart #DoktorlarimizaTesekkurler"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #tip-bayrami"', '2026-03-14', 3, 14, 'Sağlık', ARRAY['#TipBayrami','#14Mart','#DoktorlarimizaTesekkurler','#SaglikEmekcileri'], ARRAY['kişiye özel steteskop','doktor önlüğü kaliteli','medikal hediye kupa','termos doktor']),
('f8b9a112-9844-48f8-b3f1-000000000057', 'pi-gunu', '14 Mart Dünya Pi Günü', 'Matematiksel sabit olan Pi sayısının (3,14) onuruna dünya çapında matematikseverlerin kutladığı gün.', '## 14 Mart Dünya Pi Günü Nedir?
Pi sayısı 3.14 olduğu için Mart ayının 14. günü (3/14) Pi Günü olarak kutlanır. Aynı zamanda Albert Einstein''ın doğum günüdür.

### Tarihçesi ve Önemi
Pi sayısı 3.14 olduğu için Mart ayının 14. günü (3/14) Pi Günü olarak kutlanır. Aynı zamanda Albert Einstein''ın doğum günüdür. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 14 Mart Dünya Pi Günü Nasıl Kutlanır?
1. Pi desenli pasta ve turtalar pişirin.
2. Pi sayısının basamaklarını ezberleme yarışması yapın.
3. Matematik belgeselleri izleyin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Sonsuzluğa uzanan sayının günü kutlu olsun! 3,14... Dünya Pi Günü kutlu olsun! 🥧📐"
* "14 Mart Dünya Pi Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #PiGunu #PiDay #Matematik"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #pi-gunu"', '2026-03-14', 3, 14, 'Eğlence', ARRAY['#PiGunu','#PiDay','#Matematik','#Einstein','#314'], ARRAY['bilimsel hesap makinesi','pi sayısı tişörtü','matematik bulmaca kitapları','rubik küp']),
('f8b9a112-9844-48f8-b3f1-000000000058', 'canakkale-zaferi', '18 Mart Çanakkale Zaferi ve Şehitleri Anma Günü', '1915 Çanakkale Deniz Zaferi''nin ve vatanı uğruna can veren aziz şehitlerimizin anıldığı milli gün.', '## 18 Mart Çanakkale Zaferi ve Şehitleri Anma Günü Nedir?
18 Mart 1915''te Türk ordusunun Çanakkale Boğazı''nda yazdığı destansı zaferin ve ''Çanakkale Geçilmez'' sözünün tarihe kazındığı gündür.

### Tarihçesi ve Önemi
18 Mart 1915''te Türk ordusunun Çanakkale Boğazı''nda yazdığı destansı zaferin ve ''Çanakkale Geçilmez'' sözünün tarihe kazındığı gündür. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 18 Mart Çanakkale Zaferi ve Şehitleri Anma Günü Nasıl Kutlanır?
1. Çanakkale şehitliklerini ziyaret edin veya anma törenlerine katılın.
2. Şehitlerimizin ruhuna dualar okuyun.
3. Genç nesillere zaferin tarihsel önemini aktarın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Çanakkale Geçilmez! Gazi Mustafa Kemal Atatürk ve tüm Çanakkale kahramanlarımızı rahmet ve minnetle anıyoruz. 🇹🇷🎖️"
* "18 Mart Çanakkale Zaferi ve Şehitleri Anma Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #18Mart #CanakkaleGecilmez #CanakkaleZaferi"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #canakkale-zaferi"', '2026-03-18', 3, 18, 'Resmi', ARRAY['#18Mart','#CanakkaleGecilmez','#CanakkaleZaferi','#SehitlerimiziAniyoruz'], ARRAY['çanakkale tarihi kitabı','mustafa kemal atatürk tablosu','türk bayrağı masa üstü']),
('f8b9a112-9844-48f8-b3f1-000000000059', 'dunya-mutluluk-gunu', '20 Mart Dünya Mutluluk Günü', 'Mutluluğun temel bir insan hakkı olduğunu hatırlatmak için Birleşmiş Milletler tarafından kabul edilen gün.', '## 20 Mart Dünya Mutluluk Günü Nedir?
BM Genel Kurulu tarafından 2012 yılında ilan edilen gün, ekonomik büyümenin yanında insan mutluluğunun da ölçülmesi gerektiğini savunur.

### Tarihçesi ve Önemi
BM Genel Kurulu tarafından 2012 yılında ilan edilen gün, ekonomik büyümenin yanında insan mutluluğunun da ölçülmesi gerektiğini savunur. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 20 Mart Dünya Mutluluk Günü Nasıl Kutlanır?
1. Bugün en az bir kişiyi nedensizce gülümsetin.
2. Kendinize sevdiğiniz bir kahve veya tatlı ısmarlayın.
3. Hayatınızdaki güzel anlara odaklanın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Mutluluk paylaştıkça çoğalır! 20 Mart Dünya Mutluluk Günü''nde yüzünüzden tebessüm eksik olmasın. 😊💛"
* "20 Mart Dünya Mutluluk Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaMutlulukGunu #Mutluluk #Gulumse"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-mutluluk-gunu"', '2026-03-20', 3, 20, 'Eğlence', ARRAY['#DunyaMutlulukGunu','#Mutluluk','#Gulumse','#HappinessDay'], ARRAY['pozitif psikoloji kitapları','aroma terapi uçucu yağ','günlük şükür defteri','renkli fincan']),
('f8b9a112-9844-48f8-b3f1-000000000060', 'dunya-ormancilik-gunu', '21 Mart Dünya Ormancılık Günü ve Nevruz', 'Baharın gelişi, doğanın uyanışı ve orman varlığının korunması amacıyla kutlanan köklü bayram.', '## 21 Mart Dünya Ormancılık Günü ve Nevruz Nedir?
21 Mart hem ilkbahar ekinoksunu simgeleyen Nevruz Bayramı hem de FAO tarafından ilan edilen Dünya Ormancılık Günü''dür.

### Tarihçesi ve Önemi
21 Mart hem ilkbahar ekinoksunu simgeleyen Nevruz Bayramı hem de FAO tarafından ilan edilen Dünya Ormancılık Günü''dür. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 21 Mart Dünya Ormancılık Günü ve Nevruz Nasıl Kutlanır?
1. Doğaya bir fidan dikin veya TEMA''ya fidan bağışlayın.
2. Doğa yürüyüşü (trekking) yaparak orman havası alın.
3. Nevruz ateşi ve bahar etkinliklerine katılın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Doğa yeşeriyor, umutlar yeşeriyor! 21 Mart Dünya Ormancılık Günü ve Nevruz Bayramımız kutlu olsun! 🌱🌸🔥"
* "21 Mart Dünya Ormancılık Günü ve Nevruz kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #OrmancilikGunu #NevruzBayrami #BaharGeldi"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-ormancilik-gunu"', '2026-03-21', 3, 21, 'Çevre & Doğa', ARRAY['#OrmancilikGunu','#NevruzBayrami','#BaharGeldi','#FidanDik'], ARRAY['fidan bağışı sertifikası','bahçe bakım seti','budama makası','saksı tohum seti']),
('f8b9a112-9844-48f8-b3f1-000000000061', 'dunya-down-sendromu-gunu', '21 Mart Dünya Down Sendromu Farkındalık Günü', '+1 farkla dünyayı güzelleştiren bireylerin farkındalığını artırmak amacıyla kutlanan gün.', '## 21 Mart Dünya Down Sendromu Farkındalık Günü Nedir?
21. kromozomun 3 tane olmasından (trizomi 21) esinlenilerek 3. ayın 21. günü Dünya Down Sendromu Günü ilan edilmiştir.

### Tarihçesi ve Önemi
21. kromozomun 3 tane olmasından (trizomi 21) esinlenilerek 3. ayın 21. günü Dünya Down Sendromu Günü ilan edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 21 Mart Dünya Down Sendromu Farkındalık Günü Nasıl Kutlanır?
1. Farkındalık için rengarenk farklı çoraplar giyerek sosyal medyada paylaşın.
2. Down sendromlu bireylerin iş hayatına ve topluma katılımını destekleyin.
3. Sevgi dolu kalplerine ortak olun.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Down sendromu bir hastalık değil, genetik bir farklılıktır. +1 farkla yanınızdayız! 🧦💙💛"
* "21 Mart Dünya Down Sendromu Farkındalık Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #21Mart #DownSendromu #ArtiBirFarkla"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-down-sendromu-gunu"', '2026-03-21', 3, 21, 'Farkındalık', ARRAY['#21Mart','#DownSendromu','#ArtiBirFarkla','#GercekDostlar'], ARRAY['farklı çoraplar renkli set','özel eğitim materyali','duyusal oyun seti']),
('f8b9a112-9844-48f8-b3f1-000000000062', 'dunya-su-gunu', '22 Mart Dünya Su Günü', 'Temiz su kaynaklarının korunması ve su kıtlığı tehlikesine dikkat çekmek için BM öncülüğünde kutlanır.', '## 22 Mart Dünya Su Günü Nedir?
1993 yılında Birleşmiş Milletler tarafından kabul edilen gün, tatlı su kaynaklarının önemine ve su tasarrufuna dikkat çeker.

### Tarihçesi ve Önemi
1993 yılında Birleşmiş Milletler tarafından kabul edilen gün, tatlı su kaynaklarının önemine ve su tasarrufuna dikkat çeker. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 22 Mart Dünya Su Günü Nasıl Kutlanır?
1. Diş fırçalarken ve bulaşık yıkarken musluğu açık bırakmayın.
2. Su tasarruflu başlıklar kullanın.
3. Su ayak izinizi azaltacak adımlar atın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Su hayattır, boşa akıtma! 22 Mart Dünya Su Günü''nde her damlanın değerini bilelim. 💧🌊"
* "22 Mart Dünya Su Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaSuGunu #WorldWaterDay #SuyuKoru"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-su-gunu"', '2026-03-22', 3, 22, 'Çevre & Doğa', ARRAY['#DunyaSuGunu','#WorldWaterDay','#SuyuKoru','#GeleceginiKoru'], ARRAY['su arıtma cihazı filtre','tasarruflu duş başlığı','çelik su matarası','musluk perlatörü']),
('f8b9a112-9844-48f8-b3f1-000000000063', 'dunya-tiyatro-gunu', '27 Mart Dünya Tiyatro Günü', 'Tiyatro sanatının toplumları aydınlatıcı ve birleştirici gücünü kutlamak için 1961''den beri kutlanan sanat günü.', '## 27 Mart Dünya Tiyatro Günü Nedir?
Uluslararası Tiyatro Enstitüsü tarafından başlatılan bu özel günde dünya çapında tiyatro bildirileri yayımlanır ve oyunlar sergilenir.

### Tarihçesi ve Önemi
Uluslararası Tiyatro Enstitüsü tarafından başlatılan bu özel günde dünya çapında tiyatro bildirileri yayımlanır ve oyunlar sergilenir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 27 Mart Dünya Tiyatro Günü Nasıl Kutlanır?
1. Sevdiğiniz bir tiyatro oyununa bilet alıp izleyin.
2. Yerel ve bağımsız tiyatro topluluklarına destek olun.
3. Çocukları tiyatro ile tanıştırın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Perdeler hiç kapanmasın! 27 Mart Dünya Tiyatro Günü kutlu olsun. 🎭🎟️"
* "27 Mart Dünya Tiyatro Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaTiyatroGunu #Tiyatro #SahneSanatlari"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-tiyatro-gunu"', '2026-03-27', 3, 27, 'Kültür & Sanat', ARRAY['#DunyaTiyatroGunu','#Tiyatro','#SahneSanatlari','#27Mart'], ARRAY['tiyatro oyun metinleri','shakespeare toplu eserleri','dürbün tiyatro tipi','sanat tarihi kitabı']),
('f8b9a112-9844-48f8-b3f1-000000000064', 'dunya-otizm-farkindalik-gunu', '2 Nisan Dünya Otizm Farkındalık Günü', 'Otizm spektrumundaki bireylerin yaşam kalitesini artırmak ve erken teşhis bilincini yaymak için kutlanır.', '## 2 Nisan Dünya Otizm Farkındalık Günü Nedir?
Birleşmiş Milletler tarafından 2007 yılında ilan edilen bu günde dünya çapında anıtlar ''Mavi Işık Yak'' kampanyasıyla aydınlatılır.

### Tarihçesi ve Önemi
Birleşmiş Milletler tarafından 2007 yılında ilan edilen bu günde dünya çapında anıtlar ''Mavi Işık Yak'' kampanyasıyla aydınlatılır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 2 Nisan Dünya Otizm Farkındalık Günü Nasıl Kutlanır?
1. Mavi kıyafet giyerek veya mavi ışık yakarak farkındalığa katılın.
2. Otizmli bireylerin eğitimi için faaliyet gösteren STK''lara destek olun.
3. Toplumda hoşgörü ve kabul dilini güçlendirin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Farklıyız, eşitiz, birlikte güçlüyüz! 2 Nisan Dünya Otizm Farkındalık Günü''nde mavi ışık yakıyoruz. 💙🧩"
* "2 Nisan Dünya Otizm Farkındalık Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #OtizmFarkindalikGunu #MaviIsikYak #OtizminFarkindayim"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-otizm-farkindalik-gunu"', '2026-04-02', 4, 2, 'Sağlık', ARRAY['#OtizmFarkindalikGunu','#MaviIsikYak','#OtizminFarkindayim','#2Nisan'], ARRAY['mavi tişört','duyusal oda ışığı','otizm eğitim kartları','stres çarkı']),
('f8b9a112-9844-48f8-b3f1-000000000065', 'avukatlar-gunu', '5 Nisan Avukatlar Günü', 'Hak arama özgürlüğünün ve adaletin teminatı olan savunma makamı temsilcilerini onurlandıran gün.', '## 5 Nisan Avukatlar Günü Nedir?
1958 yılında İzmir''de yapılan Türkiye Barolar Birliği toplantısında 5 Nisan tarihi Avukatlar Günü olarak kabul edilmiştir.

### Tarihçesi ve Önemi
1958 yılında İzmir''de yapılan Türkiye Barolar Birliği toplantısında 5 Nisan tarihi Avukatlar Günü olarak kabul edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 5 Nisan Avukatlar Günü Nasıl Kutlanır?
1. Avukat dostlarınıza tebrik mesajı gönderin.
2. Hukukun üstünlüğü ve adil yargılanma hakkına dikkat çekin.
3. Hak arama bilincini geliştirin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Hukukun üstünlüğü ve adaletin savunucusu tüm avukatlarımızın 5 Nisan Avukatlar Günü kutlu olsun! ⚖️📜"
* "5 Nisan Avukatlar Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #5Nisan #AvukatlarGunu #SavunmaHakki"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #avukatlar-gunu"', '2026-04-05', 4, 5, 'Mesleki', ARRAY['#5Nisan','#AvukatlarGunu','#SavunmaHakki','#Adalet'], ARRAY['avukat hediye seti cübbe biblo','adalet heykeli themis','dolma kalem lüks','deri evrak çantası']),
('f8b9a112-9844-48f8-b3f1-000000000066', 'dunya-saglik-gunu', '7 Nisan Dünya Sağlık Günü', 'Dünya Sağlık Örgütü''nün kuruluş yıl dönümünde herkes için erişilebilir sağlık hizmetlerini savunan gün.', '## 7 Nisan Dünya Sağlık Günü Nedir?
1948 yılında Dünya Sağlık Örgütü''nün (WHO) anayasasının yürürlüğe girdiği tarih olup her yıl belirlenen temalarla kutlanır.

### Tarihçesi ve Önemi
1948 yılında Dünya Sağlık Örgütü''nün (WHO) anayasasının yürürlüğe girdiği tarih olup her yıl belirlenen temalarla kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 7 Nisan Dünya Sağlık Günü Nasıl Kutlanır?
1. Sağlık kontrollerinizi aksatmayın.
2. Düzenli yürüyüş ve egzersiz yapmayı alışkanlık haline getirin.
3. Sağlıklı beslenme düzenine geçin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Sağlık en büyük zenginliktir. 7 Nisan Dünya Sağlık Günü kutlu olsun! 🍎🩺"
* "7 Nisan Dünya Sağlık Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaSaglikGunu #WorldHealthDay #SaglikHerkesIcin"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-saglik-gunu"', '2026-04-07', 4, 7, 'Sağlık', ARRAY['#DunyaSaglikGunu','#WorldHealthDay','#SaglikHerkesIcin','#SaglikliYasam'], ARRAY['tansiyon aleti dijital','ateş ölçer temassız','vitamin multivitamin','egzersiz lastiği']),
('f8b9a112-9844-48f8-b3f1-000000000067', 'dunya-sanat-gunu', '15 Nisan Dünya Sanat Günü', 'Leonardo da Vinci''nin doğum gününde sanatsal yaratıcılığı ve özgürlüğü kutlayan uluslararası gün.', '## 15 Nisan Dünya Sanat Günü Nedir?
Uluslararası Sanat Derneği''nin Türkiye temsilcisi ressam Bedri Baykam''ın önerisiyle UNESCO tarafından kabul edilen küresel sanat günüdür.

### Tarihçesi ve Önemi
Uluslararası Sanat Derneği''nin Türkiye temsilcisi ressam Bedri Baykam''ın önerisiyle UNESCO tarafından kabul edilen küresel sanat günüdür. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 15 Nisan Dünya Sanat Günü Nasıl Kutlanır?
1. Bir sanat galerisini veya resim sergisini gezin.
2. Yeni bir sanatsal hobi edinin (resim, seramik, heykel).
3. Sanatçıların eserlerini paylaşarak destek olun.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Sanatsız kalan bir milletin hayat damarlarından biri kopmuş demektir. 15 Nisan Dünya Sanat Günü kutlu olsun! 🎨🖌️"
* "15 Nisan Dünya Sanat Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaSanatGunu #WorldArtDay #LeonardoDaVinci"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-sanat-gunu"', '2026-04-15', 4, 15, 'Kültür & Sanat', ARRAY['#DunyaSanatGunu','#WorldArtDay','#LeonardoDaVinci','#Sanat'], ARRAY['akrilik boya seti','resim şövalesi','tuval seti','eskiz defteri kaliteli']),
('f8b9a112-9844-48f8-b3f1-000000000068', 'dunya-gunu', '22 Nisan Dünya Günü (Earth Day)', 'Gezegenimizi korumak, iklim krizini önlemek ve doğaya saygı duymak için dünya çapında kutlanan çevre günü.', '## 22 Nisan Dünya Günü (Earth Day) Nedir?
1970 yılında ABD''de çevre kirliliğine karşı 20 milyon insanın katıldığı protestoyla doğmuş ve küresel çevre hareketine dönüşmüştür.

### Tarihçesi ve Önemi
1970 yılında ABD''de çevre kirliliğine karşı 20 milyon insanın katıldığı protestoyla doğmuş ve küresel çevre hareketine dönüşmüştür. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 22 Nisan Dünya Günü (Earth Day) Nasıl Kutlanır?
1. Bir günlüğüne aracınızı bırakıp toplu taşıma veya bisiklet kullanın.
2. Enerji ve plastik tüketiminizi kısıtlayın.
3. Fidan dikim etkinliklerine katılın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Evimiz Dünya için harekete geçme zamanı! 22 Nisan Dünya Günü kutlu olsun. 🌍🌱"
* "22 Nisan Dünya Günü (Earth Day) kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaGunu #EarthDay #IklimKrizi"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-gunu"', '2026-04-22', 4, 22, 'Çevre & Doğa', ARRAY['#DunyaGunu','#EarthDay','#IklimKrizi','#GezegenimiziKoru'], ARRAY['güneş enerjili powerbank','bambu pipet seti','çevre dostu temizlik ürünleri']),
('f8b9a112-9844-48f8-b3f1-000000000069', 'ulusal-egemenlik-ve-cocuk-bayrami', '23 Nisan Ulusal Egemenlik ve Çocuk Bayramı', 'TBMM''nin açılışı ve Atatürk''ün dünya çocuklarına armağan ettiği ilk ve tek çocuk bayramı.', '## 23 Nisan Ulusal Egemenlik ve Çocuk Bayramı Nedir?
23 Nisan 1920''de Ankara''da TBMM açılmış ve milletin egemenliği tescillenmiştir. Dünyadaki tüm çocuklara bayram hediye edilmiştir.

### Tarihçesi ve Önemi
23 Nisan 1920''de Ankara''da TBMM açılmış ve milletin egemenliği tescillenmiştir. Dünyadaki tüm çocuklara bayram hediye edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 23 Nisan Ulusal Egemenlik ve Çocuk Bayramı Nasıl Kutlanır?
1. Evleri ve balkonları bayraklarla süsleyin.
2. Çocuk şenliklerine katılın.
3. Çocuklara günün anlamını ve Atatürk''ü anlatın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Egemenlik kayıtsız şartsız milletindir! 23 Nisan Ulusal Egemenlik ve Çocuk Bayramımız kutlu olsun! 🇹🇷🎈"
* "23 Nisan Ulusal Egemenlik ve Çocuk Bayramı kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #23Nisan #CocukBayrami #EgemenlikUlusundur"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #ulusal-egemenlik-ve-cocuk-bayrami"', '2026-04-23', 4, 23, 'Resmi', ARRAY['#23Nisan','#CocukBayrami','#EgemenlikUlusundur','#Ataturk'], ARRAY['çocuk kostümü','uçurtma seti','çocuk zeka oyunları','türk bayrağı balon']),
('f8b9a112-9844-48f8-b3f1-000000000070', 'dunya-kitap-gunu', '23 Nisan Dünya Kitap ve Telif Hakkı Günü', 'Shakespeare ve Cervantes''in ölüm yıl dönümünde kitap okuma sevgisini ve yazarların haklarını kutlayan gün.', '## 23 Nisan Dünya Kitap ve Telif Hakkı Günü Nedir?
UNESCO tarafından 1995 yılında kitap okumayı teşvik etmek ve telif haklarını korumak amacıyla ilan edilmiştir.

### Tarihçesi ve Önemi
UNESCO tarafından 1995 yılında kitap okumayı teşvik etmek ve telif haklarını korumak amacıyla ilan edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 23 Nisan Dünya Kitap ve Telif Hakkı Günü Nasıl Kutlanır?
1. Bir arkadaşınıza en sevdiğiniz kitabı hediye edin.
2. Yeni bir kitaba başlayın ve her gün 20 sayfa okuyun.
3. Kütüphaneleri ziyaret edin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Kitaplar sessiz öğretmenlerdir. 23 Nisan Dünya Kitap Günü''nde sayfaların büyüsüne kapılın! 📖✨"
* "23 Nisan Dünya Kitap ve Telif Hakkı Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaKitapGunu #KitapKurdu #OkumakOzgurluktur"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kitap-gunu"', '2026-04-23', 4, 23, 'Kültür & Sanat', ARRAY['#DunyaKitapGunu','#KitapKurdu','#OkumakOzgurluktur','#Kitap'], ARRAY['e-kitap okuyucu kılıfı','ahşap kitap ayracı','kitap okuma lambası','roman seti çok satanlar']),
('f8b9a112-9844-48f8-b3f1-000000000071', 'dunya-dans-gunu', '29 Nisan Dünya Dans Günü', 'Bedenin evrensel dili olan dansın coşkusunu kutlamak için modern balenin yaratıcısı Noverre anısına kutlanır.', '## 29 Nisan Dünya Dans Günü Nedir?
UNESCO Uluslararası Dans Komitesi tarafından 1982 yılından bu yana tüm dans türlerini kutlamak amacıyla düzenlenir.

### Tarihçesi ve Önemi
UNESCO Uluslararası Dans Komitesi tarafından 1982 yılından bu yana tüm dans türlerini kutlamak amacıyla düzenlenir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 29 Nisan Dünya Dans Günü Nasıl Kutlanır?
1. En sevdiğiniz şarkıyı açıp özgürce dans edin.
2. Salsa, tango veya zeybek gibi yeni bir dans kursu deneyin.
3. Dans gösterilerini izleyin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Hayat bir danstır, ritmi yakala! 29 Nisan Dünya Dans Günü kutlu olsun! 💃🕺🎶"
* "29 Nisan Dünya Dans Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaDansGunu #DanceDay #DansEt"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-dans-gunu"', '2026-04-29', 4, 29, 'Kültür & Sanat', ARRAY['#DunyaDansGunu','#DanceDay','#DansEt','#Sanat'], ARRAY['dans ayakkabısı','kablosuz kulaklık spor','tayt spor kaliteli','dans kursu kuponu']),
('f8b9a112-9844-48f8-b3f1-000000000072', 'emek-ve-dayanisma-gunu', '1 Mayıs Emek ve Dayanışma Günü', 'İşçi ve emekçilerin hak mücadelelerini onurlandıran, tüm dünyada kutlanan uluslararası resmi tatil günü.', '## 1 Mayıs Emek ve Dayanışma Günü Nedir?
1886 yılında Chicago''da işçilerin 8 saatlik iş günü mücadelesiyle başlayan, emeğin ve alın terinin küresel bayramıdır.

### Tarihçesi ve Önemi
1886 yılında Chicago''da işçilerin 8 saatlik iş günü mücadelesiyle başlayan, emeğin ve alın terinin küresel bayramıdır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 1 Mayıs Emek ve Dayanışma Günü Nasıl Kutlanır?
1. Alın teriyle çalışan tüm emekçileri tebrik edin.
2. İş güvenliği ve adil ücret haklarını savunun.
3. Emek dayanışmasına katkıda bulunun.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Alın teriyle dünyayı güzelleştiren tüm emekçilerin 1 Mayıs Emek ve Dayanışma Günü kutlu olsun! 🛠️✊"
* "1 Mayıs Emek ve Dayanışma Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #1Mayis #IsciBayrami #EmekVeDayanisma"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #emek-ve-dayanisma-gunu"', '2026-05-01', 5, 1, 'Resmi', ARRAY['#1Mayis','#IsciBayrami','#EmekVeDayanisma','#Haklar'], ARRAY['iş güvenliği ayakkabısı','termos yemek kabı','iş tulumu']),
('f8b9a112-9844-48f8-b3f1-000000000073', 'anneler-gunu', '10 Mayıs Anneler Günü', 'Annelerimizin karşılıksız sevgisine ve fedakarlıklarına teşekkür ettiğimiz en duygusal özel gün.', '## 10 Mayıs Anneler Günü Nedir?
Modern Anneler Günü, Anna Jarvis''in annesi anısına başlattığı hareketle yaygınlaşmış olup Mayıs ayının ikinci pazarı kutlanır.

### Tarihçesi ve Önemi
Modern Anneler Günü, Anna Jarvis''in annesi anısına başlattığı hareketle yaygınlaşmış olup Mayıs ayının ikinci pazarı kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 10 Mayıs Anneler Günü Nasıl Kutlanır?
1. Annenizi ziyaret edin, sarılın ve sevginizi dile getirin.
2. Onun için özel bir kahvaltı hazırlayın.
3. Onu mutlu edecek içten bir hediye seçin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Cennet annelerin ayakları altındadır. Varlığıyla hayatımızı aydınlatan canım annemin ve tüm annelerin Anneler Günü kutlu olsun! 💐💖"
* "10 Mayıs Anneler Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #AnnelerGunu #CanimAnnem #AnneSevgisi"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #anneler-gunu"', '2026-05-10', 5, 10, 'Eğlence', ARRAY['#AnnelerGunu','#CanimAnnem','#AnneSevgisi','#HediyeFikirleri'], ARRAY['anneler günü hediye seti','robot süpürge','kolye anne bebek figürlü','çiçek sepeti']),
('f8b9a112-9844-48f8-b3f1-000000000074', 'hemsireler-gunu', '12 Mayıs Hemşireler Günü', 'Modern hemşireliğin kurucusu Florence Nightingale anısına sağlık ordusunun fedakar hemşirelerine adanan gün.', '## 12 Mayıs Hemşireler Günü Nedir?
Uluslararası Hemşireler Konseyi tarafından Florence Nightingale''in doğum günü olan 12 Mayıs''ta küresel olarak kutlanır.

### Tarihçesi ve Önemi
Uluslararası Hemşireler Konseyi tarafından Florence Nightingale''in doğum günü olan 12 Mayıs''ta küresel olarak kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 12 Mayıs Hemşireler Günü Nasıl Kutlanır?
1. Sağlık kuruluşlarında görev yapan hemşirelere teşekkür edin.
2. Hemşirelerin çalışma koşullarının iyileştirilmesine destek olun.
3. Onların şefkatli emeğini takdir edin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Şefkat dolu elleriyle yaralarımızı saran tüm hemşirelerimizin 12 Mayıs Hemşireler Günü kutlu olsun! 🩺🤍"
* "12 Mayıs Hemşireler Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #HemsirelerGunu #12Mayis #HemsirelereTesekkurler"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #hemsireler-gunu"', '2026-05-12', 5, 12, 'Sağlık', ARRAY['#HemsirelerGunu','#12Mayis','#HemsirelereTesekkurler','#Saglik'], ARRAY['hemşire forması desenli','ortopedik sabo terlik','hemşire saati stetoskop','fincan hemşire']),
('f8b9a112-9844-48f8-b3f1-000000000075', 'dunya-ciftciler-gunu', '14 Mayıs Dünya Çiftçiler Günü', 'Sofralarımıza gelen her lokmada emeği olan çiftçilerin ve tarım üreticilerinin uluslararası günü.', '## 14 Mayıs Dünya Çiftçiler Günü Nedir?
Uluslararası Tarım Üreticileri Federasyonu''nun kuruluş tarihi olan 14 Mayıs 1984''ten bu yana kutlanmaktadır.

### Tarihçesi ve Önemi
Uluslararası Tarım Üreticileri Federasyonu''nun kuruluş tarihi olan 14 Mayıs 1984''ten bu yana kutlanmaktadır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 14 Mayıs Dünya Çiftçiler Günü Nasıl Kutlanır?
1. Yerel üreticilerden ve köy pazarlarından alışveriş yapın.
2. Sürdürülebilir tarım uygulamalarını destekleyin.
3. Çiftçilerin emeğine saygı gösterin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Köylü milletin efendisidir! Gece gündüz üreten tüm çiftçilerimizin 14 Mayıs Dünya Çiftçiler Günü kutlu olsun. 🌾🚜"
* "14 Mayıs Dünya Çiftçiler Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaCiftcilerGunu #14Mayis #TopraginEmekcileri"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-ciftciler-gunu"', '2026-05-14', 5, 14, 'Mesleki', ARRAY['#DunyaCiftcilerGunu','#14Mayis','#TopraginEmekcileri','#Tarim'], ARRAY['bahçe eldiveni sağlam','budama testeresi','toprak ph ölçer','hasır şapka']),
('f8b9a112-9844-48f8-b3f1-000000000076', 'genclik-ve-spor-bayrami', '19 Mayıs Atatürk''ü Anma, Gençlik ve Spor Bayramı', 'Atatürk''ün Samsun''a çıkarak Milli Mücadele''yi başlattığı ve Türk gençliğine armağan ettiği milli bayramımız.', '## 19 Mayıs Atatürk''ü Anma, Gençlik ve Spor Bayramı Nedir?
19 Mayıs 1919''da Mustafa Kemal Paşa Bandırma Vapuru ile Samsun''a ayak basmış ve Kurtuluş Savaşı''nı fiilen başlatmıştır.

### Tarihçesi ve Önemi
19 Mayıs 1919''da Mustafa Kemal Paşa Bandırma Vapuru ile Samsun''a ayak basmış ve Kurtuluş Savaşı''nı fiilen başlatmıştır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 19 Mayıs Atatürk''ü Anma, Gençlik ve Spor Bayramı Nasıl Kutlanır?
1. Gençlik festivallerine ve spor müsabakalarına katılın.
2. Şehir meydanlarındaki resmi törenleri izleyin.
3. Evlerinize Türk bayrakları asın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Ey Türk Gençliği! Birinci vazifen Türk istiklalini ve Türk cumhuriyetini ilelebet muhafaza ve müdafaa etmektir. 19 Mayıs kutlu olsun! 🇹🇷🏃‍♂️"
* "19 Mayıs Atatürk''ü Anma, Gençlik ve Spor Bayramı kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #19Mayis #GenclikVesporBayrami #Ataturk"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #genclik-ve-spor-bayrami"', '2026-05-19', 5, 19, 'Resmi', ARRAY['#19Mayis','#GenclikVesporBayrami','#Ataturk','#Samsun1919'], ARRAY['türk bayrağı spor tişörtü','spor çantası','basketbol topu','atatürk imzalı rozet']),
('f8b9a112-9844-48f8-b3f1-000000000077', 'dunya-ari-gunu', '20 Mayıs Dünya Arı Günü', 'Ekosistemin ve tarımın gizli kahramanları olan arıların tozlaşmadaki hayati önemini hatırlatan BM günü.', '## 20 Mayıs Dünya Arı Günü Nedir?
Modern arıcılığın öncüsü Anton Jansa''nın doğum günü anısına Birleşmiş Milletler tarafından kabul edilmiştir.

### Tarihçesi ve Önemi
Modern arıcılığın öncüsü Anton Jansa''nın doğum günü anısına Birleşmiş Milletler tarafından kabul edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 20 Mayıs Dünya Arı Günü Nasıl Kutlanır?
1. Balkonunuza arıların sevdiği lavanta ve kekik gibi çiçekler ekin.
2. Kimyasal tarım ilaçlarının azaltılmasını savunun.
3. Gerçek arıcıları destekleyin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Arılar yoksa hayat da yok! 20 Mayıs Dünya Arı Günü''nde minik kanatlı dostlarımızı koruyalım. 🐝🍯🌸"
* "20 Mayıs Dünya Arı Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaAriGunu #WorldBeeDay #ArilariKoru"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-ari-gunu"', '2026-05-20', 5, 20, 'Çevre & Doğa', ARRAY['#DunyaAriGunu','#WorldBeeDay','#ArilariKoru','#DogayiKoru'], ARRAY['doğal organik bal','arı sütü propolis','çiçek tohumu arı dostu']),
('f8b9a112-9844-48f8-b3f1-000000000078', 'istanbulun-fethi', '29 Mayıs İstanbul''un Fethi', '1453 yılında Fatih Sultan Mehmet komutasındaki Osmanlı ordusunun İstanbul''u fethettiği tarihi gün.', '## 29 Mayıs İstanbul''un Fethi Nedir?
29 Mayıs 1453''te İstanbul fethedilmiş, Orta Çağ kapanıp Yeni Çağ başlamış ve Konstantiniyye, Osmanlı''nın başkenti olmuştur.

### Tarihçesi ve Önemi
29 Mayıs 1453''te İstanbul fethedilmiş, Orta Çağ kapanıp Yeni Çağ başlamış ve Konstantiniyye, Osmanlı''nın başkenti olmuştur. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 29 Mayıs İstanbul''un Fethi Nasıl Kutlanır?
1. Tarihi Yarımada''yı ve fethin izlerini taşıyan surları ziyaret edin.
2. Panorama 1453 Tarih Müzesi''ni gezin.
3. İstanbul''un kültürel zenginliğini anlatan eserleri inceleyin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Bir çağı kapatıp yeni bir çağ açan Fatih Sultan Mehmet ve kutlu ordusunu rahmetle anıyoruz. 29 Mayıs İstanbul''un Fethi kutlu olsun! 🇹🇷🏰"
* "29 Mayıs İstanbul''un Fethi kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #29Mayis1453 #IstanbulunFethi #FatihSultanMehmet"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #istanbulun-fethi"', '2026-05-29', 5, 29, 'Resmi', ARRAY['#29Mayis1453','#IstanbulunFethi','#FatihSultanMehmet','#Fetih'], ARRAY['istanbul fetih tarihi kitabı','osmanlı tuğrası tablo','minyatür fatih biblosu']),
('f8b9a112-9844-48f8-b3f1-000000000079', 'dunya-cevre-gunu', '5 Haziran Dünya Çevre Günü', 'Doğayı korumak, iklim kriziyle mücadele etmek ve gezegenimizin sürdürülebilirliğini sağlamak için kutlanır.', '## 5 Haziran Dünya Çevre Günü Nedir?
1972 yılında Stockholm Çevre Konferansı''nda alınan kararla ilan edilen gün çevre bilincini küresel düzeyde artırır.

### Tarihçesi ve Önemi
1972 yılında Stockholm Çevre Konferansı''nda alınan kararla ilan edilen gün çevre bilincini küresel düzeyde artırır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 5 Haziran Dünya Çevre Günü Nasıl Kutlanır?
1. Fidan dikin veya yerel çevre temizliği etkinliklerine katılın.
2. Tek kullanımlık plastik tüketiminizi sıfırlayın.
3. Su ve elektrik tasarrufu yapın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Başka bir Dünya yok! 5 Haziran Dünya Çevre Günü''nde doğaya borcumuzu ödeyelim. 🌍🌱"
* "5 Haziran Dünya Çevre Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaCevreGunu #SifirAtik #IklimKrizi"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-cevre-gunu"', '2026-06-05', 6, 5, 'Çevre & Doğa', ARRAY['#DunyaCevreGunu','#SifirAtik','#IklimKrizi','#DogaDostu'], ARRAY['çelik matara termos','bez alışveriş çantası','bambu diş fırçası seti','kompost kutusu']),
('f8b9a112-9844-48f8-b3f1-000000000080', 'dunya-okyanuslar-gunu', '8 Haziran Dünya Okyanuslar Günü', 'Gezegenimizin akciğerleri olan deniz ve okyanusların plastik kirliliğinden arındırılmasını savunan gün.', '## 8 Haziran Dünya Okyanuslar Günü Nedir?
1992 Rio Dünya Zirvesi''nde önerilen ve 2008''de BM tarafından resmi olarak tanınan küresel okyanus koruma günüdür.

### Tarihçesi ve Önemi
1992 Rio Dünya Zirvesi''nde önerilen ve 2008''de BM tarafından resmi olarak tanınan küresel okyanus koruma günüdür. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 8 Haziran Dünya Okyanuslar Günü Nasıl Kutlanır?
1. Sahil ve plaj temizliklerine katılın.
2. Plastik atıkların denizlere ulaşmasını engelleyin.
3. Sürdürülebilir deniz ürünlerini tercih edin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Mavi gezegenimizin kalbi denizler ve okyanuslardır. 8 Haziran Dünya Okyanuslar Günü kutlu olsun! 🌊🐋🐬"
* "8 Haziran Dünya Okyanuslar Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaOkyanuslarGunu #WorldOceansDay #DenizleriKoru"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-okyanuslar-gunu"', '2026-06-08', 6, 8, 'Çevre & Doğa', ARRAY['#DunyaOkyanuslarGunu','#WorldOceansDay','#DenizleriKoru','#MaviGezegen'], ARRAY['deniz gözlüğü şnorkel','mikrofiber hızlı kuruyan havlu','su geçirmez telefon kılıfı']),
('f8b9a112-9844-48f8-b3f1-000000000081', 'dunya-kan-bagiscilari-gunu', '14 Haziran Dünya Kan Bağışçıları Günü', 'Gönüllü ve karşılıksız kan bağışlayarak milyonlarca insanın hayatını kurtaran kahramanları onurlandıran gün.', '## 14 Haziran Dünya Kan Bağışçıları Günü Nedir?
AB0 kan grubu sistemini bulan Nobel ödüllü Karl Landsteiner''in doğum gününde DSÖ öncülüğünde kutlanır.

### Tarihçesi ve Önemi
AB0 kan grubu sistemini bulan Nobel ödüllü Karl Landsteiner''in doğum gününde DSÖ öncülüğünde kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 14 Haziran Dünya Kan Bağışçıları Günü Nasıl Kutlanır?
1. En yakın Kızılay kan merkezine giderek kan bağışında bulunun.
2. Sağlıklı bireyleri kan bağışına teşvik edin.
3. Kök hücre bağışçısı olmayı değerlendirin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "1 ünite kan 3 can kurtarır! Tüm gönüllü bağışçılarımızın 14 Haziran Dünya Kan Bağışçıları Günü kutlu olsun. 🩸❤️"
* "14 Haziran Dünya Kan Bağışçıları Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #KanBagiscilariGunu #KanBagisiHayatKurtarir #Kizilay"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kan-bagiscilari-gunu"', '2026-06-14', 6, 14, 'Sağlık', ARRAY['#KanBagiscilariGunu','#KanBagisiHayatKurtarir','#Kizilay','#KanVerCanVer'], ARRAY['kan şekeri ölçüm cihazı','vitamin takviyesi','sporcu su matarası']),
('f8b9a112-9844-48f8-b3f1-000000000082', 'babalar-gunu', '21 Haziran Babalar Günü', 'Babalarımızın fedakarlıklarına, sevgisine ve rehberliğine teşekkür ettiğimiz anlamlı kutlama günü.', '## 21 Haziran Babalar Günü Nedir?
Her yıl Haziran ayının üçüncü pazar günü babaların ailedeki sevgi ve koruma rolünü onurlandırmak için kutlanır.

### Tarihçesi ve Önemi
Her yıl Haziran ayının üçüncü pazar günü babaların ailedeki sevgi ve koruma rolünü onurlandırmak için kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 21 Haziran Babalar Günü Nasıl Kutlanır?
1. Babanızı arayın veya ziyaret edip ona teşekkür edin.
2. Birlikte nostaljik bir yürüyüş veya kahve molası verin.
3. Kullanışlı ve anlamlı bir hediye armağan edin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Hayatımızın en güvenli sığınağı, ilk kahramanımız olan canım babamın ve tüm babaların Babalar Günü kutlu olsun! 👔💙"
* "21 Haziran Babalar Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #BabalarGunu #CanimBabam #BabaSevgisi"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #babalar-gunu"', '2026-06-21', 6, 21, 'Eğlence', ARRAY['#BabalarGunu','#CanimBabam','#BabaSevgisi','#HediyeFikirleri'], ARRAY['babalar günü hediye kutusu','deri cüzdan kemer seti','tıraş makinesi seti','erkek kol saati']),
('f8b9a112-9844-48f8-b3f1-000000000083', 'dunya-muzik-gunu', '21 Haziran Dünya Müzik Günü', 'Yılın en uzun gününde sokaklarda, parklarda ve salonlarda müziğin evrensel dilini kutlayan müzik festivali.', '## 21 Haziran Dünya Müzik Günü Nedir?
1982''de Fransa''da başlatılan Fête de la Musique, bugün 120 ülkede amatör ve profesyonel müzisyenlerin sokaklarda özgürce müzik yaptığı bir şölendir.

### Tarihçesi ve Önemi
1982''de Fransa''da başlatılan Fête de la Musique, bugün 120 ülkede amatör ve profesyonel müzisyenlerin sokaklarda özgürce müzik yaptığı bir şölendir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 21 Haziran Dünya Müzik Günü Nasıl Kutlanır?
1. En sevdiğiniz enstrümanı çalın veya yeni bir şarkı öğrenin.
2. Ücretsiz sokak konserlerini izleyin.
3. Farklı dünya müziklerini keşfedin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Müzik ruhun gıdasıdır. Ruhu müzikle beslenen tüm dostların 21 Haziran Dünya Müzik Günü kutlu olsun! 🎵🎸🎧"
* "21 Haziran Dünya Müzik Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaMuzikGunu #FeteDeLaMusique #MuzikRuhunGidasidir"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-muzik-gunu"', '2026-06-21', 6, 21, 'Kültür & Sanat', ARRAY['#DunyaMuzikGunu','#FeteDeLaMusique','#MuzikRuhunGidasidir','#21Haziran'], ARRAY['bluetooth kulaklık','akustik gitar başlangıç seti','ukulele ahşap','taşınabilir hoparlör']),
('f8b9a112-9844-48f8-b3f1-000000000084', 'kabotaj-bayrami', '1 Temmuz Denizcilik ve Kabotaj Bayramı', 'Türk karasularında egemenliğin ve deniz ticareti hakkının Türkiye''ye geçtiği tarihi milli bayram.', '## 1 Temmuz Denizcilik ve Kabotaj Bayramı Nedir?
1 Temmuz 1926''da yürürlüğe giren Kabotaj Kanunu ile Türk limanları arasındaki deniz taşımacılığı hakkı yabancılardan alınıp Türk bayraklı gemilere verilmiştir.

### Tarihçesi ve Önemi
1 Temmuz 1926''da yürürlüğe giren Kabotaj Kanunu ile Türk limanları arasındaki deniz taşımacılığı hakkı yabancılardan alınıp Türk bayraklı gemilere verilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 1 Temmuz Denizcilik ve Kabotaj Bayramı Nasıl Kutlanır?
1. Kıyı şehirlerindeki deniz şenliklerini ve yağlı direk yarışlarını izleyin.
2. Deniz şehitlerini anma törenlerine katılın.
3. Türkiye''nin denizcilik tarihini okuyun.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Denizlere hakim olan cihana hakim olur! 1 Temmuz Denizcilik ve Kabotaj Bayramımız kutlu olsun! 🇹🇷⚓🚢"
* "1 Temmuz Denizcilik ve Kabotaj Bayramı kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #1Temmuz #KabotajBayrami #DenizcilikBayrami"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #kabotaj-bayrami"', '2026-07-01', 7, 1, 'Resmi', ARRAY['#1Temmuz','#KabotajBayrami','#DenizcilikBayrami','#MaviVatan'], ARRAY['yelkenli gemi maketi','denizci şapkası','deniz kabuğu bileklik','su geçirmez çanta']),
('f8b9a112-9844-48f8-b3f1-000000000085', 'dunya-cikolata-gunu', '7 Temmuz Dünya Çikolata Günü', 'Kakao çekirdeğinden üretilen dünyanın en sevilen tatlısının keşfini kutlayan lezzetli gün.', '## 7 Temmuz Dünya Çikolata Günü Nedir?
1550 yılında çikolatanın Avrupa''ya ilk kez getirildiği günün anısına dünya çapında çikolata günü olarak kutlanır.

### Tarihçesi ve Önemi
1550 yılında çikolatanın Avrupa''ya ilk kez getirildiği günün anısına dünya çapında çikolata günü olarak kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 7 Temmuz Dünya Çikolata Günü Nasıl Kutlanır?
1. Sevdiklerinizle özel bir çikolata kutusu paylaşın.
2. Evde kendi çikolatalı tatlınızı pişirin.
3. Yüksek kakaolu bitter çikolatanın faydalarını keşfedin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Mutluluğun en tatlı hali! Tüm çikolataseverlerin 7 Temmuz Dünya Çikolata Günü kutlu olsun! 🍫😋"
* "7 Temmuz Dünya Çikolata Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaCikolataGunu #WorldChocolateDay #CikolataSever"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-cikolata-gunu"', '2026-07-07', 7, 7, 'Eğlence', ARRAY['#DunyaCikolataGunu','#WorldChocolateDay','#CikolataSever','#TatliKriz'], ARRAY['belçika çikolatası kutusu','çikolata fondü seti','sıcak çikolata tozu','çikolatalı trüf']),
('f8b9a112-9844-48f8-b3f1-000000000086', 'demokrasi-ve-milli-birlik-gunu', '15 Temmuz Demokrasi ve Milli Birlik Günü', '15 Temmuz 2016 darbe girişimine karşı milletimizin gösterdiği destansı direnişi ve şehitlerimizi anma günü.', '## 15 Temmuz Demokrasi ve Milli Birlik Günü Nedir?
15 Temmuz gecesi halkın iradesine ve demokrasimize sahip çıkarak canlarını feda eden şehit ve gazilerimizi anmak için resmi tatil ilan edilmiştir.

### Tarihçesi ve Önemi
15 Temmuz gecesi halkın iradesine ve demokrasimize sahip çıkarak canlarını feda eden şehit ve gazilerimizi anmak için resmi tatil ilan edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 15 Temmuz Demokrasi ve Milli Birlik Günü Nasıl Kutlanır?
1. Şehitlikleri ziyaret edin ve dualar okuyun.
2. Demokrasi nöbetlerine ve anma programlarına katılın.
3. Milli birlik ve beraberlik mesajları paylaşın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Milletimizin iradesi hiçbir gücün önünde eğilmez! 15 Temmuz Demokrasi ve Milli Birlik Günü''nde şehitlerimizi rahmetle anıyoruz. 🇹🇷🕊️"
* "15 Temmuz Demokrasi ve Milli Birlik Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #15Temmuz #DemokrasiBayrami #MilliBirlikGunu"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #demokrasi-ve-milli-birlik-gunu"', '2026-07-15', 7, 15, 'Resmi', ARRAY['#15Temmuz','#DemokrasiBayrami','#MilliBirlikGunu','#SehitlerimiziUnutmadik'], ARRAY['türk bayrağı büyük boy','15 temmuz anı kitabı','atatürk tişörtü']),
('f8b9a112-9844-48f8-b3f1-000000000087', 'dunya-emoji-gunu', '17 Temmuz Dünya Emoji Günü', 'Dijital çağın küresel dili olan emojilerin iletişimdeki eğlenceli rolünü kutlayan internet günü.', '## 17 Temmuz Dünya Emoji Günü Nedir?
Apple''ın takvim emojisinin üzerinde 17 Temmuz yazdığı için Emojipedia kurucusu Jeremy Burge tarafından 2014''te ilan edilmiştir.

### Tarihçesi ve Önemi
Apple''ın takvim emojisinin üzerinde 17 Temmuz yazdığı için Emojipedia kurucusu Jeremy Burge tarafından 2014''te ilan edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 17 Temmuz Dünya Emoji Günü Nasıl Kutlanır?
1. Bugün mesajlarınızda en sevdiğiniz emojileri bolca kullanın.
2. Arkadaşlarınızla emoji tahmin oyunu oynayın.
3. Sosyal medyada günün favori emojisini seçin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Kelimelerin yetmediği yerde emojiler konuşur! 17 Temmuz Dünya Emoji Günü kutlu olsun! 🎉🥳🚀"
* "17 Temmuz Dünya Emoji Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaEmojiGunu #WorldEmojiDay #EmojiGunu"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-emoji-gunu"', '2026-07-17', 7, 17, 'Eğlence', ARRAY['#DunyaEmojiGunu','#WorldEmojiDay','#EmojiGunu','#DijitalIletisim'], ARRAY['emoji yastık peluş','emoji anahtarlık','renkli sticker çıkartma seti']),
('f8b9a112-9844-48f8-b3f1-000000000088', 'dunya-satranc-gunu', '20 Temmuz Dünya Satranç Günü', 'Strateji, zeka ve sabır oyunu satrancın zihinsel gelişimdeki gücünü kutlamak için FIDE öncülüğünde kutlanır.', '## 20 Temmuz Dünya Satranç Günü Nedir?
1924 yılında Dünya Satranç Federasyonu''nun (FIDE) Paris''te kuruluşunun anısına Birleşmiş Milletler tarafından kabul edilmiştir.

### Tarihçesi ve Önemi
1924 yılında Dünya Satranç Federasyonu''nun (FIDE) Paris''te kuruluşunun anısına Birleşmiş Milletler tarafından kabul edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 20 Temmuz Dünya Satranç Günü Nasıl Kutlanır?
1. Bir dostunuzla zevkli bir satranç maçı yapın.
2. Yeni bir açılış hamlesi veya taktik öğrenin.
3. Çocuklara satranç öğretin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Hayat da satranç gibidir, her hamle geleceğini belirler. 20 Temmuz Dünya Satranç Günü kutlu olsun! ♟️👑"
* "20 Temmuz Dünya Satranç Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaSatrancGunu #ChessDay #SatrancSeverler"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-satranc-gunu"', '2026-07-20', 7, 20, 'Eğlence', ARRAY['#DunyaSatrancGunu','#ChessDay','#SatrancSeverler','#ZekaOyunu'], ARRAY['ahşap satranç takımı','dijital satranç saati','satranç taktikleri kitabı','manyetik seyahat satrancı']),
('f8b9a112-9844-48f8-b3f1-000000000089', 'dunya-solaklar-gunu', '13 Ağustos Dünya Solaklar Günü', 'Dünya nüfusunun yaklaşık yüzde 10''unu oluşturan solakların günlük hayattaki zorluklarına dikkat çeken gün.', '## 13 Ağustos Dünya Solaklar Günü Nedir?
1976 yılında Dean R. Campbell tarafından solakların sağ el odaklı dünyada yaşadığı zorluklara eğlenceli ve eğitici bir bakış açısıyla başlatılmıştır.

### Tarihçesi ve Önemi
1976 yılında Dean R. Campbell tarafından solakların sağ el odaklı dünyada yaşadığı zorluklara eğlenceli ve eğitici bir bakış açısıyla başlatılmıştır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 13 Ağustos Dünya Solaklar Günü Nasıl Kutlanır?
1. Sağ elinizi kullanan biriyseniz bugün bir süre sol elinizle yazı yazmayı deneyin.
2. Solak arkadaşlarınıza özel hediyeler verin.
3. Solakların başarılarını kutlayın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Farklı açıdan gören ve sol eliyle dünyayı güzelleştiren tüm solakların günü kutlu olsun! ✍️🖐️"
* "13 Ağustos Dünya Solaklar Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaSolaklarGunu #LefthandersDay #SolaklarGunu"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-solaklar-gunu"', '2026-08-13', 8, 13, 'Eğlence', ARRAY['#DunyaSolaklarGunu','#LefthandersDay','#SolaklarGunu','#SolEl'], ARRAY['solaklar için makas','sol el ergonomik mouse','solaklar için dolma kalem']),
('f8b9a112-9844-48f8-b3f1-000000000090', 'dunya-fotografcilik-gunu', '19 Ağustos Dünya Fotoğrafçılık Günü', 'Anı ölümsüzleştiren fotoğraf sanatının doğuşunu (Dagerreyotipi patentini) kutlayan küresel sanat günü.', '## 19 Ağustos Dünya Fotoğrafçılık Günü Nedir?
1839 yılında Fransız hükümetinin Dagerreyotipi buluşunu tüm dünyaya ücretsiz hediye ettiği 19 Ağustos günü fotoğrafçılığın doğum günü sayılır.

### Tarihçesi ve Önemi
1839 yılında Fransız hükümetinin Dagerreyotipi buluşunu tüm dünyaya ücretsiz hediye ettiği 19 Ağustos günü fotoğrafçılığın doğum günü sayılır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 19 Ağustos Dünya Fotoğrafçılık Günü Nasıl Kutlanır?
1. Makinenizi veya telefonunuzu alıp şehri kadrajınıza alın.
2. En sevdiğiniz fotoğrafları sergileyin veya paylaşın.
3. Fotoğrafçılık kursu veya eğitim videosu izleyin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Hayatı durdurup anı ölümsüzleştiren tüm fotoğraf tutkunlarının 19 Ağustos Dünya Fotoğrafçılık Günü kutlu olsun! 📷✨"
* "19 Ağustos Dünya Fotoğrafçılık Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #FotografcilikGunu #WorldPhotographyDay #FotografSever"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-fotografcilik-gunu"', '2026-08-19', 8, 19, 'Kültür & Sanat', ARRAY['#FotografcilikGunu','#WorldPhotographyDay','#FotografSever','#Kadraj'], ARRAY['fotoğraf makinesi askısı','lens temizleme kiti','telefon için fotoğraf lensi','fotoğraf albümü']),
('f8b9a112-9844-48f8-b3f1-000000000091', 'dunya-kopekler-gunu', '26 Ağustos Dünya Köpekler Günü', 'İnsanın en sadık dostu köpeklerin yaşam hakkını ve barınaklardaki sahipsiz canları hatırlatan gün.', '## 26 Ağustos Dünya Köpekler Günü Nedir?
2004 yılında hayvan savunucusu Colleen Paige tarafından kurtarma köpeklerine ve sahiplenmeye dikkat çekmek amacıyla başlatılmıştır.

### Tarihçesi ve Önemi
2004 yılında hayvan savunucusu Colleen Paige tarafından kurtarma köpeklerine ve sahiplenmeye dikkat çekmek amacıyla başlatılmıştır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 26 Ağustos Dünya Köpekler Günü Nasıl Kutlanır?
1. Köpeğinize uzun ve keyifli bir yürüyüş yaptırın.
2. Sokak köpeklerine mama ve su bırakın.
3. Barınaktan bir dost sahiplenmeyi değerlendirin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Karşılıksız sevginin ve sadakatin adı! Tüm sevimli can dostlarımızın 26 Ağustos Dünya Köpekler Günü kutlu olsun! 🐶🦴"
* "26 Ağustos Dünya Köpekler Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaKopeklerGunu #DogDay #CanDostum"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kopekler-gunu"', '2026-08-26', 8, 26, 'Çevre & Doğa', ARRAY['#DunyaKopeklerGunu','#DogDay','#CanDostum','#SatinAlmaSahiplen'], ARRAY['köpek tasması ve künyesi','köpek ödül bisküvisi','köpek diş temizleme oyuncağı','köpek yatağı ortopedik']),
('f8b9a112-9844-48f8-b3f1-000000000092', 'zafer-bayrami', '30 Ağustos Zafer Bayramı', '1922 Büyük Taarruz ve Başkomutanlık Meydan Muharebesi zaferini kutladığımız büyük milli bayramımız.', '## 30 Ağustos Zafer Bayramı Nedir?
Gazi Mustafa Kemal Atatürk başkumandanlığında Türk ordusunun vatan topraklarını işgalden temizlediği kesin zafer günüdür.

### Tarihçesi ve Önemi
Gazi Mustafa Kemal Atatürk başkumandanlığında Türk ordusunun vatan topraklarını işgalden temizlediği kesin zafer günüdür. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 30 Ağustos Zafer Bayramı Nasıl Kutlanır?
1. Resmi geçit törenlerini ve Türk Yıldızları gösterilerini izleyin.
2. Şehitlikleri ziyaret ederek dua edin.
3. Evlerinizi ve iş yerlerinizi Türk bayraklarıyla donatın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "30 Ağustos, Türk milletinin bağımsızlığından asla vazgeçmeyeceğinin belgesidir. Zafer Bayramımız kutlu olsun! 🇹🇷🎖️"
* "30 Ağustos Zafer Bayramı kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #30Agustos #ZaferBayrami #BaskanMustafaKemal"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #zafer-bayrami"', '2026-08-30', 8, 30, 'Resmi', ARRAY['#30Agustos','#ZaferBayrami','#BaskanMustafaKemal','#BuyukTaarruz','#Turkiye'], ARRAY['türk bayrağı araba süsü','atatürk tişörtü','kurtuluş savaşı tarihi kitabı','rozet']),
('f8b9a112-9844-48f8-b3f1-000000000093', 'dunya-baris-gunu', '1 Eylül Dünya Barış Günü', 'İkinci Dünya Savaşı''nın başladığı günde savaşların sona ermesi ve küresel barışın tesisi için kutlanan gün.', '## 1 Eylül Dünya Barış Günü Nedir?
1 Eylül 1939''da Almanya''nın Polonya''yı işgaliyle başlayan 2. Dünya Savaşı''nın yıkımını unutmamak için ilan edilen barış günüdür.

### Tarihçesi ve Önemi
1 Eylül 1939''da Almanya''nın Polonya''yı işgaliyle başlayan 2. Dünya Savaşı''nın yıkımını unutmamak için ilan edilen barış günüdür. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 1 Eylül Dünya Barış Günü Nasıl Kutlanır?
1. ''Yurtta sulh, cihanda sulh'' ilkesini hatırlayın ve savunun.
2. Çevrenizdeki anlaşmazlıkları diyalog ve empatiyle çözün.
3. Barış mesajları paylaşın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Savaşın kazananı, barışın kaybedeni olmaz. 1 Eylül Dünya Barış Günü''nde tüm dünyaya huzur diliyoruz. 🕊️🌍"
* "1 Eylül Dünya Barış Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #1Eylul #DunyaBarisGunu #YurttaSulhCihandaSulh"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-baris-gunu"', '2026-09-01', 9, 1, 'Farkındalık', ARRAY['#1Eylul','#DunyaBarisGunu','#YurttaSulhCihandaSulh','#Baris'], ARRAY['barış güvercini kolye','barış temalı tişört','felsefe ve barış kitapları']),
('f8b9a112-9844-48f8-b3f1-000000000094', 'dunya-yazilimcilar-gunu', '13 Eylül Dünya Yazılımcılar Günü', 'Yılın 256. gününde (2 üzeri 8) dijital dünyayı inşa eden tüm yazılım geliştiricileri onurlandıran gün.', '## 13 Eylül Dünya Yazılımcılar Günü Nedir?
1 baytın alabileceği farklı değer sayısı olan 256''ncı günde kutlanan uluslararası programcılar günüdür.

### Tarihçesi ve Önemi
1 baytın alabileceği farklı değer sayısı olan 256''ncı günde kutlanan uluslararası programcılar günüdür. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 13 Eylül Dünya Yazılımcılar Günü Nasıl Kutlanır?
1. Açık kaynak projelere katkıda bulunun.
2. Yeni bir programlama dili veya framework öğrenin.
3. Yazılımcı arkadaşınıza kahve ısmarlayın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "while(alive) { code(); coffee(); } 🚀 Sıfır hatalı commit''ler ve bugsız günler dileriz! 💻✨"
* "13 Eylül Dünya Yazılımcılar Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #YazilimcilarGunu #ProgrammersDay #Coding"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-yazilimcilar-gunu"', '2026-09-13', 9, 13, 'Mesleki', ARRAY['#YazilimcilarGunu','#ProgrammersDay','#Coding','#DeveloperLife','#256Day'], ARRAY['mekanik klavye rgb','ergonomik mouse','yazılımcı tişörtü','monitör standı']),
('f8b9a112-9844-48f8-b3f1-000000000095', 'dunya-alzheimer-gunu', '21 Eylül Dünya Alzheimer Günü', 'Alzheimer hastalığına ve demansa dikkat çekmek, hasta ve hasta yakınlarına destek olmak için kutlanır.', '## 21 Eylül Dünya Alzheimer Günü Nedir?
Dünya Sağlık Örgütü ve Uluslararası Alzheimer Birliği tarafından hafıza kaybı ve nörodejeneratif süreçler hakkında bilinç oluşturmak için düzenlenir.

### Tarihçesi ve Önemi
Dünya Sağlık Örgütü ve Uluslararası Alzheimer Birliği tarafından hafıza kaybı ve nörodejeneratif süreçler hakkında bilinç oluşturmak için düzenlenir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 21 Eylül Dünya Alzheimer Günü Nasıl Kutlanır?
1. Zihinsel aktiviteler ve bulmacalarla beyninizi zinde tutun.
2. Yaşlı aile bireylerinizle kaliteli zaman geçirin.
3. Alzheimer derneklerine destek olun.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Bizi biz yapan anılarımızdır. 21 Eylül Dünya Alzheimer Günü''nde sevdiklerimizi unutmayalım, yanlarında olalım. 🧠💜"
* "21 Eylül Dünya Alzheimer Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #AlzheimerGunu #Unutma #ErkenTeshis"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-alzheimer-gunu"', '2026-09-21', 9, 21, 'Sağlık', ARRAY['#AlzheimerGunu','#Unutma','#ErkenTeshis','#AlzheimerFarkindalik'], ARRAY['hafıza güçlendirme bulmaca kitabı','akıl oyunları seti yetişkin','akıllı saat gps yaşlı']),
('f8b9a112-9844-48f8-b3f1-000000000096', 'dunya-kuduz-gunu', '28 Eylül Dünya Kuduz Günü', 'Kuduz hastalığı konusunda farkındalık yaratmak ve aşının hayati önemini vurgulamak için kutlanır.', '## 28 Eylül Dünya Kuduz Günü Nedir?
Kuduz aşısını bulan Louis Pasteur''ün ölüm yıl dönümü olan 28 Eylül''de WHO ve GARC öncülüğünde düzenlenir.

### Tarihçesi ve Önemi
Kuduz aşısını bulan Louis Pasteur''ün ölüm yıl dönümü olan 28 Eylül''de WHO ve GARC öncülüğünde düzenlenir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 28 Eylül Dünya Kuduz Günü Nasıl Kutlanır?
1. Evcil hayvanlarınızın yıllık kuduz aşılarını aksatmayın.
2. Sokak hayvanlarının aşılanmasına destek olun.
3. Isırılma durumunda derhal hastaneye başvurun.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Aşı hayat kurtarır! 28 Eylül Dünya Kuduz Günü''nde can dostlarımızı koruyalım, kuduzu birlikte sıfırlayalım. 🐾💉"
* "28 Eylül Dünya Kuduz Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaKuduzGunu #KuduzFarkindaligi #AsiHayatKurtarir"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kuduz-gunu"', '2026-09-28', 9, 28, 'Sağlık', ARRAY['#DunyaKuduzGunu','#KuduzFarkindaligi','#AsiHayatKurtarir','#28Eylul'], ARRAY['kedi köpek taşıma çantası','köpek tasması ve künyesi','veteriner bakım seti']),
('f8b9a112-9844-48f8-b3f1-000000000097', 'bilgiye-evrensel-erisim-gunu', '28 Eylül Uluslararası Bilgiye Evrensel Erişim Günü', 'Bilginin serbestçe yayılması ve şeffaf toplumların inşası için UNESCO öncülüğünde kutlanır.', '## 28 Eylül Uluslararası Bilgiye Evrensel Erişim Günü Nedir?
Vatandaşların kamu bilgilerine erişim hakkını ve basın özgürlüğünü güvence altına almayı hedefler.

### Tarihçesi ve Önemi
Vatandaşların kamu bilgilerine erişim hakkını ve basın özgürlüğünü güvence altına almayı hedefler. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 28 Eylül Uluslararası Bilgiye Evrensel Erişim Günü Nasıl Kutlanır?
1. Açık kaynak kütüphaneleri ve veri setlerini keşfedin.
2. Dijital okuryazarlığı destekleyin.
3. Bilgiye erişim hakkını savunun.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Bilgi güçtür, özgürce erişildiğinde toplumu dönüştürür. 28 Eylül Bilgiye Evrensel Erişim Günü kutlu olsun! 📚🌐"
* "28 Eylül Uluslararası Bilgiye Evrensel Erişim Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #BilgiyeErisimGunu #UNESCO #AcikBilgi"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #bilgiye-evrensel-erisim-gunu"', '2026-09-28', 9, 28, 'Farkındalık', ARRAY['#BilgiyeErisimGunu','#UNESCO','#AcikBilgi','#DijitalHaklar'], ARRAY['e-kitap okuyucu','bilimsel kitaplar','hızlı okuma kitap seti']),
('f8b9a112-9844-48f8-b3f1-000000000098', 'dunya-kalp-gunu', '29 Eylül Dünya Kalp Günü', 'Kalp ve damar hastalıklarına karşı sağlıklı yaşam, beslenme ve egzersiz bilincini artıran küresel sağlık günü.', '## 29 Eylül Dünya Kalp Günü Nedir?
Dünya Kalp Federasyonu tarafından kardiyovasküler hastalıkların önlenmesine dikkat çekmek için kutlanır.

### Tarihçesi ve Önemi
Dünya Kalp Federasyonu tarafından kardiyovasküler hastalıkların önlenmesine dikkat çekmek için kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 29 Eylül Dünya Kalp Günü Nasıl Kutlanır?
1. Günde en az 30 dakika tempolu yürüyüş yapın.
2. Tuzu, şekeri ve doymuş yağları azaltın.
3. Sigarayı bırakın ve kalp kontrollerinizi yaptırın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Her atışında sevgi var, kalbini koru! 29 Eylül Dünya Kalp Günü kutlu olsun. ❤️🩺"
* "29 Eylül Dünya Kalp Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaKalpGunu #KalbiniKoru #WorldHeartDay"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kalp-gunu"', '2026-09-29', 9, 29, 'Sağlık', ARRAY['#DunyaKalpGunu','#KalbiniKoru','#WorldHeartDay','#SaglikliKalp'], ARRAY['akıllı saat nabız ölçer','kolesterol diyeti kitabı','koşu bandı ev tipi']),
('f8b9a112-9844-48f8-b3f1-000000000099', 'dunya-kahve-gunu', '1 Ekim Dünya Kahve Günü', 'Her yıl 1 Ekim''de kahve üreticilerinin emeğini ve dünyanın en sevilen içeceğinin lezzetini kutlayan gün.', '## 1 Ekim Dünya Kahve Günü Nedir?
Uluslararası Kahve Örgütü (ICO) tarafından 2015 yılında resmi olarak başlatılan küresel bir kutlama günüdür.

### Tarihçesi ve Önemi
Uluslararası Kahve Örgütü (ICO) tarafından 2015 yılında resmi olarak başlatılan küresel bir kutlama günüdür. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 1 Ekim Dünya Kahve Günü Nasıl Kutlanır?
1. V60, Chemex veya geleneksel Türk kahvesi demleyin.
2. Yerel bağımsız kahvecileri ziyaret edin.
3. İş arkadaşlarınızla kahve molası verin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Bir fincan kahvenin kırk yıl hatırı vardır, Dünya Kahve Günü kutlu olsun! ☕✨"
* "1 Ekim Dünya Kahve Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaKahveGunu #Kahve #CoffeeDay"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kahve-gunu"', '2026-10-01', 10, 1, 'Eğlence', ARRAY['#DunyaKahveGunu','#Kahve','#CoffeeDay','#KahveSever','#1Ekim'], ARRAY['filtre kahve makinesi','nitelikli çekirdek kahve','termos kupa','french press','chemex']),
('f8b9a112-9844-48f8-b3f1-000000000100', 'hayvanlari-koruma-gunu', '4 Ekim Hayvanları Koruma Günü', 'Tüm canlıların yaşam haklarına saygı duymak ve sokak hayvanlarının refahını artırmak amacıyla kutlanır.', '## 4 Ekim Hayvanları Koruma Günü Nedir?
1931 yılında Floransa''da çevre bilimcilerin girişimiyle tehlike altındaki türleri korumak için başlatılmıştır.

### Tarihçesi ve Önemi
1931 yılında Floransa''da çevre bilimcilerin girişimiyle tehlike altındaki türleri korumak için başlatılmıştır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 4 Ekim Hayvanları Koruma Günü Nasıl Kutlanır?
1. Bir kap su ve bir kap mama bırakın.
2. Barınakları ziyaret edip sahiplenmeyi değerlendirin.
3. Hayvan sevgisini çocuklara aşılayın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Onlar bize emanet! Dünyayı paylaştığımız tüm can dostlarımızın 4 Ekim Hayvanları Koruma Günü kutlu olsun. 🐶🐱🐦"
* "4 Ekim Hayvanları Koruma Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #4Ekim #HayvanlariKorumaGunu #SatinAlmaSahiplen"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #hayvanlari-koruma-gunu"', '2026-10-04', 10, 4, 'Çevre & Doğa', ARRAY['#4Ekim','#HayvanlariKorumaGunu','#SatinAlmaSahiplen','#CanDostlarimiz'], ARRAY['kedi maması 15kg','köpek maması premium','kuş yemi ve kafesi','otomatik su sebili pet']),
('f8b9a112-9844-48f8-b3f1-000000000101', 'dunya-ruh-sagligi-gunu', '10 Ekim Dünya Ruh Sağlığı Günü', 'Ruh sağlığının genel sağlığın ayrılmaz bir parçası olduğunu vurgulayan ve psikolojik desteği savunan gün.', '## 10 Ekim Dünya Ruh Sağlığı Günü Nedir?
Dünya Ruh Sağlığı Federasyonu tarafından ruh sağlığı sorunlarına yönelik damgalamayı kırmak amacıyla kutlanır.

### Tarihçesi ve Önemi
Dünya Ruh Sağlığı Federasyonu tarafından ruh sağlığı sorunlarına yönelik damgalamayı kırmak amacıyla kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 10 Ekim Dünya Ruh Sağlığı Günü Nasıl Kutlanır?
1. Kendi ruh halinizi dinleyin ve dinlenmeye vakit ayırın.
2. Bir yakınınızın halini hatırını içtenlikle sorun.
3. İhtiyaç duyduğunuzda profesyonel psikolojik destek alın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Zihnin de bedenin kadar özen ister. 10 Ekim Dünya Ruh Sağlığı Günü''nde kendine şefkat göster. 🧠💚"
* "10 Ekim Dünya Ruh Sağlığı Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #RuhSagligiGunu #WorldMentalHealthDay #YalnizDegilsin"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-ruh-sagligi-gunu"', '2026-10-10', 10, 10, 'Sağlık', ARRAY['#RuhSagligiGunu','#WorldMentalHealthDay','#YalnizDegilsin','#Psikoloji'], ARRAY['psikoloji kitapları çok satanlar','meditasyon minderi','aromaterapi difüzör']),
('f8b9a112-9844-48f8-b3f1-000000000102', 'dunya-kiz-cocuklari-gunu', '11 Ekim Dünya Kız Çocukları Günü', 'Kız çocuklarının eğitim, sağlık, eşitlik ve güçlendirilmesi haklarına dikkat çekmek için BM tarafından kutlanır.', '## 11 Ekim Dünya Kız Çocukları Günü Nedir?
2012 yılında Türkiye, Kanada ve Peru''nun öncülüğünde BM Genel Kurulu''nda kabul edilen küresel bir farkındalık günüdür.

### Tarihçesi ve Önemi
2012 yılında Türkiye, Kanada ve Peru''nun öncülüğünde BM Genel Kurulu''nda kabul edilen küresel bir farkındalık günüdür. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 11 Ekim Dünya Kız Çocukları Günü Nasıl Kutlanır?
1. Kız çocuklarının eğitimine destek veren burs fonlarına bağış yapın.
2. Kız çocuklarına hayallerinin peşinden gitme cesareti verin.
3. Cinsiyetçi kalıpları yıkın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Kız çocukları okursa dünya değişir! 11 Ekim Dünya Kız Çocukları Günü kutlu olsun. 👧📚✨"
* "11 Ekim Dünya Kız Çocukları Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #KizCocuklariGunu #DayOfTheGirl #GucluKizlar"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kiz-cocuklari-gunu"', '2026-10-11', 10, 11, 'Farkındalık', ARRAY['#KizCocuklariGunu','#DayOfTheGirl','#GucluKizlar','#EgitimHerkesIcin'], ARRAY['ilham veren kadınlar çocuk kitabı','bilim seti kız çocuk','kodlama oyuncakları']),
('f8b9a112-9844-48f8-b3f1-000000000103', 'cumhuriyet-bayrami', '29 Ekim Cumhuriyet Bayramı', 'Türkiye Cumhuriyeti''nin 1923 yılında Gazi Mustafa Kemal Atatürk tarafından ilan edildiği en büyük ulusal bayramımız.', '## 29 Ekim Cumhuriyet Bayramı Nedir?
29 Ekim 1923''te TBMM''de Cumhuriyet ilan edilmiş ve egemenlik kayıtsız şartsız millete teslim edilmiştir.

### Tarihçesi ve Önemi
29 Ekim 1923''te TBMM''de Cumhuriyet ilan edilmiş ve egemenlik kayıtsız şartsız millete teslim edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 29 Ekim Cumhuriyet Bayramı Nasıl Kutlanır?
1. Evlerinize ve caddelere Türk Bayrakları asın.
2. Törenlere, geçit alaylarına ve fener alaylarına katılın.
3. Cumhuriyet değerlerini ve Atatürk ilkelerini hatırlayın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Cumhuriyetimizin ışığında, Atamızın izinde daima ileriye! 29 Ekim Cumhuriyet Bayramımız kutlu olsun! 🇹🇷✨"
* "29 Ekim Cumhuriyet Bayramı kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #29Ekim #CumhuriyetBayrami #Ataturk"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #cumhuriyet-bayrami"', '2026-10-29', 10, 29, 'Resmi', ARRAY['#29Ekim','#CumhuriyetBayrami','#Ataturk','#Cumhuriyet103Yasinda','#Turkiye'], ARRAY['türk bayrağı büyük boy','atatürk rozeti','nutuk özel baskı','fener alayı meşalesi']),
('f8b9a112-9844-48f8-b3f1-000000000104', 'losemili-cocuklar-haftasi', '2-8 Kasım Lösemili Çocuklar Haftası', 'Lösemi hastalığı konusunda bilinç oluşturmak ve minik kahramanlara umut olmak amacıyla düzenlenen farkındalık haftası.', '## 2-8 Kasım Lösemili Çocuklar Haftası Nedir?
LÖSEV öncülüğünde löseminin önlenebilir ve tedavi edilebilir bir hastalık olduğunu anlatmak amacıyla kutlanır.

### Tarihçesi ve Önemi
LÖSEV öncülüğünde löseminin önlenebilir ve tedavi edilebilir bir hastalık olduğunu anlatmak amacıyla kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 2-8 Kasım Lösemili Çocuklar Haftası Nasıl Kutlanır?
1. Maske takarak sosyal medyada farkındalık fotoğrafları paylaşın.
2. LÖSEV''e bağışta bulunun.
3. Lösemi tedavisi gören çocuklara sevgi ve moral gönderin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Maskemizi takıyoruz, minik kahramanlarımızın yanındayız! Lösemili Çocuklar Haftası kutlu olsun. 🧡🎗️"
* "2-8 Kasım Lösemili Çocuklar Haftası kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #LosemiliCocuklarHaftasi #MaskemiTakarimFarkindalikYaratirim #LÖSEV"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #losemili-cocuklar-haftasi"', '2026-11-02', 11, 2, 'Sağlık', ARRAY['#LosemiliCocuklarHaftasi','#MaskemiTakarimFarkindalikYaratirim','#LÖSEV','#Umut'], ARRAY['lösev hediyelik eşya','renkli maske seti','çocuk boyama seti']),
('f8b9a112-9844-48f8-b3f1-000000000105', 'ataturku-anma-gunu', '10 Kasım Atatürk''ü Anma Günü', 'Türkiye Cumhuriyeti''nin kurucusu Gazi Mustafa Kemal Atatürk''ün ebediyete intikalinin yıl dönümü ve anma günü.', '## 10 Kasım Atatürk''ü Anma Günü Nedir?
10 Kasım 1938 günü saat 09:05''te Dolmabahçe Sarayı''nda vefat eden Atatürk''ün anısına her yıl ulusal saygı duruşuyla icra edilir.

### Tarihçesi ve Önemi
10 Kasım 1938 günü saat 09:05''te Dolmabahçe Sarayı''nda vefat eden Atatürk''ün anısına her yıl ulusal saygı duruşuyla icra edilir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 10 Kasım Atatürk''ü Anma Günü Nasıl Kutlanır?
1. Saat 09:05''te sirenler eşliğinde 2 dakikalık saygı duruşunda bulunun.
2. Anıtkabir''i ve Atatürk müzelerini ziyaret edin.
3. Onun fikirlerini ve mirasını okuyun.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Beni görmek demek mutlaka yüzümü görmek değildir. Fikirlerimi anlıyorsanız bu kafidir. Saygı, sevgi ve özlemle anıyoruz. 🇹🇷🖤"
* "10 Kasım Atatürk''ü Anma Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #10Kasim #Ataturk #SaygiVeOzlemle"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #ataturku-anma-gunu"', '2026-11-10', 11, 10, 'Resmi', ARRAY['#10Kasim','#Ataturk','#SaygiVeOzlemle','#0905','#Turkiye'], ARRAY['atatürk portresi çerçeveli','atatürk biyografi kitabı','atatürk imzalı kupa','nutuk ciltli']),
('f8b9a112-9844-48f8-b3f1-000000000106', 'dunya-diyabet-gunu', '14 Kasım Dünya Diyabet Günü', 'İnsülinin kaşifi Frederick Banting''in doğum gününde diyabet hastalığı ve dengeli beslenme bilincini artıran gün.', '## 14 Kasım Dünya Diyabet Günü Nedir?
Uluslararası Diyabet Federasyonu ve DSÖ tarafından artan şeker hastalığı riskine karşı ''Mavi Halka'' sembolüyle kutlanır.

### Tarihçesi ve Önemi
Uluslararası Diyabet Federasyonu ve DSÖ tarafından artan şeker hastalığı riskine karşı ''Mavi Halka'' sembolüyle kutlanır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 14 Kasım Dünya Diyabet Günü Nasıl Kutlanır?
1. Kan şekeri ölçümünüzü ve HbA1c testinizi yaptırın.
2. Şekerli ve işlenmiş gıdalardan uzak durun.
3. Günlük hareketinizi artırın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Farkında ol, kontrol sende olsun! 14 Kasım Dünya Diyabet Günü''nde sağlıklı yaşamı seçelim. 🔵🩺"
* "14 Kasım Dünya Diyabet Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DiyabetGunu #MaviHalka #SekerHastaligi"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-diyabet-gunu"', '2026-11-14', 11, 14, 'Sağlık', ARRAY['#DiyabetGunu','#MaviHalka','#SekerHastaligi','#DengeliBeslen'], ARRAY['şeker ölçüm cihazı stripli','şekersiz tatlandırıcı','diyabet tarifleri kitabı']),
('f8b9a112-9844-48f8-b3f1-000000000107', 'dunya-cocuk-haklari-gunu', '20 Kasım Dünya Çocuk Hakları Günü', 'BM Çocuk Haklarına Dair Sözleşme''nin kabul edildiği gün, her çocuğun sağlık, eğitim ve korunma hakkını savunur.', '## 20 Kasım Dünya Çocuk Hakları Günü Nedir?
20 Kasım 1989''da Birleşmiş Milletler Genel Kurulu tarafından Çocuk Hakları Sözleşmesi oy birliğiyle kabul edilmiştir.

### Tarihçesi ve Önemi
20 Kasım 1989''da Birleşmiş Milletler Genel Kurulu tarafından Çocuk Hakları Sözleşmesi oy birliğiyle kabul edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 20 Kasım Dünya Çocuk Hakları Günü Nasıl Kutlanır?
1. Çocukların sesini dinleyin ve fikirlerine saygı gösterin.
2. Çocuk istismarı ve çocuk işçiliğine karşı ses çıkarın.
3. Çocuk koruma derneklerine destek verin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Bütün çocuklar sevgi dolu ve eşit bir dünyayı hak eder! 20 Kasım Dünya Çocuk Hakları Günü kutlu olsun. 🧒🎈👧"
* "20 Kasım Dünya Çocuk Hakları Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #CocukHaklariGunu #HerCocukIcinHaklar #UNICEF"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-cocuk-haklari-gunu"', '2026-11-20', 11, 20, 'Farkındalık', ARRAY['#CocukHaklariGunu','#HerCocukIcinHaklar','#UNICEF','#Gelecegimiz'], ARRAY['çocuk hakları resimli kitap','eğitici kutu oyunları','çocuk gelişim kitapları']),
('f8b9a112-9844-48f8-b3f1-000000000108', 'dis-hekimleri-gunu', '22 Kasım Diş Hekimleri Günü', 'Türkiye''de ilk Dişçi Mektebi''nin kuruluş yıl dönümünde ağız ve diş sağlığı kahramanlarına adanan gün.', '## 22 Kasım Diş Hekimleri Günü Nedir?
22 Kasım 1908''de Dişçi Mekteb-i Aliyesi kurulmuş ve bu hafta Ağız Diş Sağlığı Haftası olarak kutlanmaya başlanmıştır.

### Tarihçesi ve Önemi
22 Kasım 1908''de Dişçi Mekteb-i Aliyesi kurulmuş ve bu hafta Ağız Diş Sağlığı Haftası olarak kutlanmaya başlanmıştır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 22 Kasım Diş Hekimleri Günü Nasıl Kutlanır?
1. 6 aylık rutin diş hekimi kontrolünüzü yaptırın.
2. Günde 2 kez dişlerinizi fırçalayın ve diş ipi kullanın.
3. Diş hekiminize teşekkür edin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Sağlıklı gülüşlerimizin mimarı diş hekimlerimizin 22 Kasım Diş Hekimleri Günü kutlu olsun! 🦷🪥"
* "22 Kasım Diş Hekimleri Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DisHekimleriGunu #AgizVeDisSagligi #Gulumse"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dis-hekimleri-gunu"', '2026-11-22', 11, 22, 'Sağlık', ARRAY['#DisHekimleriGunu','#AgizVeDisSagligi','#Gulumse','#DisHekimi'], ARRAY['şarjlı diş fırçası','ağız duşu cihazı','diş hekimi esprili kupa','diş ipi seti']),
('f8b9a112-9844-48f8-b3f1-000000000109', 'ogretmenler-gunu', '24 Kasım Öğretmenler Günü', 'Mustafa Kemal Atatürk''ün Millet Mektepleri Başöğretmenliği unvanını kabul ettiği günün anısına kutlanır.', '## 24 Kasım Öğretmenler Günü Nedir?
24 Kasım 1928''de Atatürk Başöğretmen unvanını kabul etmiş, 1981''den bu yana Türkiye''de Öğretmenler Günü olarak kutlanmaktadır.

### Tarihçesi ve Önemi
24 Kasım 1928''de Atatürk Başöğretmen unvanını kabul etmiş, 1981''den bu yana Türkiye''de Öğretmenler Günü olarak kutlanmaktadır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 24 Kasım Öğretmenler Günü Nasıl Kutlanır?
1. Öğretmenlerinizi arayıp vefa ve teşekkürlerinizi iletin.
2. Emekli öğretmenleri ziyaret edin.
3. Eğitime katkı sağlayan projelere destek verin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Geleceğimizin mimarı fedakar öğretmenlerimizin 24 Kasım Öğretmenler Günü kutlu olsun! 💐🧑‍🏫"
* "24 Kasım Öğretmenler Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #24Kasim #OgretmenlerGunu #Basogretmen"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #ogretmenler-gunu"', '2026-11-24', 11, 24, 'Mesleki', ARRAY['#24Kasim','#OgretmenlerGunu','#Basogretmen','#CanimOgretmenim'], ARRAY['isme özel öğretmen dolma kalemi','öğretmenler günü hediye kutusu','çiçek buketi','deri ajanda']),
('f8b9a112-9844-48f8-b3f1-000000000110', 'dunya-engelliler-gunu', '3 Aralık Dünya Engelliler Günü', 'Engelli bireylerin haklarına, toplumsal hayata tam katılımlarına ve erişilebilirliğe dikkat çeken BM günü.', '## 3 Aralık Dünya Engelliler Günü Nedir?
1992 yılında BM Genel Kurulu tarafından engellilerin haklarını savunmak ve farkındalık yaratmak amacıyla ilan edilmiştir.

### Tarihçesi ve Önemi
1992 yılında BM Genel Kurulu tarafından engellilerin haklarını savunmak ve farkındalık yaratmak amacıyla ilan edilmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 3 Aralık Dünya Engelliler Günü Nasıl Kutlanır?
1. Şehirlerimizin ve binalarımızın engelsiz ve erişilebilir olmasını talep edin.
2. Engelli otoparklarına ve rampalarına araç park etmeyin.
3. Sevgi ve empatiyle engelleri birlikte kaldırın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "En büyük engel sevgisizliktir. 3 Aralık Dünya Engelliler Günü''nde engelleri sevgi ve dayanışmayla aşıyoruz! ♿🤝💛"
* "3 Aralık Dünya Engelliler Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #3Aralik #DunyaEngellilerGunu #SevgiVarsaEngelYok"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-engelliler-gunu"', '2026-12-03', 12, 3, 'Farkındalık', ARRAY['#3Aralik','#DunyaEngellilerGunu','#SevgiVarsaEngelYok','#Erisilebilirlik'], ARRAY['tekerlekli sandalye minderi','ergonomik tutacak seti','sesli uyarı cihazı']),
('f8b9a112-9844-48f8-b3f1-000000000111', 'dunya-turk-kahvesi-gunu', '5 Aralık Dünya Türk Kahvesi Günü', 'UNESCO tarafından Somut Olmayan Kültürel Miras listesine alınan Türk Kahvesi kültürünün küresel kutlaması.', '## 5 Aralık Dünya Türk Kahvesi Günü Nedir?
5 Aralık 2013''te UNESCO, Türk Kahvesi Kültürü ve Geleneği''ni İnsanlığın Somut Olmayan Kültürel Mirası Temsili Listesi''ne kaydetmiştir.

### Tarihçesi ve Önemi
5 Aralık 2013''te UNESCO, Türk Kahvesi Kültürü ve Geleneği''ni İnsanlığın Somut Olmayan Kültürel Mirası Temsili Listesi''ne kaydetmiştir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 5 Aralık Dünya Türk Kahvesi Günü Nasıl Kutlanır?
1. Bakır cezvede bol köpüklü okkalı bir Türk kahvesi pişirin.
2. Yanında lokum ve bir bardak su ile geleneksel sunum yapın.
3. Sevdiklerinizle kırk yıllık hatır sohbeti edin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Gönül ne kahve ister ne kahvehane, gönül sohbet ister kahve bahane. 5 Aralık Dünya Türk Kahvesi Günü kutlu olsun! ☕🇹🇷"
* "5 Aralık Dünya Türk Kahvesi Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaTurkKahvesiGunu #TurkKahvesi #UNESCO"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-turk-kahvesi-gunu"', '2026-12-05', 12, 5, 'Kültür & Sanat', ARRAY['#DunyaTurkKahvesiGunu','#TurkKahvesi','#UNESCO','#KahveKulturu'], ARRAY['otomatik türk kahvesi makinesi','bakır cezve seti','türk kahvesi fincan takımı','hacı bekir lokumu']),
('f8b9a112-9844-48f8-b3f1-000000000112', 'dunya-kadin-haklari-gunu', '5 Aralık Dünya Kadın Hakları Günü', 'Türk kadınlarına seçme ve seçilme hakkının birçok Avrupa ülkesinden önce verildiği tarihi gün.', '## 5 Aralık Dünya Kadın Hakları Günü Nedir?
5 Aralık 1934''te Gazi Mustafa Kemal Atatürk''ün önderliğinde Türk kadınlarına milletvekili seçme ve seçilme hakkı tanınmıştır.

### Tarihçesi ve Önemi
5 Aralık 1934''te Gazi Mustafa Kemal Atatürk''ün önderliğinde Türk kadınlarına milletvekili seçme ve seçilme hakkı tanınmıştır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 5 Aralık Dünya Kadın Hakları Günü Nasıl Kutlanır?
1. Kadınların siyasette ve yönetimde eşit temsilini savunun.
2. Atatürk''ün kadın haklarına verdiği önemi hatırlayın.
3. Kadınların başarılarını kutlayın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Dünyada hiçbir milletin kadını ''Ben Anadolu kadınından daha fazla çalıştım'' diyemez. 5 Aralık Kadın Hakları Günü kutlu olsun! 🇹🇷👩‍💼"
* "5 Aralık Dünya Kadın Hakları Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #5Aralik #KadinHaklariGunu #SecmeVeSecilmeHakki"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kadin-haklari-gunu"', '2026-12-05', 12, 5, 'Farkındalık', ARRAY['#5Aralik','#KadinHaklariGunu','#SecmeVeSecilmeHakki','#Ataturk'], ARRAY['kadın liderler biyografi kitabı','özel tasarım takı seti','fular ipek']),
('f8b9a112-9844-48f8-b3f1-000000000113', 'dunya-insan-haklari-gunu', '10 Aralık Dünya İnsan Hakları Günü', '1948 yılında BM İnsan Hakları Evrensel Beyannamesi''nin kabul edildiği, temel hak ve özgürlüklerin günü.', '## 10 Aralık Dünya İnsan Hakları Günü Nedir?
Tüm insanların özgür, eşit ve onurlu doğduğunu dünyaya ilan eden İnsan Hakları Evrensel Beyannamesi''nin kabul günüdür.

### Tarihçesi ve Önemi
Tüm insanların özgür, eşit ve onurlu doğduğunu dünyaya ilan eden İnsan Hakları Evrensel Beyannamesi''nin kabul günüdür. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 10 Aralık Dünya İnsan Hakları Günü Nasıl Kutlanır?
1. İnsan Hakları Evrensel Beyannamesi''nin maddelerini okuyun.
2. Ayrımcılığa ve adaletsizliğe karşı ses çıkarın.
3. İnsan hakları savunucularını destekleyin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Bütün insanlar hür, haysiyet ve haklar bakımından eşit doğarlar. 10 Aralık İnsan Hakları Günü kutlu olsun! ⚖️🕊️"
* "10 Aralık Dünya İnsan Hakları Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #10Aralik #InsanHaklariGunu #HumanRightsDay"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-insan-haklari-gunu"', '2026-12-10', 12, 10, 'Farkındalık', ARRAY['#10Aralik','#InsanHaklariGunu','#HumanRightsDay','#Esitlik'], ARRAY['insan hakları evrensel beyannamesi kitap','felsefe ve etik kitapları']),
('f8b9a112-9844-48f8-b3f1-000000000114', 'en-uzun-gece', '21 Aralık En Uzun Gece (Kış Gündönümü)', 'Kuzey yarımkürede yılın en uzun gecesinin yaşandığı ve kış mevsiminin astronomik olarak başladığı gün.', '## 21 Aralık En Uzun Gece (Kış Gündönümü) Nedir?
Kuzey yarımkürede Güneş ışınlarının Oğlak Dönencesi''ne dik geldiği, en uzun gecenin ve en kısa gündüzün yaşandığı doğa olayıdır.

### Tarihçesi ve Önemi
Kuzey yarımkürede Güneş ışınlarının Oğlak Dönencesi''ne dik geldiği, en uzun gecenin ve en kısa gündüzün yaşandığı doğa olayıdır. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 21 Aralık En Uzun Gece (Kış Gündönümü) Nasıl Kutlanır?
1. Sıcak çikolatanızı veya kahvenizi alıp sevdiklerinizle uzun bir film maratonu yapın.
2. Kitap okuyarak gecenin sessizliğinin tadını çıkarın.
3. Gece yürüyüşü yapıp kış havasını hissedin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "En uzun gece bile yerini aydınlık bir sabaha bırakır! 21 Aralık Kış Gündönümü kutlu ve huzurlu olsun. 🌙❄️⭐"
* "21 Aralık En Uzun Gece (Kış Gündönümü) kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #21Aralik #EnUzunGece #KisGundonumu"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #en-uzun-gece"', '2026-12-21', 12, 21, 'Eğlence', ARRAY['#21Aralik','#EnUzunGece','#KisGundonumu','#Gece'], ARRAY['kokulu mum seti','polar battaniye','film izleme projeksiyon','termos kupa']),
('f8b9a112-9844-48f8-b3f1-000000000115', 'yilbasi-gecesi', '31 Aralık Yılbaşı Gecesi', 'Bir yılın son anlarını geride bırakıp yeni umutlarla gelecek yıla adım atılan tüm dünyada coşkuyla kutlanan gece.', '## 31 Aralık Yılbaşı Gecesi Nedir?
Eski yılı uğurlayıp yeni yılın ilk dakikalarını karşılamak için aile ve dostlarla bir araya gelinen evrensel kutlama gecesidir.

### Tarihçesi ve Önemi
Eski yılı uğurlayıp yeni yılın ilk dakikalarını karşılamak için aile ve dostlarla bir araya gelinen evrensel kutlama gecesidir. Bu özel gün gerek Türkiye''de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## 31 Aralık Yılbaşı Gecesi Nasıl Kutlanır?
1. Sevdiklerinizle zengin bir yılbaşı sofrasında toplanın.
2. Geçen yılın anılarını yad edin ve geleceğe dilekler tutun.
3. Geri sayımla yeni yılı coşkuyla karşılayın.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Giden yıl tüm yorgunlukları alsın, gelen yıl tüm hayallerinizi gerçekleştirsin! Yılbaşı geceniz kutlu olsun! 🎆🥂✨"
* "31 Aralık Yılbaşı Gecesi kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #YilbasiGecesi #GuleGule2026 #YeniYilKutlamasi"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #yilbasi-gecesi"', '2026-12-31', 12, 31, 'Eğlence', ARRAY['#YilbasiGecesi','#GuleGule2026','#YeniYilKutlamasi','#31Aralik'], ARRAY['yılbaşı çam ağacı süsü','parti kutlama şapkası','kutu masa oyunu','ışıklı peri led']);
