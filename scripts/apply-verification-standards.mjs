import fs from 'fs';
import path from 'path';

const filePath = path.join(process.cwd(), 'src', 'lib', 'data', 'special-days-data.ts');
const fileContent = fs.readFileSync(filePath, 'utf8');

// Match the array
const match = fileContent.match(/export const INITIAL_SPECIAL_DAYS: SpecialDay\[\] = (\[[\s\S]*\]);/);
if (!match) {
  console.error("Could not find INITIAL_SPECIAL_DAYS array in file");
  process.exit(1);
}

const list = JSON.parse(match[1]);

// Primary verified list with legitimate legal or UN resolutions
const VERIFIED_DAYS_MAP = {
  // Turkish National Days & Public Holidays
  "yilbasi": {
    official_status: "official",
    declaring_authority: "Türkiye Cumhuriyeti (2429 Sayılı Ulusal Bayram ve Genel Tatiller Hakkında Kanun)",
    source_name: "T.C. Mevzuat Bilgi Sistemi (2429 Sayılı Kanun)",
    source_url: "https://www.mevzuat.gov.tr/mevzuat?MevzuatNo=2429&MevzuatTur=1&MevzuatTertip=5",
    source_type: "primary_official",
    is_public_holiday: true,
    holiday_country: "TR",
    holiday_year: 2026,
    scope: "turkiye",
    day_type: "resmi-tatil"
  },
  "ulusal-egemenlik-ve-cocuk-bayrami": {
    official_status: "official",
    declaring_authority: "TBMM / Türkiye Cumhuriyeti",
    source_name: "T.C. Resmî Gazete (2429 Sayılı Kanun)",
    source_url: "https://www.mevzuat.gov.tr/mevzuat?MevzuatNo=2429&MevzuatTur=1&MevzuatTertip=5",
    source_type: "primary_official",
    is_public_holiday: true,
    holiday_country: "TR",
    holiday_year: 2026,
    scope: "turkiye",
    day_type: "resmi-tatil"
  },
  "emek-ve-dayanisma-gunu": {
    official_status: "official",
    declaring_authority: "Türkiye Cumhuriyeti (5892 Sayılı Kanun)",
    source_name: "T.C. Resmî Gazete (Sayı 27212)",
    source_url: "https://www.resmigazete.gov.tr",
    source_type: "primary_official",
    is_public_holiday: true,
    holiday_country: "TR",
    holiday_year: 2026,
    scope: "turkiye",
    day_type: "resmi-tatil"
  },
  "ataturku-anma-genclik-ve-spor-bayrami": {
    official_status: "official",
    declaring_authority: "Türkiye Cumhuriyeti (2429 Sayılı Kanun)",
    source_name: "T.C. Resmî Gazete (2429 Sayılı Kanun)",
    source_url: "https://www.mevzuat.gov.tr/mevzuat?MevzuatNo=2429&MevzuatTur=1&MevzuatTertip=5",
    source_type: "primary_official",
    is_public_holiday: true,
    holiday_country: "TR",
    holiday_year: 2026,
    scope: "turkiye",
    day_type: "resmi-tatil"
  },
  "demokrasi-ve-milli-birlik-gunu": {
    official_status: "official",
    declaring_authority: "Türkiye Cumhuriyeti (6752 Sayılı Kanun)",
    source_name: "T.C. Resmî Gazete (Sayı 29872)",
    source_url: "https://www.resmigazete.gov.tr",
    source_type: "primary_official",
    is_public_holiday: true,
    holiday_country: "TR",
    holiday_year: 2026,
    scope: "turkiye",
    day_type: "resmi-tatil"
  },
  "zafer-bayrami": {
    official_status: "official",
    declaring_authority: "Türkiye Cumhuriyeti (2429 Sayılı Kanun)",
    source_name: "T.C. Resmî Gazete (2429 Sayılı Kanun)",
    source_url: "https://www.mevzuat.gov.tr/mevzuat?MevzuatNo=2429&MevzuatTur=1&MevzuatTertip=5",
    source_type: "primary_official",
    is_public_holiday: true,
    holiday_country: "TR",
    holiday_year: 2026,
    scope: "turkiye",
    day_type: "resmi-tatil"
  },
  "cumhuriyet-bayrami": {
    official_status: "official",
    declaring_authority: "TBMM / Türkiye Cumhuriyeti",
    source_name: "T.C. Resmî Gazete (2429 Sayılı Kanun)",
    source_url: "https://www.mevzuat.gov.tr/mevzuat?MevzuatNo=2429&MevzuatTur=1&MevzuatTertip=5",
    source_type: "primary_official",
    is_public_holiday: true,
    holiday_country: "TR",
    holiday_year: 2026,
    scope: "turkiye",
    day_type: "resmi-tatil"
  },
  "ataturku-anma-gunu": {
    official_status: "official",
    declaring_authority: "Türkiye Cumhuriyeti Cumhurbaşkanlığı",
    source_name: "T.C. Resmî Gazete & Cumhurbaşkanlığı Genelgesi",
    source_url: "https://www.mevzuat.gov.tr",
    source_type: "primary_official",
    is_public_holiday: false,
    holiday_country: "TR",
    holiday_year: 2026,
    scope: "turkiye",
    day_type: "anma"
  },
  "canakkale-zaferi-ve-sehitleri-anma-gunu": {
    official_status: "official",
    declaring_authority: "Türkiye Cumhuriyeti (4768 Sayılı Kanun)",
    source_name: "T.C. Resmî Gazete (Sayı 24707)",
    source_url: "https://www.resmigazete.gov.tr",
    source_type: "primary_official",
    is_public_holiday: false,
    scope: "turkiye",
    day_type: "anma"
  },
  "ogretmenler-gunu": {
    official_status: "official",
    declaring_authority: "T.C. Millî Eğitim Bakanlığı",
    source_name: "Millet Mektepleri Başöğretmenlik Kararı (1981)",
    source_url: "https://www.meb.gov.tr",
    source_type: "primary_official",
    is_public_holiday: false,
    scope: "turkiye",
    day_type: "kutlama"
  },
  "tip-bayrami": {
    official_status: "official",
    declaring_authority: "T.C. Sağlık Bakanlığı",
    source_name: "T.C. Sağlık Bakanlığı Resmî Kayıtları",
    source_url: "https://www.saglik.gov.tr",
    source_type: "primary_official",
    is_public_holiday: false,
    scope: "turkiye",
    day_type: "kutlama"
  },
  // UN / UNESCO / WHO Official Observances with direct UN resolutions
  "dunya-braille-gunu": {
    official_status: "international_observance",
    declaring_authority: "Birleşmiş Milletler Genel Kurulu",
    source_name: "Birleşmiş Milletler (A/RES/73/161)",
    source_url: "https://www.un.org/en/observances/braille-day",
    source_type: "primary_official",
    scope: "bm",
    day_type: "farkindalik"
  },
  "uluslararasi-egitim-gunu": {
    official_status: "international_observance",
    declaring_authority: "Birleşmiş Milletler Genel Kurulu",
    source_name: "Birleşmiş Milletler (A/RES/73/25)",
    source_url: "https://www.un.org/en/observances/education-day",
    source_type: "primary_official",
    scope: "bm",
    day_type: "farkindalik"
  },
  "uluslararasi-holokost-kurbanlarini-anma-gunu": {
    official_status: "international_observance",
    declaring_authority: "Birleşmiş Milletler Genel Kurulu",
    source_name: "Birleşmiş Milletler (A/RES/60/7)",
    source_url: "https://www.un.org/en/observances/holocaust-remembrance-day",
    source_type: "primary_official",
    scope: "bm",
    day_type: "anma"
  },
  "dunya-kanser-gunu": {
    official_status: "international_observance",
    declaring_authority: "Dünya Sağlık Örgütü (DSÖ) & UICC",
    source_name: "World Health Organization (WHO)",
    source_url: "https://www.who.int/campaigns/world-cancer-day",
    source_type: "primary_official",
    scope: "uluslararasi",
    day_type: "farkindalik"
  },
  "dunya-radyo-gunu": {
    official_status: "international_observance",
    declaring_authority: "UNESCO / Birleşmiş Milletler",
    source_name: "UNESCO & BM (A/RES/67/124)",
    source_url: "https://www.unesco.org/en/days/world-radio-day",
    source_type: "primary_official",
    scope: "bm",
    day_type: "kutlama"
  },
  "uluslararasi-ana-dili-gunu": {
    official_status: "international_observance",
    declaring_authority: "UNESCO",
    source_name: "UNESCO Genel Konferansı (30C/62)",
    source_url: "https://www.unesco.org/en/days/mother-language-day",
    source_type: "primary_official",
    scope: "bm",
    day_type: "farkindalik"
  },
  "dunya-kadinlar-gunu": {
    official_status: "international_observance",
    declaring_authority: "Birleşmiş Milletler Genel Kurulu",
    source_name: "Birleşmiş Milletler (A/RES/32/142)",
    source_url: "https://www.un.org/en/observances/womens-day",
    source_type: "primary_official",
    scope: "bm",
    day_type: "kutlama"
  },
  "uluslararasi-mutluluk-gunu": {
    official_status: "international_observance",
    declaring_authority: "Birleşmiş Milletler Genel Kurulu",
    source_name: "Birleşmiş Milletler (A/RES/66/281)",
    source_url: "https://www.un.org/en/observances/happiness-day",
    source_type: "primary_official",
    scope: "bm",
    day_type: "kutlama"
  },
  "dunya-down-sendromu-gunu": {
    official_status: "international_observance",
    declaring_authority: "Birleşmiş Milletler Genel Kurulu",
    source_name: "Birleşmiş Milletler (A/RES/66/149)",
    source_url: "https://www.un.org/en/observances/down-syndrome-day",
    source_type: "primary_official",
    scope: "bm",
    day_type: "farkindalik"
  },
  "dunya-su-gunu": {
    official_status: "international_observance",
    declaring_authority: "Birleşmiş Milletler Genel Kurulu",
    source_name: "Birleşmiş Milletler (A/RES/47/193)",
    source_url: "https://www.un.org/en/observances/water-day",
    source_type: "primary_official",
    scope: "bm",
    day_type: "farkindalik"
  },
  "dunya-otizm-farkindalik-gunu": {
    official_status: "international_observance",
    declaring_authority: "Birleşmiş Milletler Genel Kurulu",
    source_name: "Birleşmiş Milletler (A/RES/62/139)",
    source_url: "https://www.un.org/en/observances/autism-day",
    source_type: "primary_official",
    scope: "bm",
    day_type: "farkindalik"
  },
  "dunya-saglik-gunu": {
    official_status: "international_observance",
    declaring_authority: "Dünya Sağlık Örgütü (DSÖ)",
    source_name: "Dünya Sağlık Asamblesi (WHA.1/Rel/1)",
    source_url: "https://www.who.int/campaigns/world-health-day",
    source_type: "primary_official",
    scope: "bm",
    day_type: "farkindalik"
  },
  "dunya-kitap-ve-telif-hakki-gunu": {
    official_status: "international_observance",
    declaring_authority: "UNESCO",
    source_name: "UNESCO Genel Konferansı (28 C/Res. 3.18)",
    source_url: "https://www.unesco.org/en/days/world-book-and-copyright-day",
    source_type: "primary_official",
    scope: "bm",
    day_type: "kutlama"
  },
  "dunya-basin-ozgurlugu-gunu": {
    official_status: "international_observance",
    declaring_authority: "Birleşmiş Milletler Genel Kurulu",
    source_name: "Birleşmiş Milletler (A/RES/48/432)",
    source_url: "https://www.un.org/en/observances/press-freedom-day",
    source_type: "primary_official",
    scope: "bm",
    day_type: "farkindalik"
  },
  "dunya-cevre-gunu": {
    official_status: "international_observance",
    declaring_authority: "Birleşmiş Milletler Genel Kurulu",
    source_name: "Birleşmiş Milletler (A/RES/2994 (XXVII))",
    source_url: "https://www.un.org/en/observances/environment-day",
    source_type: "primary_official",
    scope: "bm",
    day_type: "farkindalik"
  },
  "dunya-multeciler-gunu": {
    official_status: "international_observance",
    declaring_authority: "Birleşmiş Milletler Genel Kurulu",
    source_name: "Birleşmiş Milletler (A/RES/55/76)",
    source_url: "https://www.un.org/en/observances/refugee-day",
    source_type: "primary_official",
    scope: "bm",
    day_type: "farkindalik"
  },
  "dunya-nufus-gunu": {
    official_status: "international_observance",
    declaring_authority: "Birleşmiş Milletler Genel Kurulu",
    source_name: "Birleşmiş Milletler (A/RES/45/216)",
    source_url: "https://www.un.org/en/observances/world-population-day",
    source_type: "primary_official",
    scope: "bm",
    day_type: "farkindalik"
  },
  "uluslararasi-baris-gunu": {
    official_status: "international_observance",
    declaring_authority: "Birleşmiş Milletler Genel Kurulu",
    source_name: "Birleşmiş Milletler (A/RES/36/67 ve A/RES/55/282)",
    source_url: "https://www.un.org/en/observances/international-day-peace",
    source_type: "primary_official",
    scope: "bm",
    day_type: "farkindalik"
  },
  "dunya-turizm-gunu": {
    official_status: "international_observance",
    declaring_authority: "Birleşmiş Milletler Dünya Turizm Örgütü (UNWTO)",
    source_name: "UN Tourism (UNWTO)",
    source_url: "https://www.unwto.org/world-tourism-day",
    source_type: "primary_official",
    scope: "bm",
    day_type: "kutlama"
  },
  "dunya-kahve-gunu": {
    official_status: "international_observance",
    declaring_authority: "Uluslararası Kahve Örgütü (ICO)",
    source_name: "International Coffee Organization (ICO Expo Milano)",
    source_url: "https://www.internationalcoffeeday.org",
    source_type: "institutional",
    scope: "uluslararasi",
    day_type: "kutlama"
  },
  "dunya-pamuk-gunu": {
    official_status: "international_observance",
    declaring_authority: "Birleşmiş Milletler Genel Kurulu",
    source_name: "Birleşmiş Milletler (A/RES/75/318)",
    source_url: "https://press.un.org/en/2021/ga12354.doc.htm",
    source_type: "primary_official",
    scope: "bm",
    day_type: "farkindalik"
  },
  "dunya-gida-gunu": {
    official_status: "international_observance",
    declaring_authority: "BM Gıda ve Tarım Örgütü (FAO)",
    source_name: "Birleşmiş Milletler (A/RES/35/70)",
    source_url: "https://www.fao.org/world-food-day",
    source_type: "primary_official",
    scope: "bm",
    day_type: "farkindalik"
  },
  "birlesmis-milletler-gunu": {
    official_status: "international_observance",
    declaring_authority: "Birleşmiş Milletler Genel Kurulu",
    source_name: "Birleşmiş Milletler (A/RES/168 (II))",
    source_url: "https://www.un.org/en/observances/un-day",
    source_type: "primary_official",
    scope: "bm",
    day_type: "kutlama"
  },
  "dunya-diyabet-gunu": {
    official_status: "international_observance",
    declaring_authority: "Birleşmiş Milletler Genel Kurulu",
    source_name: "Birleşmiş Milletler (A/RES/61/225)",
    source_url: "https://www.un.org/en/observances/diabetes-day",
    source_type: "primary_official",
    scope: "bm",
    day_type: "farkindalik"
  },
  "dunya-cocuk-haklari-gunu": {
    official_status: "international_observance",
    declaring_authority: "Birleşmiş Milletler Genel Kurulu",
    source_name: "Birleşmiş Milletler (A/RES/44/25 Çocuk Haklarına Dair Sözleşme)",
    source_url: "https://www.un.org/en/observances/world-childrens-day",
    source_type: "primary_official",
    scope: "bm",
    day_type: "farkindalik"
  },
  "dunya-aids-gunu": {
    official_status: "international_observance",
    declaring_authority: "Dünya Sağlık Örgütü (DSÖ)",
    source_name: "Dünya Sağlık Örgütü (WHO)",
    source_url: "https://www.who.int/campaigns/world-aids-day",
    source_type: "primary_official",
    scope: "bm",
    day_type: "farkindalik"
  },
  "dunya-engelliler-gunu": {
    official_status: "international_observance",
    declaring_authority: "Birleşmiş Milletler Genel Kurulu",
    source_name: "Birleşmiş Milletler (A/RES/47/3)",
    source_url: "https://www.un.org/en/observances/day-of-persons-with-disabilities",
    source_type: "primary_official",
    scope: "bm",
    day_type: "farkindalik"
  },
  "dunya-insan-haklari-gunu": {
    official_status: "international_observance",
    declaring_authority: "Birleşmiş Milletler Genel Kurulu",
    source_name: "Birleşmiş Milletler (A/RES/217 A)",
    source_url: "https://www.un.org/en/observances/human-rights-day",
    source_type: "primary_official",
    scope: "bm",
    day_type: "farkindalik"
  }
};

