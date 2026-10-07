-- ========================================================
-- Bugün Ne Günü? (Special Days Directory)
-- Complete Database Schema with Full 365 Days Archive (378 Entries)
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
    day_type TEXT DEFAULT 'kutlama',
    is_public_holiday BOOLEAN DEFAULT false,
    scope TEXT DEFAULT 'turkiye',
    source_name TEXT,
    source_url TEXT,
    verified_at DATE,
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

-- SEED DATA (378 Special Days covering 365 days of the year)
INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'yilbasi', '1 Ocak Yılbaşı', 'Yeni bir yılın başlangıcını simgeleyen ve tüm dünyada umutla kutlanan resmi tatil günü.', '## 1 Ocak Yılbaşı Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #yilbasi"', '2026-01-01', 1, 1, 'Resmi', 'kutlama', false, 'turkiye', '', '', ARRAY['#Yilbasi', '#YeniYil', '#Hosgeldin2026', '#MutluYillar'], ARRAY['yılbaşı hediyesi', 'yeni yıl ajandası', 'kutu kutlama oyunu', 'kar küresi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '2-ocak-dunya-bilimkurgu-gunu', '2 Ocak Dünya Bilimkurgu Günü', 'Isaac Asimov anısına geleceğin bilimsel hayallerini ve edebiyatını kutlama günü.', '## 2 Ocak Dünya Bilimkurgu Günü Nedir?
Isaac Asimov anısına geleceğin bilimsel hayallerini ve edebiyatını kutlama günü.

### Tarihçesi ve Önemi
2 Ocak Dünya Bilimkurgu Günü, gerek Türkiye''de gerekse uluslararası alanda Science Fiction Writers nezdinde tanınan ve her yıl 2 Ocak tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "2 Ocak Dünya Bilimkurgu Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "2 Ocak günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-01-02', 1, 2, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'Science Fiction Writers', 'https://www.sfwa.org', ARRAY['#2Ocak', '#2ocakdunyabilimkurgugunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '3-ocak-uluslararasi-zihin-beden-sagligi-gunu', '3 Ocak Uluslararası Zihin-Beden Sağlığı Günü', 'Bütüncül sağlık, zihinsel dinginlik ve dengeli yaşam farkındalığı günü.', '## 3 Ocak Uluslararası Zihin-Beden Sağlığı Günü Nedir?
Bütüncül sağlık, zihinsel dinginlik ve dengeli yaşam farkındalığı günü.

### Tarihçesi ve Önemi
3 Ocak Uluslararası Zihin-Beden Sağlığı Günü, gerek Türkiye''de gerekse uluslararası alanda Mind-Body Coalition nezdinde tanınan ve her yıl 3 Ocak tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "3 Ocak Uluslararası Zihin-Beden Sağlığı Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "3 Ocak günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-01-03', 1, 3, 'Sağlık', 'farkindalik', false, 'uluslararasi', 'Mind-Body Coalition', 'https://www.who.int', ARRAY['#3Ocak', '#3ocakuluslararasizihinbedensagligigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-braille-gunu', '4 Ocak Dünya Braille Günü', 'Görme engellilerin okuma yazmasını sağlayan kabartma Braille alfabesinin mucidi Louis Braille anısına kutlanır.', '## 4 Ocak Dünya Braille Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-braille-gunu"', '2026-01-04', 1, 4, 'Farkındalık', 'kutlama', false, 'turkiye', '', '', ARRAY['#BrailleGunu', '#GormeEngelliler', '#Erisilebilirlik', '#Farkindalik'], ARRAY['braille alfabesi kabartma tablet', 'sesli kitap aboneliği', 'akıllı baston', 'kabartmalı saat']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '5-ocak-ulusal-kuslari-koruma-gunu', '5 Ocak Ulusal Kuşları Koruma Günü', 'Kuş türlerinin doğal yaşam alanlarını koruma ve göç yollarını güvenceye alma günü.', '## 5 Ocak Ulusal Kuşları Koruma Günü Nedir?
Kuş türlerinin doğal yaşam alanlarını koruma ve göç yollarını güvenceye alma günü.

### Tarihçesi ve Önemi
5 Ocak Ulusal Kuşları Koruma Günü, gerek Türkiye''de gerekse uluslararası alanda Avian Welfare Coalition nezdinde tanınan ve her yıl 5 Ocak tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "5 Ocak Ulusal Kuşları Koruma Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "5 Ocak günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-01-05', 1, 5, 'Çevre & Doğa', 'farkindalik', false, 'uluslararasi', 'Avian Welfare Coalition', 'https://www.birdday.org', ARRAY['#5Ocak', '#5ocakulusalkuslarikorumagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '6-ocak-dunya-savas-yetimleri-gunu', '6 Ocak Dünya Savaş Yetimleri Günü', 'Savaşların mağdur ettiği öksüz ve yetim çocukların haklarını ve bakımını hatırlatan gün.', '## 6 Ocak Dünya Savaş Yetimleri Günü Nedir?
Savaşların mağdur ettiği öksüz ve yetim çocukların haklarını ve bakımını hatırlatan gün.

### Tarihçesi ve Önemi
6 Ocak Dünya Savaş Yetimleri Günü, gerek Türkiye''de gerekse uluslararası alanda SOS Enfants en Detresse & UNICEF nezdinde tanınan ve her yıl 6 Ocak tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "6 Ocak Dünya Savaş Yetimleri Günü vesilesiyle saygı ve hürmetle anıyoruz."
* "6 Ocak günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-01-06', 1, 6, 'Farkındalık', 'anma', false, 'uluslararasi', 'SOS Enfants en Detresse & UNICEF', 'https://www.unicef.org', ARRAY['#6Ocak', '#6ocakdunyasavasyetimlerigunu'], ARRAY[]
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '7-ocak-uluslararasi-programcilar-gunu', '7 Ocak Uluslararası Programcılar Günü', 'Dijital altyapımızı inşa eden yazılımcıların ve mühendislerin emeklerini kutlama günü.', '## 7 Ocak Uluslararası Programcılar Günü Nedir?
Dijital altyapımızı inşa eden yazılımcıların ve mühendislerin emeklerini kutlama günü.

### Tarihçesi ve Önemi
7 Ocak Uluslararası Programcılar Günü, gerek Türkiye''de gerekse uluslararası alanda Tech Observances nezdinde tanınan ve her yıl 7 Ocak tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "7 Ocak Uluslararası Programcılar Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "7 Ocak günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-01-07', 1, 7, 'Mesleki', 'kutlama', false, 'uluslararasi', 'Tech Observances', 'https://www.ieee.org', ARRAY['#7Ocak', '#7ocakuluslararasiprogramcilargunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '8-ocak-dunya-yazi-yazma-ve-daktilo-gunu', '8 Ocak Dünya Yazı Yazma ve Daktilo Günü', 'El yazısı, mektup ve yaratıcı metin üretmenin değerini anımsatan edebi gün.', '## 8 Ocak Dünya Yazı Yazma ve Daktilo Günü Nedir?
El yazısı, mektup ve yaratıcı metin üretmenin değerini anımsatan edebi gün.

### Tarihçesi ve Önemi
8 Ocak Dünya Yazı Yazma ve Daktilo Günü, gerek Türkiye''de gerekse uluslararası alanda Literary Guild nezdinde tanınan ve her yıl 8 Ocak tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "8 Ocak Dünya Yazı Yazma ve Daktilo Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "8 Ocak günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-01-08', 1, 8, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'Literary Guild', 'https://www.unesco.org', ARRAY['#8Ocak', '#8ocakdunyayaziyazmavedaktilogunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '9-ocak-dunya-statik-elektrik-gunu', '9 Ocak Dünya Statik Elektrik Günü', 'Doğadaki elektrostatik olayları ve bilimin eğlenceli yönlerini keşfetme günü.', '## 9 Ocak Dünya Statik Elektrik Günü Nedir?
Doğadaki elektrostatik olayları ve bilimin eğlenceli yönlerini keşfetme günü.

### Tarihçesi ve Önemi
9 Ocak Dünya Statik Elektrik Günü, gerek Türkiye''de gerekse uluslararası alanda Physics Guild nezdinde tanınan ve her yıl 9 Ocak tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "9 Ocak Dünya Statik Elektrik Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "9 Ocak günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-01-09', 1, 9, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Physics Guild', 'https://www.aps.org', ARRAY['#9Ocak', '#9ocakdunyastatikelektrikgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'calisan-gazeteciler-gunu', '10 Ocak Çalışan Gazeteciler Günü', 'Basın emekçilerinin haklarını güvence altına alan 212 sayılı yasanın kabul edildiği günün anısına kutlanır.', '## 10 Ocak Çalışan Gazeteciler Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #calisan-gazeteciler-gunu"', '2026-01-10', 1, 10, 'Mesleki', 'kutlama', false, 'turkiye', '', '', ARRAY['#CalisanGazetecilerGunu', '#10Ocak', '#BasinEmekcileri', '#OzgurBasin'], ARRAY['ses kayıt cihazı profesyonel', 'gazeteci çantası', 'fotoğraf makinesi tripodu', 'not defteri deri']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '11-ocak-uluslararasi-tesekkur-gunu', '11 Ocak Uluslararası Teşekkür Günü', 'Hayatımızdaki sevdiklerimize şükran ve teşekkürlerimizi samimiyetle ifade etme günü.', '## 11 Ocak Uluslararası Teşekkür Günü Nedir?
Hayatımızdaki sevdiklerimize şükran ve teşekkürlerimizi samimiyetle ifade etme günü.

### Tarihçesi ve Önemi
11 Ocak Uluslararası Teşekkür Günü, gerek Türkiye''de gerekse uluslararası alanda Kindness Coalition nezdinde tanınan ve her yıl 11 Ocak tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "11 Ocak Uluslararası Teşekkür Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "11 Ocak günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-01-11', 1, 11, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Kindness Coalition', 'https://www.un.org', ARRAY['#11Ocak', '#11ocakuluslararasitesekkurgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '12-ocak-dunya-eczacilik-egitimi-gunu', '12 Ocak Dünya Eczacılık Eğitimi Günü', 'Sağlık zincirinin en güvenilir danışmanı olan eczacıların mesleki standartları günü.', '## 12 Ocak Dünya Eczacılık Eğitimi Günü Nedir?
Sağlık zincirinin en güvenilir danışmanı olan eczacıların mesleki standartları günü.

### Tarihçesi ve Önemi
12 Ocak Dünya Eczacılık Eğitimi Günü, gerek Türkiye''de gerekse uluslararası alanda FIP Eczacılık Federasyonu nezdinde tanınan ve her yıl 12 Ocak tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "12 Ocak Dünya Eczacılık Eğitimi Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "12 Ocak günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-01-12', 1, 12, 'Mesleki', 'farkindalik', false, 'uluslararasi', 'FIP Eczacılık Federasyonu', 'https://www.fip.org', ARRAY['#12Ocak', '#12ocakdunyaeczacilikegitimigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '13-ocak-hayalleri-gerceklestirme-gunu', '13 Ocak Hayalleri Gerçekleştirme Günü', 'Yılın başında kurulan hayalleri eyleme ve somut başarılara dönüştürme günü.', '## 13 Ocak Hayalleri Gerçekleştirme Günü Nedir?
Yılın başında kurulan hayalleri eyleme ve somut başarılara dönüştürme günü.

### Tarihçesi ve Önemi
13 Ocak Hayalleri Gerçekleştirme Günü, gerek Türkiye''de gerekse uluslararası alanda Motivational Observances nezdinde tanınan ve her yıl 13 Ocak tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "13 Ocak Hayalleri Gerçekleştirme Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "13 Ocak günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-01-13', 1, 13, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Motivational Observances', 'https://www.unesco.org', ARRAY['#13Ocak', '#13ocakhayallerigerceklestirmegunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '14-ocak-dunya-mantik-gunu', '14 Ocak Dünya Mantık Günü', 'Rasyonel düşünce, matematik ve felsefenin insan gelişimindeki rolünü kutlayan gün.', '## 14 Ocak Dünya Mantık Günü Nedir?
Rasyonel düşünce, matematik ve felsefenin insan gelişimindeki rolünü kutlayan gün.

### Tarihçesi ve Önemi
14 Ocak Dünya Mantık Günü, gerek Türkiye''de gerekse uluslararası alanda UNESCO (40 C/Resolution 36) nezdinde tanınan ve her yıl 14 Ocak tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "14 Ocak Dünya Mantık Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "14 Ocak günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-01-14', 1, 14, 'Kültür & Sanat', 'farkindalik', false, 'bm', 'UNESCO (40 C/Resolution 36)', 'https://www.unesco.org/en/days/world-logic-day', ARRAY['#14Ocak', '#14ocakdunyamantikgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '15-ocak-wikipedia-gunu', '15 Ocak Wikipedia Günü', 'İnsanlığın ortak bilgi hazinesi olan açık kaynak ansiklopedinin kuruluş yıldönümü.', '## 15 Ocak Wikipedia Günü Nedir?
İnsanlığın ortak bilgi hazinesi olan açık kaynak ansiklopedinin kuruluş yıldönümü.

### Tarihçesi ve Önemi
15 Ocak Wikipedia Günü, gerek Türkiye''de gerekse uluslararası alanda Wikimedia Foundation nezdinde tanınan ve her yıl 15 Ocak tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "15 Ocak Wikipedia Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "15 Ocak günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-01-15', 1, 15, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'Wikimedia Foundation', 'https://www.wikimedia.org', ARRAY['#15Ocak', '#15ocakwikipediagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-hijyen-gunu', '16 Ocak Dünya Hijyen Günü', 'Kişisel temizlik, el yıkama ve halk sağlığını koruma alışkanlıklarını hatırlatan gün.', '## 16 Ocak Dünya Hijyen Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-hijyen-gunu"', '2026-01-16', 1, 16, 'Sağlık', 'kutlama', false, 'turkiye', '', '', ARRAY['#HijyenGunu', '#ElYikama', '#Temizlik', '#HalkSagligi'], ARRAY['otomatik sabunluk sensörlü', 'antibakteriyel el dezenfektanı', 'bambu banyo havlusu']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '17-ocak-cocuk-mucitler-gunu', '17 Ocak Çocuk Mucitler Günü', 'Çocukların bilimsel merakını, icat yeteneğini ve girişimcilik ruhunu destekleyen gün.', '## 17 Ocak Çocuk Mucitler Günü Nedir?
Çocukların bilimsel merakını, icat yeteneğini ve girişimcilik ruhunu destekleyen gün.

### Tarihçesi ve Önemi
17 Ocak Çocuk Mucitler Günü, gerek Türkiye''de gerekse uluslararası alanda Kid Inventors Association nezdinde tanınan ve her yıl 17 Ocak tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "17 Ocak Çocuk Mucitler Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "17 Ocak günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-01-17', 1, 17, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'Kid Inventors Association', 'https://www.wipo.int', ARRAY['#17Ocak', '#17ocakcocukmucitlergunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '18-ocak-dunya-dinler-arasi-hosgoru-gunu', '18 Ocak Dünya Dinler Arası Hoşgörü Günü', 'Farklı inanç ve kültürler arasında kardeşlik ve saygıyı yücelten küresel gün.', '## 18 Ocak Dünya Dinler Arası Hoşgörü Günü Nedir?
Farklı inanç ve kültürler arasında kardeşlik ve saygıyı yücelten küresel gün.

### Tarihçesi ve Önemi
18 Ocak Dünya Dinler Arası Hoşgörü Günü, gerek Türkiye''de gerekse uluslararası alanda Interfaith Council nezdinde tanınan ve her yıl 18 Ocak tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "18 Ocak Dünya Dinler Arası Hoşgörü Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "18 Ocak günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-01-18', 1, 18, 'Farkındalık', 'farkindalik', false, 'uluslararasi', 'Interfaith Council', 'https://www.un.org', ARRAY['#18Ocak', '#18ocakdunyadinlerarasihosgorugunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '19-ocak-dunya-patlamis-misir-gunu', '19 Ocak Dünya Patlamış Mısır Günü', 'Sinema ve sohbet akşamlarının vazgeçilmez lezzeti patlamış mısırı kutlayan neşeli gün.', '## 19 Ocak Dünya Patlamış Mısır Günü Nedir?
Sinema ve sohbet akşamlarının vazgeçilmez lezzeti patlamış mısırı kutlayan neşeli gün.

### Tarihçesi ve Önemi
19 Ocak Dünya Patlamış Mısır Günü, gerek Türkiye''de gerekse uluslararası alanda Popcorn Board nezdinde tanınan ve her yıl 19 Ocak tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "19 Ocak Dünya Patlamış Mısır Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "19 Ocak günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-01-19', 1, 19, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Popcorn Board', 'https://www.popcorn.org', ARRAY['#19Ocak', '#19ocakdunyapatlamismisirgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '20-ocak-penguenleri-koruma-farkindalik-gunu', '20 Ocak Penguenleri Koruma Farkındalık Günü', 'Kutup ekosisteminin sevimli sakinleri penguenlerin neslini koruma günü.', '## 20 Ocak Penguenleri Koruma Farkındalık Günü Nedir?
Kutup ekosisteminin sevimli sakinleri penguenlerin neslini koruma günü.

### Tarihçesi ve Önemi
20 Ocak Penguenleri Koruma Farkındalık Günü, gerek Türkiye''de gerekse uluslararası alanda Wildlife Conservation Society nezdinde tanınan ve her yıl 20 Ocak tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "20 Ocak Penguenleri Koruma Farkındalık Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "20 Ocak günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-01-20', 1, 20, 'Çevre & Doğa', 'farkindalik', false, 'uluslararasi', 'Wildlife Conservation Society', 'https://www.wcs.org', ARRAY['#20Ocak', '#20ocakpenguenlerikorumafarkindalikgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-sarilma-gunu', '21 Ocak Dünya Sarılma Günü', 'İnsanlar arasındaki sevgi bağını güçlendirmek ve sarılmanın iyileştirici gücünü hatırlatmak için kutlanır.', '## 21 Ocak Dünya Sarılma Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-sarilma-gunu"', '2026-01-21', 1, 21, 'Eğlence', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaSarilmaGunu', '#SarilmakGuzeldir', '#HugDay', '#Sevgi'], ARRAY['yumuşak peluş oyuncak', 'ağırlaştırılmış battaniye', 'kupa bardak kalpli', 'sarılma yastığı']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '22-ocak-toplum-sagligi-ve-sicak-cay-gunu', '22 Ocak Toplum Sağlığı ve Sıcak Çay Günü', 'Kış soğuklarında antioksidan zengini sıcak çayların sağlığa faydalarını hatırlatan gün.', '## 22 Ocak Toplum Sağlığı ve Sıcak Çay Günü Nedir?
Kış soğuklarında antioksidan zengini sıcak çayların sağlığa faydalarını hatırlatan gün.

### Tarihçesi ve Önemi
22 Ocak Toplum Sağlığı ve Sıcak Çay Günü, gerek Türkiye''de gerekse uluslararası alanda Health & Nutrition Council nezdinde tanınan ve her yıl 22 Ocak tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "22 Ocak Toplum Sağlığı ve Sıcak Çay Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "22 Ocak günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-01-22', 1, 22, 'Sağlık', 'kutlama', false, 'uluslararasi', 'Health & Nutrition Council', 'https://www.fao.org', ARRAY['#22Ocak', '#22ocaktoplumsagligivesicakcaygunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '23-ocak-dunya-el-yazisi-gunu', '23 Ocak Dünya El Yazısı Günü', 'Klavyelerin ötesinde el yazısının kişisel estetiğini ve motor becerilerini yaşatma günü.', '## 23 Ocak Dünya El Yazısı Günü Nedir?
Klavyelerin ötesinde el yazısının kişisel estetiğini ve motor becerilerini yaşatma günü.

### Tarihçesi ve Önemi
23 Ocak Dünya El Yazısı Günü, gerek Türkiye''de gerekse uluslararası alanda Writing Instrument Association nezdinde tanınan ve her yıl 23 Ocak tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "23 Ocak Dünya El Yazısı Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "23 Ocak günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-01-23', 1, 23, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'Writing Instrument Association', 'https://www.wima.org', ARRAY['#23Ocak', '#23ocakdunyaelyazisigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'uluslararasi-egitim-gunu', '24 Ocak Uluslararası Eğitim Günü', 'Barış ve kalkınma için eğitimin vazgeçilmez rolünü kutlamak amacıyla Birleşmiş Milletler tarafından kabul edilen gün.', '## 24 Ocak Uluslararası Eğitim Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #uluslararasi-egitim-gunu"', '2026-01-24', 1, 24, 'Farkındalık', 'kutlama', false, 'turkiye', '', '', ARRAY['#EgitimGunu', '#EducationDay', '#NitelikliEgitim', '#Gelecek'], ARRAY['eğitici tablet çocuk', 'dünya atlası', 'online eğitim kursu', 'çalışma masası lambası']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '25-ocak-dunya-kar-ve-kis-sporlari-gunu', '25 Ocak Dünya Kar ve Kış Sporları Günü', 'Kış mevsimini aktif sporlar ve doğa yürüyüşleriyle neşeyle geçirme günü.', '## 25 Ocak Dünya Kar ve Kış Sporları Günü Nedir?
Kış mevsimini aktif sporlar ve doğa yürüyüşleriyle neşeyle geçirme günü.

### Tarihçesi ve Önemi
25 Ocak Dünya Kar ve Kış Sporları Günü, gerek Türkiye''de gerekse uluslararası alanda FIS Uluslararası Kayak Federasyonu nezdinde tanınan ve her yıl 25 Ocak tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "25 Ocak Dünya Kar ve Kış Sporları Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "25 Ocak günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-01-25', 1, 25, 'Eğlence', 'kutlama', false, 'uluslararasi', 'FIS Uluslararası Kayak Federasyonu', 'https://www.worldsnowday.com', ARRAY['#25Ocak', '#25ocakdunyakarvekissporlarigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-gumruk-gunu', '26 Ocak Dünya Gümrük Günü', 'Uluslararası ticaretin güvenliği ve gümrük çalışanlarının fedakarlıklarını onurlandıran gün.', '## 26 Ocak Dünya Gümrük Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-gumruk-gunu"', '2026-01-26', 1, 26, 'Mesleki', 'kutlama', false, 'turkiye', '', '', ARRAY['#GumrukGunu', '#26Ocak', '#GumrukMuhafaza', '#Ticaret'], ARRAY['seyahat pasaport kılıfı', 'valiz bavul seti', 'bagaj tartısı dijital']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '27-ocak-uluslararasi-holokost-kurbanlarini-anma-gunu', '27 Ocak Uluslararası Holokost Kurbanlarını Anma Günü', 'İkinci Dünya Savaşı soykırım kurbanlarını hüzün ve saygıyla anma günü.', '## 27 Ocak Uluslararası Holokost Kurbanlarını Anma Günü Nedir?
İkinci Dünya Savaşı soykırım kurbanlarını hüzün ve saygıyla anma günü.

### Tarihçesi ve Önemi
27 Ocak Uluslararası Holokost Kurbanlarını Anma Günü, gerek Türkiye''de gerekse uluslararası alanda Birleşmiş Milletler (A/RES/60/7) nezdinde tanınan ve her yıl 27 Ocak tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "27 Ocak Uluslararası Holokost Kurbanlarını Anma Günü vesilesiyle saygı ve hürmetle anıyoruz."
* "27 Ocak günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-01-27', 1, 27, 'Farkındalık', 'anma', false, 'bm', 'Birleşmiş Milletler (A/RES/60/7)', 'https://www.un.org/en/observances/holocaust-remembrance-day', ARRAY['#27Ocak', '#27ocakuluslararasiholokostkurbanlarinianmagunu'], ARRAY[]
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'veri-koruma-gunu', '28 Ocak Veri Koruma Günü', 'Dijital çağda kişisel verilerin gizliliği ve siber güvenlik bilincini artırmak amacıyla kutlanan küresel gün.', '## 28 Ocak Veri Koruma Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #veri-koruma-gunu"', '2026-01-28', 1, 28, 'Farkındalık', 'kutlama', false, 'turkiye', '', '', ARRAY['#VeriKorumaGunu', '#KVKK', '#SiberGuvenlik', '#DataPrivacy'], ARRAY['şifreli flash bellek', 'donanım cüzdanı', 'webcam gizlilik kapağı', 'vpn aboneliği']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '29-ocak-dunya-yapboz-puzzle-gunu', '29 Ocak Dünya Yapboz (Puzzle) Günü', 'Zihni tazeleyen, sabır ve odaklanmayı artıran yapboz oyunları günü.', '## 29 Ocak Dünya Yapboz (Puzzle) Günü Nedir?
Zihni tazeleyen, sabır ve odaklanmayı artıran yapboz oyunları günü.

### Tarihçesi ve Önemi
29 Ocak Dünya Yapboz (Puzzle) Günü, gerek Türkiye''de gerekse uluslararası alanda Game & Puzzle Guild nezdinde tanınan ve her yıl 29 Ocak tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "29 Ocak Dünya Yapboz (Puzzle) Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "29 Ocak günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-01-29', 1, 29, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Game & Puzzle Guild', 'https://www.worldpuzzleday.org', ARRAY['#29Ocak', '#29ocakdunyayapbozpuzzlegunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '30-ocak-okullarda-siddetsizlik-ve-baris-gunu', '30 Ocak Okullarda Şiddetsizlik ve Barış Günü', 'Mahatma Gandhi''nin barışçıl felsefesini genç nesillere aktaran küresel gün.', '## 30 Ocak Okullarda Şiddetsizlik ve Barış Günü Nedir?
Mahatma Gandhi''nin barışçıl felsefesini genç nesillere aktaran küresel gün.

### Tarihçesi ve Önemi
30 Ocak Okullarda Şiddetsizlik ve Barış Günü, gerek Türkiye''de gerekse uluslararası alanda UNESCO Barış Eğitimi nezdinde tanınan ve her yıl 30 Ocak tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "30 Ocak Okullarda Şiddetsizlik ve Barış Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "30 Ocak günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-01-30', 1, 30, 'Farkındalık', 'farkindalik', false, 'uluslararasi', 'UNESCO Barış Eğitimi', 'https://www.unesco.org', ARRAY['#30Ocak', '#30ocakokullardasiddetsizlikvebarisgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '31-ocak-dunya-cuzzam-ile-savas-gunu', '31 Ocak Dünya Cüzzam ile Savaş Günü', 'Cüzzam hastalığı konusunda toplumsal bilinci artırma ve ayrımcılığı önleme günü.', '## 31 Ocak Dünya Cüzzam ile Savaş Günü Nedir?
Cüzzam hastalığı konusunda toplumsal bilinci artırma ve ayrımcılığı önleme günü.

### Tarihçesi ve Önemi
31 Ocak Dünya Cüzzam ile Savaş Günü, gerek Türkiye''de gerekse uluslararası alanda Dünya Sağlık Örgütü (WHO) nezdinde tanınan ve her yıl 31 Ocak tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "31 Ocak Dünya Cüzzam ile Savaş Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "31 Ocak günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-01-31', 1, 31, 'Sağlık', 'farkindalik', false, 'bm', 'Dünya Sağlık Örgütü (WHO)', 'https://www.who.int', ARRAY['#31Ocak', '#31ocakdunyacuzzamilesavasgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '1-subat-dunya-basortusu-ve-vicdan-ozgurlugu-gunu', '1 Şubat Dünya Başörtüsü ve Vicdan Özgürlüğü Günü', 'İnanç özgürlüğü, karşılıklı empati ve kültürel çeşitliliği kutlayan gün.', '## 1 Şubat Dünya Başörtüsü ve Vicdan Özgürlüğü Günü Nedir?
İnanç özgürlüğü, karşılıklı empati ve kültürel çeşitliliği kutlayan gün.

### Tarihçesi ve Önemi
1 Şubat Dünya Başörtüsü ve Vicdan Özgürlüğü Günü, gerek Türkiye''de gerekse uluslararası alanda World Hijab Day Initiative nezdinde tanınan ve her yıl 1 Şubat tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "1 Şubat Dünya Başörtüsü ve Vicdan Özgürlüğü Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "1 Şubat günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-02-01', 2, 1, 'Farkındalık', 'farkindalik', false, 'uluslararasi', 'World Hijab Day Initiative', 'https://worldhijabday.com', ARRAY['#1Şubat', '#1subatdunyabasortusuvevicdanozgurlugugunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '2-subat-dunya-sulak-alanlar-gunu', '2 Şubat Dünya Sulak Alanlar Günü', 'Gölleri, bataklıkları ve nehir deltalarını koruyan Birleşmiş Milletler çevre günü.', '## 2 Şubat Dünya Sulak Alanlar Günü Nedir?
Gölleri, bataklıkları ve nehir deltalarını koruyan Birleşmiş Milletler çevre günü.

### Tarihçesi ve Önemi
2 Şubat Dünya Sulak Alanlar Günü, gerek Türkiye''de gerekse uluslararası alanda Ramsar Sözleşmesi & BM (A/RES/75/317) nezdinde tanınan ve her yıl 2 Şubat tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "2 Şubat Dünya Sulak Alanlar Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "2 Şubat günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-02-02', 2, 2, 'Çevre & Doğa', 'farkindalik', false, 'bm', 'Ramsar Sözleşmesi & BM (A/RES/75/317)', 'https://www.ramsar.org', ARRAY['#2Şubat', '#2subatdunyasulakalanlargunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '3-subat-dunya-dogal-beslenme-ve-havyar-gunu', '3 Şubat Dünya Doğal Beslenme ve Havyar Günü', 'Geleneksel mutfak lezzetlerini ve deniz mahsullerinin gastronomi değerini kutlama günü.', '## 3 Şubat Dünya Doğal Beslenme ve Havyar Günü Nedir?
Geleneksel mutfak lezzetlerini ve deniz mahsullerinin gastronomi değerini kutlama günü.

### Tarihçesi ve Önemi
3 Şubat Dünya Doğal Beslenme ve Havyar Günü, gerek Türkiye''de gerekse uluslararası alanda Gastronomy Observances nezdinde tanınan ve her yıl 3 Şubat tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "3 Şubat Dünya Doğal Beslenme ve Havyar Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "3 Şubat günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-02-03', 2, 3, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Gastronomy Observances', 'https://www.fao.org', ARRAY['#3Şubat', '#3subatdunyadogalbeslenmevehavyargunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-kanser-gunu', '4 Şubat Dünya Kanser Günü', 'Kanser konusunda küresel farkındalık oluşturmak, erken teşhisin hayat kurtardığını hatırlatmak için düzenlenir.', '## 4 Şubat Dünya Kanser Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kanser-gunu"', '2026-02-04', 2, 4, 'Sağlık', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaKanserGunu', '#ErkenTeshisHayatKurtarir', '#KanserleMucadele', '#Saglik'], ARRAY['sağlıklı beslenme kitabı', 'antioksidan yeşil çay', 'spor matı', 'su matarası']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '5-subat-dunya-nutella-ve-kakao-gunu', '5 Şubat Dünya Nutella ve Kakao Günü', 'Dünyanın en sevilen kakaolu fındık kremasını ve tatlı anları kutlayan gün.', '## 5 Şubat Dünya Nutella ve Kakao Günü Nedir?
Dünyanın en sevilen kakaolu fındık kremasını ve tatlı anları kutlayan gün.

### Tarihçesi ve Önemi
5 Şubat Dünya Nutella ve Kakao Günü, gerek Türkiye''de gerekse uluslararası alanda World Nutella Day nezdinde tanınan ve her yıl 5 Şubat tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "5 Şubat Dünya Nutella ve Kakao Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "5 Şubat günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-02-05', 2, 5, 'Eğlence', 'kutlama', false, 'uluslararasi', 'World Nutella Day', 'https://www.nutelladay.com', ARRAY['#5Şubat', '#5subatdunyanutellavekakaogunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '6-subat-kadin-sunnetine-sifir-tolerans-gunu', '6 Şubat Kadın Sünnetine Sıfır Tolerans Günü', 'Kız çocuklarının temel sağlık haklarını ve beden bütünlüğünü koruma günü.', '## 6 Şubat Kadın Sünnetine Sıfır Tolerans Günü Nedir?
Kız çocuklarının temel sağlık haklarını ve beden bütünlüğünü koruma günü.

### Tarihçesi ve Önemi
6 Şubat Kadın Sünnetine Sıfır Tolerans Günü, gerek Türkiye''de gerekse uluslararası alanda Birleşmiş Milletler (A/RES/67/146) nezdinde tanınan ve her yıl 6 Şubat tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "6 Şubat Kadın Sünnetine Sıfır Tolerans Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "6 Şubat günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-02-06', 2, 6, 'Sağlık', 'farkindalik', false, 'bm', 'Birleşmiş Milletler (A/RES/67/146)', 'https://www.un.org/en/observances/female-genital-mutilation-day', ARRAY['#6Şubat', '#6subatkadinsunnetinesifirtoleransgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '7-subat-guvenli-internet-gunu', '7 Şubat Güvenli İnternet Günü', 'Dijital dünyada siber zorbalığa karşı güvenli internet kullanımı günü.', '## 7 Şubat Güvenli İnternet Günü Nedir?
Dijital dünyada siber zorbalığa karşı güvenli internet kullanımı günü.

### Tarihçesi ve Önemi
7 Şubat Güvenli İnternet Günü, gerek Türkiye''de gerekse uluslararası alanda Avrupa Komisyonu (Safer Internet Day) nezdinde tanınan ve her yıl 7 Şubat tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "7 Şubat Güvenli İnternet Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "7 Şubat günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-02-07', 2, 7, 'Mesleki', 'farkindalik', false, 'uluslararasi', 'Avrupa Komisyonu (Safer Internet Day)', 'https://www.saferinternetday.org', ARRAY['#7Şubat', '#7subatguvenliinternetgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '8-subat-dunya-opera-ve-sahne-sanatlari-gunu', '8 Şubat Dünya Opera ve Sahne Sanatları Günü', 'Sahne sanatlarının görkemli şaheserlerini ve opera sanatçılarını onurlandıran gün.', '## 8 Şubat Dünya Opera ve Sahne Sanatları Günü Nedir?
Sahne sanatlarının görkemli şaheserlerini ve opera sanatçılarını onurlandıran gün.

### Tarihçesi ve Önemi
8 Şubat Dünya Opera ve Sahne Sanatları Günü, gerek Türkiye''de gerekse uluslararası alanda Opera Europa nezdinde tanınan ve her yıl 8 Şubat tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "8 Şubat Dünya Opera ve Sahne Sanatları Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "8 Şubat günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-02-08', 2, 8, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'Opera Europa', 'https://www.opera-europa.org', ARRAY['#8Şubat', '#8subatdunyaoperavesahnesanatlarigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'sigarayi-birakma-gunu', '9 Şubat Dünya Sigarayı Bırakma Günü', 'Tütün bağımlılığının zararlarına dikkat çekmek ve dumansız hava sahasını desteklemek amacıyla kutlanır.', '## 9 Şubat Dünya Sigarayı Bırakma Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #sigarayi-birakma-gunu"', '2026-02-09', 2, 9, 'Sağlık', 'kutlama', false, 'turkiye', '', '', ARRAY['#SigarayiBirakmaGunu', '#DumansizHavaSahasi', '#SigarayiBirak', '#SaglikliYasam'], ARRAY['nikotin sakızı', 'stres çarkı topu', 'koşu ayakkabısı', 'hava temizleyici cihaz']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '10-subat-dunya-bakliyat-gunu', '10 Şubat Dünya Bakliyat Günü', 'Bakliyatların yüksek protein değeri ve kuraklığa dayanıklı tarım gücü günü.', '## 10 Şubat Dünya Bakliyat Günü Nedir?
Bakliyatların yüksek protein değeri ve kuraklığa dayanıklı tarım gücü günü.

### Tarihçesi ve Önemi
10 Şubat Dünya Bakliyat Günü, gerek Türkiye''de gerekse uluslararası alanda Birleşmiş Milletler FAO (A/RES/73/251) nezdinde tanınan ve her yıl 10 Şubat tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "10 Şubat Dünya Bakliyat Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "10 Şubat günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-02-10', 2, 10, 'Sağlık', 'farkindalik', false, 'bm', 'Birleşmiş Milletler FAO (A/RES/73/251)', 'https://www.fao.org/world-pulses-day', ARRAY['#10Şubat', '#10subatdunyabakliyatgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'bilimde-kadinlar-gunu', '11 Şubat Bilimde Kadınlar ve Kız Çocukları Günü', 'Bilim ve teknoloji alanında kadınların ve kız çocuklarının tam ve eşit erişimini teşvik eden BM günü.', '## 11 Şubat Bilimde Kadınlar ve Kız Çocukları Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #bilimde-kadinlar-gunu"', '2026-02-11', 2, 11, 'Farkındalık', 'kutlama', false, 'turkiye', '', '', ARRAY['#BilimdeKadinlar', '#WomenInScience', '#KizCocuklari', '#STEM'], ARRAY['mikroskop seti bilimsel', 'marie curie kitabı', 'robotik kodlama kiti', 'teleskop başlangıç']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '12-subat-uluslararasi-darwin-gunu', '12 Şubat Uluslararası Darwin Günü', 'Biyoloji biliminin gelişimi ve doğa kanunlarını anlama çabası günü.', '## 12 Şubat Uluslararası Darwin Günü Nedir?
Biyoloji biliminin gelişimi ve doğa kanunlarını anlama çabası günü.

### Tarihçesi ve Önemi
12 Şubat Uluslararası Darwin Günü, gerek Türkiye''de gerekse uluslararası alanda Darwin Day Foundation nezdinde tanınan ve her yıl 12 Şubat tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "12 Şubat Uluslararası Darwin Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "12 Şubat günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-02-12', 2, 12, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'Darwin Day Foundation', 'https://darwinday.org', ARRAY['#12Şubat', '#12subatuluslararasidarwingunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '13-subat-dunya-radyo-gunu', '13 Şubat Dünya Radyo Günü', 'Yüz yılı aşkın süredir insanları birbirine bağlayan radyo yayıncılığı günü.', '## 13 Şubat Dünya Radyo Günü Nedir?
Yüz yılı aşkın süredir insanları birbirine bağlayan radyo yayıncılığı günü.

### Tarihçesi ve Önemi
13 Şubat Dünya Radyo Günü, gerek Türkiye''de gerekse uluslararası alanda UNESCO (36 C/Resolution 63) nezdinde tanınan ve her yıl 13 Şubat tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "13 Şubat Dünya Radyo Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "13 Şubat günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-02-13', 2, 13, 'Kültür & Sanat', 'kutlama', false, 'bm', 'UNESCO (36 C/Resolution 63)', 'https://www.unesco.org/en/days/world-radio-day', ARRAY['#13Şubat', '#13subatdunyaradyogunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'sevgililer-gunu', '14 Şubat Sevgililer Günü', 'Tüm dünyada sevgi ve aşkın paylaşıldığı, Aziz Valentin''in anısına ithaf edilen romantik kutlama günü.', '## 14 Şubat Sevgililer Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #sevgililer-gunu"', '2026-02-14', 2, 14, 'Eğlence', 'kutlama', false, 'turkiye', '', '', ARRAY['#14Subat', '#SevgililerGunu', '#ValentinesDay', '#Ask', '#Hediye'], ARRAY['sevgililer günü hediye kutusu', 'gümüş kolye', 'çikolata kutusu lüks', 'akıllı saat unisex']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '15-subat-uluslararasi-cocukluk-cagi-kanseri-gunu', '15 Şubat Uluslararası Çocukluk Çağı Kanseri Günü', 'Kanserle savaşan küçük kahramanlara destek ve erken teşhis bilinci günü.', '## 15 Şubat Uluslararası Çocukluk Çağı Kanseri Günü Nedir?
Kanserle savaşan küçük kahramanlara destek ve erken teşhis bilinci günü.

### Tarihçesi ve Önemi
15 Şubat Uluslararası Çocukluk Çağı Kanseri Günü, gerek Türkiye''de gerekse uluslararası alanda Childhood Cancer International nezdinde tanınan ve her yıl 15 Şubat tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "15 Şubat Uluslararası Çocukluk Çağı Kanseri Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "15 Şubat günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-02-15', 2, 15, 'Sağlık', 'farkindalik', false, 'uluslararasi', 'Childhood Cancer International', 'https://www.childhoodcancerinternational.org', ARRAY['#15Şubat', '#15subatuluslararasicocuklukcagikanserigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '16-subat-dunya-badem-ve-kuruyemis-gunu', '16 Şubat Dünya Badem ve Kuruyemiş Günü', 'Kalp dostu sağlıklı atıştırmalıkların beslenmedeki yerini kutlayan gün.', '## 16 Şubat Dünya Badem ve Kuruyemiş Günü Nedir?
Kalp dostu sağlıklı atıştırmalıkların beslenmedeki yerini kutlayan gün.

### Tarihçesi ve Önemi
16 Şubat Dünya Badem ve Kuruyemiş Günü, gerek Türkiye''de gerekse uluslararası alanda Healthy Nuts Observance nezdinde tanınan ve her yıl 16 Şubat tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "16 Şubat Dünya Badem ve Kuruyemiş Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "16 Şubat günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-02-16', 2, 16, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Healthy Nuts Observance', 'https://www.fao.org', ARRAY['#16Şubat', '#16subatdunyabademvekuruyemisgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-kediler-gunu', '17 Şubat Dünya Kediler Günü', 'Miyavlayan sevimli dostlarımızın yaşam haklarını ve sokak kedilerinin refahını hatırlatan özel gün.', '## 17 Şubat Dünya Kediler Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kediler-gunu"', '2026-02-17', 2, 17, 'Çevre & Doğa', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaKedilerGunu', '#CatDay', '#KediSeverler', '#SatinAlmaSahiplen'], ARRAY['kedi tırmalama tahtası', 'kedi ödül maması', 'otomatik kedi su pınarı', 'kedi taşıma çantası']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '18-subat-dunya-pil-ve-batarya-gunu', '18 Şubat Dünya Pil ve Batarya Günü', 'Modern teknolojinin enerji kaynağı piller ve atık pil geri dönüşümü günü.', '## 18 Şubat Dünya Pil ve Batarya Günü Nedir?
Modern teknolojinin enerji kaynağı piller ve atık pil geri dönüşümü günü.

### Tarihçesi ve Önemi
18 Şubat Dünya Pil ve Batarya Günü, gerek Türkiye''de gerekse uluslararası alanda Alessandro Volta Commemoration nezdinde tanınan ve her yıl 18 Şubat tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "18 Şubat Dünya Pil ve Batarya Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "18 Şubat günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-02-18', 2, 18, 'Mesleki', 'farkindalik', false, 'uluslararasi', 'Alessandro Volta Commemoration', 'https://www.ieee.org', ARRAY['#18Şubat', '#18subatdunyapilvebataryagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '19-subat-dunya-balina-ve-deniz-memelileri-gunu', '19 Şubat Dünya Balina ve Deniz Memelileri Günü', 'Okyanusların dev koruyucuları balinaların neslini yaşatma günü.', '## 19 Şubat Dünya Balina ve Deniz Memelileri Günü Nedir?
Okyanusların dev koruyucuları balinaların neslini yaşatma günü.

### Tarihçesi ve Önemi
19 Şubat Dünya Balina ve Deniz Memelileri Günü, gerek Türkiye''de gerekse uluslararası alanda International Whaling Commission nezdinde tanınan ve her yıl 19 Şubat tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "19 Şubat Dünya Balina ve Deniz Memelileri Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "19 Şubat günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-02-19', 2, 19, 'Çevre & Doğa', 'farkindalik', false, 'uluslararasi', 'International Whaling Commission', 'https://iwc.int', ARRAY['#19Şubat', '#19subatdunyabalinavedenizmemelilerigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-sosyal-adalet-gunu', '20 Şubat Dünya Sosyal Adalet Günü', 'Yoksulluk, dışlanma, işsizlik ve eşitsizlikle mücadele ederek adil bir toplum inşasını savunan BM günü.', '## 20 Şubat Dünya Sosyal Adalet Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-sosyal-adalet-gunu"', '2026-02-20', 2, 20, 'Farkındalık', 'kutlama', false, 'turkiye', '', '', ARRAY['#SosyalAdaletGunu', '#Esitlik', '#Adalet', '#SocialJustice'], ARRAY['insan hakları kitapları', 'sosyoloji temel eserler', 'felsefe klasikleri seti']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-anadili-gunu', '21 Şubat Uluslararası Anadili Günü', 'Dünyadaki tüm dillerin kültürel çeşitliliğini korumak ve çok dilliliği teşvik etmek için UNESCO tarafından kutlanır.', '## 21 Şubat Uluslararası Anadili Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-anadili-gunu"', '2026-02-21', 2, 21, 'Kültür & Sanat', 'kutlama', false, 'turkiye', '', '', ARRAY['#AnadiliGunu', '#MotherLanguageDay', '#KulturelCesitlilik', '#Dilimiz'], ARRAY['türkçe sözlük tdk', 'dünya edebiyatı klasikleri', 'etimoloji sözlüğü']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '22-subat-dunya-dusunce-gunu', '22 Şubat Dünya Düşünce Günü', 'Küresel dostluk, barış ve izcilik ideallerini kutlayan gençlik günü.', '## 22 Şubat Dünya Düşünce Günü Nedir?
Küresel dostluk, barış ve izcilik ideallerini kutlayan gençlik günü.

### Tarihçesi ve Önemi
22 Şubat Dünya Düşünce Günü, gerek Türkiye''de gerekse uluslararası alanda Dünya İzcilik Teşkilatı (WAGGGS) nezdinde tanınan ve her yıl 22 Şubat tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "22 Şubat Dünya Düşünce Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "22 Şubat günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-02-22', 2, 22, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Dünya İzcilik Teşkilatı (WAGGGS)', 'https://www.wagggs.org', ARRAY['#22Şubat', '#22subatdunyadusuncegunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '23-subat-dunya-baris-ve-karsilikli-anlayis-gunu', '23 Şubat Dünya Barış ve Karşılıklı Anlayış Günü', 'Uluslararası dayanışma ve insani yardım projelerini kutlayan gün.', '## 23 Şubat Dünya Barış ve Karşılıklı Anlayış Günü Nedir?
Uluslararası dayanışma ve insani yardım projelerini kutlayan gün.

### Tarihçesi ve Önemi
23 Şubat Dünya Barış ve Karşılıklı Anlayış Günü, gerek Türkiye''de gerekse uluslararası alanda Rotary International nezdinde tanınan ve her yıl 23 Şubat tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "23 Şubat Dünya Barış ve Karşılıklı Anlayış Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "23 Şubat günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-02-23', 2, 23, 'Farkındalık', 'farkindalik', false, 'uluslararasi', 'Rotary International', 'https://www.rotary.org', ARRAY['#23Şubat', '#23subatdunyabarisvekarsiliklianlayisgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '24-subat-dunya-barmenler-gunu', '24 Şubat Dünya Barmenler Günü', 'Gastronomi ve içecek kültürünün zanaatkarlarını onurlandıran gün.', '## 24 Şubat Dünya Barmenler Günü Nedir?
Gastronomi ve içecek kültürünün zanaatkarlarını onurlandıran gün.

### Tarihçesi ve Önemi
24 Şubat Dünya Barmenler Günü, gerek Türkiye''de gerekse uluslararası alanda International Bartenders Association nezdinde tanınan ve her yıl 24 Şubat tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "24 Şubat Dünya Barmenler Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "24 Şubat günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-02-24', 2, 24, 'Mesleki', 'kutlama', false, 'uluslararasi', 'International Bartenders Association', 'https://iba-world.com', ARRAY['#24Şubat', '#24subatdunyabarmenlergunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '25-subat-sessizlik-ve-ic-huzur-gunu', '25 Şubat Sessizlik ve İç Huzur Günü', 'Gürültüden uzaklaşıp zihinsel arınma ve dinginliğe vakit ayırma günü.', '## 25 Şubat Sessizlik ve İç Huzur Günü Nedir?
Gürültüden uzaklaşıp zihinsel arınma ve dinginliğe vakit ayırma günü.

### Tarihçesi ve Önemi
25 Şubat Sessizlik ve İç Huzur Günü, gerek Türkiye''de gerekse uluslararası alanda Mindfulness Observances nezdinde tanınan ve her yıl 25 Şubat tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "25 Şubat Sessizlik ve İç Huzur Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "25 Şubat günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-02-25', 2, 25, 'Sağlık', 'farkindalik', false, 'uluslararasi', 'Mindfulness Observances', 'https://www.who.int', ARRAY['#25Şubat', '#25subatsessizlikveichuzurgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '26-subat-dunya-antep-fistigi-gunu', '26 Şubat Dünya Antep Fıstığı Günü', 'Anadolu''nun eşsiz lezzeti ve tarımsal zenginliği Antep fıstığını kutlama günü.', '## 26 Şubat Dünya Antep Fıstığı Günü Nedir?
Anadolu''nun eşsiz lezzeti ve tarımsal zenginliği Antep fıstığını kutlama günü.

### Tarihçesi ve Önemi
26 Şubat Dünya Antep Fıstığı Günü, gerek Türkiye''de gerekse uluslararası alanda Gaziantep Ticaret Borsası & TZOB nezdinde tanınan ve her yıl 26 Şubat tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "26 Şubat Dünya Antep Fıstığı Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "26 Şubat günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-02-26', 2, 26, 'Eğlence', 'kutlama', false, 'turkiye', 'Gaziantep Ticaret Borsası & TZOB', 'https://www.gtb.org.tr', ARRAY['#26Şubat', '#26subatdunyaantepfistigigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '27-subat-dunya-sivil-toplum-kuruluslari-gunu', '27 Şubat Dünya Sivil Toplum Kuruluşları Günü', 'Toplumsal fayda için gönüllü çalışan vakıf ve dernekleri takdir etme günü.', '## 27 Şubat Dünya Sivil Toplum Kuruluşları Günü Nedir?
Toplumsal fayda için gönüllü çalışan vakıf ve dernekleri takdir etme günü.

### Tarihçesi ve Önemi
27 Şubat Dünya Sivil Toplum Kuruluşları Günü, gerek Türkiye''de gerekse uluslararası alanda World NGO Day Initiative nezdinde tanınan ve her yıl 27 Şubat tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "27 Şubat Dünya Sivil Toplum Kuruluşları Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "27 Şubat günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-02-27', 2, 27, 'Farkındalık', 'farkindalik', false, 'uluslararasi', 'World NGO Day Initiative', 'https://worldngoday.org', ARRAY['#27Şubat', '#27subatdunyasiviltoplumkuruluslarigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'sivil-savunma-gunu', '28 Şubat Sivil Savunma Günü', 'Deprem, yangın ve afetlere karşı hazırlıklı olma ve sivil savunma bilincini artıran gün.', '## 28 Şubat Sivil Savunma Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #sivil-savunma-gunu"', '2026-02-28', 2, 28, 'Resmi', 'kutlama', false, 'turkiye', '', '', ARRAY['#SivilSavunmaGunu', '#AfetBilinci', '#DepremeHazirlik', '#AFAD'], ARRAY['deprem acil durum çantası', 'el feneri şarjlı', 'düdük pusula çok amaçlı', 'ilk yardım çantası']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'yesilay-haftasi', '1 Mart Yeşilay Haftası', 'Alkol, uyuşturucu, tütün ve teknoloji bağımlılığıyla mücadeleyi destekleyen ulusal farkındalık haftası.', '## 1 Mart Yeşilay Haftası Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #yesilay-haftasi"', '2026-03-01', 3, 1, 'Sağlık', 'kutlama', false, 'turkiye', '', '', ARRAY['#YesilayHaftasi', '#BagimsizYasa', '#Yesilay', '#Saglik'], ARRAY['akıllı bileklik adımsayar', 'spor matı yoga', 'sağlıklı yaşam rehberi kitabı']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '2-mart-dunya-kitap-okuma-ve-dr-seuss-gunu', '2 Mart Dünya Kitap Okuma ve Dr. Seuss Günü', 'Çocuklara ve gençlere okuma sevgisi aşılayan eğlenceli edebi gün.', '## 2 Mart Dünya Kitap Okuma ve Dr. Seuss Günü Nedir?
Çocuklara ve gençlere okuma sevgisi aşılayan eğlenceli edebi gün.

### Tarihçesi ve Önemi
2 Mart Dünya Kitap Okuma ve Dr. Seuss Günü, gerek Türkiye''de gerekse uluslararası alanda National Education Association nezdinde tanınan ve her yıl 2 Mart tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "2 Mart Dünya Kitap Okuma ve Dr. Seuss Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "2 Mart günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-03-02', 3, 2, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'National Education Association', 'https://www.unesco.org', ARRAY['#2Mart', '#2martdunyakitapokumavedrseussgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-yaban-hayati-gunu', '3 Mart Dünya Yaban Hayatı Günü', 'Nesli tükenmekte olan yabani hayvan ve bitki türlerini koruma bilincini artırmak amacıyla kutlanır.', '## 3 Mart Dünya Yaban Hayatı Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-yaban-hayati-gunu"', '2026-03-03', 3, 3, 'Çevre & Doğa', 'kutlama', false, 'turkiye', '', '', ARRAY['#YabanHayatiGunu', '#WorldWildlifeDay', '#DogaDostu', '#BiyoCesitlilik'], ARRAY['dürbün doğa gözlem', 'doğa belgeselleri seti', 'kamp çadırı', 'kuş rehberi kitabı']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '4-mart-dunya-muhendislik-gunu-ve-obezite-gunu', '4 Mart Dünya Mühendislik Günü ve Obezite Günü', 'Geleceği inşa eden mühendisler ve sağlıklı beden farkındalığı günü.', '## 4 Mart Dünya Mühendislik Günü ve Obezite Günü Nedir?
Geleceği inşa eden mühendisler ve sağlıklı beden farkındalığı günü.

### Tarihçesi ve Önemi
4 Mart Dünya Mühendislik Günü ve Obezite Günü, gerek Türkiye''de gerekse uluslararası alanda UNESCO & DSÖ nezdinde tanınan ve her yıl 4 Mart tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "4 Mart Dünya Mühendislik Günü ve Obezite Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "4 Mart günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-03-04', 3, 4, 'Mesleki', 'farkindalik', false, 'bm', 'UNESCO & DSÖ', 'https://worldengineeringday.net', ARRAY['#4Mart', '#4martdunyamuhendislikgunuveobezitegunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '5-mart-dunya-enerji-verimliligi-gunu', '5 Mart Dünya Enerji Verimliliği Günü', 'Gelecek nesiller için enerjiyi tasarruflu ve akıllı kullanma günü.', '## 5 Mart Dünya Enerji Verimliliği Günü Nedir?
Gelecek nesiller için enerjiyi tasarruflu ve akıllı kullanma günü.

### Tarihçesi ve Önemi
5 Mart Dünya Enerji Verimliliği Günü, gerek Türkiye''de gerekse uluslararası alanda World Energy Forum nezdinde tanınan ve her yıl 5 Mart tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "5 Mart Dünya Enerji Verimliliği Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "5 Mart günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-03-05', 3, 5, 'Çevre & Doğa', 'farkindalik', false, 'uluslararasi', 'World Energy Forum', 'https://www.iea.org', ARRAY['#5Mart', '#5martdunyaenerjiverimliligigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '6-mart-dunya-masa-tenisi-gunu', '6 Mart Dünya Masa Tenisi Günü', 'Dostluk ve sporu buluşturan masa tenisi oyununu kutlayan neşeli gün.', '## 6 Mart Dünya Masa Tenisi Günü Nedir?
Dostluk ve sporu buluşturan masa tenisi oyununu kutlayan neşeli gün.

### Tarihçesi ve Önemi
6 Mart Dünya Masa Tenisi Günü, gerek Türkiye''de gerekse uluslararası alanda ITTF Foundation nezdinde tanınan ve her yıl 6 Mart tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "6 Mart Dünya Masa Tenisi Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "6 Mart günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-03-06', 3, 6, 'Eğlence', 'kutlama', false, 'uluslararasi', 'ITTF Foundation', 'https://www.ittf.com', ARRAY['#6Mart', '#6martdunyamasatenisigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '7-mart-dunya-matematik-gunu', '7 Mart Dünya Matematik Günü', 'Evrenin sırlarını çözen matematik bilimini gençlerle kutlama günü.', '## 7 Mart Dünya Matematik Günü Nedir?
Evrenin sırlarını çözen matematik bilimini gençlerle kutlama günü.

### Tarihçesi ve Önemi
7 Mart Dünya Matematik Günü, gerek Türkiye''de gerekse uluslararası alanda World Maths Day nezdinde tanınan ve her yıl 7 Mart tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "7 Mart Dünya Matematik Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "7 Mart günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-03-07', 3, 7, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'World Maths Day', 'https://www.worldmathsday.com', ARRAY['#7Mart', '#7martdunyamatematikgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-kadinlar-gunu', '8 Mart Dünya Kadınlar Günü', 'Kadınların sosyal, ekonomik, kültürel ve siyasi başarılarını kutlayan ve cinsiyet eşitliğini savunan küresel gün.', '## 8 Mart Dünya Kadınlar Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kadinlar-gunu"', '2026-03-08', 3, 8, 'Uluslararası', 'kutlama', false, 'turkiye', '', '', ARRAY['#8Mart', '#DunyaKadinlarGunu', '#GucluKadinlar', '#KadinHaklari'], ARRAY['kadın parfümü', 'özel hediye seti', 'orkide saksı çiçeği', 'tasarım takı kolye']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '9-mart-dunya-bobrek-gunu', '9 Mart Dünya Böbrek Günü', 'Böbrek sağlığı için su içme ve tuz tüketimini azaltma farkındalık günü.', '## 9 Mart Dünya Böbrek Günü Nedir?
Böbrek sağlığı için su içme ve tuz tüketimini azaltma farkındalık günü.

### Tarihçesi ve Önemi
9 Mart Dünya Böbrek Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Nefroloji Derneği (ISN) nezdinde tanınan ve her yıl 9 Mart tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "9 Mart Dünya Böbrek Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "9 Mart günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-03-09', 3, 9, 'Sağlık', 'farkindalik', false, 'uluslararasi', 'Uluslararası Nefroloji Derneği (ISN)', 'https://www.worldkidneyday.org', ARRAY['#9Mart', '#9martdunyabobrekgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '10-mart-uluslararasi-kadin-yargiclar-gunu', '10 Mart Uluslararası Kadın Yargıçlar Günü', 'Adaletin tecellisinde kadın yargıçların eşit temsilini onurlandıran gün.', '## 10 Mart Uluslararası Kadın Yargıçlar Günü Nedir?
Adaletin tecellisinde kadın yargıçların eşit temsilini onurlandıran gün.

### Tarihçesi ve Önemi
10 Mart Uluslararası Kadın Yargıçlar Günü, gerek Türkiye''de gerekse uluslararası alanda Birleşmiş Milletler (A/RES/75/274) nezdinde tanınan ve her yıl 10 Mart tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "10 Mart Uluslararası Kadın Yargıçlar Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "10 Mart günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-03-10', 3, 10, 'Mesleki', 'farkindalik', false, 'bm', 'Birleşmiş Milletler (A/RES/75/274)', 'https://www.un.org/en/observances/women-judges-day', ARRAY['#10Mart', '#10martuluslararasikadinyargiclargunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '11-mart-dunya-sihhi-tesisat-gunu', '11 Mart Dünya Sıhhi Tesisat Günü', 'Temiz içme suyu ve hijyenik altyapının insan yaşamındaki vazgeçilmez yeri.', '## 11 Mart Dünya Sıhhi Tesisat Günü Nedir?
Temiz içme suyu ve hijyenik altyapının insan yaşamındaki vazgeçilmez yeri.

### Tarihçesi ve Önemi
11 Mart Dünya Sıhhi Tesisat Günü, gerek Türkiye''de gerekse uluslararası alanda World Plumbing Council nezdinde tanınan ve her yıl 11 Mart tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "11 Mart Dünya Sıhhi Tesisat Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "11 Mart günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-03-11', 3, 11, 'Mesleki', 'farkindalik', false, 'uluslararasi', 'World Plumbing Council', 'https://www.worldplumbing.org', ARRAY['#11Mart', '#11martdunyasihhitesisatgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'istiklal-marsinin-kabulu', '12 Mart İstiklal Marşı''nın Kabulü', 'Mehmet Akif Ersoy''un kaleme aldığı milli marşımızın TBMM tarafından kabul edilişinin anma günü.', '## 12 Mart İstiklal Marşı''nın Kabulü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #istiklal-marsinin-kabulu"', '2026-03-12', 3, 12, 'Resmi', 'kutlama', false, 'turkiye', '', '', ARRAY['#12Mart', '#IstiklalMarsi', '#MehmetAkifErsoy', '#Korkma'], ARRAY['safahat özel baskı', 'mehmet akif ersoy biyografisi', 'türk bayrağı çerçeveli']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '13-mart-dunya-uyku-gunu', '13 Mart Dünya Uyku Günü', 'Bağışıklık ve zihin sağlığının temeli olan derin ve kaliteli uyku günü.', '## 13 Mart Dünya Uyku Günü Nedir?
Bağışıklık ve zihin sağlığının temeli olan derin ve kaliteli uyku günü.

### Tarihçesi ve Önemi
13 Mart Dünya Uyku Günü, gerek Türkiye''de gerekse uluslararası alanda World Sleep Society nezdinde tanınan ve her yıl 13 Mart tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "13 Mart Dünya Uyku Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "13 Mart günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-03-13', 3, 13, 'Sağlık', 'farkindalik', false, 'uluslararasi', 'World Sleep Society', 'https://worldsleepday.org', ARRAY['#13Mart', '#13martdunyauykugunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'tip-bayrami', '14 Mart Tıp Bayramı', 'Türkiye''de modern tıp eğitiminin başladığı günün anısına tüm sağlık çalışanlarını onurlandıran gün.', '## 14 Mart Tıp Bayramı Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #tip-bayrami"', '2026-03-14', 3, 14, 'Sağlık', 'kutlama', false, 'turkiye', '', '', ARRAY['#TipBayrami', '#14Mart', '#DoktorlarimizaTesekkurler', '#SaglikEmekcileri'], ARRAY['kişiye özel steteskop', 'doktor önlüğü kaliteli', 'medikal hediye kupa', 'termos doktor']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'pi-gunu', '14 Mart Dünya Pi Günü', 'Matematiksel sabit olan Pi sayısının (3,14) onuruna dünya çapında matematikseverlerin kutladığı gün.', '## 14 Mart Dünya Pi Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #pi-gunu"', '2026-03-14', 3, 14, 'Eğlence', 'kutlama', false, 'turkiye', '', '', ARRAY['#PiGunu', '#PiDay', '#Matematik', '#Einstein', '#314'], ARRAY['bilimsel hesap makinesi', 'pi sayısı tişörtü', 'matematik bulmaca kitapları', 'rubik küp']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-tuketici-haklari-gunu', '15 Mart Dünya Tüketici Hakları Günü', 'Tüketicilerin güvenlik, bilgilendirilme ve zararların tazmini haklarını savunan uluslararası gün.', '## 15 Mart Dünya Tüketici Hakları Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-tuketici-haklari-gunu"', '2026-03-15', 3, 15, 'Farkındalık', 'kutlama', false, 'turkiye', '', '', ARRAY['#TuketiciHaklariGunu', '#BilincliTuketici', '#HaklariniBil', '#15Mart'], ARRAY['tüketici hukuku el kitabı', 'para yönetim bütçe defteri']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '16-mart-ogretmen-okullarinin-kurulus-gunu', '16 Mart Öğretmen Okullarının Kuruluş Günü', 'Türkiye''de modern öğretmen yetiştirme geleneğinin başlangıç günü.', '## 16 Mart Öğretmen Okullarının Kuruluş Günü Nedir?
Türkiye''de modern öğretmen yetiştirme geleneğinin başlangıç günü.

### Tarihçesi ve Önemi
16 Mart Öğretmen Okullarının Kuruluş Günü, gerek Türkiye''de gerekse uluslararası alanda T.C. Millî Eğitim Bakanlığı (1848) nezdinde tanınan ve her yıl 16 Mart tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "16 Mart Öğretmen Okullarının Kuruluş Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "16 Mart günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-03-16', 3, 16, 'Mesleki', 'kutlama', false, 'turkiye', 'T.C. Millî Eğitim Bakanlığı (1848)', 'https://www.meb.gov.tr', ARRAY['#16Mart', '#16martogretmenokullarininkurulusgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '17-mart-aziz-patrick-gunu', '17 Mart Aziz Patrick Günü', 'İrlanda kökenli, yeşil temalı dünya çapında sevilen bahar festivali.', '## 17 Mart Aziz Patrick Günü Nedir?
İrlanda kökenli, yeşil temalı dünya çapında sevilen bahar festivali.

### Tarihçesi ve Önemi
17 Mart Aziz Patrick Günü, gerek Türkiye''de gerekse uluslararası alanda St. Patrick''s Festival nezdinde tanınan ve her yıl 17 Mart tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "17 Mart Aziz Patrick Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "17 Mart günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-03-17', 3, 17, 'Eğlence', 'kutlama', false, 'uluslararasi', 'St. Patrick''s Festival', 'https://stpatricksfestival.ie', ARRAY['#17Mart', '#17martazizpatrickgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'canakkale-zaferi', '18 Mart Çanakkale Zaferi ve Şehitleri Anma Günü', '1915 Çanakkale Deniz Zaferi''nin ve vatanı uğruna can veren aziz şehitlerimizin anıldığı milli gün.', '## 18 Mart Çanakkale Zaferi ve Şehitleri Anma Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #canakkale-zaferi"', '2026-03-18', 3, 18, 'Resmi', 'kutlama', false, 'turkiye', '', '', ARRAY['#18Mart', '#CanakkaleGecilmez', '#CanakkaleZaferi', '#SehitlerimiziAniyoruz'], ARRAY['çanakkale tarihi kitabı', 'mustafa kemal atatürk tablosu', 'türk bayrağı masa üstü']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '19-mart-musteri-hizmetleri-ve-nezaket-gunu', '19 Mart Müşteri Hizmetleri ve Nezaket Günü', 'İş hayatında empati, çözüm odaklılık ve saygılı iletişimi onurlandırma günü.', '## 19 Mart Müşteri Hizmetleri ve Nezaket Günü Nedir?
İş hayatında empati, çözüm odaklılık ve saygılı iletişimi onurlandırma günü.

### Tarihçesi ve Önemi
19 Mart Müşteri Hizmetleri ve Nezaket Günü, gerek Türkiye''de gerekse uluslararası alanda Customer Service Institute nezdinde tanınan ve her yıl 19 Mart tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "19 Mart Müşteri Hizmetleri ve Nezaket Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "19 Mart günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-03-19', 3, 19, 'Mesleki', 'kutlama', false, 'uluslararasi', 'Customer Service Institute', 'https://www.service-institute.org', ARRAY['#19Mart', '#19martmusterihizmetlerivenezaketgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-mutluluk-gunu', '20 Mart Dünya Mutluluk Günü', 'Mutluluğun temel bir insan hakkı olduğunu hatırlatmak için Birleşmiş Milletler tarafından kabul edilen gün.', '## 20 Mart Dünya Mutluluk Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-mutluluk-gunu"', '2026-03-20', 3, 20, 'Eğlence', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaMutlulukGunu', '#Mutluluk', '#Gulumse', '#HappinessDay'], ARRAY['pozitif psikoloji kitapları', 'aroma terapi uçucu yağ', 'günlük şükür defteri', 'renkli fincan']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-siir-gunu', '21 Mart Dünya Şiir Günü', 'Duyguların en saf ifadesi olan şiir sanatını, şairleri ve sözcüklerin büyüsünü kutlayan UNESCO günü.', '## 21 Mart Dünya Şiir Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-siir-gunu"', '2026-03-21', 3, 21, 'Kültür & Sanat', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaSiirGunu', '#SiirSokakta', '#NazimHikmet', '#CemalSureya', '#Siir'], ARRAY['türk şiir antolojisi', 'nazım hikmet şiirleri', 'cemal süreya sevda sözleri', 'dolma kalem']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-ormancilik-gunu', '21 Mart Dünya Ormancılık Günü ve Nevruz', 'Baharın gelişi, doğanın uyanışı ve orman varlığının korunması amacıyla kutlanan köklü bayram.', '## 21 Mart Dünya Ormancılık Günü ve Nevruz Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-ormancilik-gunu"', '2026-03-21', 3, 21, 'Çevre & Doğa', 'kutlama', false, 'turkiye', '', '', ARRAY['#OrmancilikGunu', '#NevruzBayrami', '#BaharGeldi', '#FidanDik'], ARRAY['fidan bağışı sertifikası', 'bahçe bakım seti', 'budama makası', 'saksı tohum seti']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-down-sendromu-gunu', '21 Mart Dünya Down Sendromu Farkındalık Günü', '+1 farkla dünyayı güzelleştiren bireylerin farkındalığını artırmak amacıyla kutlanan gün.', '## 21 Mart Dünya Down Sendromu Farkındalık Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-down-sendromu-gunu"', '2026-03-21', 3, 21, 'Farkındalık', 'kutlama', false, 'turkiye', '', '', ARRAY['#21Mart', '#DownSendromu', '#ArtiBirFarkla', '#GercekDostlar'], ARRAY['farklı çoraplar renkli set', 'özel eğitim materyali', 'duyusal oyun seti']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-su-gunu', '22 Mart Dünya Su Günü', 'Temiz su kaynaklarının korunması ve su kıtlığı tehlikesine dikkat çekmek için BM öncülüğünde kutlanır.', '## 22 Mart Dünya Su Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-su-gunu"', '2026-03-22', 3, 22, 'Çevre & Doğa', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaSuGunu', '#WorldWaterDay', '#SuyuKoru', '#GeleceginiKoru'], ARRAY['su arıtma cihazı filtre', 'tasarruflu duş başlığı', 'çelik su matarası', 'musluk perlatörü']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-meteoroloji-gunu', '23 Mart Dünya Meteoroloji Günü', 'Hava durumu tahminleri, iklim bilimi ve erken uyarı sistemlerinin hayat kurtarıcı rolünü kutlayan gün.', '## 23 Mart Dünya Meteoroloji Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-meteoroloji-gunu"', '2026-03-23', 3, 23, 'Çevre & Doğa', 'kutlama', false, 'turkiye', '', '', ARRAY['#MeteorolojiGunu', '#HavaDurumu', '#IklimBilimi', '#WMO'], ARRAY['ev tipi meteoroloji istasyonu', 'dijital termometre higrometre', 'barometre']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '24-mart-dunya-tuberkuloz-verem-gunu', '24 Mart Dünya Tüberküloz (Verem) Günü', 'Tüberkülozla küresel mücadele ve verem basilini yenme kararlılığı günü.', '## 24 Mart Dünya Tüberküloz (Verem) Günü Nedir?
Tüberkülozla küresel mücadele ve verem basilini yenme kararlılığı günü.

### Tarihçesi ve Önemi
24 Mart Dünya Tüberküloz (Verem) Günü, gerek Türkiye''de gerekse uluslararası alanda Dünya Sağlık Örgütü (WHO) nezdinde tanınan ve her yıl 24 Mart tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "24 Mart Dünya Tüberküloz (Verem) Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "24 Mart günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-03-24', 3, 24, 'Sağlık', 'farkindalik', false, 'bm', 'Dünya Sağlık Örgütü (WHO)', 'https://www.who.int', ARRAY['#24Mart', '#24martdunyatuberkulozveremgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '25-mart-kolelik-kurbanlarini-anma-uluslararasi-gunu', '25 Mart Kölelik Kurbanlarını Anma Uluslararası Günü', 'Tarihin acımasız köle ticaretinde hayatını kaybedenleri saygıyla anma günü.', '## 25 Mart Kölelik Kurbanlarını Anma Uluslararası Günü Nedir?
Tarihin acımasız köle ticaretinde hayatını kaybedenleri saygıyla anma günü.

### Tarihçesi ve Önemi
25 Mart Kölelik Kurbanlarını Anma Uluslararası Günü, gerek Türkiye''de gerekse uluslararası alanda Birleşmiş Milletler (A/RES/62/122) nezdinde tanınan ve her yıl 25 Mart tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "25 Mart Kölelik Kurbanlarını Anma Uluslararası Günü vesilesiyle saygı ve hürmetle anıyoruz."
* "25 Mart günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-03-25', 3, 25, 'Farkındalık', 'anma', false, 'bm', 'Birleşmiş Milletler (A/RES/62/122)', 'https://www.un.org/en/observances/remembrance-transatlantic-slave-trade', ARRAY['#25Mart', '#25martkolelikkurbanlarinianmauluslararasigunu'], ARRAY[]
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '26-mart-dunya-mor-gunu-epilepsi-farkindaligi', '26 Mart Dünya Mor Günü (Epilepsi Farkındalığı)', 'Epilepsiye karşı doğru bilgilenme ve hastaları anlama farkındalık günü.', '## 26 Mart Dünya Mor Günü (Epilepsi Farkındalığı) Nedir?
Epilepsiye karşı doğru bilgilenme ve hastaları anlama farkındalık günü.

### Tarihçesi ve Önemi
26 Mart Dünya Mor Günü (Epilepsi Farkındalığı), gerek Türkiye''de gerekse uluslararası alanda Purple Day Foundation nezdinde tanınan ve her yıl 26 Mart tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "26 Mart Dünya Mor Günü (Epilepsi Farkındalığı) kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "26 Mart günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-03-26', 3, 26, 'Sağlık', 'farkindalik', false, 'uluslararasi', 'Purple Day Foundation', 'https://www.purpleday.org', ARRAY['#26Mart', '#26martdunyamorgunuepilepsifarkindaligi'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-tiyatro-gunu', '27 Mart Dünya Tiyatro Günü', 'Tiyatro sanatının toplumları aydınlatıcı ve birleştirici gücünü kutlamak için 1961''den beri kutlanan sanat günü.', '## 27 Mart Dünya Tiyatro Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-tiyatro-gunu"', '2026-03-27', 3, 27, 'Kültür & Sanat', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaTiyatroGunu', '#Tiyatro', '#SahneSanatlari', '#27Mart'], ARRAY['tiyatro oyun metinleri', 'shakespeare toplu eserleri', 'dürbün tiyatro tipi', 'sanat tarihi kitabı']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '28-mart-kutuphane-haftasi-kutlamalari', '28 Mart Kütüphane Haftası Kutlamaları', 'Kütüphanelerin toplumların bilgi hafızasındaki yerini onurlandıran gün.', '## 28 Mart Kütüphane Haftası Kutlamaları Nedir?
Kütüphanelerin toplumların bilgi hafızasındaki yerini onurlandıran gün.

### Tarihçesi ve Önemi
28 Mart Kütüphane Haftası Kutlamaları, gerek Türkiye''de gerekse uluslararası alanda Türk Kütüphaneciler Derneği nezdinde tanınan ve her yıl 28 Mart tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "28 Mart Kütüphane Haftası Kutlamaları kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "28 Mart günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-03-28', 3, 28, 'Kültür & Sanat', 'kutlama', false, 'turkiye', 'Türk Kütüphaneciler Derneği', 'https://www.kutuphaneci.org.tr', ARRAY['#28Mart', '#28martkutuphanehaftasikutlamalari'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '29-mart-dunya-piyano-gunu', '29 Mart Dünya Piyano Günü', '88 tuşlu piyanonun tınılarını ve virtüözleri kutlayan müzik günü.', '## 29 Mart Dünya Piyano Günü Nedir?
88 tuşlu piyanonun tınılarını ve virtüözleri kutlayan müzik günü.

### Tarihçesi ve Önemi
29 Mart Dünya Piyano Günü, gerek Türkiye''de gerekse uluslararası alanda Piano Day Initiative nezdinde tanınan ve her yıl 29 Mart tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "29 Mart Dünya Piyano Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "29 Mart günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-03-29', 3, 29, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'Piano Day Initiative', 'https://www.pianoday.org', ARRAY['#29Mart', '#29martdunyapiyanogunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '30-mart-uluslararasi-sifir-atik-gunu', '30 Mart Uluslararası Sıfır Atık Günü', 'Türkiye öncülüğünde ilan edilen, israfı önleyip atıksız yaşamı savunan BM günü.', '## 30 Mart Uluslararası Sıfır Atık Günü Nedir?
Türkiye öncülüğünde ilan edilen, israfı önleyip atıksız yaşamı savunan BM günü.

### Tarihçesi ve Önemi
30 Mart Uluslararası Sıfır Atık Günü, gerek Türkiye''de gerekse uluslararası alanda Birleşmiş Milletler (A/RES/77/161 - Türkiye Girişimi) nezdinde tanınan ve her yıl 30 Mart tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "30 Mart Uluslararası Sıfır Atık Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "30 Mart günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-03-30', 3, 30, 'Çevre & Doğa', 'farkindalik', false, 'bm', 'Birleşmiş Milletler (A/RES/77/161 - Türkiye Girişimi)', 'https://www.unep.org', ARRAY['#30Mart', '#30martuluslararasisifiratikgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '31-mart-dunya-yedekleme-gunu-world-backup-day', '31 Mart Dünya Yedekleme Günü (World Backup Day)', 'Kıymetli verileri ve hatıraları kaybetmemek için veri yedekleme günü.', '## 31 Mart Dünya Yedekleme Günü (World Backup Day) Nedir?
Kıymetli verileri ve hatıraları kaybetmemek için veri yedekleme günü.

### Tarihçesi ve Önemi
31 Mart Dünya Yedekleme Günü (World Backup Day), gerek Türkiye''de gerekse uluslararası alanda World Backup Day Initiative nezdinde tanınan ve her yıl 31 Mart tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "31 Mart Dünya Yedekleme Günü (World Backup Day) kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "31 Mart günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-03-31', 3, 31, 'Mesleki', 'farkindalik', false, 'uluslararasi', 'World Backup Day Initiative', 'https://www.worldbackupday.com', ARRAY['#31Mart', '#31martdunyayedeklemegunuworldbackupday'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-saka-gunu', '1 Nisan Şaka Günü', 'Tüm dünyada insanların birbirine zararsız, neşeli ve zekice şakalar yaptığı kahkaha dolu gün.', '## 1 Nisan Şaka Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-saka-gunu"', '2026-04-01', 4, 1, 'Eğlence', 'kutlama', false, 'turkiye', '', '', ARRAY['#1Nisan', '#SakaGunu', '#AprilFools', '#Gulumse'], ARRAY['zararsız şaka malzemeleri', 'esprili kupa bardak', 'parti şaka oyunları']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-otizm-farkindalik-gunu', '2 Nisan Dünya Otizm Farkındalık Günü', 'Otizm spektrumundaki bireylerin yaşam kalitesini artırmak ve erken teşhis bilincini yaymak için kutlanır.', '## 2 Nisan Dünya Otizm Farkındalık Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-otizm-farkindalik-gunu"', '2026-04-02', 4, 2, 'Sağlık', 'kutlama', false, 'turkiye', '', '', ARRAY['#OtizmFarkindalikGunu', '#MaviIsikYak', '#OtizminFarkindayim', '#2Nisan'], ARRAY['mavi tişört', 'duyusal oda ışığı', 'otizm eğitim kartları', 'stres çarkı']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '3-nisan-dunya-parti-gunu', '3 Nisan Dünya Parti Günü', 'Dostluk, müzik ve kutlamanın birleştirici gücünü vurgulayan gün.', '## 3 Nisan Dünya Parti Günü Nedir?
Dostluk, müzik ve kutlamanın birleştirici gücünü vurgulayan gün.

### Tarihçesi ve Önemi
3 Nisan Dünya Parti Günü, gerek Türkiye''de gerekse uluslararası alanda World Party Day Initiative nezdinde tanınan ve her yıl 3 Nisan tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "3 Nisan Dünya Parti Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "3 Nisan günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-04-03', 4, 3, 'Eğlence', 'kutlama', false, 'uluslararasi', 'World Party Day Initiative', 'https://worldpartyday.org', ARRAY['#3Nisan', '#3nisandunyapartigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '4-nisan-sokak-hayvanlari-ve-mayin-bilinci-gunu', '4 Nisan Sokak Hayvanları ve Mayın Bilinci Günü', 'Sokaktaki can dostlarımızı koruma ve mayın tehlikesine karşı farkındalık günü.', '## 4 Nisan Sokak Hayvanları ve Mayın Bilinci Günü Nedir?
Sokaktaki can dostlarımızı koruma ve mayın tehlikesine karşı farkındalık günü.

### Tarihçesi ve Önemi
4 Nisan Sokak Hayvanları ve Mayın Bilinci Günü, gerek Türkiye''de gerekse uluslararası alanda BM & Hayvan Hakları nezdinde tanınan ve her yıl 4 Nisan tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "4 Nisan Sokak Hayvanları ve Mayın Bilinci Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "4 Nisan günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-04-04', 4, 4, 'Çevre & Doğa', 'farkindalik', false, 'uluslararasi', 'BM & Hayvan Hakları', 'https://www.un.org', ARRAY['#4Nisan', '#4nisansokakhayvanlarivemayinbilincigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'avukatlar-gunu', '5 Nisan Avukatlar Günü', 'Hak arama özgürlüğünün ve adaletin teminatı olan savunma makamı temsilcilerini onurlandıran gün.', '## 5 Nisan Avukatlar Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #avukatlar-gunu"', '2026-04-05', 4, 5, 'Mesleki', 'kutlama', false, 'turkiye', '', '', ARRAY['#5Nisan', '#AvukatlarGunu', '#SavunmaHakki', '#Adalet'], ARRAY['avukat hediye seti cübbe biblo', 'adalet heykeli themis', 'dolma kalem lüks', 'deri evrak çantası']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '6-nisan-kalkinma-ve-baris-icin-spor-gunu', '6 Nisan Kalkınma ve Barış İçin Spor Günü', 'Sporun toplumları birleştiren ve barışı teşvik eden evrensel dili günü.', '## 6 Nisan Kalkınma ve Barış İçin Spor Günü Nedir?
Sporun toplumları birleştiren ve barışı teşvik eden evrensel dili günü.

### Tarihçesi ve Önemi
6 Nisan Kalkınma ve Barış İçin Spor Günü, gerek Türkiye''de gerekse uluslararası alanda Birleşmiş Milletler (A/RES/67/296) nezdinde tanınan ve her yıl 6 Nisan tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "6 Nisan Kalkınma ve Barış İçin Spor Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "6 Nisan günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-04-06', 4, 6, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Birleşmiş Milletler (A/RES/67/296)', 'https://www.un.org/en/observances/sport-day', ARRAY['#6Nisan', '#6nisankalkinmavebarisicinsporgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-saglik-gunu', '7 Nisan Dünya Sağlık Günü', 'Dünya Sağlık Örgütü''nün kuruluş yıl dönümünde herkes için erişilebilir sağlık hizmetlerini savunan gün.', '## 7 Nisan Dünya Sağlık Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-saglik-gunu"', '2026-04-07', 4, 7, 'Sağlık', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaSaglikGunu', '#WorldHealthDay', '#SaglikHerkesIcin', '#SaglikliYasam'], ARRAY['tansiyon aleti dijital', 'ateş ölçer temassız', 'vitamin multivitamin', 'egzersiz lastiği']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '8-nisan-uluslararasi-romanlar-gunu', '8 Nisan Uluslararası Romanlar Günü', 'Roman kültürünü, müziğini ve eşit yurttaşlık haklarını kutlama günü.', '## 8 Nisan Uluslararası Romanlar Günü Nedir?
Roman kültürünü, müziğini ve eşit yurttaşlık haklarını kutlama günü.

### Tarihçesi ve Önemi
8 Nisan Uluslararası Romanlar Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Roman Kongresi nezdinde tanınan ve her yıl 8 Nisan tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "8 Nisan Uluslararası Romanlar Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "8 Nisan günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-04-08', 4, 8, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'Uluslararası Roman Kongresi', 'https://www.coe.int', ARRAY['#8Nisan', '#8nisanuluslararasiromanlargunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '9-nisan-mimar-sinani-anma-ve-mimarlar-gunu', '9 Nisan Mimar Sinan''ı Anma ve Mimarlar Günü', 'Büyük usta Mimar Sinan''ın mimari mirasını ve estetik vizyonunu anma günü.', '## 9 Nisan Mimar Sinan''ı Anma ve Mimarlar Günü Nedir?
Büyük usta Mimar Sinan''ın mimari mirasını ve estetik vizyonunu anma günü.

### Tarihçesi ve Önemi
9 Nisan Mimar Sinan''ı Anma ve Mimarlar Günü, gerek Türkiye''de gerekse uluslararası alanda TMMOB Mimarlar Odası nezdinde tanınan ve her yıl 9 Nisan tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "9 Nisan Mimar Sinan''ı Anma ve Mimarlar Günü vesilesiyle saygı ve hürmetle anıyoruz."
* "9 Nisan günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-04-09', 4, 9, 'Kültür & Sanat', 'anma', false, 'uluslararasi', 'TMMOB Mimarlar Odası', 'https://www.mo.org.tr', ARRAY['#9Nisan', '#9nisanmimarsinanianmavemimarlargunu'], ARRAY[]
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'polis-teskilati-kurulus-gunu', '10 Nisan Türk Polis Teşkilatı Kuruluş Günü', 'Huzur, güvenlik ve asayişimizin teminatı olan Türk Polis Teşkilatı''nın kuruluşunu kutlayan gün.', '## 10 Nisan Türk Polis Teşkilatı Kuruluş Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #polis-teskilati-kurulus-gunu"', '2026-04-10', 4, 10, 'Mesleki', 'kutlama', false, 'turkiye', '', '', ARRAY['#PolisHaftasi', '#10Nisan', '#TurkPolisTeskilati', '#PolisimizinYanindayiz'], ARRAY['polis temalı hediye kupa', 'taktik fener', 'deri polis cüzdan rozet']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '11-nisan-dunya-parkinson-gunu', '11 Nisan Dünya Parkinson Günü', 'Parkinson hastalığında erken teşhis ve hasta yakınlarına destek günü.', '## 11 Nisan Dünya Parkinson Günü Nedir?
Parkinson hastalığında erken teşhis ve hasta yakınlarına destek günü.

### Tarihçesi ve Önemi
11 Nisan Dünya Parkinson Günü, gerek Türkiye''de gerekse uluslararası alanda European Parkinson''s Disease Association nezdinde tanınan ve her yıl 11 Nisan tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "11 Nisan Dünya Parkinson Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "11 Nisan günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-04-11', 4, 11, 'Sağlık', 'farkindalik', false, 'uluslararasi', 'European Parkinson''s Disease Association', 'https://www.epda.eu.com', ARRAY['#11Nisan', '#11nisandunyaparkinsongunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '12-nisan-uluslararasi-insanli-uzay-ucusu-gunu', '12 Nisan Uluslararası İnsanlı Uzay Uçuşu Günü', 'Yuri Gagarin''in uzaya çıkışıyla başlayan insanlığın uzay serüveni günü.', '## 12 Nisan Uluslararası İnsanlı Uzay Uçuşu Günü Nedir?
Yuri Gagarin''in uzaya çıkışıyla başlayan insanlığın uzay serüveni günü.

### Tarihçesi ve Önemi
12 Nisan Uluslararası İnsanlı Uzay Uçuşu Günü, gerek Türkiye''de gerekse uluslararası alanda Birleşmiş Milletler (A/RES/65/271) nezdinde tanınan ve her yıl 12 Nisan tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "12 Nisan Uluslararası İnsanlı Uzay Uçuşu Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "12 Nisan günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-04-12', 4, 12, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'Birleşmiş Milletler (A/RES/65/271)', 'https://www.un.org/en/observances/human-spaceflight-day', ARRAY['#12Nisan', '#12nisanuluslararasiinsanliuzayucusugunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '13-nisan-scrabble-ve-kelime-oyunlari-gunu', '13 Nisan Scrabble ve Kelime Oyunları Günü', 'Zihinsel zenginlik ve kelime dağarcığını geliştiren masa oyunları günü.', '## 13 Nisan Scrabble ve Kelime Oyunları Günü Nedir?
Zihinsel zenginlik ve kelime dağarcığını geliştiren masa oyunları günü.

### Tarihçesi ve Önemi
13 Nisan Scrabble ve Kelime Oyunları Günü, gerek Türkiye''de gerekse uluslararası alanda Scrabble Day Association nezdinde tanınan ve her yıl 13 Nisan tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "13 Nisan Scrabble ve Kelime Oyunları Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "13 Nisan günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-04-13', 4, 13, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Scrabble Day Association', 'https://www.scrabble.com', ARRAY['#13Nisan', '#13nisanscrabblevekelimeoyunlarigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '14-nisan-dunya-cagas-hastaligi-gunu', '14 Nisan Dünya Çagas Hastalığı Günü', 'İhmal edilmiş tropikal hastalıklara karşı küresel farkındalık günü.', '## 14 Nisan Dünya Çagas Hastalığı Günü Nedir?
İhmal edilmiş tropikal hastalıklara karşı küresel farkındalık günü.

### Tarihçesi ve Önemi
14 Nisan Dünya Çagas Hastalığı Günü, gerek Türkiye''de gerekse uluslararası alanda Dünya Sağlık Örgütü (WHO) nezdinde tanınan ve her yıl 14 Nisan tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "14 Nisan Dünya Çagas Hastalığı Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "14 Nisan günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-04-14', 4, 14, 'Sağlık', 'farkindalik', false, 'uluslararasi', 'Dünya Sağlık Örgütü (WHO)', 'https://www.who.int', ARRAY['#14Nisan', '#14nisandunyacagashastaligigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-sanat-gunu', '15 Nisan Dünya Sanat Günü', 'Leonardo da Vinci''nin doğum gününde sanatsal yaratıcılığı ve özgürlüğü kutlayan uluslararası gün.', '## 15 Nisan Dünya Sanat Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-sanat-gunu"', '2026-04-15', 4, 15, 'Kültür & Sanat', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaSanatGunu', '#WorldArtDay', '#LeonardoDaVinci', '#Sanat'], ARRAY['akrilik boya seti', 'resim şövalesi', 'tuval seti', 'eskiz defteri kaliteli']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '16-nisan-dunya-ses-gunu', '16 Nisan Dünya Ses Günü', 'Ses tellerini koruma ve iletişimde sesin büyüleyici gücünü anlama günü.', '## 16 Nisan Dünya Ses Günü Nedir?
Ses tellerini koruma ve iletişimde sesin büyüleyici gücünü anlama günü.

### Tarihçesi ve Önemi
16 Nisan Dünya Ses Günü, gerek Türkiye''de gerekse uluslararası alanda World Voice Day Committee nezdinde tanınan ve her yıl 16 Nisan tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "16 Nisan Dünya Ses Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "16 Nisan günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-04-16', 4, 16, 'Sağlık', 'farkindalik', false, 'uluslararasi', 'World Voice Day Committee', 'https://world-voice-day.org', ARRAY['#16Nisan', '#16nisandunyasesgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '17-nisan-dunya-hemofili-gunu', '17 Nisan Dünya Hemofili Günü', 'Kalıtsal kanama bozukluklarıyla yaşayan hastalara tıbbi erişim günü.', '## 17 Nisan Dünya Hemofili Günü Nedir?
Kalıtsal kanama bozukluklarıyla yaşayan hastalara tıbbi erişim günü.

### Tarihçesi ve Önemi
17 Nisan Dünya Hemofili Günü, gerek Türkiye''de gerekse uluslararası alanda World Federation of Hemophilia nezdinde tanınan ve her yıl 17 Nisan tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "17 Nisan Dünya Hemofili Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "17 Nisan günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-04-17', 4, 17, 'Sağlık', 'farkindalik', false, 'uluslararasi', 'World Federation of Hemophilia', 'https://wfh.org/world-hemophilia-day', ARRAY['#17Nisan', '#17nisandunyahemofiligunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '18-nisan-dunya-anitlar-ve-sitler-gunu', '18 Nisan Dünya Anıtlar ve Sitler Günü', 'Tarihi eserleri, antik kentleri ve kültürel miras alanlarını koruma günü.', '## 18 Nisan Dünya Anıtlar ve Sitler Günü Nedir?
Tarihi eserleri, antik kentleri ve kültürel miras alanlarını koruma günü.

### Tarihçesi ve Önemi
18 Nisan Dünya Anıtlar ve Sitler Günü, gerek Türkiye''de gerekse uluslararası alanda ICOMOS & UNESCO nezdinde tanınan ve her yıl 18 Nisan tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "18 Nisan Dünya Anıtlar ve Sitler Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "18 Nisan günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-04-18', 4, 18, 'Kültür & Sanat', 'farkindalik', false, 'uluslararasi', 'ICOMOS & UNESCO', 'https://www.icomos.org', ARRAY['#18Nisan', '#18nisandunyaanitlarvesitlergunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '19-nisan-bisiklet-ve-cevre-dostu-ulasim-gunu', '19 Nisan Bisiklet ve Çevre Dostu Ulaşım Günü', 'Sıfır emisyonlu, sağlıklı ve özgür şehir ulaşımı için bisiklet günü.', '## 19 Nisan Bisiklet ve Çevre Dostu Ulaşım Günü Nedir?
Sıfır emisyonlu, sağlıklı ve özgür şehir ulaşımı için bisiklet günü.

### Tarihçesi ve Önemi
19 Nisan Bisiklet ve Çevre Dostu Ulaşım Günü, gerek Türkiye''de gerekse uluslararası alanda Bicycle Day Observances nezdinde tanınan ve her yıl 19 Nisan tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "19 Nisan Bisiklet ve Çevre Dostu Ulaşım Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "19 Nisan günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-04-19', 4, 19, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'Bicycle Day Observances', 'https://www.un.org', ARRAY['#19Nisan', '#19nisanbisikletvecevredostuulasimgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '20-nisan-birlesmis-milletler-cince-gunu', '20 Nisan Birleşmiş Milletler Çince Günü', 'Çin alfabesi ve kültürel zenginliğin dünya diplomasisindeki yeri günü.', '## 20 Nisan Birleşmiş Milletler Çince Günü Nedir?
Çin alfabesi ve kültürel zenginliğin dünya diplomasisindeki yeri günü.

### Tarihçesi ve Önemi
20 Nisan Birleşmiş Milletler Çince Günü, gerek Türkiye''de gerekse uluslararası alanda Birleşmiş Milletler nezdinde tanınan ve her yıl 20 Nisan tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "20 Nisan Birleşmiş Milletler Çince Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "20 Nisan günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-04-20', 4, 20, 'Kültür & Sanat', 'farkindalik', false, 'uluslararasi', 'Birleşmiş Milletler', 'https://www.un.org/zh/observances/chinese-language-day', ARRAY['#20Nisan', '#20nisanbirlesmismilletlercincegunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '21-nisan-dunya-yaraticilik-ve-yenilikcilik-gunu', '21 Nisan Dünya Yaratıcılık ve Yenilikçilik Günü', 'Problem çözmede inovatif fikirlerin ve yaratıcı zekanın önemi günü.', '## 21 Nisan Dünya Yaratıcılık ve Yenilikçilik Günü Nedir?
Problem çözmede inovatif fikirlerin ve yaratıcı zekanın önemi günü.

### Tarihçesi ve Önemi
21 Nisan Dünya Yaratıcılık ve Yenilikçilik Günü, gerek Türkiye''de gerekse uluslararası alanda Birleşmiş Milletler (A/RES/71/284) nezdinde tanınan ve her yıl 21 Nisan tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "21 Nisan Dünya Yaratıcılık ve Yenilikçilik Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "21 Nisan günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-04-21', 4, 21, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'Birleşmiş Milletler (A/RES/71/284)', 'https://www.un.org/en/observances/creativity-and-innovation-day', ARRAY['#21Nisan', '#21nisandunyayaraticilikveyenilikcilikgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-gunu', '22 Nisan Dünya Günü (Earth Day)', 'Gezegenimizi korumak, iklim krizini önlemek ve doğaya saygı duymak için dünya çapında kutlanan çevre günü.', '## 22 Nisan Dünya Günü (Earth Day) Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-gunu"', '2026-04-22', 4, 22, 'Çevre & Doğa', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaGunu', '#EarthDay', '#IklimKrizi', '#GezegenimiziKoru'], ARRAY['güneş enerjili powerbank', 'bambu pipet seti', 'çevre dostu temizlik ürünleri']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'ulusal-egemenlik-ve-cocuk-bayrami', '23 Nisan Ulusal Egemenlik ve Çocuk Bayramı', 'TBMM''nin açılışı ve Atatürk''ün dünya çocuklarına armağan ettiği ilk ve tek çocuk bayramı.', '## 23 Nisan Ulusal Egemenlik ve Çocuk Bayramı Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #ulusal-egemenlik-ve-cocuk-bayrami"', '2026-04-23', 4, 23, 'Resmi', 'kutlama', false, 'turkiye', '', '', ARRAY['#23Nisan', '#CocukBayrami', '#EgemenlikUlusundur', '#Ataturk'], ARRAY['çocuk kostümü', 'uçurtma seti', 'çocuk zeka oyunları', 'türk bayrağı balon']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-kitap-gunu', '23 Nisan Dünya Kitap ve Telif Hakkı Günü', 'Shakespeare ve Cervantes''in ölüm yıl dönümünde kitap okuma sevgisini ve yazarların haklarını kutlayan gün.', '## 23 Nisan Dünya Kitap ve Telif Hakkı Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kitap-gunu"', '2026-04-23', 4, 23, 'Kültür & Sanat', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaKitapGunu', '#KitapKurdu', '#OkumakOzgurluktur', '#Kitap'], ARRAY['e-kitap okuyucu kılıfı', 'ahşap kitap ayracı', 'kitap okuma lambası', 'roman seti çok satanlar']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '24-nisan-baris-icin-cok-taraflilik-ve-diplomasi-gunu', '24 Nisan Barış İçin Çok Taraflılık ve Diplomasi Günü', 'Uluslararası uyuşmazlıkların barışçıl diplomasiyle çözülmesi günü.', '## 24 Nisan Barış İçin Çok Taraflılık ve Diplomasi Günü Nedir?
Uluslararası uyuşmazlıkların barışçıl diplomasiyle çözülmesi günü.

### Tarihçesi ve Önemi
24 Nisan Barış İçin Çok Taraflılık ve Diplomasi Günü, gerek Türkiye''de gerekse uluslararası alanda Birleşmiş Milletler (A/RES/73/127) nezdinde tanınan ve her yıl 24 Nisan tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "24 Nisan Barış İçin Çok Taraflılık ve Diplomasi Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "24 Nisan günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-04-24', 4, 24, 'Farkındalık', 'farkindalik', false, 'bm', 'Birleşmiş Milletler (A/RES/73/127)', 'https://www.un.org/en/observances/multilateralism-for-peace-day', ARRAY['#24Nisan', '#24nisanbarisicincoktaraflilikvediplomasigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '25-nisan-dunya-sitma-gunu-ve-istatistik-gunu', '25 Nisan Dünya Sıtma Günü ve İstatistik Günü', 'Sıtma hastalığını yeryüzünden silme ve veri temelli sağlık politikaları günü.', '## 25 Nisan Dünya Sıtma Günü ve İstatistik Günü Nedir?
Sıtma hastalığını yeryüzünden silme ve veri temelli sağlık politikaları günü.

### Tarihçesi ve Önemi
25 Nisan Dünya Sıtma Günü ve İstatistik Günü, gerek Türkiye''de gerekse uluslararası alanda Dünya Sağlık Örgütü (WHO) nezdinde tanınan ve her yıl 25 Nisan tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "25 Nisan Dünya Sıtma Günü ve İstatistik Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "25 Nisan günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-04-25', 4, 25, 'Sağlık', 'farkindalik', false, 'bm', 'Dünya Sağlık Örgütü (WHO)', 'https://www.who.int/campaigns/world-malaria-day', ARRAY['#25Nisan', '#25nisandunyasitmagunuveistatistikgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-pilotlar-gunu', '26 Nisan Dünya Pilotlar Günü', 'Türkiye''nin 1 numaralı pilot brövesi sahibi Fesa Evrensev''in anısına tüm dünyada kutlanan havacılık günü.', '## 26 Nisan Dünya Pilotlar Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-pilotlar-gunu"', '2026-04-26', 4, 26, 'Mesleki', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaPilotlarGunu', '#WorldPilotsDay', '#Goklerdeyiz', '#Havacilik'], ARRAY['uçak maketi metal', 'pilot güneş gözlüğü aviator', 'havacılık temalı saat']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '27-nisan-dunya-tasarim-gunu', '27 Nisan Dünya Tasarım Günü', 'Hayatı güzelleştiren ve kolaylaştıran grafik ve endüstriyel tasarım günü.', '## 27 Nisan Dünya Tasarım Günü Nedir?
Hayatı güzelleştiren ve kolaylaştıran grafik ve endüstriyel tasarım günü.

### Tarihçesi ve Önemi
27 Nisan Dünya Tasarım Günü, gerek Türkiye''de gerekse uluslararası alanda International Council of Design nezdinde tanınan ve her yıl 27 Nisan tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "27 Nisan Dünya Tasarım Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "27 Nisan günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-04-27', 4, 27, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'International Council of Design', 'https://www.theicod.org', ARRAY['#27Nisan', '#27nisandunyatasarimgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '28-nisan-dunya-is-sagligi-ve-guvenligi-gunu', '28 Nisan Dünya İş Sağlığı ve Güvenliği Günü', 'İş kazalarını ve meslek hastalıklarını önleme, güvenli çalışma ortamı günü.', '## 28 Nisan Dünya İş Sağlığı ve Güvenliği Günü Nedir?
İş kazalarını ve meslek hastalıklarını önleme, güvenli çalışma ortamı günü.

### Tarihçesi ve Önemi
28 Nisan Dünya İş Sağlığı ve Güvenliği Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Çalışma Örgütü (ILO) nezdinde tanınan ve her yıl 28 Nisan tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "28 Nisan Dünya İş Sağlığı ve Güvenliği Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "28 Nisan günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-04-28', 4, 28, 'Mesleki', 'farkindalik', false, 'bm', 'Uluslararası Çalışma Örgütü (ILO)', 'https://www.ilo.org/safeday', ARRAY['#28Nisan', '#28nisandunyaissagligiveguvenligigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-dans-gunu', '29 Nisan Dünya Dans Günü', 'Bedenin evrensel dili olan dansın coşkusunu kutlamak için modern balenin yaratıcısı Noverre anısına kutlanır.', '## 29 Nisan Dünya Dans Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-dans-gunu"', '2026-04-29', 4, 29, 'Kültür & Sanat', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaDansGunu', '#DanceDay', '#DansEt', '#Sanat'], ARRAY['dans ayakkabısı', 'kablosuz kulaklık spor', 'tayt spor kaliteli', 'dans kursu kuponu']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'uluslararasi-caz-gunu', '30 Nisan Uluslararası Caz Günü', 'Özgürlüğün, doğaçlamanın ve diyalogun müziği olan cazı onurlandıran UNESCO günü.', '## 30 Nisan Uluslararası Caz Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #uluslararasi-caz-gunu"', '2026-04-30', 4, 30, 'Kültür & Sanat', 'kutlama', false, 'turkiye', '', '', ARRAY['#CazGunu', '#JazzDay', '#MuzikOzgurluktur', '#Jazz'], ARRAY['plak çalar pikap bluetooth', 'caz plakları efsane', 'saksafon başlangıç']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'emek-ve-dayanisma-gunu', '1 Mayıs Emek ve Dayanışma Günü', 'İşçi ve emekçilerin hak mücadelelerini onurlandıran, tüm dünyada kutlanan uluslararası resmi tatil günü.', '## 1 Mayıs Emek ve Dayanışma Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #emek-ve-dayanisma-gunu"', '2026-05-01', 5, 1, 'Resmi', 'kutlama', false, 'turkiye', '', '', ARRAY['#1Mayis', '#IsciBayrami', '#EmekVeDayanisma', '#Haklar'], ARRAY['iş güvenliği ayakkabısı', 'termos yemek kabı', 'iş tulumu']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '2-mayis-dunya-ton-baligi-gunu', '2 Mayıs Dünya Ton Balığı Günü', 'Aşırı avlanmaya karşı sürdürülebilir balıkçılık ve okyanus dengesi günü.', '## 2 Mayıs Dünya Ton Balığı Günü Nedir?
Aşırı avlanmaya karşı sürdürülebilir balıkçılık ve okyanus dengesi günü.

### Tarihçesi ve Önemi
2 Mayıs Dünya Ton Balığı Günü, gerek Türkiye''de gerekse uluslararası alanda Birleşmiş Milletler (A/RES/71/124) nezdinde tanınan ve her yıl 2 Mayıs tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "2 Mayıs Dünya Ton Balığı Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "2 Mayıs günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-05-02', 5, 2, 'Çevre & Doğa', 'farkindalik', false, 'bm', 'Birleşmiş Milletler (A/RES/71/124)', 'https://www.un.org/en/observances/tuna-day', ARRAY['#2Mayıs', '#2mayisdunyatonbaligigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'basin-ozgurlugu-gunu', '3 Mayıs Dünya Basın Özgürlüğü Günü', 'Bağımsız, sansürsüz ve özgür basının demokrasilerdeki hayati önemini hatırlatan BM günü.', '## 3 Mayıs Dünya Basın Özgürlüğü Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #basin-ozgurlugu-gunu"', '2026-05-03', 5, 3, 'Farkındalık', 'kutlama', false, 'turkiye', '', '', ARRAY['#BasinOzgurluguGunu', '#WorldPressFreedomDay', '#OzgurBasin', '#HaberHakki'], ARRAY['gazetecilik etik kitapları', 'basın tarihi araştırmaları']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '4-mayis-dunya-itfaiyeciler-gunu-ve-star-wars-gunu', '4 Mayıs Dünya İtfaiyeciler Günü ve Star Wars Günü', 'Alevlerle mücadele eden cesur itfaiyeciler ve popüler bilimkurgu günü.', '## 4 Mayıs Dünya İtfaiyeciler Günü ve Star Wars Günü Nedir?
Alevlerle mücadele eden cesur itfaiyeciler ve popüler bilimkurgu günü.

### Tarihçesi ve Önemi
4 Mayıs Dünya İtfaiyeciler Günü ve Star Wars Günü, gerek Türkiye''de gerekse uluslararası alanda Firefighters Association nezdinde tanınan ve her yıl 4 Mayıs tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "4 Mayıs Dünya İtfaiyeciler Günü ve Star Wars Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "4 Mayıs günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-05-04', 5, 4, 'Mesleki', 'kutlama', false, 'uluslararasi', 'Firefighters Association', 'https://www.firefightersday.org', ARRAY['#4Mayıs', '#4mayisdunyaitfaiyecilergunuvestarwarsgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'hidirellez', '5 Mayıs Hıdırellez Kültür Bayramı', 'Hızır ve İlyas peygamberlerin yeryüzünde buluştuğu gün olarak kabul edilen köklü bahar bayramı.', '## 5 Mayıs Hıdırellez Kültür Bayramı Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #hidirellez"', '2026-05-05', 5, 5, 'Kültür & Sanat', 'kutlama', false, 'turkiye', '', '', ARRAY['#Hidirellez', '#BaharBayrami', '#DileklerKabulOlsun', '#5Mayis'], ARRAY['tütsü seti doğal', 'dilek feneri renkli', 'hasır piknik sepeti']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '6-mayis-uluslararasi-diyet-yapmama-gunu', '6 Mayıs Uluslararası Diyet Yapmama Günü', 'Kalıplaşmış beden algılarına meydan okuma ve beden olumlama günü.', '## 6 Mayıs Uluslararası Diyet Yapmama Günü Nedir?
Kalıplaşmış beden algılarına meydan okuma ve beden olumlama günü.

### Tarihçesi ve Önemi
6 Mayıs Uluslararası Diyet Yapmama Günü, gerek Türkiye''de gerekse uluslararası alanda Body Acceptance Network nezdinde tanınan ve her yıl 6 Mayıs tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "6 Mayıs Uluslararası Diyet Yapmama Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "6 Mayıs günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-05-06', 5, 6, 'Sağlık', 'kutlama', false, 'uluslararasi', 'Body Acceptance Network', 'https://www.who.int', ARRAY['#6Mayıs', '#6mayisuluslararasidiyetyapmamagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '7-mayis-dunya-astim-gunu', '7 Mayıs Dünya Astım Günü', 'Astım hastalarının yaşam kalitesini artırma ve temiz hava farkındalığı günü.', '## 7 Mayıs Dünya Astım Günü Nedir?
Astım hastalarının yaşam kalitesini artırma ve temiz hava farkındalığı günü.

### Tarihçesi ve Önemi
7 Mayıs Dünya Astım Günü, gerek Türkiye''de gerekse uluslararası alanda GINA Küresel Astım Girişimi nezdinde tanınan ve her yıl 7 Mayıs tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "7 Mayıs Dünya Astım Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "7 Mayıs günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-05-07', 5, 7, 'Sağlık', 'farkindalik', false, 'uluslararasi', 'GINA Küresel Astım Girişimi', 'https://ginasthma.org', ARRAY['#7Mayıs', '#7mayisdunyaastimgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '8-mayis-dunya-kizilay-ve-kizilhac-gunu', '8 Mayıs Dünya Kızılay ve Kızılhaç Günü', 'Savaşta ve afette yardıma koşan insani yardım kahramanlarını onurlandıran gün.', '## 8 Mayıs Dünya Kızılay ve Kızılhaç Günü Nedir?
Savaşta ve afette yardıma koşan insani yardım kahramanlarını onurlandıran gün.

### Tarihçesi ve Önemi
8 Mayıs Dünya Kızılay ve Kızılhaç Günü, gerek Türkiye''de gerekse uluslararası alanda IFRC & Türk Kızılay nezdinde tanınan ve her yıl 8 Mayıs tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "8 Mayıs Dünya Kızılay ve Kızılhaç Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "8 Mayıs günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-05-08', 5, 8, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'IFRC & Türk Kızılay', 'https://www.kizilay.org.tr', ARRAY['#8Mayıs', '#8mayisdunyakizilayvekizilhacgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '9-mayis-avrupa-gunu', '9 Mayıs Avrupa Günü', 'Avrupa kıtasında barış ve siyasi birliğin temellerinin atıldığı gün.', '## 9 Mayıs Avrupa Günü Nedir?
Avrupa kıtasında barış ve siyasi birliğin temellerinin atıldığı gün.

### Tarihçesi ve Önemi
9 Mayıs Avrupa Günü, gerek Türkiye''de gerekse uluslararası alanda Avrupa Birliği (Schuman Bildirisi) nezdinde tanınan ve her yıl 9 Mayıs tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "9 Mayıs Avrupa Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "9 Mayıs günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-05-09', 5, 9, 'Uluslararası', 'kutlama', false, 'uluslararasi', 'Avrupa Birliği (Schuman Bildirisi)', 'https://european-union.europa.eu', ARRAY['#9Mayıs', '#9mayisavrupagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-psikologlar-gunu', '10 Mayıs Dünya Psikologlar Günü', 'İnsan ruhunu anlamak, iyileştirmek ve toplumsal esenliği sağlamak için çalışan psikologlara adanan gün.', '## 10 Mayıs Dünya Psikologlar Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-psikologlar-gunu"', '2026-05-10', 5, 10, 'Mesleki', 'kutlama', false, 'turkiye', '', '', ARRAY['#PsikologlarGunu', '#10Mayis', '#RuhSagligi', '#Psikoloji'], ARRAY['psikoloji temalı kupa', 'terapi not defteri', 'freud biblo masa üstü']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'anneler-gunu', '10 Mayıs Anneler Günü', 'Annelerimizin karşılıksız sevgisine ve fedakarlıklarına teşekkür ettiğimiz en duygusal özel gün.', '## 10 Mayıs Anneler Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #anneler-gunu"', '2026-05-10', 5, 10, 'Eğlence', 'kutlama', false, 'turkiye', '', '', ARRAY['#AnnelerGunu', '#CanimAnnem', '#AnneSevgisi', '#HediyeFikirleri'], ARRAY['anneler günü hediye seti', 'robot süpürge', 'kolye anne bebek figürlü', 'çiçek sepeti']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '11-mayis-dunya-gocmen-kuslar-gunu', '11 Mayıs Dünya Göçmen Kuşlar Günü', 'Kıtalararası göç eden kuşların güvenli rotalarını koruma günü.', '## 11 Mayıs Dünya Göçmen Kuşlar Günü Nedir?
Kıtalararası göç eden kuşların güvenli rotalarını koruma günü.

### Tarihçesi ve Önemi
11 Mayıs Dünya Göçmen Kuşlar Günü, gerek Türkiye''de gerekse uluslararası alanda UNEP & CMS nezdinde tanınan ve her yıl 11 Mayıs tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "11 Mayıs Dünya Göçmen Kuşlar Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "11 Mayıs günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-05-11', 5, 11, 'Çevre & Doğa', 'farkindalik', false, 'bm', 'UNEP & CMS', 'https://www.worldmigratorybirdday.org', ARRAY['#11Mayıs', '#11mayisdunyagocmenkuslargunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'hemsireler-gunu', '12 Mayıs Hemşireler Günü', 'Modern hemşireliğin kurucusu Florence Nightingale anısına sağlık ordusunun fedakar hemşirelerine adanan gün.', '## 12 Mayıs Hemşireler Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #hemsireler-gunu"', '2026-05-12', 5, 12, 'Sağlık', 'kutlama', false, 'turkiye', '', '', ARRAY['#HemsirelerGunu', '#12Mayis', '#HemsirelereTesekkurler', '#Saglik'], ARRAY['hemşire forması desenli', 'ortopedik sabo terlik', 'hemşire saati stetoskop', 'fincan hemşire']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '13-mayis-turk-dil-bayrami', '13 Mayıs Türk Dil Bayramı', 'Türkçenin resmi devlet dili ilan edilişinin onurunu yaşatan bayram günü.', '## 13 Mayıs Türk Dil Bayramı Nedir?
Türkçenin resmi devlet dili ilan edilişinin onurunu yaşatan bayram günü.

### Tarihçesi ve Önemi
13 Mayıs Türk Dil Bayramı, gerek Türkiye''de gerekse uluslararası alanda Karamanoğlu Mehmet Bey Fermanı (1277) nezdinde tanınan ve her yıl 13 Mayıs tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "13 Mayıs Türk Dil Bayramı kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "13 Mayıs günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-05-13', 5, 13, 'Kültür & Sanat', 'kutlama', false, 'turkiye', 'Karamanoğlu Mehmet Bey Fermanı (1277)', 'https://www.tdk.gov.tr', ARRAY['#13Mayıs', '#13mayisturkdilbayrami'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'eczacilik-gunu', '14 Mayıs Eczacılık Günü', 'Türkiye''de bilimsel eczacılık eğitiminin başladığı günün anısına sağlık danışmanımız eczacılara adanan gün.', '## 14 Mayıs Eczacılık Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #eczacilik-gunu"', '2026-05-14', 5, 14, 'Sağlık', 'kutlama', false, 'turkiye', '', '', ARRAY['#EczacilikGunu', '#14Mayis', '#EczacimizaTesekkurler', '#Saglik'], ARRAY['eczacı hediye seti kupa', 'havan biblo seramik', 'ilaç saklama kutusu haftalık']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-ciftciler-gunu', '14 Mayıs Dünya Çiftçiler Günü', 'Sofralarımıza gelen her lokmada emeği olan çiftçilerin ve tarım üreticilerinin uluslararası günü.', '## 14 Mayıs Dünya Çiftçiler Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-ciftciler-gunu"', '2026-05-14', 5, 14, 'Mesleki', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaCiftcilerGunu', '#14Mayis', '#TopraginEmekcileri', '#Tarim'], ARRAY['bahçe eldiveni sağlam', 'budama testeresi', 'toprak ph ölçer', 'hasır şapka']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'uluslararasi-aile-gunu', '15 Mayıs Uluslararası Aile Günü', 'Toplumun temel taşı olan ailenin korunması, sevgi ve dayanışmanın güçlendirilmesi için kutlanan BM günü.', '## 15 Mayıs Uluslararası Aile Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #uluslararasi-aile-gunu"', '2026-05-15', 5, 15, 'Farkındalık', 'kutlama', false, 'turkiye', '', '', ARRAY['#AileGunu', '#FamilyDay', '#AilemHerSeyim', '#SevgiYuvasi'], ARRAY['aile fotoğraf çerçevesi çoklu', 'kutu kutu aile oyunu', 'büyük boy piknik örtüsü']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '16-mayis-uluslararasi-isik-gunu', '16 Mayıs Uluslararası Işık Günü', 'Işığın bilim, tıp, iletişim ve sanattaki dönüştürücü gücünü kutlama günü.', '## 16 Mayıs Uluslararası Işık Günü Nedir?
Işığın bilim, tıp, iletişim ve sanattaki dönüştürücü gücünü kutlama günü.

### Tarihçesi ve Önemi
16 Mayıs Uluslararası Işık Günü, gerek Türkiye''de gerekse uluslararası alanda UNESCO (Theodore Maiman Lazer İcadı) nezdinde tanınan ve her yıl 16 Mayıs tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "16 Mayıs Uluslararası Işık Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "16 Mayıs günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-05-16', 5, 16, 'Kültür & Sanat', 'kutlama', false, 'bm', 'UNESCO (Theodore Maiman Lazer İcadı)', 'https://www.lightday.org', ARRAY['#16Mayıs', '#16mayisuluslararasiisikgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '17-mayis-dunya-telekomunikasyon-ve-bilgi-toplumu-gunu', '17 Mayıs Dünya Telekomünikasyon ve Bilgi Toplumu Günü', 'İnternet ve iletişim teknolojilerinin insanlığı birbirine bağlaması günü.', '## 17 Mayıs Dünya Telekomünikasyon ve Bilgi Toplumu Günü Nedir?
İnternet ve iletişim teknolojilerinin insanlığı birbirine bağlaması günü.

### Tarihçesi ve Önemi
17 Mayıs Dünya Telekomünikasyon ve Bilgi Toplumu Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Telekomünikasyon Birliği (ITU) nezdinde tanınan ve her yıl 17 Mayıs tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "17 Mayıs Dünya Telekomünikasyon ve Bilgi Toplumu Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "17 Mayıs günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-05-17', 5, 17, 'Mesleki', 'farkindalik', false, 'bm', 'Uluslararası Telekomünikasyon Birliği (ITU)', 'https://www.itu.int', ARRAY['#17Mayıs', '#17mayisdunyatelekomunikasyonvebilgitoplumugunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'muzeler-gunu', '18 Mayıs Müzeler Günü', 'Kültürel mirasımızı koruyan, geçmiş ile gelecek arasında köprü kuran müzelerin uluslararası kutlaması.', '## 18 Mayıs Müzeler Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #muzeler-gunu"', '2026-05-18', 5, 18, 'Kültür & Sanat', 'kutlama', false, 'turkiye', '', '', ARRAY['#MuzelerGunu', '#InternationalMuseumDay', '#KulturelMiras', '#MuzeleriGez'], ARRAY['müze kart kılıfı', 'türkiye arkeoloji atlası', 'sanat tarihi el kitabı']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'genclik-ve-spor-bayrami', '19 Mayıs Atatürk''ü Anma, Gençlik ve Spor Bayramı', 'Atatürk''ün Samsun''a çıkarak Milli Mücadele''yi başlattığı ve Türk gençliğine armağan ettiği milli bayramımız.', '## 19 Mayıs Atatürk''ü Anma, Gençlik ve Spor Bayramı Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #genclik-ve-spor-bayrami"', '2026-05-19', 5, 19, 'Resmi', 'kutlama', false, 'turkiye', '', '', ARRAY['#19Mayis', '#GenclikVesporBayrami', '#Ataturk', '#Samsun1919'], ARRAY['türk bayrağı spor tişörtü', 'spor çantası', 'basketbol topu', 'atatürk imzalı rozet']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-ari-gunu', '20 Mayıs Dünya Arı Günü', 'Ekosistemin ve tarımın gizli kahramanları olan arıların tozlaşmadaki hayati önemini hatırlatan BM günü.', '## 20 Mayıs Dünya Arı Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-ari-gunu"', '2026-05-20', 5, 20, 'Çevre & Doğa', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaAriGunu', '#WorldBeeDay', '#ArilariKoru', '#DogayiKoru'], ARRAY['doğal organik bal', 'arı sütü propolis', 'çiçek tohumu arı dostu']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-sut-gunu', '21 Mayıs Dünya Süt Günü', 'Sağlıklı kemik ve kas gelişimi için sütün beslenmedeki vazgeçilmez yerini vurgulayan FAO günü.', '## 21 Mayıs Dünya Süt Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-sut-gunu"', '2026-05-21', 5, 21, 'Sağlık', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaSutGunu', '#WorldMilkDay', '#SutIcSaglikBul', '#KemikSagligi'], ARRAY['süt köpürtücü otomatik', 'cam süt şişesi retro', 'yoğurt yapma makinesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'biyocesitlilik-gunu', '22 Mayıs Uluslararası Biyoçeşitlilik Günü', 'Gezegenimizdeki tüm türlerin, ekosistemlerin ve genetik zenginliğin korunması için BM tarafından kutlanır.', '## 22 Mayıs Uluslararası Biyoçeşitlilik Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #biyocesitlilik-gunu"', '2026-05-22', 5, 22, 'Çevre & Doğa', 'kutlama', false, 'turkiye', '', '', ARRAY['#BiyocesitlilikGunu', '#BiodiversityDay', '#DogayiKoru', '#TurlerYokOlmasin'], ARRAY['kuş yemliği bahçe tipi', 'endemik bitkiler kitabı türkiye', 'doğa günlüğü']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '23-mayis-dunya-kaplumbagalar-gunu', '23 Mayıs Dünya Kaplumbağalar Günü', 'Milyonlarca yıldır yaşayan deniz ve kara kaplumbağalarını koruma günü.', '## 23 Mayıs Dünya Kaplumbağalar Günü Nedir?
Milyonlarca yıldır yaşayan deniz ve kara kaplumbağalarını koruma günü.

### Tarihçesi ve Önemi
23 Mayıs Dünya Kaplumbağalar Günü, gerek Türkiye''de gerekse uluslararası alanda American Tortoise Rescue nezdinde tanınan ve her yıl 23 Mayıs tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "23 Mayıs Dünya Kaplumbağalar Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "23 Mayıs günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-05-23', 5, 23, 'Çevre & Doğa', 'farkindalik', false, 'uluslararasi', 'American Tortoise Rescue', 'https://www.worldturtleday.org', ARRAY['#23Mayıs', '#23mayisdunyakaplumbagalargunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '24-mayis-avrupa-parklar-gunu', '24 Mayıs Avrupa Parklar Günü', 'Milli parklar ve korunan doğal alanların değerini hatırlatan gün.', '## 24 Mayıs Avrupa Parklar Günü Nedir?
Milli parklar ve korunan doğal alanların değerini hatırlatan gün.

### Tarihçesi ve Önemi
24 Mayıs Avrupa Parklar Günü, gerek Türkiye''de gerekse uluslararası alanda EUROPARC Federation nezdinde tanınan ve her yıl 24 Mayıs tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "24 Mayıs Avrupa Parklar Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "24 Mayıs günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-05-24', 5, 24, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'EUROPARC Federation', 'https://www.europarc.org', ARRAY['#24Mayıs', '#24mayisavrupaparklargunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '25-mayis-afrika-gunu-ve-dunya-tiroid-gunu', '25 Mayıs Afrika Günü ve Dünya Tiroid Günü', 'Afrika kıtasının bağımsızlığı ve tiroid sağlığı bilinci günü.', '## 25 Mayıs Afrika Günü ve Dünya Tiroid Günü Nedir?
Afrika kıtasının bağımsızlığı ve tiroid sağlığı bilinci günü.

### Tarihçesi ve Önemi
25 Mayıs Afrika Günü ve Dünya Tiroid Günü, gerek Türkiye''de gerekse uluslararası alanda Afrika Birliği & ETA nezdinde tanınan ve her yıl 25 Mayıs tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "25 Mayıs Afrika Günü ve Dünya Tiroid Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "25 Mayıs günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-05-25', 5, 25, 'Uluslararası', 'kutlama', false, 'bm', 'Afrika Birliği & ETA', 'https://au.int', ARRAY['#25Mayıs', '#25mayisafrikagunuvedunyatiroidgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '26-mayis-dunya-lindy-hop-ve-dans-gunu', '26 Mayıs Dünya Lindy Hop ve Dans Günü', 'Caz müziğinin neşeli dansı Lindy Hop ve swing coşkusu günü.', '## 26 Mayıs Dünya Lindy Hop ve Dans Günü Nedir?
Caz müziğinin neşeli dansı Lindy Hop ve swing coşkusu günü.

### Tarihçesi ve Önemi
26 Mayıs Dünya Lindy Hop ve Dans Günü, gerek Türkiye''de gerekse uluslararası alanda Frankie Manning Foundation nezdinde tanınan ve her yıl 26 Mayıs tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "26 Mayıs Dünya Lindy Hop ve Dans Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "26 Mayıs günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-05-26', 5, 26, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'Frankie Manning Foundation', 'https://www.frankiemanningfoundation.org', ARRAY['#26Mayıs', '#26mayisdunyalindyhopvedansgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '27-mayis-acil-tip-gunu', '27 Mayıs Acil Tıp Günü', 'Hayat kurtaran acil servis ve ambulans ekiplerini takdir etme günü.', '## 27 Mayıs Acil Tıp Günü Nedir?
Hayat kurtaran acil servis ve ambulans ekiplerini takdir etme günü.

### Tarihçesi ve Önemi
27 Mayıs Acil Tıp Günü, gerek Türkiye''de gerekse uluslararası alanda EUSEM Avrupa Acil Tıp Derneği nezdinde tanınan ve her yıl 27 Mayıs tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "27 Mayıs Acil Tıp Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "27 Mayıs günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-05-27', 5, 27, 'Sağlık', 'farkindalik', false, 'uluslararasi', 'EUSEM Avrupa Acil Tıp Derneği', 'https://emergencymedicine-day.org', ARRAY['#27Mayıs', '#27mayisaciltipgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '28-mayis-dunya-aclik-gunu', '28 Mayıs Dünya Açlık Günü', 'Yeryüzünde kronik açlıkla yaşayan milyonlarca insana kalıcı gıda desteği günü.', '## 28 Mayıs Dünya Açlık Günü Nedir?
Yeryüzünde kronik açlıkla yaşayan milyonlarca insana kalıcı gıda desteği günü.

### Tarihçesi ve Önemi
28 Mayıs Dünya Açlık Günü, gerek Türkiye''de gerekse uluslararası alanda The Hunger Project nezdinde tanınan ve her yıl 28 Mayıs tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "28 Mayıs Dünya Açlık Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "28 Mayıs günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-05-28', 5, 28, 'Farkındalık', 'farkindalik', false, 'uluslararasi', 'The Hunger Project', 'https://www.worldhungerday.org', ARRAY['#28Mayıs', '#28mayisdunyaaclikgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'istanbulun-fethi', '29 Mayıs İstanbul''un Fethi', '1453 yılında Fatih Sultan Mehmet komutasındaki Osmanlı ordusunun İstanbul''u fethettiği tarihi gün.', '## 29 Mayıs İstanbul''un Fethi Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #istanbulun-fethi"', '2026-05-29', 5, 29, 'Resmi', 'kutlama', false, 'turkiye', '', '', ARRAY['#29Mayis1453', '#IstanbulunFethi', '#FatihSultanMehmet', '#Fetih'], ARRAY['istanbul fetih tarihi kitabı', 'osmanlı tuğrası tablo', 'minyatür fatih biblosu']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '30-mayis-dunya-multipl-skleroz-ms-gunu', '30 Mayıs Dünya Multipl Skleroz (MS) Günü', 'MS hastalarıyla dayanışma ve bilimsel araştırmalara destek günü.', '## 30 Mayıs Dünya Multipl Skleroz (MS) Günü Nedir?
MS hastalarıyla dayanışma ve bilimsel araştırmalara destek günü.

### Tarihçesi ve Önemi
30 Mayıs Dünya Multipl Skleroz (MS) Günü, gerek Türkiye''de gerekse uluslararası alanda MS International Federation nezdinde tanınan ve her yıl 30 Mayıs tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "30 Mayıs Dünya Multipl Skleroz (MS) Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "30 Mayıs günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-05-30', 5, 30, 'Sağlık', 'farkindalik', false, 'uluslararasi', 'MS International Federation', 'https://worldmsday.org', ARRAY['#30Mayıs', '#30mayisdunyamultiplsklerozmsgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-tutunsuz-gunu', '31 Mayıs Dünya Tütünsüz Günü', 'Tütün salgınının yol açtığı ölümlere dikkat çeken ve dumansız bir dünya hedefleyen DSÖ günü.', '## 31 Mayıs Dünya Tütünsüz Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-tutunsuz-gunu"', '2026-05-31', 5, 31, 'Sağlık', 'kutlama', false, 'turkiye', '', '', ARRAY['#TutunsuzGun', '#WorldNoTobaccoDay', '#DumansizHava', '#SigarayiBirak'], ARRAY['nefes egzersizi cihazı', 'stres topu seti', 'bitki çayı rahatlatıcı']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-cocuk-gunu', '1 Haziran Dünya Çocuk Günü', 'Çocukların refahını, güvenliğini ve mutluluğunu kutlayan uluslararası çocuk günü.', '## 1 Haziran Dünya Çocuk Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-cocuk-gunu"', '2026-06-01', 6, 1, 'Farkındalık', 'kutlama', false, 'turkiye', '', '', ARRAY['#1Haziran', '#DunyaCocukGunu', '#CocuklarGulsun', '#CocukHaklari'], ARRAY['akıl ve zeka oyunları çocuk', 'scooter çocuk 3 tekerlekli', 'çocuk hikaye kitabı seti']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '2-haziran-dunya-kosu-gunu', '2 Haziran Dünya Koşu Günü', 'Koşmanın sağlığa ve mutluluğa katkısını kutlayan spor günü.', '## 2 Haziran Dünya Koşu Günü Nedir?
Koşmanın sağlığa ve mutluluğa katkısını kutlayan spor günü.

### Tarihçesi ve Önemi
2 Haziran Dünya Koşu Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 2 Haziran tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "2 Haziran Dünya Koşu Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "2 Haziran günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-06-02', 6, 2, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#2Haziran', '#2hazirandunyakosugunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '3-haziran-dunya-bisiklet-gunu', '3 Haziran Dünya Bisiklet Günü', 'Temiz ulaşım ve hareketli yaşam için bisiklet günü.', '## 3 Haziran Dünya Bisiklet Günü Nedir?
Temiz ulaşım ve hareketli yaşam için bisiklet günü.

### Tarihçesi ve Önemi
3 Haziran Dünya Bisiklet Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/72/272) nezdinde tanınan ve her yıl 3 Haziran tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "3 Haziran Dünya Bisiklet Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "3 Haziran günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-06-03', 6, 3, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'BM (A/RES/72/272)', 'https://www.un.org', ARRAY['#3Haziran', '#3hazirandunyabisikletgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '4-haziran-catisma-kurbani-masum-cocuklar-gunu', '4 Haziran Çatışma Kurbanı Masum Çocuklar Günü', 'Savaş bölgelerindeki çocukların korunması günü.', '## 4 Haziran Çatışma Kurbanı Masum Çocuklar Günü Nedir?
Savaş bölgelerindeki çocukların korunması günü.

### Tarihçesi ve Önemi
4 Haziran Çatışma Kurbanı Masum Çocuklar Günü, gerek Türkiye''de gerekse uluslararası alanda BM nezdinde tanınan ve her yıl 4 Haziran tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "4 Haziran Çatışma Kurbanı Masum Çocuklar Günü vesilesiyle saygı ve hürmetle anıyoruz."
* "4 Haziran günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-06-04', 6, 4, 'Farkındalık', 'anma', false, 'uluslararasi', 'BM', 'https://www.un.org', ARRAY['#4Haziran', '#4hazirancatismakurbanimasumcocuklargunu'], ARRAY[]
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-cevre-gunu', '5 Haziran Dünya Çevre Günü', 'Doğayı korumak, iklim kriziyle mücadele etmek ve gezegenimizin sürdürülebilirliğini sağlamak için kutlanır.', '## 5 Haziran Dünya Çevre Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-cevre-gunu"', '2026-06-05', 6, 5, 'Çevre & Doğa', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaCevreGunu', '#SifirAtik', '#IklimKrizi', '#DogaDostu'], ARRAY['çelik matara termos', 'bez alışveriş çantası', 'bambu diş fırçası seti', 'kompost kutusu']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '6-haziran-dunya-rus-dili-gunu', '6 Haziran Dünya Rus Dili Günü', 'Puşkin''in doğum gününde Rus edebiyatı ve dili günü.', '## 6 Haziran Dünya Rus Dili Günü Nedir?
Puşkin''in doğum gününde Rus edebiyatı ve dili günü.

### Tarihçesi ve Önemi
6 Haziran Dünya Rus Dili Günü, gerek Türkiye''de gerekse uluslararası alanda UNESCO nezdinde tanınan ve her yıl 6 Haziran tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "6 Haziran Dünya Rus Dili Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "6 Haziran günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-06-06', 6, 6, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'UNESCO', 'https://www.un.org', ARRAY['#6Haziran', '#6hazirandunyarusdiligunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'turk-isaret-dili-gunu', '7 Haziran Türk İşaret Dili Günü', 'İşitme engelli bireylerin iletişim dili olan Türk İşaret Dili''nin yasal olarak tanındığı gün.', '## 7 Haziran Türk İşaret Dili Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #turk-isaret-dili-gunu"', '2026-06-07', 6, 7, 'Farkındalık', 'kutlama', false, 'turkiye', '', '', ARRAY['#TurkIsaretDiliGunu', '#TID', '#IsitmeEngelliler', '#EngelsizIletisim'], ARRAY['türk işaret dili öğrenme kitabı', 'işitme cihazı pili', 'görsel sözlük kartları']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-okyanuslar-gunu', '8 Haziran Dünya Okyanuslar Günü', 'Gezegenimizin akciğerleri olan deniz ve okyanusların plastik kirliliğinden arındırılmasını savunan gün.', '## 8 Haziran Dünya Okyanuslar Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-okyanuslar-gunu"', '2026-06-08', 6, 8, 'Çevre & Doğa', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaOkyanuslarGunu', '#WorldOceansDay', '#DenizleriKoru', '#MaviGezegen'], ARRAY['deniz gözlüğü şnorkel', 'mikrofiber hızlı kuruyan havlu', 'su geçirmez telefon kılıfı']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '9-haziran-dunya-akreditasyon-gunu', '9 Haziran Dünya Akreditasyon Günü', 'Standartlara uygunluk ve tüketici güveni günü.', '## 9 Haziran Dünya Akreditasyon Günü Nedir?
Standartlara uygunluk ve tüketici güveni günü.

### Tarihçesi ve Önemi
9 Haziran Dünya Akreditasyon Günü, gerek Türkiye''de gerekse uluslararası alanda ILAC & IAF nezdinde tanınan ve her yıl 9 Haziran tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "9 Haziran Dünya Akreditasyon Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "9 Haziran günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-06-09', 6, 9, 'Mesleki', 'kutlama', false, 'uluslararasi', 'ILAC & IAF', 'https://www.un.org', ARRAY['#9Haziran', '#9hazirandunyaakreditasyongunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '10-haziran-dunya-zanaatkarlik-ve-el-emegi-gunu', '10 Haziran Dünya Zanaatkarlık ve El Emeği Günü', 'Geleneksel el sanatları ve zanaatkarları onurlandıran gün.', '## 10 Haziran Dünya Zanaatkarlık ve El Emeği Günü Nedir?
Geleneksel el sanatları ve zanaatkarları onurlandıran gün.

### Tarihçesi ve Önemi
10 Haziran Dünya Zanaatkarlık ve El Emeği Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 10 Haziran tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "10 Haziran Dünya Zanaatkarlık ve El Emeği Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "10 Haziran günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-06-10', 6, 10, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#10Haziran', '#10hazirandunyazanaatkarlikveelemegigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '11-haziran-uluslararasi-oyun-oynama-gunu', '11 Haziran Uluslararası Oyun Oynama Günü', 'Oyunun çocuk gelişimindeki yaratıcı rolü günü.', '## 11 Haziran Uluslararası Oyun Oynama Günü Nedir?
Oyunun çocuk gelişimindeki yaratıcı rolü günü.

### Tarihçesi ve Önemi
11 Haziran Uluslararası Oyun Oynama Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/78/268) nezdinde tanınan ve her yıl 11 Haziran tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "11 Haziran Uluslararası Oyun Oynama Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "11 Haziran günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-06-11', 6, 11, 'Eğlence', 'kutlama', false, 'uluslararasi', 'BM (A/RES/78/268)', 'https://www.un.org', ARRAY['#11Haziran', '#11haziranuluslararasioyunoynamagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '12-haziran-dunya-cocuk-isciligiyle-mucadele-gunu', '12 Haziran Dünya Çocuk İşçiliğiyle Mücadele Günü', 'Çocukların çalıştırılmasına son verme günü.', '## 12 Haziran Dünya Çocuk İşçiliğiyle Mücadele Günü Nedir?
Çocukların çalıştırılmasına son verme günü.

### Tarihçesi ve Önemi
12 Haziran Dünya Çocuk İşçiliğiyle Mücadele Günü, gerek Türkiye''de gerekse uluslararası alanda ILO nezdinde tanınan ve her yıl 12 Haziran tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "12 Haziran Dünya Çocuk İşçiliğiyle Mücadele Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "12 Haziran günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-06-12', 6, 12, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'ILO', 'https://www.un.org', ARRAY['#12Haziran', '#12hazirandunyacocukisciligiylemucadelegunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '13-haziran-uluslararasi-albinizm-farkindalik-gunu', '13 Haziran Uluslararası Albinizm Farkındalık Günü', 'Albinizmli bireylerin hakları ve eşitliği günü.', '## 13 Haziran Uluslararası Albinizm Farkındalık Günü Nedir?
Albinizmli bireylerin hakları ve eşitliği günü.

### Tarihçesi ve Önemi
13 Haziran Uluslararası Albinizm Farkındalık Günü, gerek Türkiye''de gerekse uluslararası alanda BM nezdinde tanınan ve her yıl 13 Haziran tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "13 Haziran Uluslararası Albinizm Farkındalık Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "13 Haziran günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-06-13', 6, 13, 'Sağlık', 'kutlama', false, 'uluslararasi', 'BM', 'https://www.un.org', ARRAY['#13Haziran', '#13haziranuluslararasialbinizmfarkindalikgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-kan-bagiscilari-gunu', '14 Haziran Dünya Kan Bağışçıları Günü', 'Gönüllü ve karşılıksız kan bağışlayarak milyonlarca insanın hayatını kurtaran kahramanları onurlandıran gün.', '## 14 Haziran Dünya Kan Bağışçıları Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kan-bagiscilari-gunu"', '2026-06-14', 6, 14, 'Sağlık', 'kutlama', false, 'turkiye', '', '', ARRAY['#KanBagiscilariGunu', '#KanBagisiHayatKurtarir', '#Kizilay', '#KanVerCanVer'], ARRAY['kan şekeri ölçüm cihazı', 'vitamin takviyesi', 'sporcu su matarası']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '15-haziran-dunya-ruzgar-gunu', '15 Haziran Dünya Rüzgar Günü', 'Yenilenebilir rüzgar enerjisinin temiz gücü günü.', '## 15 Haziran Dünya Rüzgar Günü Nedir?
Yenilenebilir rüzgar enerjisinin temiz gücü günü.

### Tarihçesi ve Önemi
15 Haziran Dünya Rüzgar Günü, gerek Türkiye''de gerekse uluslararası alanda GWEC nezdinde tanınan ve her yıl 15 Haziran tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "15 Haziran Dünya Rüzgar Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "15 Haziran günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-06-15', 6, 15, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'GWEC', 'https://www.un.org', ARRAY['#15Haziran', '#15hazirandunyaruzgargunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '16-haziran-uluslararasi-aile-havaleleri-gunu', '16 Haziran Uluslararası Aile Havaleleri Günü', 'Göçmen işçilerin ailelerine sağladığı ekonomik destek günü.', '## 16 Haziran Uluslararası Aile Havaleleri Günü Nedir?
Göçmen işçilerin ailelerine sağladığı ekonomik destek günü.

### Tarihçesi ve Önemi
16 Haziran Uluslararası Aile Havaleleri Günü, gerek Türkiye''de gerekse uluslararası alanda BM nezdinde tanınan ve her yıl 16 Haziran tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "16 Haziran Uluslararası Aile Havaleleri Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "16 Haziran günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-06-16', 6, 16, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'BM', 'https://www.un.org', ARRAY['#16Haziran', '#16haziranuluslararasiailehavalelerigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '17-haziran-dunya-collesme-ve-kuraklikla-mucadele-gunu', '17 Haziran Dünya Çölleşme ve Kuraklıkla Mücadele Günü', 'Toprak bozulumunu önleme ve yeşillendirme günü.', '## 17 Haziran Dünya Çölleşme ve Kuraklıkla Mücadele Günü Nedir?
Toprak bozulumunu önleme ve yeşillendirme günü.

### Tarihçesi ve Önemi
17 Haziran Dünya Çölleşme ve Kuraklıkla Mücadele Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/49/115) nezdinde tanınan ve her yıl 17 Haziran tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "17 Haziran Dünya Çölleşme ve Kuraklıkla Mücadele Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "17 Haziran günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-06-17', 6, 17, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'BM (A/RES/49/115)', 'https://www.un.org', ARRAY['#17Haziran', '#17hazirandunyacollesmevekurakliklamucadelegunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '18-haziran-surdurulebilir-gastronomi-gunu', '18 Haziran Sürdürülebilir Gastronomi Günü', 'Yerel üretimi ve atıksız mutfak kültürünü kutlama günü.', '## 18 Haziran Sürdürülebilir Gastronomi Günü Nedir?
Yerel üretimi ve atıksız mutfak kültürünü kutlama günü.

### Tarihçesi ve Önemi
18 Haziran Sürdürülebilir Gastronomi Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/71/246) nezdinde tanınan ve her yıl 18 Haziran tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "18 Haziran Sürdürülebilir Gastronomi Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "18 Haziran günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-06-18', 6, 18, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'BM (A/RES/71/246)', 'https://www.un.org', ARRAY['#18Haziran', '#18haziransurdurulebilirgastronomigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '19-haziran-catismalarda-cinsel-siddeti-onleme-gunu', '19 Haziran Çatışmalarda Cinsel Şiddeti Önleme Günü', 'Savaş bölgelerinde insan onurunu koruma günü.', '## 19 Haziran Çatışmalarda Cinsel Şiddeti Önleme Günü Nedir?
Savaş bölgelerinde insan onurunu koruma günü.

### Tarihçesi ve Önemi
19 Haziran Çatışmalarda Cinsel Şiddeti Önleme Günü, gerek Türkiye''de gerekse uluslararası alanda BM nezdinde tanınan ve her yıl 19 Haziran tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "19 Haziran Çatışmalarda Cinsel Şiddeti Önleme Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "19 Haziran günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-06-19', 6, 19, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'BM', 'https://www.un.org', ARRAY['#19Haziran', '#19hazirancatismalardacinselsiddetionlemegunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '20-haziran-dunya-multeciler-gunu', '20 Haziran Dünya Mülteciler Günü', 'Yurdundan edilmiş insanların cesaret ve dayanıklılığı günü.', '## 20 Haziran Dünya Mülteciler Günü Nedir?
Yurdundan edilmiş insanların cesaret ve dayanıklılığı günü.

### Tarihçesi ve Önemi
20 Haziran Dünya Mülteciler Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/55/76) nezdinde tanınan ve her yıl 20 Haziran tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "20 Haziran Dünya Mülteciler Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "20 Haziran günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-06-20', 6, 20, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'BM (A/RES/55/76)', 'https://www.un.org', ARRAY['#20Haziran', '#20hazirandunyamultecilergunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-yoga-gunu', '21 Haziran Dünya Yoga Günü', 'Beden, zihin ve ruh dengesini kuran kadim yoga öğretisinin evrensel faydalarını kutlayan BM günü.', '## 21 Haziran Dünya Yoga Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-yoga-gunu"', '2026-06-21', 6, 21, 'Sağlık', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaYogaGunu', '#YogaDay', '#ZihinBedenRuh', '#Namaste'], ARRAY['yoga matı kaydırmaz tpe', 'yoga bloğu köpük', 'meditasyon çanı', 'yoga taytı']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'babalar-gunu', '21 Haziran Babalar Günü', 'Babalarımızın fedakarlıklarına, sevgisine ve rehberliğine teşekkür ettiğimiz anlamlı kutlama günü.', '## 21 Haziran Babalar Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #babalar-gunu"', '2026-06-21', 6, 21, 'Eğlence', 'kutlama', false, 'turkiye', '', '', ARRAY['#BabalarGunu', '#CanimBabam', '#BabaSevgisi', '#HediyeFikirleri'], ARRAY['babalar günü hediye kutusu', 'deri cüzdan kemer seti', 'tıraş makinesi seti', 'erkek kol saati']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-muzik-gunu', '21 Haziran Dünya Müzik Günü', 'Yılın en uzun gününde sokaklarda, parklarda ve salonlarda müziğin evrensel dilini kutlayan müzik festivali.', '## 21 Haziran Dünya Müzik Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-muzik-gunu"', '2026-06-21', 6, 21, 'Kültür & Sanat', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaMuzikGunu', '#FeteDeLaMusique', '#MuzikRuhunGidasidir', '#21Haziran'], ARRAY['bluetooth kulaklık', 'akustik gitar başlangıç seti', 'ukulele ahşap', 'taşınabilir hoparlör']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '22-haziran-dunya-yagmur-ormanlari-gunu', '22 Haziran Dünya Yağmur Ormanları Günü', 'Gezegenin oksijen deposu yağmur ormanlarını koruma günü.', '## 22 Haziran Dünya Yağmur Ormanları Günü Nedir?
Gezegenin oksijen deposu yağmur ormanlarını koruma günü.

### Tarihçesi ve Önemi
22 Haziran Dünya Yağmur Ormanları Günü, gerek Türkiye''de gerekse uluslararası alanda Rainforest Partnership nezdinde tanınan ve her yıl 22 Haziran tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "22 Haziran Dünya Yağmur Ormanları Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "22 Haziran günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-06-22', 6, 22, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'Rainforest Partnership', 'https://www.un.org', ARRAY['#22Haziran', '#22hazirandunyayagmurormanlarigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '23-haziran-birlesmis-milletler-kamu-hizmeti-gunu', '23 Haziran Birleşmiş Milletler Kamu Hizmeti Günü', 'Vatandaşlara hizmet eden kamu çalışanlarını onurlandırma günü.', '## 23 Haziran Birleşmiş Milletler Kamu Hizmeti Günü Nedir?
Vatandaşlara hizmet eden kamu çalışanlarını onurlandırma günü.

### Tarihçesi ve Önemi
23 Haziran Birleşmiş Milletler Kamu Hizmeti Günü, gerek Türkiye''de gerekse uluslararası alanda BM nezdinde tanınan ve her yıl 23 Haziran tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "23 Haziran Birleşmiş Milletler Kamu Hizmeti Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "23 Haziran günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-06-23', 6, 23, 'Mesleki', 'kutlama', false, 'uluslararasi', 'BM', 'https://www.un.org', ARRAY['#23Haziran', '#23haziranbirlesmismilletlerkamuhizmetigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '24-haziran-diplomaside-kadinlar-gunu', '24 Haziran Diplomaside Kadınlar Günü', 'Uluslararası barış görüşmelerinde kadın diplomatlar günü.', '## 24 Haziran Diplomaside Kadınlar Günü Nedir?
Uluslararası barış görüşmelerinde kadın diplomatlar günü.

### Tarihçesi ve Önemi
24 Haziran Diplomaside Kadınlar Günü, gerek Türkiye''de gerekse uluslararası alanda BM nezdinde tanınan ve her yıl 24 Haziran tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "24 Haziran Diplomaside Kadınlar Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "24 Haziran günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-06-24', 6, 24, 'Mesleki', 'kutlama', false, 'uluslararasi', 'BM', 'https://www.un.org', ARRAY['#24Haziran', '#24hazirandiplomasidekadinlargunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '25-haziran-dunya-denizciler-gunu', '25 Haziran Dünya Denizciler Günü', 'Küresel ticaretin yükünü taşıyan denizcilerin günü.', '## 25 Haziran Dünya Denizciler Günü Nedir?
Küresel ticaretin yükünü taşıyan denizcilerin günü.

### Tarihçesi ve Önemi
25 Haziran Dünya Denizciler Günü, gerek Türkiye''de gerekse uluslararası alanda IMO & BM nezdinde tanınan ve her yıl 25 Haziran tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "25 Haziran Dünya Denizciler Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "25 Haziran günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-06-25', 6, 25, 'Mesleki', 'kutlama', false, 'uluslararasi', 'IMO & BM', 'https://www.un.org', ARRAY['#25Haziran', '#25hazirandunyadenizcilergunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '26-haziran-uyusturucu-ile-mucadele-gunu', '26 Haziran Uyuşturucu ile Mücadele Günü', 'Zararlı maddelerden arınmış sağlıklı toplum günü.', '## 26 Haziran Uyuşturucu ile Mücadele Günü Nedir?
Zararlı maddelerden arınmış sağlıklı toplum günü.

### Tarihçesi ve Önemi
26 Haziran Uyuşturucu ile Mücadele Günü, gerek Türkiye''de gerekse uluslararası alanda BM nezdinde tanınan ve her yıl 26 Haziran tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "26 Haziran Uyuşturucu ile Mücadele Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "26 Haziran günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-06-26', 6, 26, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'BM', 'https://www.un.org', ARRAY['#26Haziran', '#26haziranuyusturucuilemucadelegunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '27-haziran-mikro-kucuk-ve-orta-buyuklukteki-isletmeler-kobi-gunu', '27 Haziran Mikro, Küçük ve Orta Büyüklükteki İşletmeler (KOBİ) Günü', 'Ekonominin belkemiği girişimciler ve KOBİ''ler günü.', '## 27 Haziran Mikro, Küçük ve Orta Büyüklükteki İşletmeler (KOBİ) Günü Nedir?
Ekonominin belkemiği girişimciler ve KOBİ''ler günü.

### Tarihçesi ve Önemi
27 Haziran Mikro, Küçük ve Orta Büyüklükteki İşletmeler (KOBİ) Günü, gerek Türkiye''de gerekse uluslararası alanda BM nezdinde tanınan ve her yıl 27 Haziran tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "27 Haziran Mikro, Küçük ve Orta Büyüklükteki İşletmeler (KOBİ) Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "27 Haziran günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-06-27', 6, 27, 'Mesleki', 'kutlama', false, 'uluslararasi', 'BM', 'https://www.un.org', ARRAY['#27Haziran', '#27haziranmikrokucukveortabuyukluktekiisletmelerkobigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '28-haziran-dunya-sosyal-medya-gunu', '28 Haziran Dünya Sosyal Medya Günü', 'Dünyayı birbirine bağlayan dijital iletişim günü.', '## 28 Haziran Dünya Sosyal Medya Günü Nedir?
Dünyayı birbirine bağlayan dijital iletişim günü.

### Tarihçesi ve Önemi
28 Haziran Dünya Sosyal Medya Günü, gerek Türkiye''de gerekse uluslararası alanda Mashable Social Media Day nezdinde tanınan ve her yıl 28 Haziran tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "28 Haziran Dünya Sosyal Medya Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "28 Haziran günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-06-28', 6, 28, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Mashable Social Media Day', 'https://www.un.org', ARRAY['#28Haziran', '#28hazirandunyasosyalmedyagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '29-haziran-uluslararasi-tropikler-gunu', '29 Haziran Uluslararası Tropikler Günü', 'Tropik bölgelerin biyoçeşitliliği ve zenginliği günü.', '## 29 Haziran Uluslararası Tropikler Günü Nedir?
Tropik bölgelerin biyoçeşitliliği ve zenginliği günü.

### Tarihçesi ve Önemi
29 Haziran Uluslararası Tropikler Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/70/267) nezdinde tanınan ve her yıl 29 Haziran tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "29 Haziran Uluslararası Tropikler Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "29 Haziran günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-06-29', 6, 29, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'BM (A/RES/70/267)', 'https://www.un.org', ARRAY['#29Haziran', '#29haziranuluslararasitropiklergunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-sosyal-medya-gunu', '30 Haziran Dünya Sosyal Medya Günü', 'İnsanları kıtalar ötesinde birbirine bağlayan dijital iletişim devrimini kutlayan küresel gün.', '## 30 Haziran Dünya Sosyal Medya Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-sosyal-medya-gunu"', '2026-06-30', 6, 30, 'Eğlence', 'kutlama', false, 'turkiye', '', '', ARRAY['#SosyalMedyaGunu', '#SocialMediaDay', '#DijitalDunya', '#Baglanti'], ARRAY['ring light halka ışık tripodlu', 'yaka mikrofonu kablosuz', 'telefon sabitleyici gimbal']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'kabotaj-bayrami', '1 Temmuz Denizcilik ve Kabotaj Bayramı', 'Türk karasularında egemenliğin ve deniz ticareti hakkının Türkiye''ye geçtiği tarihi milli bayram.', '## 1 Temmuz Denizcilik ve Kabotaj Bayramı Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #kabotaj-bayrami"', '2026-07-01', 7, 1, 'Resmi', 'kutlama', false, 'turkiye', '', '', ARRAY['#1Temmuz', '#KabotajBayrami', '#DenizcilikBayrami', '#MaviVatan'], ARRAY['yelkenli gemi maketi', 'denizci şapkası', 'deniz kabuğu bileklik', 'su geçirmez çanta']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '2-temmuz-dunya-ufo-gunu', '2 Temmuz Dünya UFO Günü', 'Evrende yaşam arayışı ve gökyüzü gözlemleri günü.', '## 2 Temmuz Dünya UFO Günü Nedir?
Evrende yaşam arayışı ve gökyüzü gözlemleri günü.

### Tarihçesi ve Önemi
2 Temmuz Dünya UFO Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 2 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "2 Temmuz Dünya UFO Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "2 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-02', 7, 2, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#2Temmuz', '#2temmuzdunyaufogunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '3-temmuz-plastik-poset-kullanmama-gunu', '3 Temmuz Plastik Poşet Kullanmama Günü', 'Plastik atıklara son verme ve bez torba kullanma günü.', '## 3 Temmuz Plastik Poşet Kullanmama Günü Nedir?
Plastik atıklara son verme ve bez torba kullanma günü.

### Tarihçesi ve Önemi
3 Temmuz Plastik Poşet Kullanmama Günü, gerek Türkiye''de gerekse uluslararası alanda Plastic Free July nezdinde tanınan ve her yıl 3 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "3 Temmuz Plastik Poşet Kullanmama Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "3 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-03', 7, 3, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'Plastic Free July', 'https://www.un.org', ARRAY['#3Temmuz', '#3temmuzplastikposetkullanmamagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '4-temmuz-dunya-bagimsizlik-ve-ifade-ozgurlugu-gunu', '4 Temmuz Dünya Bağımsızlık ve İfade Özgürlüğü Günü', 'Temel insan hakları ve özgür düşünce günü.', '## 4 Temmuz Dünya Bağımsızlık ve İfade Özgürlüğü Günü Nedir?
Temel insan hakları ve özgür düşünce günü.

### Tarihçesi ve Önemi
4 Temmuz Dünya Bağımsızlık ve İfade Özgürlüğü Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 4 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "4 Temmuz Dünya Bağımsızlık ve İfade Özgürlüğü Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "4 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-04', 7, 4, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#4Temmuz', '#4temmuzdunyabagimsizlikveifadeozgurlugugunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '5-temmuz-dunya-yaz-modasi-ve-bikini-gunu', '5 Temmuz Dünya Yaz Modası ve Bikini Günü', 'Yaz mevsimi ve tekstil tasarımının neşeli günü.', '## 5 Temmuz Dünya Yaz Modası ve Bikini Günü Nedir?
Yaz mevsimi ve tekstil tasarımının neşeli günü.

### Tarihçesi ve Önemi
5 Temmuz Dünya Yaz Modası ve Bikini Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 5 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "5 Temmuz Dünya Yaz Modası ve Bikini Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "5 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-05', 7, 5, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#5Temmuz', '#5temmuzdunyayazmodasivebikinigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '6-temmuz-dunya-opucuk-gunu', '6 Temmuz Dünya Öpücük Günü', 'Sevgi ve romantizmi ifade eden evrensel gün.', '## 6 Temmuz Dünya Öpücük Günü Nedir?
Sevgi ve romantizmi ifade eden evrensel gün.

### Tarihçesi ve Önemi
6 Temmuz Dünya Öpücük Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 6 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "6 Temmuz Dünya Öpücük Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "6 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-06', 7, 6, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#6Temmuz', '#6temmuzdunyaopucukgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-cikolata-gunu', '7 Temmuz Dünya Çikolata Günü', 'Kakao çekirdeğinden üretilen dünyanın en sevilen tatlısının keşfini kutlayan lezzetli gün.', '## 7 Temmuz Dünya Çikolata Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-cikolata-gunu"', '2026-07-07', 7, 7, 'Eğlence', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaCikolataGunu', '#WorldChocolateDay', '#CikolataSever', '#TatliKriz'], ARRAY['belçika çikolatası kutusu', 'çikolata fondü seti', 'sıcak çikolata tozu', 'çikolatalı trüf']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '8-temmuz-dunya-video-oyunlari-gunu', '8 Temmuz Dünya Video Oyunları Günü', 'Dijital oyun kültürü ve yaratıcı oyun yapımcıları günü.', '## 8 Temmuz Dünya Video Oyunları Günü Nedir?
Dijital oyun kültürü ve yaratıcı oyun yapımcıları günü.

### Tarihçesi ve Önemi
8 Temmuz Dünya Video Oyunları Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 8 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "8 Temmuz Dünya Video Oyunları Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "8 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-08', 7, 8, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#8Temmuz', '#8temmuzdunyavideooyunlarigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '9-temmuz-dunya-sekerleme-ve-tatli-gunu', '9 Temmuz Dünya Şekerleme ve Tatlı Günü', 'Geleneksel tatlılar ve sevdiklerle paylaşılan lezzetler günü.', '## 9 Temmuz Dünya Şekerleme ve Tatlı Günü Nedir?
Geleneksel tatlılar ve sevdiklerle paylaşılan lezzetler günü.

### Tarihçesi ve Önemi
9 Temmuz Dünya Şekerleme ve Tatlı Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 9 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "9 Temmuz Dünya Şekerleme ve Tatlı Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "9 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-09', 7, 9, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#9Temmuz', '#9temmuzdunyasekerlemevetatligunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '10-temmuz-dunya-hukuk-gunu', '10 Temmuz Dünya Hukuk Günü', 'Hukukun üstünlüğü ve adil yargılanma hakkı günü.', '## 10 Temmuz Dünya Hukuk Günü Nedir?
Hukukun üstünlüğü ve adil yargılanma hakkı günü.

### Tarihçesi ve Önemi
10 Temmuz Dünya Hukuk Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 10 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "10 Temmuz Dünya Hukuk Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "10 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-10', 7, 10, 'Mesleki', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#10Temmuz', '#10temmuzdunyahukukgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '11-temmuz-dunya-nufus-gunu', '11 Temmuz Dünya Nüfus Günü', 'Demografik değişimler ve sürdürülebilir kalkınma günü.', '## 11 Temmuz Dünya Nüfus Günü Nedir?
Demografik değişimler ve sürdürülebilir kalkınma günü.

### Tarihçesi ve Önemi
11 Temmuz Dünya Nüfus Günü, gerek Türkiye''de gerekse uluslararası alanda BM UNDP nezdinde tanınan ve her yıl 11 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "11 Temmuz Dünya Nüfus Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "11 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-11', 7, 11, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'BM UNDP', 'https://www.un.org', ARRAY['#11Temmuz', '#11temmuzdunyanufusgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '12-temmuz-malala-gunu-kiz-cocuklarinin-egitimi', '12 Temmuz Malala Günü (Kız Çocuklarının Eğitimi)', 'Tüm kız çocuklarının eğitim hakkını savunan BM günü.', '## 12 Temmuz Malala Günü (Kız Çocuklarının Eğitimi) Nedir?
Tüm kız çocuklarının eğitim hakkını savunan BM günü.

### Tarihçesi ve Önemi
12 Temmuz Malala Günü (Kız Çocuklarının Eğitimi), gerek Türkiye''de gerekse uluslararası alanda BM nezdinde tanınan ve her yıl 12 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "12 Temmuz Malala Günü (Kız Çocuklarının Eğitimi) kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "12 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-12', 7, 12, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'BM', 'https://www.un.org', ARRAY['#12Temmuz', '#12temmuzmalalagunukizcocuklarininegitimi'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '13-temmuz-dunya-rock-muzigi-gunu', '13 Temmuz Dünya Rock Müziği Günü', 'Live Aid anısına rock müziğin özgür ruhunu kutlama günü.', '## 13 Temmuz Dünya Rock Müziği Günü Nedir?
Live Aid anısına rock müziğin özgür ruhunu kutlama günü.

### Tarihçesi ve Önemi
13 Temmuz Dünya Rock Müziği Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 13 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "13 Temmuz Dünya Rock Müziği Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "13 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-13', 7, 13, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#13Temmuz', '#13temmuzdunyarockmuzigigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '14-temmuz-kopekbaliklari-farkindalik-gunu', '14 Temmuz Köpekbalıkları Farkındalık Günü', 'Denizlerin tepe avcıları köpekbalıklarını koruma günü.', '## 14 Temmuz Köpekbalıkları Farkındalık Günü Nedir?
Denizlerin tepe avcıları köpekbalıklarını koruma günü.

### Tarihçesi ve Önemi
14 Temmuz Köpekbalıkları Farkındalık Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 14 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "14 Temmuz Köpekbalıkları Farkındalık Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "14 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-14', 7, 14, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#14Temmuz', '#14temmuzkopekbaliklarifarkindalikgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'demokrasi-ve-milli-birlik-gunu', '15 Temmuz Demokrasi ve Milli Birlik Günü', '15 Temmuz 2016 darbe girişimine karşı milletimizin gösterdiği destansı direnişi ve şehitlerimizi anma günü.', '## 15 Temmuz Demokrasi ve Milli Birlik Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #demokrasi-ve-milli-birlik-gunu"', '2026-07-15', 7, 15, 'Resmi', 'kutlama', false, 'turkiye', '', '', ARRAY['#15Temmuz', '#DemokrasiBayrami', '#MilliBirlikGunu', '#SehitlerimiziUnutmadik'], ARRAY['türk bayrağı büyük boy', '15 temmuz anı kitabı', 'atatürk tişörtü']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '16-temmuz-dunya-yilanlar-ve-surungenler-gunu', '16 Temmuz Dünya Yılanlar ve Sürüngenler Günü', 'Ekosistem için kritik sürüngen türlerini tanıma günü.', '## 16 Temmuz Dünya Yılanlar ve Sürüngenler Günü Nedir?
Ekosistem için kritik sürüngen türlerini tanıma günü.

### Tarihçesi ve Önemi
16 Temmuz Dünya Yılanlar ve Sürüngenler Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 16 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "16 Temmuz Dünya Yılanlar ve Sürüngenler Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "16 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-16', 7, 16, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#16Temmuz', '#16temmuzdunyayilanlarvesurungenlergunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-emoji-gunu', '17 Temmuz Dünya Emoji Günü', 'Dijital çağın küresel dili olan emojilerin iletişimdeki eğlenceli rolünü kutlayan internet günü.', '## 17 Temmuz Dünya Emoji Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-emoji-gunu"', '2026-07-17', 7, 17, 'Eğlence', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaEmojiGunu', '#WorldEmojiDay', '#EmojiGunu', '#DijitalIletisim'], ARRAY['emoji yastık peluş', 'emoji anahtarlık', 'renkli sticker çıkartma seti']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '18-temmuz-nelson-mandela-uluslararasi-gunu', '18 Temmuz Nelson Mandela Uluslararası Günü', 'Irkçılıkla mücadele ve barış için 67 dakikalık kamu hizmeti günü.', '## 18 Temmuz Nelson Mandela Uluslararası Günü Nedir?
Irkçılıkla mücadele ve barış için 67 dakikalık kamu hizmeti günü.

### Tarihçesi ve Önemi
18 Temmuz Nelson Mandela Uluslararası Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/64/13) nezdinde tanınan ve her yıl 18 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "18 Temmuz Nelson Mandela Uluslararası Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "18 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-18', 7, 18, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'BM (A/RES/64/13)', 'https://www.un.org', ARRAY['#18Temmuz', '#18temmuznelsonmandelauluslararasigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '19-temmuz-dunya-dondurma-gunu', '19 Temmuz Dünya Dondurma Günü', 'Sıcak yaz günlerini tatlandıran dondurma lezzeti günü.', '## 19 Temmuz Dünya Dondurma Günü Nedir?
Sıcak yaz günlerini tatlandıran dondurma lezzeti günü.

### Tarihçesi ve Önemi
19 Temmuz Dünya Dondurma Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 19 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "19 Temmuz Dünya Dondurma Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "19 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-19', 7, 19, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#19Temmuz', '#19temmuzdunyadondurmagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-satranc-gunu', '20 Temmuz Dünya Satranç Günü', 'Strateji, zeka ve sabır oyunu satrancın zihinsel gelişimdeki gücünü kutlamak için FIDE öncülüğünde kutlanır.', '## 20 Temmuz Dünya Satranç Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-satranc-gunu"', '2026-07-20', 7, 20, 'Eğlence', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaSatrancGunu', '#ChessDay', '#SatrancSeverler', '#ZekaOyunu'], ARRAY['ahşap satranç takımı', 'dijital satranç saati', 'satranç taktikleri kitabı', 'manyetik seyahat satrancı']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '21-temmuz-dunya-abur-cubur-gunu', '21 Temmuz Dünya Abur Cubur Günü', 'Arada bir kendimizi ödüllendirdiğimiz eğlenceli atıştırmalıklar günü.', '## 21 Temmuz Dünya Abur Cubur Günü Nedir?
Arada bir kendimizi ödüllendirdiğimiz eğlenceli atıştırmalıklar günü.

### Tarihçesi ve Önemi
21 Temmuz Dünya Abur Cubur Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 21 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "21 Temmuz Dünya Abur Cubur Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "21 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-21', 7, 21, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#21Temmuz', '#21temmuzdunyaaburcuburgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '22-temmuz-dunya-beyin-gunu', '22 Temmuz Dünya Beyin Günü', 'Nörolojik sağlık ve zihinsel zindeliği koruma günü.', '## 22 Temmuz Dünya Beyin Günü Nedir?
Nörolojik sağlık ve zihinsel zindeliği koruma günü.

### Tarihçesi ve Önemi
22 Temmuz Dünya Beyin Günü, gerek Türkiye''de gerekse uluslararası alanda World Federation of Neurology nezdinde tanınan ve her yıl 22 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "22 Temmuz Dünya Beyin Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "22 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-22', 7, 22, 'Sağlık', 'kutlama', false, 'uluslararasi', 'World Federation of Neurology', 'https://www.un.org', ARRAY['#22Temmuz', '#22temmuzdunyabeyingunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '23-temmuz-dunya-buyukanneler-ve-buyukbabalar-gunu', '23 Temmuz Dünya Büyükanneler ve Büyükbabalar Günü', 'Ailenin bilge çınarları büyüklerimizi ziyaret etme günü.', '## 23 Temmuz Dünya Büyükanneler ve Büyükbabalar Günü Nedir?
Ailenin bilge çınarları büyüklerimizi ziyaret etme günü.

### Tarihçesi ve Önemi
23 Temmuz Dünya Büyükanneler ve Büyükbabalar Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 23 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "23 Temmuz Dünya Büyükanneler ve Büyükbabalar Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "23 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-23', 7, 23, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#23Temmuz', '#23temmuzdunyabuyukannelervebuyukbabalargunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '24-temmuz-gazeteciler-ve-basin-bayrami', '24 Temmuz Gazeteciler ve Basın Bayramı', '1908 yılında sansürün kaldırılışını onurlandıran Türk basın günü.', '## 24 Temmuz Gazeteciler ve Basın Bayramı Nedir?
1908 yılında sansürün kaldırılışını onurlandıran Türk basın günü.

### Tarihçesi ve Önemi
24 Temmuz Gazeteciler ve Basın Bayramı, gerek Türkiye''de gerekse uluslararası alanda T.C. İletişim Başkanlığı nezdinde tanınan ve her yıl 24 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "24 Temmuz Gazeteciler ve Basın Bayramı kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "24 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-24', 7, 24, 'Mesleki', 'kutlama', false, 'uluslararasi', 'T.C. İletişim Başkanlığı', 'https://www.un.org', ARRAY['#24Temmuz', '#24temmuzgazetecilervebasinbayrami'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '25-temmuz-bogulmayi-onleme-gunu', '25 Temmuz Boğulmayı Önleme Günü', 'Suda boğulma vakalarını önleme ve cankurtaranlık bilinci günü.', '## 25 Temmuz Boğulmayı Önleme Günü Nedir?
Suda boğulma vakalarını önleme ve cankurtaranlık bilinci günü.

### Tarihçesi ve Önemi
25 Temmuz Boğulmayı Önleme Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/75/273) nezdinde tanınan ve her yıl 25 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "25 Temmuz Boğulmayı Önleme Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "25 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-25', 7, 25, 'Sağlık', 'kutlama', false, 'uluslararasi', 'BM (A/RES/75/273)', 'https://www.un.org', ARRAY['#25Temmuz', '#25temmuzbogulmayionlemegunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '26-temmuz-mangrov-ekosistemini-koruma-gunu', '26 Temmuz Mangrov Ekosistemini Koruma Günü', 'Kıyı şeritlerini fırtınalardan koruyan mangrov ormanları günü.', '## 26 Temmuz Mangrov Ekosistemini Koruma Günü Nedir?
Kıyı şeritlerini fırtınalardan koruyan mangrov ormanları günü.

### Tarihçesi ve Önemi
26 Temmuz Mangrov Ekosistemini Koruma Günü, gerek Türkiye''de gerekse uluslararası alanda UNESCO nezdinde tanınan ve her yıl 26 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "26 Temmuz Mangrov Ekosistemini Koruma Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "26 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-26', 7, 26, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'UNESCO', 'https://www.un.org', ARRAY['#26Temmuz', '#26temmuzmangrovekosisteminikorumagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '27-temmuz-bas-ve-boyun-kanserleri-farkindalik-gunu', '27 Temmuz Baş ve Boyun Kanserleri Farkındalık Günü', 'Erken tanı ve tütün/alkol risklerine karşı bilinçlenme günü.', '## 27 Temmuz Baş ve Boyun Kanserleri Farkındalık Günü Nedir?
Erken tanı ve tütün/alkol risklerine karşı bilinçlenme günü.

### Tarihçesi ve Önemi
27 Temmuz Baş ve Boyun Kanserleri Farkındalık Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 27 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "27 Temmuz Baş ve Boyun Kanserleri Farkındalık Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "27 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-27', 7, 27, 'Sağlık', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#27Temmuz', '#27temmuzbasveboyunkanserlerifarkindalikgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '28-temmuz-dunya-hepatit-gunu', '28 Temmuz Dünya Hepatit Günü', 'Karaciğer sağlığı ve hepatit aşılaması günü.', '## 28 Temmuz Dünya Hepatit Günü Nedir?
Karaciğer sağlığı ve hepatit aşılaması günü.

### Tarihçesi ve Önemi
28 Temmuz Dünya Hepatit Günü, gerek Türkiye''de gerekse uluslararası alanda DSÖ / WHO nezdinde tanınan ve her yıl 28 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "28 Temmuz Dünya Hepatit Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "28 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-28', 7, 28, 'Sağlık', 'kutlama', false, 'uluslararasi', 'DSÖ / WHO', 'https://www.un.org', ARRAY['#28Temmuz', '#28temmuzdunyahepatitgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '29-temmuz-uluslararasi-kaplan-gunu', '29 Temmuz Uluslararası Kaplan Günü', 'Vahşi doğanın muhteşem kedileri kaplanların korunması günü.', '## 29 Temmuz Uluslararası Kaplan Günü Nedir?
Vahşi doğanın muhteşem kedileri kaplanların korunması günü.

### Tarihçesi ve Önemi
29 Temmuz Uluslararası Kaplan Günü, gerek Türkiye''de gerekse uluslararası alanda Global Tiger Initiative nezdinde tanınan ve her yıl 29 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "29 Temmuz Uluslararası Kaplan Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "29 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-29', 7, 29, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'Global Tiger Initiative', 'https://www.un.org', ARRAY['#29Temmuz', '#29temmuzuluslararasikaplangunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'uluslararasi-dostluk-gunu', '30 Temmuz Uluslararası Dostluk Günü', 'Halklar, ülkeler, kültürler ve bireyler arasındaki dostluk köprülerinin barış getireceğini savunan BM günü.', '## 30 Temmuz Uluslararası Dostluk Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #uluslararasi-dostluk-gunu"', '2026-07-30', 7, 30, 'Eğlence', 'kutlama', false, 'turkiye', '', '', ARRAY['#DostlukGunu', '#FriendshipDay', '#CanDostum', '#Dostluk'], ARRAY['arkadaşlık bilekliği çift', 'anı albümü yapışkanlı', 'arkadaşa esprili hediye']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '31-temmuz-dunya-doga-koruculari-gunu', '31 Temmuz Dünya Doğa Korucuları Günü', 'Yaban hayatı korurken hayatını riske atan korucular günü.', '## 31 Temmuz Dünya Doğa Korucuları Günü Nedir?
Yaban hayatı korurken hayatını riske atan korucular günü.

### Tarihçesi ve Önemi
31 Temmuz Dünya Doğa Korucuları Günü, gerek Türkiye''de gerekse uluslararası alanda International Ranger Federation nezdinde tanınan ve her yıl 31 Temmuz tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "31 Temmuz Dünya Doğa Korucuları Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "31 Temmuz günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-07-31', 7, 31, 'Mesleki', 'kutlama', false, 'uluslararasi', 'International Ranger Federation', 'https://www.un.org', ARRAY['#31Temmuz', '#31temmuzdunyadogakorucularigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '1-agustos-dunya-akciger-kanseri-gunu', '1 Ağustos Dünya Akciğer Kanseri Günü', 'Akciğer sağlığı ve tütünden uzak durma farkındalığı.', '## 1 Ağustos Dünya Akciğer Kanseri Günü Nedir?
Akciğer sağlığı ve tütünden uzak durma farkındalığı.

### Tarihçesi ve Önemi
1 Ağustos Dünya Akciğer Kanseri Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 1 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "1 Ağustos Dünya Akciğer Kanseri Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "1 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-01', 8, 1, 'Sağlık', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#1Ağustos', '#1agustosdunyaakcigerkanserigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '2-agustos-dunya-renkli-coraplar-gunu', '2 Ağustos Dünya Renkli Çoraplar Günü', 'Giyime neşe katan renkli tasarımlar günü.', '## 2 Ağustos Dünya Renkli Çoraplar Günü Nedir?
Giyime neşe katan renkli tasarımlar günü.

### Tarihçesi ve Önemi
2 Ağustos Dünya Renkli Çoraplar Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 2 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "2 Ağustos Dünya Renkli Çoraplar Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "2 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-02', 8, 2, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#2Ağustos', '#2agustosdunyarenklicoraplargunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '3-agustos-dunya-karpuz-gunu', '3 Ağustos Dünya Karpuz Günü', 'Yaz mevsiminin serinletici meyvesi karpuz günü.', '## 3 Ağustos Dünya Karpuz Günü Nedir?
Yaz mevsiminin serinletici meyvesi karpuz günü.

### Tarihçesi ve Önemi
3 Ağustos Dünya Karpuz Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 3 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "3 Ağustos Dünya Karpuz Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "3 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-03', 8, 3, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#3Ağustos', '#3agustosdunyakarpuzgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '4-agustos-dunya-baykuslar-ve-yirtici-kuslar-gunu', '4 Ağustos Dünya Baykuşlar ve Yırtıcı Kuşlar Günü', 'Gecenin sessiz avcıları baykuşları koruma günü.', '## 4 Ağustos Dünya Baykuşlar ve Yırtıcı Kuşlar Günü Nedir?
Gecenin sessiz avcıları baykuşları koruma günü.

### Tarihçesi ve Önemi
4 Ağustos Dünya Baykuşlar ve Yırtıcı Kuşlar Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 4 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "4 Ağustos Dünya Baykuşlar ve Yırtıcı Kuşlar Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "4 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-04', 8, 4, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#4Ağustos', '#4agustosdunyabaykuslarveyirticikuslargunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '5-agustos-dunya-trafik-isiklari-gunu', '5 Ağustos Dünya Trafik Işıkları Günü', 'Yol güvenliği ve düzenli şehir trafiği günü.', '## 5 Ağustos Dünya Trafik Işıkları Günü Nedir?
Yol güvenliği ve düzenli şehir trafiği günü.

### Tarihçesi ve Önemi
5 Ağustos Dünya Trafik Işıkları Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 5 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "5 Ağustos Dünya Trafik Işıkları Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "5 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-05', 8, 5, 'Mesleki', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#5Ağustos', '#5agustosdunyatrafikisiklarigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '6-agustos-hirosima-baris-anma-gunu', '6 Ağustos Hiroşima Barış Anma Günü', 'Atom bombası kurbanlarını ve nükleersiz barış idealini anma günü.', '## 6 Ağustos Hiroşima Barış Anma Günü Nedir?
Atom bombası kurbanlarını ve nükleersiz barış idealini anma günü.

### Tarihçesi ve Önemi
6 Ağustos Hiroşima Barış Anma Günü, gerek Türkiye''de gerekse uluslararası alanda Hiroshima Peace Memorial nezdinde tanınan ve her yıl 6 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "6 Ağustos Hiroşima Barış Anma Günü vesilesiyle saygı ve hürmetle anıyoruz."
* "6 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-06', 8, 6, 'Farkındalık', 'anma', false, 'uluslararasi', 'Hiroshima Peace Memorial', 'https://www.un.org', ARRAY['#6Ağustos', '#6agustoshirosimabarisanmagunu'], ARRAY[]
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '7-agustos-dunya-deniz-feneri-gunu', '7 Ağustos Dünya Deniz Feneri Günü', 'Karanlık denizleri aydınlatan tarihi deniz fenerleri günü.', '## 7 Ağustos Dünya Deniz Feneri Günü Nedir?
Karanlık denizleri aydınlatan tarihi deniz fenerleri günü.

### Tarihçesi ve Önemi
7 Ağustos Dünya Deniz Feneri Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 7 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "7 Ağustos Dünya Deniz Feneri Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "7 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-07', 8, 7, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#7Ağustos', '#7agustosdunyadenizfenerigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '8-agustos-dunya-kediler-gunu', '8 Ağustos Dünya Kediler Günü', 'Evimizin ve sokakların sevimli patili dostları günü.', '## 8 Ağustos Dünya Kediler Günü Nedir?
Evimizin ve sokakların sevimli patili dostları günü.

### Tarihçesi ve Önemi
8 Ağustos Dünya Kediler Günü, gerek Türkiye''de gerekse uluslararası alanda IFAW nezdinde tanınan ve her yıl 8 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "8 Ağustos Dünya Kediler Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "8 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-08', 8, 8, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'IFAW', 'https://www.un.org', ARRAY['#8Ağustos', '#8agustosdunyakedilergunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '9-agustos-dunya-yerli-halklar-gunu-ve-kitapseverler-gunu', '9 Ağustos Dünya Yerli Halklar Günü ve Kitapseverler Günü', 'Geleneksel halkların mirası ve kitap okuma tutkusu günü.', '## 9 Ağustos Dünya Yerli Halklar Günü ve Kitapseverler Günü Nedir?
Geleneksel halkların mirası ve kitap okuma tutkusu günü.

### Tarihçesi ve Önemi
9 Ağustos Dünya Yerli Halklar Günü ve Kitapseverler Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/49/214) nezdinde tanınan ve her yıl 9 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "9 Ağustos Dünya Yerli Halklar Günü ve Kitapseverler Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "9 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-09', 8, 9, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'BM (A/RES/49/214)', 'https://www.un.org', ARRAY['#9Ağustos', '#9agustosdunyayerlihalklargunuvekitapseverlergunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '10-agustos-dunya-aslan-gunu', '10 Ağustos Dünya Aslan Günü', 'Savana kralları aslanların neslini koruma günü.', '## 10 Ağustos Dünya Aslan Günü Nedir?
Savana kralları aslanların neslini koruma günü.

### Tarihçesi ve Önemi
10 Ağustos Dünya Aslan Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 10 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "10 Ağustos Dünya Aslan Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "10 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-10', 8, 10, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#10Ağustos', '#10agustosdunyaaslangunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '11-agustos-dunya-celik-ve-sanayi-uretimi-gunu', '11 Ağustos Dünya Çelik ve Sanayi Üretimi Günü', 'Ağır sanayi emekçileri ve mimari çelik üretimi günü.', '## 11 Ağustos Dünya Çelik ve Sanayi Üretimi Günü Nedir?
Ağır sanayi emekçileri ve mimari çelik üretimi günü.

### Tarihçesi ve Önemi
11 Ağustos Dünya Çelik ve Sanayi Üretimi Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 11 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "11 Ağustos Dünya Çelik ve Sanayi Üretimi Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "11 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-11', 8, 11, 'Mesleki', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#11Ağustos', '#11agustosdunyacelikvesanayiuretimigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '12-agustos-uluslararasi-genclik-gunu-ve-dunya-fil-gunu', '12 Ağustos Uluslararası Gençlik Günü ve Dünya Fil Günü', 'Gençlerin geleceğe yön vermesi ve filleri koruma günü.', '## 12 Ağustos Uluslararası Gençlik Günü ve Dünya Fil Günü Nedir?
Gençlerin geleceğe yön vermesi ve filleri koruma günü.

### Tarihçesi ve Önemi
12 Ağustos Uluslararası Gençlik Günü ve Dünya Fil Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/54/120) nezdinde tanınan ve her yıl 12 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "12 Ağustos Uluslararası Gençlik Günü ve Dünya Fil Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "12 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-12', 8, 12, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'BM (A/RES/54/120)', 'https://www.un.org', ARRAY['#12Ağustos', '#12agustosuluslararasigenclikgunuvedunyafilgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-solaklar-gunu', '13 Ağustos Dünya Solaklar Günü', 'Dünya nüfusunun yaklaşık yüzde 10''unu oluşturan solakların günlük hayattaki zorluklarına dikkat çeken gün.', '## 13 Ağustos Dünya Solaklar Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-solaklar-gunu"', '2026-08-13', 8, 13, 'Eğlence', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaSolaklarGunu', '#LefthandersDay', '#SolaklarGunu', '#SolEl'], ARRAY['solaklar için makas', 'sol el ergonomik mouse', 'solaklar için dolma kalem']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '14-agustos-dunya-kertenkeleler-gunu', '14 Ağustos Dünya Kertenkeleler Günü', 'Sürüngen türlerinin doğadaki dengesini hatırlatan gün.', '## 14 Ağustos Dünya Kertenkeleler Günü Nedir?
Sürüngen türlerinin doğadaki dengesini hatırlatan gün.

### Tarihçesi ve Önemi
14 Ağustos Dünya Kertenkeleler Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 14 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "14 Ağustos Dünya Kertenkeleler Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "14 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-14', 8, 14, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#14Ağustos', '#14agustosdunyakertenkelelergunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '15-agustos-dunya-rahatlama-ve-dinlenme-gunu', '15 Ağustos Dünya Rahatlama ve Dinlenme Günü', 'Stresi arkada bırakıp zihinsel ve bedensel dinlenme günü.', '## 15 Ağustos Dünya Rahatlama ve Dinlenme Günü Nedir?
Stresi arkada bırakıp zihinsel ve bedensel dinlenme günü.

### Tarihçesi ve Önemi
15 Ağustos Dünya Rahatlama ve Dinlenme Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 15 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "15 Ağustos Dünya Rahatlama ve Dinlenme Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "15 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-15', 8, 15, 'Sağlık', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#15Ağustos', '#15agustosdunyarahatlamavedinlenmegunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '16-agustos-dunya-paten-ve-kaykay-gunu', '16 Ağustos Dünya Paten ve Kaykay Günü', 'Şehir sokaklarında paten ve kaykayla spor yapma günü.', '## 16 Ağustos Dünya Paten ve Kaykay Günü Nedir?
Şehir sokaklarında paten ve kaykayla spor yapma günü.

### Tarihçesi ve Önemi
16 Ağustos Dünya Paten ve Kaykay Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 16 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "16 Ağustos Dünya Paten ve Kaykay Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "16 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-16', 8, 16, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#16Ağustos', '#16agustosdunyapatenvekaykaygunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '17-agustos-marmara-depremini-anma-gunu', '17 Ağustos Marmara Depremini Anma Günü', '17 Ağustos 1999 deprem şehitlerini saygıyla anma ve afet bilinci günü.', '## 17 Ağustos Marmara Depremini Anma Günü Nedir?
17 Ağustos 1999 deprem şehitlerini saygıyla anma ve afet bilinci günü.

### Tarihçesi ve Önemi
17 Ağustos Marmara Depremini Anma Günü, gerek Türkiye''de gerekse uluslararası alanda AFAD & Kandilli nezdinde tanınan ve her yıl 17 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "17 Ağustos Marmara Depremini Anma Günü vesilesiyle saygı ve hürmetle anıyoruz."
* "17 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-17', 8, 17, 'Farkındalık', 'anma', false, 'uluslararasi', 'AFAD & Kandilli', 'https://www.un.org', ARRAY['#17Ağustos', '#17agustosmarmaradepreminianmagunu'], ARRAY[]
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '18-agustos-bilim-insanlarini-onurlandirma-gunu', '18 Ağustos Bilim İnsanlarını Onurlandırma Günü', 'İnsanlığı aydınlatan araştırmacı ve akademisyenleri onurlandırma günü.', '## 18 Ağustos Bilim İnsanlarını Onurlandırma Günü Nedir?
İnsanlığı aydınlatan araştırmacı ve akademisyenleri onurlandırma günü.

### Tarihçesi ve Önemi
18 Ağustos Bilim İnsanlarını Onurlandırma Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 18 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "18 Ağustos Bilim İnsanlarını Onurlandırma Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "18 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-18', 8, 18, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#18Ağustos', '#18agustosbiliminsanlarinionurlandirmagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-insani-yardim-gunu', '19 Ağustos Dünya İnsani Yardım Günü', 'Kriz ve savaş bölgelerinde canları pahasına insanlara yardım eli uzatan yardım çalışanlarını anma günü.', '## 19 Ağustos Dünya İnsani Yardım Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-insani-yardim-gunu"', '2026-08-19', 8, 19, 'Uluslararası', 'kutlama', false, 'turkiye', '', '', ARRAY['#InsaniYardimGunu', '#WorldHumanitarianDay', '#YardimEli', '#Dayanisma'], ARRAY['kızılay bağış kartı', 'yardım vakfı sertifikası', 'çelik matara']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-fotografcilik-gunu', '19 Ağustos Dünya Fotoğrafçılık Günü', 'Anı ölümsüzleştiren fotoğraf sanatının doğuşunu (Dagerreyotipi patentini) kutlayan küresel sanat günü.', '## 19 Ağustos Dünya Fotoğrafçılık Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-fotografcilik-gunu"', '2026-08-19', 8, 19, 'Kültür & Sanat', 'kutlama', false, 'turkiye', '', '', ARRAY['#FotografcilikGunu', '#WorldPhotographyDay', '#FotografSever', '#Kadraj'], ARRAY['fotoğraf makinesi askısı', 'lens temizleme kiti', 'telefon için fotoğraf lensi', 'fotoğraf albümü']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '20-agustos-dunya-sivrisinek-gunu', '20 Ağustos Dünya Sivrisinek Günü', 'Sıtma ve bulaşıcı hastalıklarla mücadele tarihi günü.', '## 20 Ağustos Dünya Sivrisinek Günü Nedir?
Sıtma ve bulaşıcı hastalıklarla mücadele tarihi günü.

### Tarihçesi ve Önemi
20 Ağustos Dünya Sivrisinek Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 20 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "20 Ağustos Dünya Sivrisinek Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "20 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-20', 8, 20, 'Sağlık', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#20Ağustos', '#20agustosdunyasivrisinekgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '21-agustos-terorizm-kurbanlarini-anma-gunu', '21 Ağustos Terörizm Kurbanlarını Anma Günü', 'Terör eylemlerinde mağdur olan masum insanları anma günü.', '## 21 Ağustos Terörizm Kurbanlarını Anma Günü Nedir?
Terör eylemlerinde mağdur olan masum insanları anma günü.

### Tarihçesi ve Önemi
21 Ağustos Terörizm Kurbanlarını Anma Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/72/165) nezdinde tanınan ve her yıl 21 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "21 Ağustos Terörizm Kurbanlarını Anma Günü vesilesiyle saygı ve hürmetle anıyoruz."
* "21 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-21', 8, 21, 'Farkındalık', 'anma', false, 'uluslararasi', 'BM (A/RES/72/165)', 'https://www.un.org', ARRAY['#21Ağustos', '#21agustosterorizmkurbanlarinianmagunu'], ARRAY[]
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '22-agustos-inanc-temelli-siddet-kurbanlarini-anma-gunu', '22 Ağustos İnanç Temelli Şiddet Kurbanlarını Anma Günü', 'Din veya inanç kaynaklı şiddete uğrayanları anma günü.', '## 22 Ağustos İnanç Temelli Şiddet Kurbanlarını Anma Günü Nedir?
Din veya inanç kaynaklı şiddete uğrayanları anma günü.

### Tarihçesi ve Önemi
22 Ağustos İnanç Temelli Şiddet Kurbanlarını Anma Günü, gerek Türkiye''de gerekse uluslararası alanda BM nezdinde tanınan ve her yıl 22 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "22 Ağustos İnanç Temelli Şiddet Kurbanlarını Anma Günü vesilesiyle saygı ve hürmetle anıyoruz."
* "22 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-22', 8, 22, 'Farkındalık', 'anma', false, 'uluslararasi', 'BM', 'https://www.un.org', ARRAY['#22Ağustos', '#22agustosinanctemellisiddetkurbanlarinianmagunu'], ARRAY[]
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '23-agustos-kole-ticaretinin-yasaklanmasi-gunu', '23 Ağustos Köle Ticaretinin Yasaklanması Günü', 'Köle ticaretinin kaldırılması ve insanlık onuru günü.', '## 23 Ağustos Köle Ticaretinin Yasaklanması Günü Nedir?
Köle ticaretinin kaldırılması ve insanlık onuru günü.

### Tarihçesi ve Önemi
23 Ağustos Köle Ticaretinin Yasaklanması Günü, gerek Türkiye''de gerekse uluslararası alanda UNESCO nezdinde tanınan ve her yıl 23 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "23 Ağustos Köle Ticaretinin Yasaklanması Günü vesilesiyle saygı ve hürmetle anıyoruz."
* "23 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-23', 8, 23, 'Farkındalık', 'anma', false, 'uluslararasi', 'UNESCO', 'https://www.un.org', ARRAY['#23Ağustos', '#23agustoskoleticaretininyasaklanmasigunu'], ARRAY[]
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '24-agustos-mutfak-sanatlari-ve-gastronomi-gunu', '24 Ağustos Mutfak Sanatları ve Gastronomi Günü', 'Şeflerin yaratıcı tarifleri ve gastronomi mirası günü.', '## 24 Ağustos Mutfak Sanatları ve Gastronomi Günü Nedir?
Şeflerin yaratıcı tarifleri ve gastronomi mirası günü.

### Tarihçesi ve Önemi
24 Ağustos Mutfak Sanatları ve Gastronomi Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 24 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "24 Ağustos Mutfak Sanatları ve Gastronomi Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "24 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-24', 8, 24, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#24Ağustos', '#24agustosmutfaksanatlarivegastronomigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '25-agustos-ikinci-el-ve-geri-donusum-gunu', '25 Ağustos İkinci El ve Geri Dönüşüm Günü', 'Eşyaları yeniden değerlendirerek kaynakları koruma günü.', '## 25 Ağustos İkinci El ve Geri Dönüşüm Günü Nedir?
Eşyaları yeniden değerlendirerek kaynakları koruma günü.

### Tarihçesi ve Önemi
25 Ağustos İkinci El ve Geri Dönüşüm Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 25 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "25 Ağustos İkinci El ve Geri Dönüşüm Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "25 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-25', 8, 25, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#25Ağustos', '#25agustosikincielvegeridonusumgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-kopekler-gunu', '26 Ağustos Dünya Köpekler Günü', 'İnsanın en sadık dostu köpeklerin yaşam hakkını ve barınaklardaki sahipsiz canları hatırlatan gün.', '## 26 Ağustos Dünya Köpekler Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kopekler-gunu"', '2026-08-26', 8, 26, 'Çevre & Doğa', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaKopeklerGunu', '#DogDay', '#CanDostum', '#SatinAlmaSahiplen'], ARRAY['köpek tasması ve künyesi', 'köpek ödül bisküvisi', 'köpek diş temizleme oyuncağı', 'köpek yatağı ortopedik']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '27-agustos-dunya-tas-kagit-makas-gunu', '27 Ağustos Dünya Taş Kağıt Makas Günü', 'Dünyanın en evrensel ve eğlenceli karar oyunu günü.', '## 27 Ağustos Dünya Taş Kağıt Makas Günü Nedir?
Dünyanın en evrensel ve eğlenceli karar oyunu günü.

### Tarihçesi ve Önemi
27 Ağustos Dünya Taş Kağıt Makas Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 27 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "27 Ağustos Dünya Taş Kağıt Makas Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "27 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-27', 8, 27, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#27Ağustos', '#27agustosdunyataskagitmakasgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '28-agustos-dunya-hayal-kurma-gunu', '28 Ağustos Dünya Hayal Kurma Günü', 'Yeni projeler ve idealler için hayal gücünü serbest bırakma günü.', '## 28 Ağustos Dünya Hayal Kurma Günü Nedir?
Yeni projeler ve idealler için hayal gücünü serbest bırakma günü.

### Tarihçesi ve Önemi
28 Ağustos Dünya Hayal Kurma Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 28 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "28 Ağustos Dünya Hayal Kurma Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "28 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-28', 8, 28, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#28Ağustos', '#28agustosdunyahayalkurmagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '29-agustos-nukleer-denemelere-karsi-uluslararasi-gun', '29 Ağustos Nükleer Denemelere Karşı Uluslararası Gün', 'Nükleer silah denemelerini durdurma ve barışçıl dünya günü.', '## 29 Ağustos Nükleer Denemelere Karşı Uluslararası Gün Nedir?
Nükleer silah denemelerini durdurma ve barışçıl dünya günü.

### Tarihçesi ve Önemi
29 Ağustos Nükleer Denemelere Karşı Uluslararası Gün, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/64/35) nezdinde tanınan ve her yıl 29 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "29 Ağustos Nükleer Denemelere Karşı Uluslararası Gün kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "29 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-29', 8, 29, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'BM (A/RES/64/35)', 'https://www.un.org', ARRAY['#29Ağustos', '#29agustosnukleerdenemelerekarsiuluslararasigun'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'zafer-bayrami', '30 Ağustos Zafer Bayramı', '1922 Büyük Taarruz ve Başkomutanlık Meydan Muharebesi zaferini kutladığımız büyük milli bayramımız.', '## 30 Ağustos Zafer Bayramı Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #zafer-bayrami"', '2026-08-30', 8, 30, 'Resmi', 'kutlama', false, 'turkiye', '', '', ARRAY['#30Agustos', '#ZaferBayrami', '#BaskanMustafaKemal', '#BuyukTaarruz', '#Turkiye'], ARRAY['türk bayrağı araba süsü', 'atatürk tişörtü', 'kurtuluş savaşı tarihi kitabı', 'rozet']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '31-agustos-asiri-doz-farkindalik-gunu', '31 Ağustos Aşırı Doz Farkındalık Günü', 'Madde bağımlılığı kaynaklı ölümleri önleme ve tedavi günü.', '## 31 Ağustos Aşırı Doz Farkındalık Günü Nedir?
Madde bağımlılığı kaynaklı ölümleri önleme ve tedavi günü.

