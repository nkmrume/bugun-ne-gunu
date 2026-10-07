import fs from 'fs';
import path from 'path';

const filePath = path.join(process.cwd(), 'src', 'lib', 'data', 'special-days-data.ts');
let fileContent = fs.readFileSync(filePath, 'utf8');

// 1. Define 7 Ekim Dünya Pamuk Günü
const dunyaPamukGunu = {
  id: "f8b9a112-9844-48f8-b3f1-000000000100b",
  slug: "dunya-pamuk-gunu",
  title: "7 Ekim Dünya Pamuk Günü",
  description: "Birleşmiş Milletler (BM) Genel Kurulu tarafından ilan edilen, pamuğun küresel ekonomideki, sürdürülebilir tarımdaki ve istihdamdaki kritik rolünü vurgulayan uluslararası gün.",
  content: `## 7 Ekim Dünya Pamuk Günü Nedir?
Dünya Pamuk Günü (World Cotton Day), Birleşmiş Milletler (BM) Genel Kurulu'nun A/RES/75/318 sayılı kararı ile her yıl 7 Ekim tarihinde tüm dünyada idrak edilen resmî bir uluslararası farkındalık günüdür.

### Tarihçesi ve Önemi
Pamuk üreticisi gelişmekte olan Benin, Burkina Faso, Çad ve Mali (Cotton-4) ülkelerinin Dünya Ticaret Örgütü'ne (DTÖ) yaptığı başvuru sonucunda, 2019 yılında BM Gıda ve Tarım Örgütü (FAO), BM Ticaret ve Kalkınma Konferansı (UNCTAD) ve Uluslararası Pamuk Danışma Komitesi (ICAC) ortaklığıyla başlatılmıştır. Pamuk, dünya genelinde 100 milyondan fazla aileye doğrudan gelir sağlayan ve biyolojik olarak tamamen çözünebilen stratejik bir doğal elyaftır.

---

## 7 Ekim Dünya Pamuk Günü Nasıl Değerlendirilir?
1. Sürdürülebilir, organik ve sertifikalı pamuklu tekstil ürünlerini tercih edin.
2. Sentetik ve mikroplastik yayan kumaşlar yerine doğal liflerin önemini araştırın.
3. Çiftçilerin ve tekstil işçilerinin adil ticaret (Fairtrade) haklarına destek olun.

---

## Sosyal Medya Farkındalık Mesajları
* "Tarladan gardıroba uzanan doğal emek: 7 Ekim Dünya Pamuk Günü kutlu olsun! Sürdürülebilir tarımı ve doğal lifleri destekliyoruz. 🌱🧵 #DunyaPamukGunu #WorldCottonDay"
* "Dünya genelinde 100 milyondan fazla çiftçi ailesinin geçim kaynağı olan pamuğun değerini biliyoruz. 7 Ekim Dünya Pamuk Günü kutlu olsun. #Pamuk #SurdurulebilirTekstil"
* "Sentetik kumaşlara karşı doğayı koru, pamuğu seç. #WorldCottonDay #7Ekim"`,
  celebration_date: "2026-10-07",
  month_no: 10,
  day_no: 7,
  category: "Uluslararası",
  day_type: "farkindalik",
  is_public_holiday: false,
  scope: "bm",
  source_name: "Birleşmiş Milletler Genel Kurulu (A/RES/75/318)",
  source_url: "https://press.un.org/en/2021/ga12354.doc.htm",
  verified_at: "2026-10-07",
  hashtags: [
    "#DunyaPamukGunu",
    "#WorldCottonDay",
    "#7Ekim",
    "#Pamuk",
    "#SurdurulebilirTarim"
  ],
  affiliate_keywords: [
    "organik pamuk nevresim",
    "yüzde 100 pamuk tişört",
    "doğal pamuklu havlu"
  ]
};