let verifiedCount = 0;
let needsReviewCount = 0;

const updatedList = list.map((day) => {
  const verifiedOverride = VERIFIED_DAYS_MAP[day.slug];

  if (verifiedOverride) {
    verifiedCount++;
    return {
      ...day,
      ...verifiedOverride,
      editorial_status: "verified",
      source_checked_at: "2026-10-10",
      last_verified_at: "2026-10-10",
      verified_at: "2026-10-10"
    };
  }

  // Not in strict primary verified list:
  needsReviewCount++;
  const hasGenericSource = Boolean(day.source_url && day.source_name);
  const isCelebrationOrFun = day.category === "Eğlence" || day.category === "Kültür & Sanat";

  return {
    ...day,
    editorial_status: "needs_review",
    official_status: isCelebrationOrFun ? "community_observance" : "unverified",
    source_type: hasGenericSource ? "secondary_reliable" : "unverified",
    declaring_authority: null,
    source_checked_at: "2026-10-10",
    last_verified_at: null,
    is_public_holiday: false
  };
});

console.log(`Classified: ${verifiedCount} verified, ${needsReviewCount} needs_review (total: ${updatedList.length})`);

// Write back to special-days-data.ts
const replacement = `export const INITIAL_SPECIAL_DAYS: SpecialDay[] = ${JSON.stringify(updatedList, null, 2)};`;
const newFileContent = fileContent.replace(/export const INITIAL_SPECIAL_DAYS: SpecialDay\[\] = \[[\s\S]*\];/, replacement);

fs.writeFileSync(filePath, newFileContent, 'utf8');
console.log("Successfully updated special-days-data.ts!");