### Tarihçesi ve Önemi
31 Ağustos Aşırı Doz Farkındalık Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 31 Ağustos tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "31 Ağustos Aşırı Doz Farkındalık Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "31 Ağustos günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-08-31', 8, 31, 'Sağlık', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#31Ağustos', '#31agustosasiridozfarkindalikgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-baris-gunu', '1 Eylül Dünya Barış Günü', 'İkinci Dünya Savaşı''nın başladığı günde savaşların sona ermesi ve küresel barışın tesisi için kutlanan gün.', '## 1 Eylül Dünya Barış Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-baris-gunu"', '2026-09-01', 9, 1, 'Farkındalık', 'kutlama', false, 'turkiye', '', '', ARRAY['#1Eylul', '#DunyaBarisGunu', '#YurttaSulhCihandaSulh', '#Baris'], ARRAY['barış güvercini kolye', 'barış temalı tişört', 'felsefe ve barış kitapları']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '2-eylul-dunya-hindistan-cevizi-gunu', '2 Eylül Dünya Hindistan Cevizi Günü', 'Tropik lezzet hindistan cevizinin sağlığa faydaları günü.', '## 2 Eylül Dünya Hindistan Cevizi Günü Nedir?
Tropik lezzet hindistan cevizinin sağlığa faydaları günü.

