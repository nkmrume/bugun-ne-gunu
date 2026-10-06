-- ========================================================
-- Bugün Ne Günü? (Special Days Directory)
-- Database Schema for Supabase (PostgreSQL)
-- ========================================================

-- Enable UUID extension if not already enabled
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Drop table if exists during migrations
DROP TABLE IF EXISTS special_days;

-- 1. Create special_days table
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

-- 2. Performance & SEO Query Indexes
CREATE INDEX idx_special_days_slug ON special_days(slug);
CREATE INDEX idx_special_days_today ON special_days(month_no, day_no);
CREATE INDEX idx_special_days_month ON special_days(month_no);
CREATE INDEX idx_special_days_category ON special_days(category);
CREATE INDEX idx_special_days_celebration_date ON special_days(celebration_date);

-- Full-text search index for title and description in Turkish
CREATE INDEX idx_special_days_fts ON special_days USING gin(to_tsvector('simple', title || ' ' || description));

-- 3. Row Level Security (RLS) Configuration
ALTER TABLE special_days ENABLE ROW LEVEL SECURITY;

-- Allow public read access to everyone
CREATE POLICY "Public read access for special_days"
    ON special_days
    FOR SELECT
    USING (true);

-- Allow authenticated service role full access
CREATE POLICY "Service role full access"
    ON special_days
    USING (auth.role() = 'service_role');

-- 4. Automatic updated_at trigger
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

-- ========================================================
-- Seed Data: Sample Special Days
-- ========================================================