// 2. Define corrected 10 Kasım Atatürk'ü Anma Günü
const ataturkuAnmaGunu = {
  id: "f8b9a112-9844-48f8-b3f1-000000000105",
  slug: "ataturku-anma-gunu",
  title: "10 Kasım Atatürk'ü Anma Günü",
  description: "Türkiye Cumhuriyeti'nin kurucusu Gazi Mustafa Kemal Atatürk'ün ebediyete intikalinin 88. yıl dönümü ve milli anma günü.",
  content: `## 10 Kasım Atatürk'ü Anma Günü Nedir?
10 Kasım 1938 günü saat 09:05'te Dolmabahçe Sarayı'nda ebediyete irtihal eden Türkiye Cumhuriyeti'nin kurucusu Gazi Mustafa Kemal Atatürk'ün aziz hatırasını yaşatmak amacıyla her yıl düzenlenen ulusal yas ve anma günüdür.

### Tarihçesi ve Milli Anlamı
Mustafa Kemal Atatürk, askeri dehası ve liderliğiyle Kurtuluş Savaşı'nı zafere ulaştırmış, ardından hayata geçirdiği inkılaplarla modern, bağımsız ve laik Türkiye Cumhuriyeti'ni inşa etmiştir. Her 10 Kasım günü saat 09:05'te tüm yurtta sirenler eşliğinde 2 dakikalık saygı duruşunda bulunulur; bayraklar yarıya indirilir ve Anıtkabir'de resmi devlet töreni icra edilir.

---

## 10 Kasım'da Atatürk Nasıl Anılır?
1. Saat 09:05'te nerede olursanız olun siren sesiyle birlikte saygı duruşunda bulunun.
2. Anıtkabir'i ve yerel Atatürk anıtlarını ziyaret ederek çiçek bırakın.
3. Nutuk'u, Atatürk'ün fikirlerini ve Cumhuriyet ilkelerini çocuklarınıza anlatın.
4. Anma etkinliklerine ve resmi törenlere katılarak saygınızı ifade edin.

---

## 10 Kasım Anma ve Saygı Mesajları
* "Beni görmek demek mutlaka yüzümü görmek demek değildir. Benim fikirlerimi, benim duygularımı anlıyorsanız ve hissediyorsanız bu kafidir. Gazi Mustafa Kemal Atatürk'ü saygı, rahmet ve sonsuz minnetle anıyoruz. 🇹🇷🖤"
* "Fikirlerin, ilkelerin ve emanetin olan Cumhuriyet ilelebet yaşayacak. 10 Kasım Atatürk'ü Anma Günü'nde Başkomutanımızı derin bir özlemle yad ediyoruz. #10Kasim #Ataturk #0905"
* "Açtığın yolda, gösterdiğin hedefe durmadan yürüyeceğimize ant içeriz. Ruhun şad olsun Atam. #SaygiVeOzlemle #MustafaKemalAtaturk"`,
  celebration_date: "2026-11-10",
  month_no: 11,
  day_no: 10,
  category: "Resmi",
  day_type: "anma",
  is_public_holiday: false,
  scope: "turkiye",
  source_name: "T.C. Resmî Gazete & Anıtkabir Komutanlığı",
  source_url: "https://www.anitkabir.tsk.tr",
  verified_at: "2026-10-07",
  hashtags: [
    "#10Kasim",
    "#Ataturk",
    "#SaygiVeOzlemle",
    "#0905",
    "#Turkiye"
  ],
  affiliate_keywords: [] // No commercial affiliates on memorial days
};

// Check if 7 Ekim is already in file
if (!fileContent.includes('"slug": "dunya-pamuk-gunu"')) {
  // Insert before 10 Ekim Dünya Ruh Sağlığı Günü
  const targetStr = '"slug": "dunya-ruh-sagligi-gunu"';
  const insertIndex = fileContent.indexOf(targetStr);
  if (insertIndex !== -1) {
    // Find the opening brace before this
    const braceIndex = fileContent.lastIndexOf('{', insertIndex);
    const pamukJson = JSON.stringify(dunyaPamukGunu, null, 2) + ',\n  ';
    fileContent = fileContent.slice(0, braceIndex) + pamukJson + fileContent.slice(braceIndex);
    console.log("Successfully inserted 7 Ekim Dünya Pamuk Günü!");
  }
}

// Replace 10 Kasım entry
const ataturkSlugStr = '"slug": "ataturku-anma-gunu"';
const ataturkIndex = fileContent.indexOf(ataturkSlugStr);
if (ataturkIndex !== -1) {
  const startBrace = fileContent.lastIndexOf('{', ataturkIndex);
  // Find closing brace of this object
  let depth = 0;
  let endBrace = -1;
  for (let i = startBrace; i < fileContent.length; i++) {
    if (fileContent[i] === '{') depth++;
    else if (fileContent[i] === '}') {
      depth--;
      if (depth === 0) {
        endBrace = i;
        break;
      }
    }
  }
  if (endBrace !== -1) {
    const ataturkJson = JSON.stringify(ataturkuAnmaGunu, null, 2);
    fileContent = fileContent.slice(0, startBrace) + ataturkJson + fileContent.slice(endBrace + 1);
    console.log("Successfully replaced 10 Kasım Atatürk'ü Anma Günü with solemn memorial template!");
  }
}

fs.writeFileSync(filePath, fileContent, 'utf8');
console.log("File saved successfully.");