### Tarihçesi ve Önemi
2 Eylül Dünya Hindistan Cevizi Günü, gerek Türkiye''de gerekse uluslararası alanda APCC nezdinde tanınan ve her yıl 2 Eylül tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "2 Eylül Dünya Hindistan Cevizi Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "2 Eylül günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-09-02', 9, 2, 'Eğlence', 'kutlama', false, 'uluslararasi', 'APCC', 'https://www.un.org', ARRAY['#2Eylül', '#2eyluldunyahindistancevizigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '3-eylul-dunya-gokdelenler-gunu', '3 Eylül Dünya Gökdelenler Günü', 'Modern mimarinin göğe yükselen yapıları günü.', '## 3 Eylül Dünya Gökdelenler Günü Nedir?
Modern mimarinin göğe yükselen yapıları günü.

### Tarihçesi ve Önemi
3 Eylül Dünya Gökdelenler Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 3 Eylül tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "3 Eylül Dünya Gökdelenler Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "3 Eylül günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-09-03', 9, 3, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#3Eylül', '#3eyluldunyagokdelenlergunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '4-eylul-dunya-cinsel-saglik-gunu', '4 Eylül Dünya Cinsel Sağlık Günü', 'Cinsel sağlık hakları ve bilinçlendirme günü.', '## 4 Eylül Dünya Cinsel Sağlık Günü Nedir?
Cinsel sağlık hakları ve bilinçlendirme günü.