INSERT INTO special_days (
    slug,
    title,
    description,
    content,
    celebration_date,
    month_no,
    day_no,
    category,
    hashtags,
    affiliate_keywords
) VALUES
(
    'dunya-kahve-gunu',
    'Dünya Kahve Günü',
    'Her yıl 1 Ekim''de kutlanan Dünya Kahve Günü, kahve üreticilerinin emeğini onurlandırmak ve dünyanın en sevilen içeceğinin lezzetini kutlamak için düzenlenir.',
    '## Dünya Kahve Günü Nedir?
Dünya Kahve Günü (International Coffee Day), 2015 yılında Uluslararası Kahve Örgütü (ICO) tarafından resmi olarak başlatılan küresel bir kutlama günüdür. Bu özel günün temel amacı, kahve çiftçilerinin zorlu çalışma koşullarına ve adil ticaret prensiplerine dikkat çekmek, aynı zamanda milyonlarca insanın gününü aydınlatan bu eşsiz içeceğin kültürel zenginliğini kutlamaktır.

Her gün dünya genelinde 3 milyardan fazla fincan kahve tüketilmektedir. Çekirdeğin yetiştiği Etiyopya ve Kolombiya dağlarından, espresso fincanınıza uzanan büyüleyici yolculuk kutlanmayı hak ediyor.

### Tarihçesi
Farklı ülkelerde daha önce farklı tarihlerde kutlanan ulusal kahve günleri, 2014 yılında Milano Expo organizasyonunda alınan kararla tek bir çatı altında toplanmış ve 1 Ekim resmi Dünya Kahve Günü ilan edilmiştir.

---

## Dünya Kahve Günü Nasıl Kutlanır?
1. **Yeni Bir Demleme Yöntemi Deneyin:** Evinizde V60, Chemex, Aeropress veya geleneksel Türk Kahvesi cezvesiyle farklı bir çekirdek demleyin.
2. **Yerel Nitelikli Kahvecileri Destekleyin:** Mahallenizdeki bağımsız üçüncü nesil kahvecileri ziyaret ederek güne özel etkinliklere katılın.
3. **Ofiste Kahve Molası Verin:** İş arkadaşlarınızla kahve eşliğinde keyifli bir sohbet molası planlayın.
4. **Adil Ticaret Çekirdekleri Seçin:** Sürdürülebilir tarımı ve çiftçileri destekleyen sertifikalı kahveleri tercih edin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Bir fincan kahvenin kırk yıl hatırı vardır, Dünya Kahve Günü kutlu olsun! ☕✨"
* "Hayat kahveyle başlar! Tüm kahveseverlerin 1 Ekim Dünya Kahve Günü''nü en lezzetli dileklerimle kutlarım."
* "Kokusuyla uyandıran, tadıyla günümüze anlam katan kahveye teşekkür günü. #DunyaKahveGunu"',
    '2026-10-01',
    10,
    1,
    'Eğlence',
    ARRAY['#DunyaKahveGunu', '#Kahve', '#CoffeeDay', '#KahveSever', '#1Ekim'],
    ARRAY['filtre kahve makinesi', 'nitelikli çekirdek kahve', 'termos kupa', 'french press', 'chemex kahve demleme']
),
(
    'dunya-kuduz-gunu',
    'Dünya Kuduz Günü',
    'Her yıl 28 Eylül''de kutlanan Dünya Kuduz Günü, kuduz hastalığı konusunda farkındalık yaratmak ve aşılamanın hayati önemini vurgulamak amacıyla düzenlenir.',
    '## Dünya Kuduz Günü Nedir?
Dünya Kuduz Günü, kuduz aşısını geliştiren Fransız kimyager ve mikrobiyolog Louis Pasteur''ün ölüm yıl dönümü olan 28 Eylül tarihinde her yıl düzenlenmektedir. Dünya Sağlık Örgütü (WHO) ve Küresel Kuduz Kontrolü Birliği (GARC) ortaklığında yürütülen küresel bir farkındalık girişimidir.

Kuduz, yüzde 100 önlenebilir bir viral hastalık olmasına rağmen dünya çapında her yıl on binlerce insanın ve hayvanın hayatına mal olmaktadır.

---

## Nasıl Farkındalık Sağlanır?
1. Evcil dostlarımızın (kedi ve köpekler) yıllık kuduz aşılarını aksatmadan yaptırın.
2. Sokaktaki canların aşılanması ve kısırlaştırılması için yerel belediyelerin ve veterinerlerin çalışmalarına destek olun.
3. Çocuklara tanımadıkları ve agresif davranan hayvanlara nasıl güvenli yaklaşmaları gerektiğini öğretin.

---

## Sosyal Medya Mesajları
* "Aşı hayat kurtarır! 28 Eylül Dünya Kuduz Günü''nde can dostlarımızın sağlığını koruyalım, kuduzu birlikte sıfırlayalım. 🐾💉"
* "Kuduz yüzde 100 önlenebilir! Sevimli dostlarımızın aşılarını ihmal etmeyelim. #DunyaKuduzGunu"',
    '2026-09-28',
    9,
    28,
    'Sağlık',
    ARRAY['#DunyaKuduzGunu', '#KuduzFarkindaligi', '#AsiHayatKurtarir', '#28Eylul'],
    ARRAY['kedi köpek taşıma çantası', 'köpek tasması ve künyesi', 'veteriner bakım seti', 'evcil hayvan vitamini']
),
(
    'bilgiye-evrensel-erisim-gunu',
    'Uluslararası Bilgiye Evrensel Erişim Günü',
    '28 Eylül Uluslararası Bilgiye Evrensel Erişim Günü, bilginin serbestçe yayılması ve şeffaf toplumların inşası için UNESCO öncülüğünde kutlanır.',
    '## Bilgiye Evrensel Erişim Günü Nedir?
UNESCO tarafından ilan edilen bu özel gün, vatandaşların kamu bilgilerine erişim hakkını (bilgi edinme hakkı) ve basın özgürlüğünü güvence altına almayı hedefler. Bilgiye erişim; insan haklarının, demokrasinin ve sürdürülebilir kalkınmanın en temel direğidir.

---

## Nasıl Kutlanır?
1. Açık kaynaklı kütüphaneleri, bilimsel makaleleri ve kamuya açık veri setlerini keşfedin.
2. Toplumda dijital okuryazarlığın gelişmesine katkıda bulunacak kaynakları paylaşın.
3. Kütüphaneleri ve bağımsız arşivleri ziyaret edin.

---

## Sosyal Medya Mesajları
* "Bilgi güçtür, özgürce erişildiğinde ise toplumu dönüştürür. 28 Eylül Uluslararası Bilgiye Evrensel Erişim Günü kutlu olsun! 📚🌐"',
    '2026-09-28',
    9,
    28,
    'Farkındalık',
    ARRAY['#BilgiyeErisimGunu', '#UNESCO', '#AcikBilgi', '#DijitalHaklar'],
    ARRAY['e-kitap okuyucu', 'bilimsel kitaplar', 'hızlı okuma kitap seti', 'masa lambası']
),
(
    'cumhuriyet-bayrami',
    '29 Ekim Cumhuriyet Bayramı',
    'Türkiye Cumhuriyeti''nin 1923 yılında Gazi Mustafa Kemal Atatürk ve silah arkadaşları tarafından ilan edildiği ulusal bayramımız.',
    '## 29 Ekim Cumhuriyet Bayramı Nedir?
29 Ekim 1923 tarihinde Türkiye Büyük Millet Meclisi tarafından Cumhuriyet idaresi resmen ilan edilmiş ve Gazi Mustafa Kemal Atatürk, Türkiye Cumhuriyeti''nin ilk Cumhurbaşkanı seçilmiştir. Egemenliğin kayıtsız şartsız millete verildiği bu kutlu gün, Türkiye Cumhuriyeti''nin ve Kuzey Kıbrıs Türk Cumhuriyeti''nin en büyük ulusal bayramıdır.

---

## Nasıl Kutlanır?
1. Evlerin pencerelerine, balkonlara ve sokaklara Türk Bayrakları asılır.
2. Anıtkabir ve il/ilçe meydanlarındaki resmi törenlere ve fener alaylarına katılınır.
3. Okullarda şiirler okunur, cumhuriyet değerleri ve Atatürk ilkeleri üzerine konuşmalar yapılır.

---

## Sosyal Medya Mesajları
* "Cumhuriyetimizin ışığında, Atamızın izinde daima ileriye! 29 Ekim Cumhuriyet Bayramımız kutlu olsun! 🇹🇷"
* "Ey yükselen yeni nesil! İstikbal sizsiniz. Cumhuriyeti biz kurduk, onu yükseltecek ve yaşatacak sizsiniz. 🇹🇷✨"',
    '2026-10-29',
    10,
    29,
    'Resmi',
    ARRAY['#29Ekim', '#CumhuriyetBayrami', '#Ataturk', '#Cumhuriyet103Yasinda', '#Turkiye'],
    ARRAY['türk bayrağı büyük boy', 'atatürk rozeti', 'nutuk özel baskı', 'fener alayı meşalesi']
),
(
    'hayvanlari-koruma-gunu',
    '4 Ekim Hayvanları Koruma Günü',
    'Doğadaki tüm canlıların yaşam haklarına saygı duymak ve sokak hayvanlarının refahını artırmak amacıyla kutlanan uluslararası gün.',
    '## Hayvanları Koruma Günü Nedir?
İlk olarak 1931 yılında Floransa''da çevre bilimcilerin girişimiyle başlatılan 4 Ekim Dünya Hayvanları Koruma Günü, tehlike altındaki türlerin korunması ve evcil/sokak hayvanlarının yaşam şartlarının iyileştirilmesi için farkındalık yaratır.

---

## Nasıl Kutlanır?
1. Bir kap su ve bir kap mama bırakarak sokak hayvanlarını besleyin.
2. Barınakları ziyaret edin ve bir can sahiplenmeyi değerlendirin ("Satın alma, sahiplen!").
3. Çocuklara hayvan sevgisini aşılayan kitaplar ve belgeseller izletin.

---

## Sosyal Medya Mesajları
* "Onlar bize emanet! Dünyayı paylaştığımız tüm can dostlarımızın 4 Ekim Hayvanları Koruma Günü kutlu olsun. 🐶🐱🐦"
* "Bir kap su, bir kap mama hayat kurtarır. Sevgiyle koruyalım! #4EkimHayvanlariKorumaGunu"',
    '2026-10-04',
    10,
    4,
    'Çevre & Doğa',
    ARRAY['#4Ekim', '#HayvanlariKorumaGunu', '#SatinAlmaSahiplen', '#CanDostlarimiz'],
    ARRAY['kedi maması 15kg', 'köpek maması premium', 'kuş yemi ve kafesi', 'otomatik su sebili pet']
);