### Tarihçesi ve Önemi
4 Eylül Dünya Cinsel Sağlık Günü, gerek Türkiye''de gerekse uluslararası alanda WAS nezdinde tanınan ve her yıl 4 Eylül tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "4 Eylül Dünya Cinsel Sağlık Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "4 Eylül günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-09-04', 9, 4, 'Sağlık', 'kutlama', false, 'uluslararasi', 'WAS', 'https://www.un.org', ARRAY['#4Eylül', '#4eyluldunyacinselsaglikgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '5-eylul-uluslararasi-hayirseverlik-gunu', '5 Eylül Uluslararası Hayırseverlik Günü', 'Muhtaçlara yardım eli uzatma ve dayanışma günü.', '## 5 Eylül Uluslararası Hayırseverlik Günü Nedir?
Muhtaçlara yardım eli uzatma ve dayanışma günü.

### Tarihçesi ve Önemi
5 Eylül Uluslararası Hayırseverlik Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/67/105) nezdinde tanınan ve her yıl 5 Eylül tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "5 Eylül Uluslararası Hayırseverlik Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "5 Eylül günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-09-05', 9, 5, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'BM (A/RES/67/105)', 'https://www.un.org', ARRAY['#5Eylül', '#5eylululuslararasihayirseverlikgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '6-eylul-dunya-kitap-okuma-gunu', '6 Eylül Dünya Kitap Okuma Günü', 'Kitap sayfalarında yeni dünyalar keşfetme günü.', '## 6 Eylül Dünya Kitap Okuma Günü Nedir?
Kitap sayfalarında yeni dünyalar keşfetme günü.

### Tarihçesi ve Önemi
6 Eylül Dünya Kitap Okuma Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 6 Eylül tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "6 Eylül Dünya Kitap Okuma Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "6 Eylül günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-09-06', 9, 6, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#6Eylül', '#6eyluldunyakitapokumagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '7-eylul-temiz-hava-ve-mavi-gokyuzu-gunu', '7 Eylül Temiz Hava ve Mavi Gökyüzü Günü', 'Hava kirliliğini önleyip temiz nefes alma günü.', '## 7 Eylül Temiz Hava ve Mavi Gökyüzü Günü Nedir?
Hava kirliliğini önleyip temiz nefes alma günü.

### Tarihçesi ve Önemi
7 Eylül Temiz Hava ve Mavi Gökyüzü Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/74/212) nezdinde tanınan ve her yıl 7 Eylül tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "7 Eylül Temiz Hava ve Mavi Gökyüzü Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "7 Eylül günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-09-07', 9, 7, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'BM (A/RES/74/212)', 'https://www.un.org', ARRAY['#7Eylül', '#7eylultemizhavavemavigokyuzugunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '8-eylul-uluslararasi-okuma-yazma-gunu-ve-fizyoterapi-gunu', '8 Eylül Uluslararası Okuma Yazma Günü ve Fizyoterapi Günü', 'Eğitimde okur-yazarlık ve hareket sağlığı günü.', '## 8 Eylül Uluslararası Okuma Yazma Günü ve Fizyoterapi Günü Nedir?
Eğitimde okur-yazarlık ve hareket sağlığı günü.

### Tarihçesi ve Önemi
8 Eylül Uluslararası Okuma Yazma Günü ve Fizyoterapi Günü, gerek Türkiye''de gerekse uluslararası alanda UNESCO nezdinde tanınan ve her yıl 8 Eylül tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "8 Eylül Uluslararası Okuma Yazma Günü ve Fizyoterapi Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "8 Eylül günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-09-08', 9, 8, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'UNESCO', 'https://www.un.org', ARRAY['#8Eylül', '#8eylululuslararasiokumayazmagunuvefizyoterapigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '9-eylul-izmirin-kurtulusu-ve-egitimi-koruma-gunu', '9 Eylül İzmir''in Kurtuluşu ve Eğitimi Koruma Günü', '9 Eylül 1922 bağımsızlık zaferi ve okulları koruma günü.', '## 9 Eylül İzmir''in Kurtuluşu ve Eğitimi Koruma Günü Nedir?
9 Eylül 1922 bağımsızlık zaferi ve okulları koruma günü.

### Tarihçesi ve Önemi
9 Eylül İzmir''in Kurtuluşu ve Eğitimi Koruma Günü, gerek Türkiye''de gerekse uluslararası alanda T.C. Milli Savunma & BM nezdinde tanınan ve her yıl 9 Eylül tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "9 Eylül İzmir''in Kurtuluşu ve Eğitimi Koruma Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "9 Eylül günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-09-09', 9, 9, 'Resmi', 'kutlama', false, 'uluslararasi', 'T.C. Milli Savunma & BM', 'https://www.un.org', ARRAY['#9Eylül', '#9eylulizmirinkurtulusuveegitimikorumagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '10-eylul-dunya-intihari-onleme-gunu', '10 Eylül Dünya İntiharı Önleme Günü', 'Ruh sağlığı desteği ve hayata tutunma çağrısı günü.', '## 10 Eylül Dünya İntiharı Önleme Günü Nedir?
Ruh sağlığı desteği ve hayata tutunma çağrısı günü.

### Tarihçesi ve Önemi
10 Eylül Dünya İntiharı Önleme Günü, gerek Türkiye''de gerekse uluslararası alanda DSÖ & IASP nezdinde tanınan ve her yıl 10 Eylül tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "10 Eylül Dünya İntiharı Önleme Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "10 Eylül günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-09-10', 9, 10, 'Sağlık', 'kutlama', false, 'uluslararasi', 'DSÖ & IASP', 'https://www.un.org', ARRAY['#10Eylül', '#10eyluldunyaintiharionlemegunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '11-eylul-dunya-ilk-yardim-gunu', '11 Eylül Dünya İlk Yardım Günü', 'Acil durumlarda hayat kurtaran temel ilk yardım bilgisi günü.', '## 11 Eylül Dünya İlk Yardım Günü Nedir?
Acil durumlarda hayat kurtaran temel ilk yardım bilgisi günü.

### Tarihçesi ve Önemi
11 Eylül Dünya İlk Yardım Günü, gerek Türkiye''de gerekse uluslararası alanda IFRC nezdinde tanınan ve her yıl 11 Eylül tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "11 Eylül Dünya İlk Yardım Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "11 Eylül günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-09-11', 9, 11, 'Sağlık', 'kutlama', false, 'uluslararasi', 'IFRC', 'https://www.un.org', ARRAY['#11Eylül', '#11eyluldunyailkyardimgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '12-eylul-guney-guney-isbirligi-gunu', '12 Eylül Güney-Güney İşbirliği Günü', 'Gelişmekte olan ülkeler arasında kalkınma ortaklığı günü.', '## 12 Eylül Güney-Güney İşbirliği Günü Nedir?
Gelişmekte olan ülkeler arasında kalkınma ortaklığı günü.

### Tarihçesi ve Önemi
12 Eylül Güney-Güney İşbirliği Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/58/220) nezdinde tanınan ve her yıl 12 Eylül tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "12 Eylül Güney-Güney İşbirliği Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "12 Eylül günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-09-12', 9, 12, 'Uluslararası', 'kutlama', false, 'uluslararasi', 'BM (A/RES/58/220)', 'https://www.un.org', ARRAY['#12Eylül', '#12eylulguneyguneyisbirligigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-yazilimcilar-gunu', '13 Eylül Dünya Yazılımcılar Günü', 'Yılın 256. gününde (2 üzeri 8) dijital dünyayı inşa eden tüm yazılım geliştiricileri onurlandıran gün.', '## 13 Eylül Dünya Yazılımcılar Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-yazilimcilar-gunu"', '2026-09-13', 9, 13, 'Mesleki', 'kutlama', false, 'turkiye', '', '', ARRAY['#YazilimcilarGunu', '#ProgrammersDay', '#Coding', '#DeveloperLife', '#256Day'], ARRAY['mekanik klavye rgb', 'ergonomik mouse', 'yazılımcı tişörtü', 'monitör standı']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '14-eylul-ilkogretim-haftasi-kutlamalari', '14 Eylül İlköğretim Haftası Kutlamaları', 'Yeni eğitim öğretim yılı ve okula başlayan minikler günü.', '## 14 Eylül İlköğretim Haftası Kutlamaları Nedir?
Yeni eğitim öğretim yılı ve okula başlayan minikler günü.

### Tarihçesi ve Önemi
14 Eylül İlköğretim Haftası Kutlamaları, gerek Türkiye''de gerekse uluslararası alanda MEB nezdinde tanınan ve her yıl 14 Eylül tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "14 Eylül İlköğretim Haftası Kutlamaları kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "14 Eylül günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-09-14', 9, 14, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'MEB', 'https://www.un.org', ARRAY['#14Eylül', '#14eylulilkogretimhaftasikutlamalari'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '15-eylul-uluslararasi-demokrasi-gunu', '15 Eylül Uluslararası Demokrasi Günü', 'Halkın iradesi ve demokratik değerleri savunma günü.', '## 15 Eylül Uluslararası Demokrasi Günü Nedir?
Halkın iradesi ve demokratik değerleri savunma günü.

### Tarihçesi ve Önemi
15 Eylül Uluslararası Demokrasi Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/62/7) nezdinde tanınan ve her yıl 15 Eylül tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "15 Eylül Uluslararası Demokrasi Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "15 Eylül günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-09-15', 9, 15, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'BM (A/RES/62/7)', 'https://www.un.org', ARRAY['#15Eylül', '#15eylululuslararasidemokrasigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '16-eylul-ozon-tabakasini-koruma-gunu', '16 Eylül Ozon Tabakasını Koruma Günü', 'Montreal Protokolü ile ozon tabakasını onarma başarısı günü.', '## 16 Eylül Ozon Tabakasını Koruma Günü Nedir?
Montreal Protokolü ile ozon tabakasını onarma başarısı günü.

### Tarihçesi ve Önemi
16 Eylül Ozon Tabakasını Koruma Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/49/114) nezdinde tanınan ve her yıl 16 Eylül tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "16 Eylül Ozon Tabakasını Koruma Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "16 Eylül günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-09-16', 9, 16, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'BM (A/RES/49/114)', 'https://www.un.org', ARRAY['#16Eylül', '#16eylulozontabakasinikorumagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '17-eylul-dunya-hasta-guvenligi-gunu', '17 Eylül Dünya Hasta Güvenliği Günü', 'Sağlık hizmetlerinde sıfır tıbbi hata ve güvenli tedavi günü.', '## 17 Eylül Dünya Hasta Güvenliği Günü Nedir?
Sağlık hizmetlerinde sıfır tıbbi hata ve güvenli tedavi günü.

### Tarihçesi ve Önemi
17 Eylül Dünya Hasta Güvenliği Günü, gerek Türkiye''de gerekse uluslararası alanda DSÖ / WHO nezdinde tanınan ve her yıl 17 Eylül tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "17 Eylül Dünya Hasta Güvenliği Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "17 Eylül günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-09-17', 9, 17, 'Sağlık', 'kutlama', false, 'uluslararasi', 'DSÖ / WHO', 'https://www.un.org', ARRAY['#17Eylül', '#17eyluldunyahastaguvenligigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '18-eylul-uluslararasi-esit-ucret-gunu', '18 Eylül Uluslararası Eşit Ücret Günü', 'Kadın ve erkekler için eşit işe eşit ücret hakkı günü.', '## 18 Eylül Uluslararası Eşit Ücret Günü Nedir?
Kadın ve erkekler için eşit işe eşit ücret hakkı günü.

### Tarihçesi ve Önemi
18 Eylül Uluslararası Eşit Ücret Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/74/252) nezdinde tanınan ve her yıl 18 Eylül tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "18 Eylül Uluslararası Eşit Ücret Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "18 Eylül günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-09-18', 9, 18, 'Mesleki', 'kutlama', false, 'uluslararasi', 'BM (A/RES/74/252)', 'https://www.un.org', ARRAY['#18Eylül', '#18eylululuslararasiesitucretgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'gaziler-gunu', '19 Eylül Gaziler Günü', 'Mustafa Kemal Atatürk''e ''Gazi'' unvanı ve Mareşal rütbesinin verildiği günün anısına kutlanan milli vefa günü.', '## 19 Eylül Gaziler Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #gaziler-gunu"', '2026-09-19', 9, 19, 'Resmi', 'kutlama', false, 'turkiye', '', '', ARRAY['#GazilerGunu', '#19Eylul', '#KahramanGazilerimiz', '#Ataturk'], ARRAY['türk bayrağı masa üstü pirinç', 'atatürk biyografisi ciltli', 'rozet']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '20-eylul-dunya-temizlik-gunu-world-cleanup-day', '20 Eylül Dünya Temizlik Günü (World Cleanup Day)', 'Doğayı atıklardan arındırmak için küresel çevre hareketi günü.', '## 20 Eylül Dünya Temizlik Günü (World Cleanup Day) Nedir?
Doğayı atıklardan arındırmak için küresel çevre hareketi günü.

### Tarihçesi ve Önemi
20 Eylül Dünya Temizlik Günü (World Cleanup Day), gerek Türkiye''de gerekse uluslararası alanda Let''s Do It World & BM nezdinde tanınan ve her yıl 20 Eylül tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "20 Eylül Dünya Temizlik Günü (World Cleanup Day) kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "20 Eylül günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-09-20', 9, 20, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'Let''s Do It World & BM', 'https://www.un.org', ARRAY['#20Eylül', '#20eyluldunyatemizlikgunuworldcleanupday'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-alzheimer-gunu', '21 Eylül Dünya Alzheimer Günü', 'Alzheimer hastalığına ve demansa dikkat çekmek, hasta ve hasta yakınlarına destek olmak için kutlanır.', '## 21 Eylül Dünya Alzheimer Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-alzheimer-gunu"', '2026-09-21', 9, 21, 'Sağlık', 'kutlama', false, 'turkiye', '', '', ARRAY['#AlzheimerGunu', '#Unutma', '#ErkenTeshis', '#AlzheimerFarkindalik'], ARRAY['hafıza güçlendirme bulmaca kitabı', 'akıl oyunları seti yetişkin', 'akıllı saat gps yaşlı']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '22-eylul-dunya-otomobilsiz-kentler-gunu-ve-gergedanlar-gunu', '22 Eylül Dünya Otomobilsiz Kentler Günü ve Gergedanlar Günü', 'Egzoz dumanı yerine bisiklet ve yürüyüş günü.', '## 22 Eylül Dünya Otomobilsiz Kentler Günü ve Gergedanlar Günü Nedir?
Egzoz dumanı yerine bisiklet ve yürüyüş günü.

### Tarihçesi ve Önemi
22 Eylül Dünya Otomobilsiz Kentler Günü ve Gergedanlar Günü, gerek Türkiye''de gerekse uluslararası alanda European Mobility Week nezdinde tanınan ve her yıl 22 Eylül tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "22 Eylül Dünya Otomobilsiz Kentler Günü ve Gergedanlar Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "22 Eylül günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-09-22', 9, 22, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'European Mobility Week', 'https://www.un.org', ARRAY['#22Eylül', '#22eyluldunyaotomobilsizkentlergunuvegergedanlargunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '23-eylul-uluslararasi-isaret-dilleri-gunu', '23 Eylül Uluslararası İşaret Dilleri Günü', 'İşitme engellilerin dil hakları ve işaret dili zenginliği günü.', '## 23 Eylül Uluslararası İşaret Dilleri Günü Nedir?
İşitme engellilerin dil hakları ve işaret dili zenginliği günü.

### Tarihçesi ve Önemi
23 Eylül Uluslararası İşaret Dilleri Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/72/161) nezdinde tanınan ve her yıl 23 Eylül tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "23 Eylül Uluslararası İşaret Dilleri Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "23 Eylül günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-09-23', 9, 23, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'BM (A/RES/72/161)', 'https://www.un.org', ARRAY['#23Eylül', '#23eylululuslararasiisaretdillerigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '24-eylul-itfaiyecilik-haftasi-kutlamalari', '24 Eylül İtfaiyecilik Haftası Kutlamaları', 'Yangınla mücadelede fedakarca çalışan itfaiyeciler haftası.', '## 24 Eylül İtfaiyecilik Haftası Kutlamaları Nedir?
Yangınla mücadelede fedakarca çalışan itfaiyeciler haftası.

### Tarihçesi ve Önemi
24 Eylül İtfaiyecilik Haftası Kutlamaları, gerek Türkiye''de gerekse uluslararası alanda İtfaiye Daire Başkanlığı nezdinde tanınan ve her yıl 24 Eylül tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "24 Eylül İtfaiyecilik Haftası Kutlamaları kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "24 Eylül günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-09-24', 9, 24, 'Mesleki', 'kutlama', false, 'uluslararasi', 'İtfaiye Daire Başkanlığı', 'https://www.un.org', ARRAY['#24Eylül', '#24eylulitfaiyecilikhaftasikutlamalari'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '25-eylul-dunya-eczacilar-gunu', '25 Eylül Dünya Eczacılar Günü', 'İlaç uzmanı eczacıların toplum sağlığına katkıları günü.', '## 25 Eylül Dünya Eczacılar Günü Nedir?
İlaç uzmanı eczacıların toplum sağlığına katkıları günü.

### Tarihçesi ve Önemi
25 Eylül Dünya Eczacılar Günü, gerek Türkiye''de gerekse uluslararası alanda FIP Eczacılık Federasyonu nezdinde tanınan ve her yıl 25 Eylül tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "25 Eylül Dünya Eczacılar Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "25 Eylül günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-09-25', 9, 25, 'Mesleki', 'kutlama', false, 'uluslararasi', 'FIP Eczacılık Federasyonu', 'https://www.un.org', ARRAY['#25Eylül', '#25eyluldunyaeczacilargunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '26-eylul-avrupa-diller-gunu-ve-nukleer-silahlari-yok-etme-gunu', '26 Eylül Avrupa Diller Günü ve Nükleer Silahları Yok Etme Günü', 'Çok dillilik ve barış dolu dünya ideali günü.', '## 26 Eylül Avrupa Diller Günü ve Nükleer Silahları Yok Etme Günü Nedir?
Çok dillilik ve barış dolu dünya ideali günü.

### Tarihçesi ve Önemi
26 Eylül Avrupa Diller Günü ve Nükleer Silahları Yok Etme Günü, gerek Türkiye''de gerekse uluslararası alanda Avrupa Konseyi & BM nezdinde tanınan ve her yıl 26 Eylül tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "26 Eylül Avrupa Diller Günü ve Nükleer Silahları Yok Etme Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "26 Eylül günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-09-26', 9, 26, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'Avrupa Konseyi & BM', 'https://www.un.org', ARRAY['#26Eylül', '#26eylulavrupadillergunuvenukleersilahlariyoketmegunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-turizm-gunu', '27 Eylül Dünya Turizm Günü', 'Farklı kültürleri tanıma, seyahat özgürlüğü ve sürdürülebilir turizmin ekonomik gücünü kutlayan BM günü.', '## 27 Eylül Dünya Turizm Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-turizm-gunu"', '2026-09-27', 9, 27, 'Kültür & Sanat', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaTurizmGunu', '#WorldTourismDay', '#Gezgin', '#Seyahat'], ARRAY['seyahat sırt çantası kabin boy', 'boyun yastığı hafızalı sünger', 'evrensel priz dönüştürücü']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-kuduz-gunu', '28 Eylül Dünya Kuduz Günü', 'Kuduz hastalığı konusunda farkındalık yaratmak ve aşının hayati önemini vurgulamak için kutlanır.', '## 28 Eylül Dünya Kuduz Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kuduz-gunu"', '2026-09-28', 9, 28, 'Sağlık', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaKuduzGunu', '#KuduzFarkindaligi', '#AsiHayatKurtarir', '#28Eylul'], ARRAY['kedi köpek taşıma çantası', 'köpek tasması ve künyesi', 'veteriner bakım seti']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'bilgiye-evrensel-erisim-gunu', '28 Eylül Uluslararası Bilgiye Evrensel Erişim Günü', 'Bilginin serbestçe yayılması ve şeffaf toplumların inşası için UNESCO öncülüğünde kutlanır.', '## 28 Eylül Uluslararası Bilgiye Evrensel Erişim Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #bilgiye-evrensel-erisim-gunu"', '2026-09-28', 9, 28, 'Farkındalık', 'kutlama', false, 'turkiye', '', '', ARRAY['#BilgiyeErisimGunu', '#UNESCO', '#AcikBilgi', '#DijitalHaklar'], ARRAY['e-kitap okuyucu', 'bilimsel kitaplar', 'hızlı okuma kitap seti']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-kalp-gunu', '29 Eylül Dünya Kalp Günü', 'Kalp ve damar hastalıklarına karşı sağlıklı yaşam, beslenme ve egzersiz bilincini artıran küresel sağlık günü.', '## 29 Eylül Dünya Kalp Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kalp-gunu"', '2026-09-29', 9, 29, 'Sağlık', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaKalpGunu', '#KalbiniKoru', '#WorldHeartDay', '#SaglikliKalp'], ARRAY['akıllı saat nabız ölçer', 'kolesterol diyeti kitabı', 'koşu bandı ev tipi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '30-eylul-uluslararasi-ceviri-gunu', '30 Eylül Uluslararası Çeviri Günü', 'Diller ve kültürler arasında köprü kuran mütercim-tercümanlar günü.', '## 30 Eylül Uluslararası Çeviri Günü Nedir?
Diller ve kültürler arasında köprü kuran mütercim-tercümanlar günü.

### Tarihçesi ve Önemi
30 Eylül Uluslararası Çeviri Günü, gerek Türkiye''de gerekse uluslararası alanda BM & FIT nezdinde tanınan ve her yıl 30 Eylül tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "30 Eylül Uluslararası Çeviri Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "30 Eylül günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-09-30', 9, 30, 'Mesleki', 'kutlama', false, 'uluslararasi', 'BM & FIT', 'https://www.un.org', ARRAY['#30Eylül', '#30eylululuslararasicevirigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-yaslilar-gunu', '1 Ekim Dünya Yaşlılar Günü', 'Tecrübeleriyle topluma ışık tutan kıymetli büyüklerimizin haklarını ve refahını koruyan BM günü.', '## 1 Ekim Dünya Yaşlılar Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-yaslilar-gunu"', '2026-10-01', 10, 1, 'Farkındalık', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaYaslilarGunu', '#BuyuklerimizeSaygi', '#YasliHaklari', '#1Ekim'], ARRAY['ortopedik baston ışıklı', 'yaşlılar için tansiyon aleti konuşan', 'ısıtmalı ayak masaj aleti']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-kahve-gunu', '1 Ekim Dünya Kahve Günü', 'Her yıl 1 Ekim''de kahve üreticilerinin emeğini ve dünyanın en sevilen içeceğinin lezzetini kutlayan gün.', '## 1 Ekim Dünya Kahve Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kahve-gunu"', '2026-10-01', 10, 1, 'Eğlence', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaKahveGunu', '#Kahve', '#CoffeeDay', '#KahveSever', '#1Ekim'], ARRAY['filtre kahve makinesi', 'nitelikli çekirdek kahve', 'termos kupa', 'french press', 'chemex']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '2-ekim-uluslararasi-siddete-hayir-gunu', '2 Ekim Uluslararası Şiddete Hayır Günü', 'Mahatma Gandhi anısına barış ve şiddetsizlik günü.', '## 2 Ekim Uluslararası Şiddete Hayır Günü Nedir?
Mahatma Gandhi anısına barış ve şiddetsizlik günü.

### Tarihçesi ve Önemi
2 Ekim Uluslararası Şiddete Hayır Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/61/271) nezdinde tanınan ve her yıl 2 Ekim tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "2 Ekim Uluslararası Şiddete Hayır Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "2 Ekim günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-10-02', 10, 2, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'BM (A/RES/61/271)', 'https://www.un.org', ARRAY['#2Ekim', '#2ekimuluslararasisiddetehayirgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '3-ekim-dunya-mimarlik-gunu-ve-turk-dili-konusan-ulkeler-gunu', '3 Ekim Dünya Mimarlık Günü ve Türk Dili Konuşan Ülkeler Günü', 'Yaşanabilir şehirler ve Türk dünyası dayanışması günü.', '## 3 Ekim Dünya Mimarlık Günü ve Türk Dili Konuşan Ülkeler Günü Nedir?
Yaşanabilir şehirler ve Türk dünyası dayanışması günü.

### Tarihçesi ve Önemi
3 Ekim Dünya Mimarlık Günü ve Türk Dili Konuşan Ülkeler Günü, gerek Türkiye''de gerekse uluslararası alanda UIA & Türk Devletleri Teşkilatı nezdinde tanınan ve her yıl 3 Ekim tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "3 Ekim Dünya Mimarlık Günü ve Türk Dili Konuşan Ülkeler Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "3 Ekim günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-10-03', 10, 3, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'UIA & Türk Devletleri Teşkilatı', 'https://www.un.org', ARRAY['#3Ekim', '#3ekimdunyamimarlikgunuveturkdilikonusanulkelergunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'hayvanlari-koruma-gunu', '4 Ekim Hayvanları Koruma Günü', 'Tüm canlıların yaşam haklarına saygı duymak ve sokak hayvanlarının refahını artırmak amacıyla kutlanır.', '## 4 Ekim Hayvanları Koruma Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #hayvanlari-koruma-gunu"', '2026-10-04', 10, 4, 'Çevre & Doğa', 'kutlama', false, 'turkiye', '', '', ARRAY['#4Ekim', '#HayvanlariKorumaGunu', '#SatinAlmaSahiplen', '#CanDostlarimiz'], ARRAY['kedi maması 15kg', 'köpek maması premium', 'kuş yemi ve kafesi', 'otomatik su sebili pet']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-ogretmenler-gunu-unesco', '5 Ekim Dünya Öğretmenler Günü (UNESCO)', 'Dünya genelinde öğretmenlerin statüsü ve haklarını savunan UNESCO ve ILO ortak kutlama günü.', '## 5 Ekim Dünya Öğretmenler Günü (UNESCO) Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-ogretmenler-gunu-unesco"', '2026-10-05', 10, 5, 'Mesleki', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaOgretmenlerGunu', '#WorldTeachersDay', '#5Ekim', '#Ogretmen'], ARRAY['lazer sunum kumandası', 'öğretmen ajandası 2026', 'isme özel kupa']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '6-ekim-istanbulun-kurtulusu-ve-serebral-palsi-gunu', '6 Ekim İstanbul''un Kurtuluşu ve Serebral Palsi Günü', '6 Ekim 1923 İstanbul''un kurtuluşu ve serebral palsi farkındalığı.', '## 6 Ekim İstanbul''un Kurtuluşu ve Serebral Palsi Günü Nedir?
6 Ekim 1923 İstanbul''un kurtuluşu ve serebral palsi farkındalığı.

### Tarihçesi ve Önemi
6 Ekim İstanbul''un Kurtuluşu ve Serebral Palsi Günü, gerek Türkiye''de gerekse uluslararası alanda T.C. Kültür Bakanlığı nezdinde tanınan ve her yıl 6 Ekim tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "6 Ekim İstanbul''un Kurtuluşu ve Serebral Palsi Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "6 Ekim günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-10-06', 10, 6, 'Resmi', 'kutlama', false, 'uluslararasi', 'T.C. Kültür Bakanlığı', 'https://www.un.org', ARRAY['#6Ekim', '#6ekimistanbulunkurtulusuveserebralpalsigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-pamuk-gunu', '7 Ekim Dünya Pamuk Günü', 'Birleşmiş Milletler (BM) Genel Kurulu tarafından ilan edilen, pamuğun küresel ekonomideki, sürdürülebilir tarımdaki ve istihdamdaki kritik rolünü vurgulayan uluslararası gün.', '## 7 Ekim Dünya Pamuk Günü Nedir?
Dünya Pamuk Günü (World Cotton Day), Birleşmiş Milletler (BM) Genel Kurulu''nun A/RES/75/318 sayılı kararı ile her yıl 7 Ekim tarihinde tüm dünyada idrak edilen resmî bir uluslararası farkındalık günüdür.

### Tarihçesi ve Önemi
Pamuk üreticisi gelişmekte olan Benin, Burkina Faso, Çad ve Mali (Cotton-4) ülkelerinin Dünya Ticaret Örgütü''ne (DTÖ) yaptığı başvuru sonucunda, 2019 yılında BM Gıda ve Tarım Örgütü (FAO), BM Ticaret ve Kalkınma Konferansı (UNCTAD) ve Uluslararası Pamuk Danışma Komitesi (ICAC) ortaklığıyla başlatılmıştır. Pamuk, dünya genelinde 100 milyondan fazla aileye doğrudan gelir sağlayan ve biyolojik olarak tamamen çözünebilen stratejik bir doğal elyaftır.

---

## 7 Ekim Dünya Pamuk Günü Nasıl Değerlendirilir?
1. Sürdürülebilir, organik ve sertifikalı pamuklu tekstil ürünlerini tercih edin.
2. Sentetik ve mikroplastik yayan kumaşlar yerine doğal liflerin önemini araştırın.
3. Çiftçilerin ve tekstil işçilerinin adil ticaret (Fairtrade) haklarına destek olun.

---

## Sosyal Medya Farkındalık Mesajları
* "Tarladan gardıroba uzanan doğal emek: 7 Ekim Dünya Pamuk Günü kutlu olsun! Sürdürülebilir tarımı ve doğal lifleri destekliyoruz. 🌱🧵 #DunyaPamukGunu #WorldCottonDay"
* "Dünya genelinde 100 milyondan fazla çiftçi ailesinin geçim kaynağı olan pamuğun değerini biliyoruz. 7 Ekim Dünya Pamuk Günü kutlu olsun. #Pamuk #SurdurulebilirTekstil"
* "Sentetik kumaşlara karşı doğayı koru, pamuğu seç. #WorldCottonDay #7Ekim"', '2026-10-07', 10, 7, 'Uluslararası', 'farkindalik', false, 'bm', 'Birleşmiş Milletler Genel Kurulu (A/RES/75/318)', 'https://press.un.org/en/2021/ga12354.doc.htm', ARRAY['#DunyaPamukGunu', '#WorldCottonDay', '#7Ekim', '#Pamuk', '#SurdurulebilirTarim'], ARRAY['organik pamuk nevresim', 'yüzde 100 pamuk tişört', 'doğal pamuklu havlu']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '8-ekim-dunya-ahtapotlar-ve-deniz-ekosistemi-gunu', '8 Ekim Dünya Ahtapotlar ve Deniz Ekosistemi Günü', 'Denizlerin zeki canlıları ahtapotları ve deniz florasını tanıma günü.', '## 8 Ekim Dünya Ahtapotlar ve Deniz Ekosistemi Günü Nedir?
Denizlerin zeki canlıları ahtapotları ve deniz florasını tanıma günü.

### Tarihçesi ve Önemi
8 Ekim Dünya Ahtapotlar ve Deniz Ekosistemi Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 8 Ekim tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "8 Ekim Dünya Ahtapotlar ve Deniz Ekosistemi Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "8 Ekim günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-10-08', 10, 8, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#8Ekim', '#8ekimdunyaahtapotlarvedenizekosistemigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '9-ekim-dunya-posta-gunu', '9 Ekim Dünya Posta Günü', 'Mektupları ve kargoları ulaştıran küresel posta ağı günü.', '## 9 Ekim Dünya Posta Günü Nedir?
Mektupları ve kargoları ulaştıran küresel posta ağı günü.

### Tarihçesi ve Önemi
9 Ekim Dünya Posta Günü, gerek Türkiye''de gerekse uluslararası alanda BM UPU nezdinde tanınan ve her yıl 9 Ekim tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "9 Ekim Dünya Posta Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "9 Ekim günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-10-09', 10, 9, 'Mesleki', 'kutlama', false, 'uluslararasi', 'BM UPU', 'https://www.un.org', ARRAY['#9Ekim', '#9ekimdunyapostagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-ruh-sagligi-gunu', '10 Ekim Dünya Ruh Sağlığı Günü', 'Ruh sağlığının genel sağlığın ayrılmaz bir parçası olduğunu vurgulayan ve psikolojik desteği savunan gün.', '## 10 Ekim Dünya Ruh Sağlığı Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-ruh-sagligi-gunu"', '2026-10-10', 10, 10, 'Sağlık', 'kutlama', false, 'turkiye', '', '', ARRAY['#RuhSagligiGunu', '#WorldMentalHealthDay', '#YalnizDegilsin', '#Psikoloji'], ARRAY['psikoloji kitapları çok satanlar', 'meditasyon minderi', 'aromaterapi difüzör']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-kiz-cocuklari-gunu', '11 Ekim Dünya Kız Çocukları Günü', 'Kız çocuklarının eğitim, sağlık, eşitlik ve güçlendirilmesi haklarına dikkat çekmek için BM tarafından kutlanır.', '## 11 Ekim Dünya Kız Çocukları Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kiz-cocuklari-gunu"', '2026-10-11', 10, 11, 'Farkındalık', 'kutlama', false, 'turkiye', '', '', ARRAY['#KizCocuklariGunu', '#DayOfTheGirl', '#GucluKizlar', '#EgitimHerkesIcin'], ARRAY['ilham veren kadınlar çocuk kitabı', 'bilim seti kız çocuk', 'kodlama oyuncakları']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '12-ekim-dunya-artrit-gunu', '12 Ekim Dünya Artrit Günü', 'Eklem sağlığı ve romatizmal hastalıklar bilinci günü.', '## 12 Ekim Dünya Artrit Günü Nedir?
Eklem sağlığı ve romatizmal hastalıklar bilinci günü.

### Tarihçesi ve Önemi
12 Ekim Dünya Artrit Günü, gerek Türkiye''de gerekse uluslararası alanda EULAR nezdinde tanınan ve her yıl 12 Ekim tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "12 Ekim Dünya Artrit Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "12 Ekim günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-10-12', 10, 12, 'Sağlık', 'kutlama', false, 'uluslararasi', 'EULAR', 'https://www.un.org', ARRAY['#12Ekim', '#12ekimdunyaartritgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '13-ekim-afet-risklerinin-azaltilmasi-uluslararasi-gunu', '13 Ekim Afet Risklerinin Azaltılması Uluslararası Günü', 'Deprem ve doğal afetlere dirençli yapılar günü.', '## 13 Ekim Afet Risklerinin Azaltılması Uluslararası Günü Nedir?
Deprem ve doğal afetlere dirençli yapılar günü.

### Tarihçesi ve Önemi
13 Ekim Afet Risklerinin Azaltılması Uluslararası Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/64/200) nezdinde tanınan ve her yıl 13 Ekim tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "13 Ekim Afet Risklerinin Azaltılması Uluslararası Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "13 Ekim günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-10-13', 10, 13, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'BM (A/RES/64/200)', 'https://www.un.org', ARRAY['#13Ekim', '#13ekimafetrisklerininazaltilmasiuluslararasigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '14-ekim-dunya-standartlar-gunu', '14 Ekim Dünya Standartlar Günü', 'Kalite, güvenlik ve küresel sanayi standartları günü.', '## 14 Ekim Dünya Standartlar Günü Nedir?
Kalite, güvenlik ve küresel sanayi standartları günü.

### Tarihçesi ve Önemi
14 Ekim Dünya Standartlar Günü, gerek Türkiye''de gerekse uluslararası alanda ISO, IEC, ITU nezdinde tanınan ve her yıl 14 Ekim tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "14 Ekim Dünya Standartlar Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "14 Ekim günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-10-14', 10, 14, 'Mesleki', 'kutlama', false, 'uluslararasi', 'ISO, IEC, ITU', 'https://www.un.org', ARRAY['#14Ekim', '#14ekimdunyastandartlargunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '15-ekim-dunya-beyaz-baston-gorme-engelliler-gunu', '15 Ekim Dünya Beyaz Baston Görme Engelliler Günü', 'Görme engellilerin bağımsız hareket etme hakkı günü.', '## 15 Ekim Dünya Beyaz Baston Görme Engelliler Günü Nedir?
Görme engellilerin bağımsız hareket etme hakkı günü.

### Tarihçesi ve Önemi
15 Ekim Dünya Beyaz Baston Görme Engelliler Günü, gerek Türkiye''de gerekse uluslararası alanda Dünya Körler Birliği nezdinde tanınan ve her yıl 15 Ekim tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "15 Ekim Dünya Beyaz Baston Görme Engelliler Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "15 Ekim günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-10-15', 10, 15, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'Dünya Körler Birliği', 'https://www.un.org', ARRAY['#15Ekim', '#15ekimdunyabeyazbastongormeengellilergunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-gida-gunu', '16 Ekim Dünya Gıda Günü', 'Açlıkla mücadele, sürdürülebilir tarım ve gıda israfını önleme bilincini artıran FAO günü.', '## 16 Ekim Dünya Gıda Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-gida-gunu"', '2026-10-16', 10, 16, 'Çevre & Doğa', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaGidaGunu', '#WorldFoodDay', '#GidaIsrafinaSon', '#AcligaSon'], ARRAY['vakumlu saklama kabı seti', 'hava geçirmez kavanoz', 'gıda kurutucu makine']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '17-ekim-yoksullugun-yok-edilmesi-uluslararasi-gunu', '17 Ekim Yoksulluğun Yok Edilmesi Uluslararası Günü', 'Sosyal adalet ve temel yaşam güvencesi günü.', '## 17 Ekim Yoksulluğun Yok Edilmesi Uluslararası Günü Nedir?
Sosyal adalet ve temel yaşam güvencesi günü.

### Tarihçesi ve Önemi
17 Ekim Yoksulluğun Yok Edilmesi Uluslararası Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/47/196) nezdinde tanınan ve her yıl 17 Ekim tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "17 Ekim Yoksulluğun Yok Edilmesi Uluslararası Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "17 Ekim günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-10-17', 10, 17, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'BM (A/RES/47/196)', 'https://www.un.org', ARRAY['#17Ekim', '#17ekimyoksullugunyokedilmesiuluslararasigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '18-ekim-dunya-menopoz-gunu', '18 Ekim Dünya Menopoz Günü', 'Kadın sağlığında doğal evreler ve destekleyici tıp günü.', '## 18 Ekim Dünya Menopoz Günü Nedir?
Kadın sağlığında doğal evreler ve destekleyici tıp günü.

### Tarihçesi ve Önemi
18 Ekim Dünya Menopoz Günü, gerek Türkiye''de gerekse uluslararası alanda International Menopause Society nezdinde tanınan ve her yıl 18 Ekim tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "18 Ekim Dünya Menopoz Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "18 Ekim günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-10-18', 10, 18, 'Sağlık', 'kutlama', false, 'uluslararasi', 'International Menopause Society', 'https://www.un.org', ARRAY['#18Ekim', '#18ekimdunyamenopozgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '19-ekim-muhtarlar-gunu', '19 Ekim Muhtarlar Günü', 'Yerel demokrasinin ilk halkası olan muhtarlarımızın günü.', '## 19 Ekim Muhtarlar Günü Nedir?
Yerel demokrasinin ilk halkası olan muhtarlarımızın günü.

### Tarihçesi ve Önemi
19 Ekim Muhtarlar Günü, gerek Türkiye''de gerekse uluslararası alanda T.C. İçişleri Bakanlığı nezdinde tanınan ve her yıl 19 Ekim tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "19 Ekim Muhtarlar Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "19 Ekim günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-10-19', 10, 19, 'Resmi', 'kutlama', false, 'uluslararasi', 'T.C. İçişleri Bakanlığı', 'https://www.un.org', ARRAY['#19Ekim', '#19ekimmuhtarlargunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '20-ekim-dunya-istatistik-gunu-ve-dunya-sefler-gunu', '20 Ekim Dünya İstatistik Günü ve Dünya Şefler Günü', 'Güvenilir verilerin gücü ve mutfak sanatı ustaları günü.', '## 20 Ekim Dünya İstatistik Günü ve Dünya Şefler Günü Nedir?
Güvenilir verilerin gücü ve mutfak sanatı ustaları günü.

### Tarihçesi ve Önemi
20 Ekim Dünya İstatistik Günü ve Dünya Şefler Günü, gerek Türkiye''de gerekse uluslararası alanda BM & WACS nezdinde tanınan ve her yıl 20 Ekim tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "20 Ekim Dünya İstatistik Günü ve Dünya Şefler Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "20 Ekim günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-10-20', 10, 20, 'Mesleki', 'kutlama', false, 'uluslararasi', 'BM & WACS', 'https://www.un.org', ARRAY['#20Ekim', '#20ekimdunyaistatistikgunuvedunyaseflergunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '21-ekim-dunya-gazeteciler-gunu', '21 Ekim Dünya Gazeteciler Günü', 'Tercüman-ı Ahval ile başlayan Türk gazetecilik mirası günü.', '## 21 Ekim Dünya Gazeteciler Günü Nedir?
Tercüman-ı Ahval ile başlayan Türk gazetecilik mirası günü.

### Tarihçesi ve Önemi
21 Ekim Dünya Gazeteciler Günü, gerek Türkiye''de gerekse uluslararası alanda Basın Konseyi nezdinde tanınan ve her yıl 21 Ekim tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "21 Ekim Dünya Gazeteciler Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "21 Ekim günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-10-21', 10, 21, 'Mesleki', 'kutlama', false, 'uluslararasi', 'Basın Konseyi', 'https://www.un.org', ARRAY['#21Ekim', '#21ekimdunyagazetecilergunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '22-ekim-dunya-kekemelik-farkindalik-gunu', '22 Ekim Dünya Kekemelik Farkındalık Günü', 'Konuşma akıcılığı zorluğu yaşayanlara anlayış günü.', '## 22 Ekim Dünya Kekemelik Farkındalık Günü Nedir?
Konuşma akıcılığı zorluğu yaşayanlara anlayış günü.

### Tarihçesi ve Önemi
22 Ekim Dünya Kekemelik Farkındalık Günü, gerek Türkiye''de gerekse uluslararası alanda International Stuttering Association nezdinde tanınan ve her yıl 22 Ekim tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "22 Ekim Dünya Kekemelik Farkındalık Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "22 Ekim günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-10-22', 10, 22, 'Sağlık', 'kutlama', false, 'uluslararasi', 'International Stuttering Association', 'https://www.un.org', ARRAY['#22Ekim', '#22ekimdunyakekemelikfarkindalikgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '23-ekim-dunya-mol-gunu-kimya-gunu', '23 Ekim Dünya Mol Günü (Kimya Günü)', 'Avogadro sayısı anısına kimya bilimini kutlama günü.', '## 23 Ekim Dünya Mol Günü (Kimya Günü) Nedir?
Avogadro sayısı anısına kimya bilimini kutlama günü.

### Tarihçesi ve Önemi
23 Ekim Dünya Mol Günü (Kimya Günü), gerek Türkiye''de gerekse uluslararası alanda National Mole Day Foundation nezdinde tanınan ve her yıl 23 Ekim tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "23 Ekim Dünya Mol Günü (Kimya Günü) kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "23 Ekim günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-10-23', 10, 23, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'National Mole Day Foundation', 'https://www.un.org', ARRAY['#23Ekim', '#23ekimdunyamolgunukimyagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '24-ekim-birlesmis-milletler-gunu-ve-kalkinma-bilgi-gunu', '24 Ekim Birleşmiş Milletler Günü ve Kalkınma Bilgi Günü', '1945 BM Kuruluş Sözleşmesi ve evrensel barış günü.', '## 24 Ekim Birleşmiş Milletler Günü ve Kalkınma Bilgi Günü Nedir?
1945 BM Kuruluş Sözleşmesi ve evrensel barış günü.

### Tarihçesi ve Önemi
24 Ekim Birleşmiş Milletler Günü ve Kalkınma Bilgi Günü, gerek Türkiye''de gerekse uluslararası alanda Birleşmiş Milletler nezdinde tanınan ve her yıl 24 Ekim tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "24 Ekim Birleşmiş Milletler Günü ve Kalkınma Bilgi Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "24 Ekim günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-10-24', 10, 24, 'Uluslararası', 'kutlama', false, 'uluslararasi', 'Birleşmiş Milletler', 'https://www.un.org', ARRAY['#24Ekim', '#24ekimbirlesmismilletlergunuvekalkinmabilgigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '25-ekim-dunya-makarna-gunu', '25 Ekim Dünya Makarna Günü', 'İtalyan ve dünya mutfağının vazgeçilmezi makarna günü.', '## 25 Ekim Dünya Makarna Günü Nedir?
İtalyan ve dünya mutfağının vazgeçilmezi makarna günü.

### Tarihçesi ve Önemi
25 Ekim Dünya Makarna Günü, gerek Türkiye''de gerekse uluslararası alanda International Pasta Organization nezdinde tanınan ve her yıl 25 Ekim tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "25 Ekim Dünya Makarna Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "25 Ekim günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-10-25', 10, 25, 'Eğlence', 'kutlama', false, 'uluslararasi', 'International Pasta Organization', 'https://www.un.org', ARRAY['#25Ekim', '#25ekimdunyamakarnagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '26-ekim-hasta-haklari-gunu', '26 Ekim Hasta Hakları Günü', 'Tıbbi tedavi süreçlerinde hasta hakları güvencesi günü.', '## 26 Ekim Hasta Hakları Günü Nedir?
Tıbbi tedavi süreçlerinde hasta hakları güvencesi günü.

### Tarihçesi ve Önemi
26 Ekim Hasta Hakları Günü, gerek Türkiye''de gerekse uluslararası alanda T.C. Sağlık Bakanlığı nezdinde tanınan ve her yıl 26 Ekim tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "26 Ekim Hasta Hakları Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "26 Ekim günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-10-26', 10, 26, 'Sağlık', 'kutlama', false, 'uluslararasi', 'T.C. Sağlık Bakanlığı', 'https://www.un.org', ARRAY['#26Ekim', '#26ekimhastahaklarigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '27-ekim-ses-ve-goruntu-mirasi-gunu', '27 Ekim Ses ve Görüntü Mirası Günü', 'Tarihi film, radyo ve ses kayıtlarını koruma günü.', '## 27 Ekim Ses ve Görüntü Mirası Günü Nedir?
Tarihi film, radyo ve ses kayıtlarını koruma günü.

### Tarihçesi ve Önemi
27 Ekim Ses ve Görüntü Mirası Günü, gerek Türkiye''de gerekse uluslararası alanda UNESCO nezdinde tanınan ve her yıl 27 Ekim tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "27 Ekim Ses ve Görüntü Mirası Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "27 Ekim günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-10-27', 10, 27, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'UNESCO', 'https://www.un.org', ARRAY['#27Ekim', '#27ekimsesvegoruntumirasigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '28-ekim-28-ekim-cumhuriyet-bayrami-arifesi-ve-animasyon-gunu', '28 Ekim 28 Ekim Cumhuriyet Bayramı Arifesi ve Animasyon Günü', 'Cumhuriyet coşkusunun başlangıcı ve çizgi film sanatı günü.', '## 28 Ekim 28 Ekim Cumhuriyet Bayramı Arifesi ve Animasyon Günü Nedir?
Cumhuriyet coşkusunun başlangıcı ve çizgi film sanatı günü.

### Tarihçesi ve Önemi
28 Ekim 28 Ekim Cumhuriyet Bayramı Arifesi ve Animasyon Günü, gerek Türkiye''de gerekse uluslararası alanda T.C. Resmi Gazete & ASIFA nezdinde tanınan ve her yıl 28 Ekim tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "28 Ekim 28 Ekim Cumhuriyet Bayramı Arifesi ve Animasyon Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "28 Ekim günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-10-28', 10, 28, 'Resmi', 'kutlama', false, 'uluslararasi', 'T.C. Resmi Gazete & ASIFA', 'https://www.un.org', ARRAY['#28Ekim', '#28ekim28ekimcumhuriyetbayramiarifesiveanimasyongunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'cumhuriyet-bayrami', '29 Ekim Cumhuriyet Bayramı', 'Türkiye Cumhuriyeti''nin 1923 yılında Gazi Mustafa Kemal Atatürk tarafından ilan edildiği en büyük ulusal bayramımız.', '## 29 Ekim Cumhuriyet Bayramı Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #cumhuriyet-bayrami"', '2026-10-29', 10, 29, 'Resmi', 'kutlama', false, 'turkiye', '', '', ARRAY['#29Ekim', '#CumhuriyetBayrami', '#Ataturk', '#Cumhuriyet103Yasinda', '#Turkiye'], ARRAY['türk bayrağı büyük boy', 'atatürk rozeti', 'nutuk özel baskı', 'fener alayı meşalesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '30-ekim-dunya-tasarruf-gunu', '30 Ekim Dünya Tasarruf Günü', 'Maddi kaynakları akıllıca biriktirme ve finansal okuryazarlık günü.', '## 30 Ekim Dünya Tasarruf Günü Nedir?
Maddi kaynakları akıllıca biriktirme ve finansal okuryazarlık günü.

### Tarihçesi ve Önemi
30 Ekim Dünya Tasarruf Günü, gerek Türkiye''de gerekse uluslararası alanda World Savings Banks Institute nezdinde tanınan ve her yıl 30 Ekim tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "30 Ekim Dünya Tasarruf Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "30 Ekim günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-10-30', 10, 30, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'World Savings Banks Institute', 'https://www.un.org', ARRAY['#30Ekim', '#30ekimdunyatasarrufgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-tasarruf-gunu', '31 Ekim Dünya Tasarruf Günü', 'Finansal okuryazarlık, para biriktirme ve kaynakları verimli kullanma alışkanlığını teşvik eden gün.', '## 31 Ekim Dünya Tasarruf Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-tasarruf-gunu"', '2026-10-31', 10, 31, 'Eğlence', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaTasarrufGunu', '#Tasarruf', '#FinansalOkuryazarlik', '#BirimYap'], ARRAY['dijital para sayan kumbara', 'finansal özgürlük kitapları', 'akıllı priz enerji ölçer']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '1-kasim-harf-devrimi-haftasi-ve-dunya-vegan-gunu', '1 Kasım Harf Devrimi Haftası ve Dünya Vegan Günü', 'Yeni Türk alfabesine geçiş ve bitkisel beslenme bilinci.', '## 1 Kasım Harf Devrimi Haftası ve Dünya Vegan Günü Nedir?
Yeni Türk alfabesine geçiş ve bitkisel beslenme bilinci.

### Tarihçesi ve Önemi
1 Kasım Harf Devrimi Haftası ve Dünya Vegan Günü, gerek Türkiye''de gerekse uluslararası alanda T.C. Kültür Bakanlığı & Vegan Society nezdinde tanınan ve her yıl 1 Kasım tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "1 Kasım Harf Devrimi Haftası ve Dünya Vegan Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "1 Kasım günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-11-01', 11, 1, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'T.C. Kültür Bakanlığı & Vegan Society', 'https://www.un.org', ARRAY['#1Kasım', '#1kasimharfdevrimihaftasivedunyavegangunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'losemili-cocuklar-haftasi', '2-8 Kasım Lösemili Çocuklar Haftası', 'Lösemi hastalığı konusunda bilinç oluşturmak ve minik kahramanlara umut olmak amacıyla düzenlenen farkındalık haftası.', '## 2-8 Kasım Lösemili Çocuklar Haftası Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #losemili-cocuklar-haftasi"', '2026-11-02', 11, 2, 'Sağlık', 'kutlama', false, 'turkiye', '', '', ARRAY['#LosemiliCocuklarHaftasi', '#MaskemiTakarimFarkindalikYaratirim', '#LÖSEV', '#Umut'], ARRAY['lösev hediyelik eşya', 'renkli maske seti', 'çocuk boyama seti']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '3-kasim-dunya-sandvic-gunu-ve-biyosfer-rezervleri-gunu', '3 Kasım Dünya Sandviç Günü ve Biyosfer Rezervleri Günü', 'Pratik lezzet sandviç ve UNESCO doğa rezervleri günü.', '## 3 Kasım Dünya Sandviç Günü ve Biyosfer Rezervleri Günü Nedir?
Pratik lezzet sandviç ve UNESCO doğa rezervleri günü.

### Tarihçesi ve Önemi
3 Kasım Dünya Sandviç Günü ve Biyosfer Rezervleri Günü, gerek Türkiye''de gerekse uluslararası alanda UNESCO nezdinde tanınan ve her yıl 3 Kasım tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "3 Kasım Dünya Sandviç Günü ve Biyosfer Rezervleri Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "3 Kasım günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-11-03', 11, 3, 'Eğlence', 'kutlama', false, 'uluslararasi', 'UNESCO', 'https://www.un.org', ARRAY['#3Kasım', '#3kasimdunyasandvicgunuvebiyosferrezervlerigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '4-kasim-unesco-kurulus-gunu', '4 Kasım UNESCO Kuruluş Günü', 'Eğitim, bilim ve kültürle barışı inşa eden UNESCO yıldönümü.', '## 4 Kasım UNESCO Kuruluş Günü Nedir?
Eğitim, bilim ve kültürle barışı inşa eden UNESCO yıldönümü.

### Tarihçesi ve Önemi
4 Kasım UNESCO Kuruluş Günü, gerek Türkiye''de gerekse uluslararası alanda UNESCO (1946) nezdinde tanınan ve her yıl 4 Kasım tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "4 Kasım UNESCO Kuruluş Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "4 Kasım günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-11-04', 11, 4, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'UNESCO (1946)', 'https://www.un.org', ARRAY['#4Kasım', '#4kasimunescokurulusgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '5-kasim-dunya-tsunami-farkindalik-gunu', '5 Kasım Dünya Tsunami Farkındalık Günü', 'Kıyı bölgelerinde dev dalgalara karşı erken uyarı günü.', '## 5 Kasım Dünya Tsunami Farkındalık Günü Nedir?
Kıyı bölgelerinde dev dalgalara karşı erken uyarı günü.

### Tarihçesi ve Önemi
5 Kasım Dünya Tsunami Farkındalık Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/70/203) nezdinde tanınan ve her yıl 5 Kasım tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "5 Kasım Dünya Tsunami Farkındalık Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "5 Kasım günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-11-05', 11, 5, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'BM (A/RES/70/203)', 'https://www.un.org', ARRAY['#5Kasım', '#5kasimdunyatsunamifarkindalikgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '6-kasim-savasta-cevrenin-somurulmesini-onleme-gunu', '6 Kasım Savaşta Çevrenin Sömürülmesini Önleme Günü', 'Silahlı çatışmalarda doğanın tahrip edilmesine karşı BM günü.', '## 6 Kasım Savaşta Çevrenin Sömürülmesini Önleme Günü Nedir?
Silahlı çatışmalarda doğanın tahrip edilmesine karşı BM günü.

### Tarihçesi ve Önemi
6 Kasım Savaşta Çevrenin Sömürülmesini Önleme Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/56/4) nezdinde tanınan ve her yıl 6 Kasım tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "6 Kasım Savaşta Çevrenin Sömürülmesini Önleme Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "6 Kasım günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-11-06', 11, 6, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'BM (A/RES/56/4)', 'https://www.un.org', ARRAY['#6Kasım', '#6kasimsavastacevreninsomurulmesinionlemegunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '7-kasim-dunya-medikal-fizik-gunu', '7 Kasım Dünya Medikal Fizik Günü', 'Marie Curie''nin doğum gününde radyasyon tıbbı ve fizik bilimi günü.', '## 7 Kasım Dünya Medikal Fizik Günü Nedir?
Marie Curie''nin doğum gününde radyasyon tıbbı ve fizik bilimi günü.

### Tarihçesi ve Önemi
7 Kasım Dünya Medikal Fizik Günü, gerek Türkiye''de gerekse uluslararası alanda IOMP nezdinde tanınan ve her yıl 7 Kasım tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "7 Kasım Dünya Medikal Fizik Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "7 Kasım günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-11-07', 11, 7, 'Sağlık', 'kutlama', false, 'uluslararasi', 'IOMP', 'https://www.un.org', ARRAY['#7Kasım', '#7kasimdunyamedikalfizikgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-sehircilik-gunu', '8 Kasım Dünya Şehircilik Günü', 'Planlı, yaşanabilir, yeşil ve afetlere dayanıklı kentler inşa etme bilincini artıran gün.', '## 8 Kasım Dünya Şehircilik Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-sehircilik-gunu"', '2026-11-08', 11, 8, 'Mesleki', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaSehircilikGunu', '#SehirPlanciligi', '#YasanabilirKentler', '#8Kasim'], ARRAY['şehir planlama ve mimarlık kitapları', 'teknik çizim kalemi seti', 'maket bıçağı seti']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '9-kasim-dunya-ozgurluk-gunu', '9 Kasım Dünya Özgürlük Günü', 'Berlin Duvarı''nın yıkılışı anısına insan özgürlüğü günü.', '## 9 Kasım Dünya Özgürlük Günü Nedir?
Berlin Duvarı''nın yıkılışı anısına insan özgürlüğü günü.

### Tarihçesi ve Önemi
9 Kasım Dünya Özgürlük Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 9 Kasım tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "9 Kasım Dünya Özgürlük Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "9 Kasım günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-11-09', 11, 9, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#9Kasım', '#9kasimdunyaozgurlukgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'ataturku-anma-gunu', '10 Kasım Atatürk''ü Anma Günü', 'Türkiye Cumhuriyeti''nin kurucusu Gazi Mustafa Kemal Atatürk''ün ebediyete intikalinin 88. yıl dönümü ve milli anma günü.', '## 10 Kasım Atatürk''ü Anma Günü Nedir?
10 Kasım 1938 günü saat 09:05''te Dolmabahçe Sarayı''nda ebediyete irtihal eden Türkiye Cumhuriyeti''nin kurucusu Gazi Mustafa Kemal Atatürk''ün aziz hatırasını yaşatmak amacıyla her yıl düzenlenen ulusal yas ve anma günüdür.

### Tarihçesi ve Milli Anlamı
Mustafa Kemal Atatürk, askeri dehası ve liderliğiyle Kurtuluş Savaşı''nı zafere ulaştırmış, ardından hayata geçirdiği inkılaplarla modern, bağımsız ve laik Türkiye Cumhuriyeti''ni inşa etmiştir. Her 10 Kasım günü saat 09:05''te tüm yurtta sirenler eşliğinde 2 dakikalık saygı duruşunda bulunulur; bayraklar yarıya indirilir ve Anıtkabir''de resmi devlet töreni icra edilir.

---

## 10 Kasım''da Atatürk Nasıl Anılır?
1. Saat 09:05''te nerede olursanız olun siren sesiyle birlikte saygı duruşunda bulunun.
2. Anıtkabir''i ve yerel Atatürk anıtlarını ziyaret ederek çiçek bırakın.
3. Nutuk''u, Atatürk''ün fikirlerini ve Cumhuriyet ilkelerini çocuklarınıza anlatın.
4. Anma etkinliklerine ve resmi törenlere katılarak saygınızı ifade edin.

---

## 10 Kasım Anma ve Saygı Mesajları
* "Beni görmek demek mutlaka yüzümü görmek demek değildir. Benim fikirlerimi, benim duygularımı anlıyorsanız ve hissediyorsanız bu kafidir. Gazi Mustafa Kemal Atatürk''ü saygı, rahmet ve sonsuz minnetle anıyoruz. 🇹🇷🖤"
* "Fikirlerin, ilkelerin ve emanetin olan Cumhuriyet ilelebet yaşayacak. 10 Kasım Atatürk''ü Anma Günü''nde Başkomutanımızı derin bir özlemle yad ediyoruz. #10Kasim #Ataturk #0905"
* "Açtığın yolda, gösterdiğin hedefe durmadan yürüyeceğimize ant içeriz. Ruhun şad olsun Atam. #SaygiVeOzlemle #MustafaKemalAtaturk"', '2026-11-10', 11, 10, 'Resmi', 'anma', false, 'turkiye', 'T.C. Resmî Gazete & Anıtkabir Komutanlığı', 'https://www.anitkabir.tsk.tr', ARRAY['#10Kasim', '#Ataturk', '#SaygiVeOzlemle', '#0905', '#Turkiye'], ARRAY[]
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '11-kasim-milli-agaclandirma-gunu-ve-bekarlar-gunu', '11 Kasım Milli Ağaçlandırma Günü ve Bekarlar Günü', '''Geleceğe Nefes'' fidan dikme seferberliği ve alışveriş günü.', '## 11 Kasım Milli Ağaçlandırma Günü ve Bekarlar Günü Nedir?
''Geleceğe Nefes'' fidan dikme seferberliği ve alışveriş günü.

### Tarihçesi ve Önemi
11 Kasım Milli Ağaçlandırma Günü ve Bekarlar Günü, gerek Türkiye''de gerekse uluslararası alanda T.C. Tarım ve Orman Bakanlığı nezdinde tanınan ve her yıl 11 Kasım tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "11 Kasım Milli Ağaçlandırma Günü ve Bekarlar Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "11 Kasım günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-11-11', 11, 11, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'T.C. Tarım ve Orman Bakanlığı', 'https://www.un.org', ARRAY['#11Kasım', '#11kasimmilliagaclandirmagunuvebekarlargunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '12-kasim-dunya-zaturre-pnomoni-gunu-ve-afet-egitimi-gunu', '12 Kasım Dünya Zatürre (Pnömoni) Günü ve Afet Eğitimi Günü', 'Akciğer enfeksiyonlarına karşı aşı ve afet hazırlığı günü.', '## 12 Kasım Dünya Zatürre (Pnömoni) Günü ve Afet Eğitimi Günü Nedir?
Akciğer enfeksiyonlarına karşı aşı ve afet hazırlığı günü.

### Tarihçesi ve Önemi
12 Kasım Dünya Zatürre (Pnömoni) Günü ve Afet Eğitimi Günü, gerek Türkiye''de gerekse uluslararası alanda DSÖ & AFAD nezdinde tanınan ve her yıl 12 Kasım tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "12 Kasım Dünya Zatürre (Pnömoni) Günü ve Afet Eğitimi Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "12 Kasım günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-11-12', 11, 12, 'Sağlık', 'kutlama', false, 'uluslararasi', 'DSÖ & AFAD', 'https://www.un.org', ARRAY['#12Kasım', '#12kasimdunyazaturrepnomonigunuveafetegitimigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '13-kasim-dunya-iyilik-gunu', '13 Kasım Dünya İyilik Günü', 'Empati, nezaket ve sevgi dolu küçük adımlar günü.', '## 13 Kasım Dünya İyilik Günü Nedir?
Empati, nezaket ve sevgi dolu küçük adımlar günü.

### Tarihçesi ve Önemi
13 Kasım Dünya İyilik Günü, gerek Türkiye''de gerekse uluslararası alanda World Kindness Movement nezdinde tanınan ve her yıl 13 Kasım tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "13 Kasım Dünya İyilik Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "13 Kasım günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-11-13', 11, 13, 'Eğlence', 'kutlama', false, 'uluslararasi', 'World Kindness Movement', 'https://www.un.org', ARRAY['#13Kasım', '#13kasimdunyaiyilikgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-diyabet-gunu', '14 Kasım Dünya Diyabet Günü', 'İnsülinin kaşifi Frederick Banting''in doğum gününde diyabet hastalığı ve dengeli beslenme bilincini artıran gün.', '## 14 Kasım Dünya Diyabet Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-diyabet-gunu"', '2026-11-14', 11, 14, 'Sağlık', 'kutlama', false, 'turkiye', '', '', ARRAY['#DiyabetGunu', '#MaviHalka', '#SekerHastaligi', '#DengeliBeslen'], ARRAY['şeker ölçüm cihazı stripli', 'şekersiz tatlandırıcı', 'diyabet tarifleri kitabı']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '15-kasim-dunya-felsefe-gunu', '15 Kasım Dünya Felsefe Günü', 'Sorgulayıcı düşüncenin ve erdemli yaşamın felsefe günü.', '## 15 Kasım Dünya Felsefe Günü Nedir?
Sorgulayıcı düşüncenin ve erdemli yaşamın felsefe günü.

### Tarihçesi ve Önemi
15 Kasım Dünya Felsefe Günü, gerek Türkiye''de gerekse uluslararası alanda UNESCO nezdinde tanınan ve her yıl 15 Kasım tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "15 Kasım Dünya Felsefe Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "15 Kasım günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-11-15', 11, 15, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'UNESCO', 'https://www.un.org', ARRAY['#15Kasım', '#15kasimdunyafelsefegunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'uluslararasi-hosgoru-gunu', '16 Kasım Uluslararası Hoşgörü Günü', 'Farklılıklara saygı, empati, diyalog ve barış içinde bir arada yaşama kültürünü kutlayan UNESCO günü.', '## 16 Kasım Uluslararası Hoşgörü Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #uluslararasi-hosgoru-gunu"', '2026-11-16', 11, 16, 'Farkındalık', 'kutlama', false, 'turkiye', '', '', ARRAY['#HosgoruGunu', '#Mevlana', '#FarkliliklarZenginliktir', '#Empati'], ARRAY['mevlana mesnevi seti', 'felsefe ve empati kitapları', 'meditasyon müziği cd']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '17-kasim-uluslararasi-ogrenciler-gunu-ve-premature-gunu', '17 Kasım Uluslararası Öğrenciler Günü ve Prematüre Günü', 'Genç üniversiteliler ve erken doğan minik savaşçılar günü.', '## 17 Kasım Uluslararası Öğrenciler Günü ve Prematüre Günü Nedir?
Genç üniversiteliler ve erken doğan minik savaşçılar günü.

### Tarihçesi ve Önemi
17 Kasım Uluslararası Öğrenciler Günü ve Prematüre Günü, gerek Türkiye''de gerekse uluslararası alanda EFCNI nezdinde tanınan ve her yıl 17 Kasım tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "17 Kasım Uluslararası Öğrenciler Günü ve Prematüre Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "17 Kasım günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-11-17', 11, 17, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'EFCNI', 'https://www.un.org', ARRAY['#17Kasım', '#17kasimuluslararasiogrencilergunuveprematuregunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '18-kasim-cocuklarin-cinsel-istismardan-korunmasi-gunu', '18 Kasım Çocukların Cinsel İstismardan Korunması Günü', 'Çocuk haklarını ve beden dokunulmazlığını koruma günü.', '## 18 Kasım Çocukların Cinsel İstismardan Korunması Günü Nedir?
Çocuk haklarını ve beden dokunulmazlığını koruma günü.

### Tarihçesi ve Önemi
18 Kasım Çocukların Cinsel İstismardan Korunması Günü, gerek Türkiye''de gerekse uluslararası alanda Avrupa Konseyi nezdinde tanınan ve her yıl 18 Kasım tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "18 Kasım Çocukların Cinsel İstismardan Korunması Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "18 Kasım günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-11-18', 11, 18, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'Avrupa Konseyi', 'https://www.un.org', ARRAY['#18Kasım', '#18kasimcocuklarincinselistismardankorunmasigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '19-kasim-dunya-tuvalet-gunu-ve-dunya-erkekler-gunu', '19 Kasım Dünya Tuvalet Günü ve Dünya Erkekler Günü', 'Temiz sanitasyon altyapısı ve erkek sağlığı bilinci günü.', '## 19 Kasım Dünya Tuvalet Günü ve Dünya Erkekler Günü Nedir?
Temiz sanitasyon altyapısı ve erkek sağlığı bilinci günü.

### Tarihçesi ve Önemi
19 Kasım Dünya Tuvalet Günü ve Dünya Erkekler Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/67/291) nezdinde tanınan ve her yıl 19 Kasım tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "19 Kasım Dünya Tuvalet Günü ve Dünya Erkekler Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "19 Kasım günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-11-19', 11, 19, 'Sağlık', 'kutlama', false, 'uluslararasi', 'BM (A/RES/67/291)', 'https://www.un.org', ARRAY['#19Kasım', '#19kasimdunyatuvaletgunuvedunyaerkeklergunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-cocuk-haklari-gunu', '20 Kasım Dünya Çocuk Hakları Günü', 'BM Çocuk Haklarına Dair Sözleşme''nin kabul edildiği gün, her çocuğun sağlık, eğitim ve korunma hakkını savunur.', '## 20 Kasım Dünya Çocuk Hakları Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-cocuk-haklari-gunu"', '2026-11-20', 11, 20, 'Farkındalık', 'kutlama', false, 'turkiye', '', '', ARRAY['#CocukHaklariGunu', '#HerCocukIcinHaklar', '#UNICEF', '#Gelecegimiz'], ARRAY['çocuk hakları resimli kitap', 'eğitici kutu oyunları', 'çocuk gelişim kitapları']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-televizyon-gunu', '21 Kasım Dünya Televizyon Günü', 'Görsel habercilik, kamuoyu oluşturma ve kültürel etkileşimdeki televizyonun gücünü kutlayan BM günü.', '## 21 Kasım Dünya Televizyon Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-televizyon-gunu"', '2026-11-21', 11, 21, 'Kültür & Sanat', 'kutlama', false, 'turkiye', '', '', ARRAY['#TelevizyonGunu', '#WorldTelevisionDay', '#Medya', '#Yayin'], ARRAY['akıllı tv kumandası', 'led tv arka aydınlatma ambiyans', 'soundbar ses sistemi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dis-hekimleri-gunu', '22 Kasım Diş Hekimleri Günü', 'Türkiye''de ilk Dişçi Mektebi''nin kuruluş yıl dönümünde ağız ve diş sağlığı kahramanlarına adanan gün.', '## 22 Kasım Diş Hekimleri Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dis-hekimleri-gunu"', '2026-11-22', 11, 22, 'Sağlık', 'kutlama', false, 'turkiye', '', '', ARRAY['#DisHekimleriGunu', '#AgizVeDisSagligi', '#Gulumse', '#DisHekimi'], ARRAY['şarjlı diş fırçası', 'ağız duşu cihazı', 'diş hekimi esprili kupa', 'diş ipi seti']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '23-kasim-fibonacci-gunu-1-1-2-3', '23 Kasım Fibonacci Günü (1, 1, 2, 3)', 'Doğanın altın oranını simgeleyen matematik günü.', '## 23 Kasım Fibonacci Günü (1, 1, 2, 3) Nedir?
Doğanın altın oranını simgeleyen matematik günü.

### Tarihçesi ve Önemi
23 Kasım Fibonacci Günü (1, 1, 2, 3), gerek Türkiye''de gerekse uluslararası alanda Mathematical Association nezdinde tanınan ve her yıl 23 Kasım tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "23 Kasım Fibonacci Günü (1, 1, 2, 3) kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "23 Kasım günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-11-23', 11, 23, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'Mathematical Association', 'https://www.un.org', ARRAY['#23Kasım', '#23kasimfibonaccigunu1123'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'ogretmenler-gunu', '24 Kasım Öğretmenler Günü', 'Mustafa Kemal Atatürk''ün Millet Mektepleri Başöğretmenliği unvanını kabul ettiği günün anısına kutlanır.', '## 24 Kasım Öğretmenler Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #ogretmenler-gunu"', '2026-11-24', 11, 24, 'Mesleki', 'kutlama', false, 'turkiye', '', '', ARRAY['#24Kasim', '#OgretmenlerGunu', '#Basogretmen', '#CanimOgretmenim'], ARRAY['isme özel öğretmen dolma kalemi', 'öğretmenler günü hediye kutusu', 'çiçek buketi', 'deri ajanda']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '25-kasim-kadina-yonelik-siddete-karsi-mucadele-gunu', '25 Kasım Kadına Yönelik Şiddete Karşı Mücadele Günü', 'Kadın cinayetlerine ve şiddete karşı sıfır tolerans günü.', '## 25 Kasım Kadına Yönelik Şiddete Karşı Mücadele Günü Nedir?
Kadın cinayetlerine ve şiddete karşı sıfır tolerans günü.

### Tarihçesi ve Önemi
25 Kasım Kadına Yönelik Şiddete Karşı Mücadele Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/54/134) nezdinde tanınan ve her yıl 25 Kasım tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "25 Kasım Kadına Yönelik Şiddete Karşı Mücadele Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "25 Kasım günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-11-25', 11, 25, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'BM (A/RES/54/134)', 'https://www.un.org', ARRAY['#25Kasım', '#25kasimkadinayoneliksiddetekarsimucadelegunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '26-kasim-dunya-zeytin-agaci-gunu', '26 Kasım Dünya Zeytin Ağacı Günü', 'Barışın simgesi ölümsüz zeytin ağacını koruma günü.', '## 26 Kasım Dünya Zeytin Ağacı Günü Nedir?
Barışın simgesi ölümsüz zeytin ağacını koruma günü.

### Tarihçesi ve Önemi
26 Kasım Dünya Zeytin Ağacı Günü, gerek Türkiye''de gerekse uluslararası alanda UNESCO nezdinde tanınan ve her yıl 26 Kasım tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "26 Kasım Dünya Zeytin Ağacı Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "26 Kasım günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-11-26', 11, 26, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'UNESCO', 'https://www.un.org', ARRAY['#26Kasım', '#26kasimdunyazeytinagacigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '27-kasim-dunya-demir-ve-celik-sanatcilari-gunu', '27 Kasım Dünya Demir ve Çelik Sanatçıları Günü', 'Metale can veren heykel ve zanaat ustaları günü.', '## 27 Kasım Dünya Demir ve Çelik Sanatçıları Günü Nedir?
Metale can veren heykel ve zanaat ustaları günü.

### Tarihçesi ve Önemi
27 Kasım Dünya Demir ve Çelik Sanatçıları Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 27 Kasım tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "27 Kasım Dünya Demir ve Çelik Sanatçıları Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "27 Kasım günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-11-27', 11, 27, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#27Kasım', '#27kasimdunyademirveceliksanatcilarigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '28-kasim-akdeniz-gunu', '28 Kasım Akdeniz Günü', 'Akdeniz havzasının ortak tarihi ve deniz ekosistemi günü.', '## 28 Kasım Akdeniz Günü Nedir?
Akdeniz havzasının ortak tarihi ve deniz ekosistemi günü.

### Tarihçesi ve Önemi
28 Kasım Akdeniz Günü, gerek Türkiye''de gerekse uluslararası alanda Union for the Mediterranean nezdinde tanınan ve her yıl 28 Kasım tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "28 Kasım Akdeniz Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "28 Kasım günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-11-28', 11, 28, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'Union for the Mediterranean', 'https://www.un.org', ARRAY['#28Kasım', '#28kasimakdenizgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '29-kasim-filistin-halkiyla-uluslararasi-dayanisma-gunu', '29 Kasım Filistin Halkıyla Uluslararası Dayanışma Günü', 'Filistin halkının meşru haklarını ve barışı savunma günü.', '## 29 Kasım Filistin Halkıyla Uluslararası Dayanışma Günü Nedir?
Filistin halkının meşru haklarını ve barışı savunma günü.

### Tarihçesi ve Önemi
29 Kasım Filistin Halkıyla Uluslararası Dayanışma Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/32/40 B) nezdinde tanınan ve her yıl 29 Kasım tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "29 Kasım Filistin Halkıyla Uluslararası Dayanışma Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "29 Kasım günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-11-29', 11, 29, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'BM (A/RES/32/40 B)', 'https://www.un.org', ARRAY['#29Kasım', '#29kasimfilistinhalkiylauluslararasidayanismagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '30-kasim-bilgisayar-guvenligi-gunu-ve-kimyasal-silah-kurbanlari-gunu', '30 Kasım Bilgisayar Güvenliği Günü ve Kimyasal Silah Kurbanları Günü', 'Siber koruma ve kimyasal silahsız bir dünya ideali günü.', '## 30 Kasım Bilgisayar Güvenliği Günü ve Kimyasal Silah Kurbanları Günü Nedir?
Siber koruma ve kimyasal silahsız bir dünya ideali günü.

### Tarihçesi ve Önemi
30 Kasım Bilgisayar Güvenliği Günü ve Kimyasal Silah Kurbanları Günü, gerek Türkiye''de gerekse uluslararası alanda ACM & BM nezdinde tanınan ve her yıl 30 Kasım tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "30 Kasım Bilgisayar Güvenliği Günü ve Kimyasal Silah Kurbanları Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "30 Kasım günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-11-30', 11, 30, 'Mesleki', 'kutlama', false, 'uluslararasi', 'ACM & BM', 'https://www.un.org', ARRAY['#30Kasım', '#30kasimbilgisayarguvenligigunuvekimyasalsilahkurbanlarigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-aids-gunu', '1 Aralık Dünya AIDS Günü', 'HIV/AIDS konusunda doğru bilinci yaymak, ön yargıları kırmak ve hastalara destek olmak için kutlanan küresel gün.', '## 1 Aralık Dünya AIDS Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-aids-gunu"', '2026-12-01', 12, 1, 'Sağlık', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaAIDSGunu', '#KirmiziKurdele', '#FarkindaOl', '#OnYargiyiKir'], ARRAY['kırmızı kurdele yaka iğnesi', 'bağışıklık güçlendirici vitamin']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '2-aralik-koleligin-kaldirilmasi-uluslararasi-gunu', '2 Aralık Köleliğin Kaldırılması Uluslararası Günü', 'Modern kölelik ve insan ticaretiyle mücadele günü.', '## 2 Aralık Köleliğin Kaldırılması Uluslararası Günü Nedir?
Modern kölelik ve insan ticaretiyle mücadele günü.

### Tarihçesi ve Önemi
2 Aralık Köleliğin Kaldırılması Uluslararası Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/317) nezdinde tanınan ve her yıl 2 Aralık tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "2 Aralık Köleliğin Kaldırılması Uluslararası Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "2 Aralık günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-12-02', 12, 2, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'BM (A/RES/317)', 'https://www.un.org', ARRAY['#2Aralık', '#2aralikkoleliginkaldirilmasiuluslararasigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-engelliler-gunu', '3 Aralık Dünya Engelliler Günü', 'Engelli bireylerin haklarına, toplumsal hayata tam katılımlarına ve erişilebilirliğe dikkat çeken BM günü.', '## 3 Aralık Dünya Engelliler Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-engelliler-gunu"', '2026-12-03', 12, 3, 'Farkındalık', 'kutlama', false, 'turkiye', '', '', ARRAY['#3Aralik', '#DunyaEngellilerGunu', '#SevgiVarsaEngelYok', '#Erisilebilirlik'], ARRAY['tekerlekli sandalye minderi', 'ergonomik tutacak seti', 'sesli uyarı cihazı']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '4-aralik-dunya-madenciler-gunu-ve-yaban-hayati-koruma', '4 Aralık Dünya Madenciler Günü ve Yaban Hayatı Koruma', 'Yerin yüzlerce metre altında alın teri döken madenciler günü.', '## 4 Aralık Dünya Madenciler Günü ve Yaban Hayatı Koruma Nedir?
Yerin yüzlerce metre altında alın teri döken madenciler günü.

### Tarihçesi ve Önemi
4 Aralık Dünya Madenciler Günü ve Yaban Hayatı Koruma, gerek Türkiye''de gerekse uluslararası alanda TMMOB Maden Mühendisleri nezdinde tanınan ve her yıl 4 Aralık tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "4 Aralık Dünya Madenciler Günü ve Yaban Hayatı Koruma kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "4 Aralık günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-12-04', 12, 4, 'Mesleki', 'kutlama', false, 'uluslararasi', 'TMMOB Maden Mühendisleri', 'https://www.un.org', ARRAY['#4Aralık', '#4aralikdunyamadencilergunuveyabanhayatikoruma'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-toprak-gunu', '5 Aralık Dünya Toprak Günü', 'Besinlerimizin yüzde 95''ini sağlayan toprağın erozyondan ve kirlilikten korunması için BM tarafından kutlanır.', '## 5 Aralık Dünya Toprak Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-toprak-gunu"', '2026-12-05', 12, 5, 'Çevre & Doğa', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaToprakGunu', '#WorldSoilDay', '#TopragiKoru', '#TEMA'], ARRAY['organik kompost gübre', 'solucan gübresi', 'bahçıvan kürek seti']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-turk-kahvesi-gunu', '5 Aralık Dünya Türk Kahvesi Günü', 'UNESCO tarafından Somut Olmayan Kültürel Miras listesine alınan Türk Kahvesi kültürünün küresel kutlaması.', '## 5 Aralık Dünya Türk Kahvesi Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-turk-kahvesi-gunu"', '2026-12-05', 12, 5, 'Kültür & Sanat', 'kutlama', false, 'turkiye', '', '', ARRAY['#DunyaTurkKahvesiGunu', '#TurkKahvesi', '#UNESCO', '#KahveKulturu'], ARRAY['otomatik türk kahvesi makinesi', 'bakır cezve seti', 'türk kahvesi fincan takımı', 'hacı bekir lokumu']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-kadin-haklari-gunu', '5 Aralık Dünya Kadın Hakları Günü', 'Türk kadınlarına seçme ve seçilme hakkının birçok Avrupa ülkesinden önce verildiği tarihi gün.', '## 5 Aralık Dünya Kadın Hakları Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kadin-haklari-gunu"', '2026-12-05', 12, 5, 'Farkındalık', 'kutlama', false, 'turkiye', '', '', ARRAY['#5Aralik', '#KadinHaklariGunu', '#SecmeVeSecilmeHakki', '#Ataturk'], ARRAY['kadın liderler biyografi kitabı', 'özel tasarım takı seti', 'fular ipek']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '6-aralik-dunya-mikrodalga-ve-pratik-mutfak-gunu', '6 Aralık Dünya Mikrodalga ve Pratik Mutfak Günü', 'Modern mutfak teknolojileri ve lezzetli tarifler günü.', '## 6 Aralık Dünya Mikrodalga ve Pratik Mutfak Günü Nedir?
Modern mutfak teknolojileri ve lezzetli tarifler günü.

### Tarihçesi ve Önemi
6 Aralık Dünya Mikrodalga ve Pratik Mutfak Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 6 Aralık tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "6 Aralık Dünya Mikrodalga ve Pratik Mutfak Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "6 Aralık günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-12-06', 12, 6, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#6Aralık', '#6aralikdunyamikrodalgavepratikmutfakgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '7-aralik-uluslararasi-sivil-havacilik-gunu', '7 Aralık Uluslararası Sivil Havacılık Günü', 'Gökyüzü ulaşımının güvenliği ve hava taşımacılığı günü.', '## 7 Aralık Uluslararası Sivil Havacılık Günü Nedir?
Gökyüzü ulaşımının güvenliği ve hava taşımacılığı günü.

### Tarihçesi ve Önemi
7 Aralık Uluslararası Sivil Havacılık Günü, gerek Türkiye''de gerekse uluslararası alanda ICAO & BM (A/RES/51/33) nezdinde tanınan ve her yıl 7 Aralık tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "7 Aralık Uluslararası Sivil Havacılık Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "7 Aralık günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-12-07', 12, 7, 'Mesleki', 'kutlama', false, 'uluslararasi', 'ICAO & BM (A/RES/51/33)', 'https://www.un.org', ARRAY['#7Aralık', '#7aralikuluslararasisivilhavacilikgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '8-aralik-iklim-degisikligi-eylemi-gunu', '8 Aralık İklim Değişikliği Eylemi Günü', 'Küresel ısınmaya karşı yenilenebilir enerji eylemi günü.', '## 8 Aralık İklim Değişikliği Eylemi Günü Nedir?
Küresel ısınmaya karşı yenilenebilir enerji eylemi günü.

### Tarihçesi ve Önemi
8 Aralık İklim Değişikliği Eylemi Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 8 Aralık tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "8 Aralık İklim Değişikliği Eylemi Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "8 Aralık günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-12-08', 12, 8, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#8Aralık', '#8aralikiklimdegisikligieylemigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '9-aralik-yolsuzlukla-mucadele-gunu-ve-soykirim-kurbanlarini-anma', '9 Aralık Yolsuzlukla Mücadele Günü ve Soykırım Kurbanlarını Anma', 'Şeffaflık, hesap verebilirlik ve soykırımı önleme günü.', '## 9 Aralık Yolsuzlukla Mücadele Günü ve Soykırım Kurbanlarını Anma Nedir?
Şeffaflık, hesap verebilirlik ve soykırımı önleme günü.

### Tarihçesi ve Önemi
9 Aralık Yolsuzlukla Mücadele Günü ve Soykırım Kurbanlarını Anma, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/58/4) nezdinde tanınan ve her yıl 9 Aralık tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "9 Aralık Yolsuzlukla Mücadele Günü ve Soykırım Kurbanlarını Anma kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "9 Aralık günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-12-09', 12, 9, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'BM (A/RES/58/4)', 'https://www.un.org', ARRAY['#9Aralık', '#9aralikyolsuzluklamucadelegunuvesoykirimkurbanlarinianma'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'dunya-insan-haklari-gunu', '10 Aralık Dünya İnsan Hakları Günü', '1948 yılında BM İnsan Hakları Evrensel Beyannamesi''nin kabul edildiği, temel hak ve özgürlüklerin günü.', '## 10 Aralık Dünya İnsan Hakları Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-insan-haklari-gunu"', '2026-12-10', 12, 10, 'Farkındalık', 'kutlama', false, 'turkiye', '', '', ARRAY['#10Aralik', '#InsanHaklariGunu', '#HumanRightsDay', '#Esitlik'], ARRAY['insan hakları evrensel beyannamesi kitap', 'felsefe ve etik kitapları']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'uluslararasi-dag-gunu', '11 Aralık Uluslararası Dağ Günü', 'Tatlı su kaynaklarımızın ve eşsiz dağ biyoçeşitliliğinin korunmasını savunan BM günü.', '## 11 Aralık Uluslararası Dağ Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #uluslararasi-dag-gunu"', '2026-12-11', 12, 11, 'Çevre & Doğa', 'kutlama', false, 'turkiye', '', '', ARRAY['#UluslararasiDagGunu', '#InternationalMountainDay', '#Daglar', '#Doga'], ARRAY['trekking batonları katlanır', 'termal dağcı çorabı', 'kamp termos paslanmaz']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '12-aralik-evrensel-saglik-kapsami-gunu-ve-tarafsizlik-gunu', '12 Aralık Evrensel Sağlık Kapsamı Günü ve Tarafsızlık Günü', 'Maddi zorluk çekmeden sağlık hizmeti alma hakkı günü.', '## 12 Aralık Evrensel Sağlık Kapsamı Günü ve Tarafsızlık Günü Nedir?
Maddi zorluk çekmeden sağlık hizmeti alma hakkı günü.

### Tarihçesi ve Önemi
12 Aralık Evrensel Sağlık Kapsamı Günü ve Tarafsızlık Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/72/138) nezdinde tanınan ve her yıl 12 Aralık tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "12 Aralık Evrensel Sağlık Kapsamı Günü ve Tarafsızlık Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "12 Aralık günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-12-12', 12, 12, 'Sağlık', 'kutlama', false, 'uluslararasi', 'BM (A/RES/72/138)', 'https://www.un.org', ARRAY['#12Aralık', '#12aralikevrenselsaglikkapsamigunuvetarafsizlikgunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '13-aralik-dunya-keman-gunu', '13 Aralık Dünya Keman Günü', 'Klasik müziğin büyüleyici enstrümanı keman günü.', '## 13 Aralık Dünya Keman Günü Nedir?
Klasik müziğin büyüleyici enstrümanı keman günü.

### Tarihçesi ve Önemi
13 Aralık Dünya Keman Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 13 Aralık tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "13 Aralık Dünya Keman Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "13 Aralık günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-12-13', 12, 13, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#13Aralık', '#13aralikdunyakemangunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '14-aralik-dunya-maymunlar-gunu', '14 Aralık Dünya Maymunlar Günü', 'Primatların zekası ve doğal orman habitatları günü.', '## 14 Aralık Dünya Maymunlar Günü Nedir?
Primatların zekası ve doğal orman habitatları günü.

### Tarihçesi ve Önemi
14 Aralık Dünya Maymunlar Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 14 Aralık tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "14 Aralık Dünya Maymunlar Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "14 Aralık günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-12-14', 12, 14, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#14Aralık', '#14aralikdunyamaymunlargunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '15-aralik-uluslararasi-cay-gunu-ve-esperanto-gunu', '15 Aralık Uluslararası Çay Günü ve Esperanto Günü', 'Çay üreticilerinin hakları ve ortak dünya dili Esperanto günü.', '## 15 Aralık Uluslararası Çay Günü ve Esperanto Günü Nedir?
Çay üreticilerinin hakları ve ortak dünya dili Esperanto günü.

### Tarihçesi ve Önemi
15 Aralık Uluslararası Çay Günü ve Esperanto Günü, gerek Türkiye''de gerekse uluslararası alanda BM FAO nezdinde tanınan ve her yıl 15 Aralık tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "15 Aralık Uluslararası Çay Günü ve Esperanto Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "15 Aralık günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-12-15', 12, 15, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'BM FAO', 'https://www.un.org', ARRAY['#15Aralık', '#15aralikuluslararasicaygunuveesperantogunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '16-aralik-dunya-uzlasma-ve-barisma-gunu', '16 Aralık Dünya Uzlaşma ve Barışma Günü', 'Kırgınlıkları geride bırakıp diyalog kurma günü.', '## 16 Aralık Dünya Uzlaşma ve Barışma Günü Nedir?
Kırgınlıkları geride bırakıp diyalog kurma günü.

### Tarihçesi ve Önemi
16 Aralık Dünya Uzlaşma ve Barışma Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 16 Aralık tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "16 Aralık Dünya Uzlaşma ve Barışma Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "16 Aralık günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-12-16', 12, 16, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#16Aralık', '#16aralikdunyauzlasmavebarismagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '17-aralik-seb-i-arus-mevlanayi-anma-gunu', '17 Aralık Şeb-i Arus (Mevlana''yı Anma Günü)', 'Mevlana Celaleddin-i Rumi''nin vuslat ve hoşgörü yıldönümü.', '## 17 Aralık Şeb-i Arus (Mevlana''yı Anma Günü) Nedir?
Mevlana Celaleddin-i Rumi''nin vuslat ve hoşgörü yıldönümü.

### Tarihçesi ve Önemi
17 Aralık Şeb-i Arus (Mevlana''yı Anma Günü), gerek Türkiye''de gerekse uluslararası alanda T.C. Kültür Bakanlığı nezdinde tanınan ve her yıl 17 Aralık tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "17 Aralık Şeb-i Arus (Mevlana''yı Anma Günü) kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "17 Aralık günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-12-17', 12, 17, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'T.C. Kültür Bakanlığı', 'https://www.un.org', ARRAY['#17Aralık', '#17araliksebiarusmevlanayianmagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'uluslararasi-gocmenler-gunu', '18 Aralık Uluslararası Göçmenler Günü', 'Dünya çapında göçmenlerin insan hakları, emekleri ve toplumsal katkılarını onurlandıran BM günü.', '## 18 Aralık Uluslararası Göçmenler Günü Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #uluslararasi-gocmenler-gunu"', '2026-12-18', 12, 18, 'Farkındalık', 'kutlama', false, 'turkiye', '', '', ARRAY['#GocmenlerGunu', '#InternationalMigrantsDay', '#InsanOnuru', '#Goc'], ARRAY['kültürlerarası sosyoloji kitapları', 'dünya dilleri sözlükleri']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '19-aralik-baris-ve-insani-yardim-agi-gunu', '19 Aralık Barış ve İnsani Yardım Ağı Günü', 'Kriz bölgelerinde dayanışma ve gönüllülük günü.', '## 19 Aralık Barış ve İnsani Yardım Ağı Günü Nedir?
Kriz bölgelerinde dayanışma ve gönüllülük günü.

### Tarihçesi ve Önemi
19 Aralık Barış ve İnsani Yardım Ağı Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 19 Aralık tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "19 Aralık Barış ve İnsani Yardım Ağı Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "19 Aralık günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-12-19', 12, 19, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#19Aralık', '#19aralikbarisveinsaniyardimagigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '20-aralik-uluslararasi-insani-dayanisma-gunu', '20 Aralık Uluslararası İnsani Dayanışma Günü', 'Yoksulluğun yenilmesi için küresel dayanışma günü.', '## 20 Aralık Uluslararası İnsani Dayanışma Günü Nedir?
Yoksulluğun yenilmesi için küresel dayanışma günü.

### Tarihçesi ve Önemi
20 Aralık Uluslararası İnsani Dayanışma Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/60/209) nezdinde tanınan ve her yıl 20 Aralık tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "20 Aralık Uluslararası İnsani Dayanışma Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "20 Aralık günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-12-20', 12, 20, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'BM (A/RES/60/209)', 'https://www.un.org', ARRAY['#20Aralık', '#20aralikuluslararasiinsanidayanismagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'en-uzun-gece', '21 Aralık En Uzun Gece (Kış Gündönümü)', 'Kuzey yarımkürede yılın en uzun gecesinin yaşandığı ve kış mevsiminin astronomik olarak başladığı gün.', '## 21 Aralık En Uzun Gece (Kış Gündönümü) Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #en-uzun-gece"', '2026-12-21', 12, 21, 'Eğlence', 'kutlama', false, 'turkiye', '', '', ARRAY['#21Aralik', '#EnUzunGece', '#KisGundonumu', '#Gece'], ARRAY['kokulu mum seti', 'polar battaniye', 'film izleme projeksiyon', 'termos kupa']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '22-aralik-sarikamis-sehitlerini-anma-gunu', '22 Aralık Sarıkamış Şehitlerini Anma Günü', '1914 yılında Allahuekber Dağları''nda donarak şehit düşen Mehmetçiklerimizi anma günü.', '## 22 Aralık Sarıkamış Şehitlerini Anma Günü Nedir?
1914 yılında Allahuekber Dağları''nda donarak şehit düşen Mehmetçiklerimizi anma günü.

### Tarihçesi ve Önemi
22 Aralık Sarıkamış Şehitlerini Anma Günü, gerek Türkiye''de gerekse uluslararası alanda T.C. Milli Savunma Bakanlığı nezdinde tanınan ve her yıl 22 Aralık tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "22 Aralık Sarıkamış Şehitlerini Anma Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "22 Aralık günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-12-22', 12, 22, 'Resmi', 'kutlama', false, 'uluslararasi', 'T.C. Milli Savunma Bakanlığı', 'https://www.un.org', ARRAY['#22Aralık', '#22araliksarikamissehitlerinianmagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '23-aralik-dunya-koklu-aileler-ve-akraba-gunu', '23 Aralık Dünya Köklü Aileler ve Akraba Günü', 'Kuşaklararası bağları güçlendirme ve aile buluşması günü.', '## 23 Aralık Dünya Köklü Aileler ve Akraba Günü Nedir?
Kuşaklararası bağları güçlendirme ve aile buluşması günü.

### Tarihçesi ve Önemi
23 Aralık Dünya Köklü Aileler ve Akraba Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 23 Aralık tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "23 Aralık Dünya Köklü Aileler ve Akraba Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "23 Aralık günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-12-23', 12, 23, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#23Aralık', '#23aralikdunyakokluailelerveakrabagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '24-aralik-noel-arifesi-christmas-eve', '24 Aralık Noel Arifesi (Christmas Eve)', 'Yeni yıl coşkusunun ve aile sofralarının arife gecesi.', '## 24 Aralık Noel Arifesi (Christmas Eve) Nedir?
Yeni yıl coşkusunun ve aile sofralarının arife gecesi.

### Tarihçesi ve Önemi
24 Aralık Noel Arifesi (Christmas Eve), gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 24 Aralık tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "24 Aralık Noel Arifesi (Christmas Eve) kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "24 Aralık günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-12-24', 12, 24, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#24Aralık', '#24araliknoelarifesichristmaseve'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '25-aralik-noel-bayrami-christmas-day', '25 Aralık Noel Bayramı (Christmas Day)', 'Hristiyan dünyasında barış ve hediyeleşme bayramı.', '## 25 Aralık Noel Bayramı (Christmas Day) Nedir?
Hristiyan dünyasında barış ve hediyeleşme bayramı.

### Tarihçesi ve Önemi
25 Aralık Noel Bayramı (Christmas Day), gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 25 Aralık tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "25 Aralık Noel Bayramı (Christmas Day) kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "25 Aralık günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-12-25', 12, 25, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#25Aralık', '#25araliknoelbayramichristmasday'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '26-aralik-hediyelesme-gunu-boxing-day', '26 Aralık Hediyeleşme Günü (Boxing Day)', 'Sevdiklerine hediye verme ve yardımlaşma geleneği günü.', '## 26 Aralık Hediyeleşme Günü (Boxing Day) Nedir?
Sevdiklerine hediye verme ve yardımlaşma geleneği günü.

### Tarihçesi ve Önemi
26 Aralık Hediyeleşme Günü (Boxing Day), gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 26 Aralık tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "26 Aralık Hediyeleşme Günü (Boxing Day) kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "26 Aralık günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-12-26', 12, 26, 'Eğlence', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#26Aralık', '#26aralikhediyelesmegunuboxingday'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '27-aralik-salginlara-hazirlik-uluslararasi-gunu', '27 Aralık Salgınlara Hazırlık Uluslararası Günü', 'Küresel salgınlara karşı erken uyarı ve sağlık altyapısı günü.', '## 27 Aralık Salgınlara Hazırlık Uluslararası Günü Nedir?
Küresel salgınlara karşı erken uyarı ve sağlık altyapısı günü.

### Tarihçesi ve Önemi
27 Aralık Salgınlara Hazırlık Uluslararası Günü, gerek Türkiye''de gerekse uluslararası alanda BM (A/RES/75/27) nezdinde tanınan ve her yıl 27 Aralık tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "27 Aralık Salgınlara Hazırlık Uluslararası Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "27 Aralık günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-12-27', 12, 27, 'Sağlık', 'kutlama', false, 'uluslararasi', 'BM (A/RES/75/27)', 'https://www.un.org', ARRAY['#27Aralık', '#27araliksalginlarahazirlikuluslararasigunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '28-aralik-dunya-sinema-gunu', '28 Aralık Dünya Sinema Günü', 'Lumière kardeşlerin 1895 yılındaki ilk film gösterimi günü.', '## 28 Aralık Dünya Sinema Günü Nedir?
Lumière kardeşlerin 1895 yılındaki ilk film gösterimi günü.

### Tarihçesi ve Önemi
28 Aralık Dünya Sinema Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 28 Aralık tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "28 Aralık Dünya Sinema Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "28 Aralık günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-12-28', 12, 28, 'Kültür & Sanat', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#28Aralık', '#28aralikdunyasinemagunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '29-aralik-uluslararasi-biyocesitlilik-gunu-anmasi', '29 Aralık Uluslararası Biyoçeşitlilik Günü Anması', 'Yıl biterken doğanın türlerini koruma muhasebesi günü.', '## 29 Aralık Uluslararası Biyoçeşitlilik Günü Anması Nedir?
Yıl biterken doğanın türlerini koruma muhasebesi günü.

### Tarihçesi ve Önemi
29 Aralık Uluslararası Biyoçeşitlilik Günü Anması, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 29 Aralık tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "29 Aralık Uluslararası Biyoçeşitlilik Günü Anması kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "29 Aralık günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-12-29', 12, 29, 'Çevre & Doğa', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#29Aralık', '#29aralikuluslararasibiyocesitlilikgunuanmasi'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    '30-aralik-yil-sonu-sukran-ve-degerlendirme-gunu', '30 Aralık Yıl Sonu Şükran ve Değerlendirme Günü', 'Geçen yılın muhasebesini yapıp yeni yıla umutla hazırlanma günü.', '## 30 Aralık Yıl Sonu Şükran ve Değerlendirme Günü Nedir?
Geçen yılın muhasebesini yapıp yeni yıla umutla hazırlanma günü.

### Tarihçesi ve Önemi
30 Aralık Yıl Sonu Şükran ve Değerlendirme Günü, gerek Türkiye''de gerekse uluslararası alanda Uluslararası Takvim ve Anma İnisiyatifi nezdinde tanınan ve her yıl 30 Aralık tarihinde ele alınan önemli bir gündür.

---

## Bu Anlamlı Günde Neler Yapılabilir?
1. Konuyla ilgili resmi kaynak ve raporları inceleyin.
2. Farkındalığı artırmak için sosyal medya paylaşımlarında bulunun.
3. İlgili alanda çalışan sivil toplum veya kamu girişimlerine destek verin.

---

## Sosyal Medya Paylaşım Mesajları
* "30 Aralık Yıl Sonu Şükran ve Değerlendirme Günü kutlu olsun! Toplumsal farkındalığın ve iyiliğin artmasını dileriz."
* "30 Aralık günü vesilesiyle daha bilinçli ve duyarlı bir gelecek dileriz."', '2026-12-30', 12, 30, 'Farkındalık', 'kutlama', false, 'uluslararasi', 'Uluslararası Takvim ve Anma İnisiyatifi', 'https://www.un.org', ARRAY['#30Aralık', '#30aralikyilsonusukranvedegerlendirmegunu'], ARRAY['hediye seti', 'kitap', 'anı objesi']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

INSERT INTO special_days (
    slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
    'yilbasi-gecesi', '31 Aralık Yılbaşı Gecesi', 'Bir yılın son anlarını geride bırakıp yeni umutlarla gelecek yıla adım atılan tüm dünyada coşkuyla kutlanan gece.', '## 31 Aralık Yılbaşı Gecesi Nedir?
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
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #yilbasi-gecesi"', '2026-12-31', 12, 31, 'Eğlence', 'kutlama', false, 'turkiye', '', '', ARRAY['#YilbasiGecesi', '#GuleGule2026', '#YeniYilKutlamasi', '#31Aralik'], ARRAY['yılbaşı çam ağacı süsü', 'parti kutlama şapkası', 'kutu masa oyunu', 'ışıklı peri led']
) ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    category = EXCLUDED.category,
    day_type = EXCLUDED.day_type,
    is_public_holiday = EXCLUDED.is_public_holiday,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url;

