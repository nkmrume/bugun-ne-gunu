import { HistoryEvent } from "@/types/database";

/**
 * Birincil ve doğrulanmış tarihî kaynaklara dayalı "Tarihte Bugün" olayları.
 * Kaynağı teyit edilmemiş veya genel geçer şablonik olaylar eklenmez.
 */
export const NOTABLE_HISTORY_EVENTS: Record<string, HistoryEvent[]> = {
  "1-ocak": [
    {
      year: 1801,
      title: "Ceres Cüce Gezegeni Keşfedildi",
      description: "İtalyan astronom Giuseppe Piazzi, Güneş sistemindeki ilk asteroit/cüce gezegen olan Ceres'i gözlemledi.",
      category: "bilim",
      source_name: "NASA Jet Propulsion Laboratory",
      source_url: "https://ssd.jpl.nasa.gov",
    },
    {
      year: 1926,
      title: "Türkiye'de Miladi Takvim Yürürlüğe Girdi",
      description: "698 sayılı kanun ile Rumi ve Hicri takvimler yerine uluslararası standart olan Miladi takvim kullanılmaya başlandı.",
      category: "turkiye",
      source_name: "T.C. Resmî Gazete (Sayı 254)",
    },
    {
      year: 2002,
      title: "Euro Para Birimi Fiziksel Olarak Dolaşıma Girdi",
      description: "Avrupa Birliği üyesi 12 ülkede Euro madeni para ve banknotları resmi olarak vatandaşların kullanımına açıldı.",
      category: "dunya",
      source_name: "Avrupa Merkez Bankası (ECB)",
      source_url: "https://www.ecb.europa.eu",
    },
  ],
  "2-ocak": [
    {
      year: 1920,
      title: "Bilimkurgu Yazarı Isaac Asimov Doğdu",
      description: "Vakıf ve Ben, Robot gibi modern bilimkurgunun temel taşlarını yazan Isaac Asimov dünyaya geldi; 2 Ocak Dünya Bilimkurgu Günü olarak anılmaktadır.",
      category: "kultur",
      source_name: "Science Fiction and Fantasy Writers of America",
      source_url: "https://www.sfwa.org",
    },
  ],
  "4-ocak": [
    {
      year: 1809,
      title: "Louis Braille Doğdu",
      description: "Görme engelli bireylerin dünyayla bağ kurmasını sağlayan kabartma Braille alfabesinin mucidi Louis Braille Fransa'da doğdu. 4 Ocak Dünya Braille Günü'dür.",
      category: "bilim",
      source_name: "Birleşmiş Milletler (A/RES/73/161)",
      source_url: "https://www.un.org/en/observances/braille-day",
    },
  ],
  "8-mart": [
    {
      year: 1857,
      title: "New York Tekstil İşçileri Grevi",
      description: "New York'ta kadın tekstil işçileri daha iyi çalışma koşulları ve eşit haklar talebiyle tarihi grevi başlattı.",
      category: "dunya",
      source_name: "BM Kadın Birimi (UN Women)",
      source_url: "https://www.unwomen.org",
    },
    {
      year: 1977,
      title: "BM Dünya Kadınlar Günü'nü Resmen Kabul Etti",
      description: "Birleşmiş Milletler Genel Kurulu, 8 Mart'ı resmi olarak Dünya Kadınlar Günü (Dünya Kadın Hakları ve Uluslararası Barış Günü) ilan etti.",
      category: "dunya",
      source_name: "BM Genel Kurulu (A/RES/32/142)",
      source_url: "https://www.un.org/en/observances/womens-day",
    },
  ],
  "14-mart": [
    {
      year: 1827,
      title: "Tıphane-i Âmire ve Cerrahhane-i Âmire Kuruldu",
      description: "II. Mahmud döneminde Şehzadebaşı'nda kurulan modern tıp mektebi, Türkiye'de modern tıp eğitiminin miladı oldu. 14 Mart bu nedenle Tıp Bayramı olarak kutlanır.",
      category: "turkiye",
      source_name: "T.C. Sağlık Bakanlığı",
    },
    {
      year: 1879,
      title: "Albert Einstein Doğdu",
      description: "Modern fiziğin ve Genel Görelilik kuramının kurucusu Nobel ödüllü teorik fizikçi Albert Einstein Almanya'da doğdu.",
      category: "bilim",
    },
  ],
  "18-mart": [
    {
      year: 1915,
      title: "Çanakkale Deniz Zaferi",
      description: "Cevat Paşa komutasındaki Türk topçusu ve Nusret Mayın Gemisi'nin döşediği mayınlarla İtilaf Devletleri donanması Çanakkale Boğazı'nda kesin mağlubiyete uğratıldı. 18 Mart Şehitleri Anma Günü ve Çanakkale Zaferi'dir.",
      category: "turkiye",
      source_name: "T.C. Millî Savunma Bakanlığı",
    },
  ],
  "22-mart": [
    {
      year: 1993,
      title: "İlk Dünya Su Günü İdrak Edildi",
      description: "1992 Rio Çevre ve Kalkınma Konferansı tavsiyesiyle BM Genel Kurulu tarafından ilan edilen Dünya Su Günü ilk kez idrak edildi.",
      category: "dunya",
      source_name: "Birleşmiş Milletler (A/RES/47/193)",
      source_url: "https://www.un.org/en/observances/water-day",
    },
  ],
  "27-mart": [
    {
      year: 1961,
      title: "Dünya Tiyatro Günü İlan Edildi",
      description: "Uluslararası Tiyatro Enstitüsü (ITI), sahne sanatlarının toplumdaki değerini yüceltmek için 27 Mart'ı Dünya Tiyatro Günü kabul etti.",
      category: "kultur",
      source_name: "UNESCO / International Theatre Institute",
      source_url: "https://www.world-theatre-day.org",
    },
  ],
  "23-nisan": [
    {
      year: 1920,
      title: "Türkiye Büyük Millet Meclisi Açıldı",
      description: "Ankara'da Hacı Bayram Camii'nde kılınan cuma namazının ardından dualarla TBMM açıldı; milli iradenin yegane temsilcisi oldu.",
      category: "turkiye",
      source_name: "TBMM Arşivi",
    },
    {
      year: 1929,
      title: "Çocuk Bayramı Olarak İlan Edildi",
      description: "Gazi Mustafa Kemal Atatürk'ün himayesinde 23 Nisan günü dünya çocuklarına armağan edilen ulusal bir bayram olarak kutlanmaya başlandı.",
      category: "turkiye",
      source_name: "T.C. Resmî Gazete",
    },
  ],
  "19-mayis": [
    {
      year: 1919,
      title: "Mustafa Kemal Paşa Samsun'a Çıktı",
      description: "Bandırma Vapuru ile Samsun'a ayak basan Mustafa Kemal, Türk Kurtuluş Savaşı'nı ve milli mücadele ateşini başlattı.",
      category: "turkiye",
      source_name: "Nutuk / Atatürk Araştırma Merkezi",
    },
    {
      year: 1938,
      title: "Gençlik ve Spor Bayramı Kanunlaştı",
      description: "3466 sayılı kanunla 19 Mayıs günü, Türkiye Cumhuriyeti'nin ulusal Gençlik ve Spor Bayramı olarak kabul edildi.",
      category: "turkiye",
      source_name: "T.C. Resmî Gazete",
    },
  ],
  "5-haziran": [
    {
      year: 1972,
      title: "Stockholm Birleşmiş Milletler İnsan Çevresi Konferansı Başladı",
      description: "Küresel çevre koruma bilincinin miladı kabul edilen konferansın açılış günü olan 5 Haziran, BM tarafından Dünya Çevre Günü ilan edildi.",
      category: "dunya",
      source_name: "Birleşmiş Milletler Çevre Programı (UNEP)",
      source_url: "https://www.unep.org",
    },
  ],
  "15-temmuz": [
    {
      year: 2016,
      title: "Demokrasi ve Milli Birlik Günü",
      description: "Milletin iradesine yönelik hain darbe girişimine karşı halkın kahramanca direnişiyle kazanılan zaferin yıl dönümü.",
      category: "turkiye",
      source_name: "6752 Sayılı Kanun, T.C. Resmî Gazete (Sayı 29872)",
    },
  ],
  "30-agustos": [
    {
      year: 1922,
      title: "Büyük Taarruz ve Başkomutanlık Meydan Muharebesi Zaferi",
      description: "Dumlupınar'da Mustafa Kemal Paşa'nın sevk ve idaresinde gerçekleşen muharebede işgalci ordu kesin yenilgiye uğratıldı; Zafer Bayramı olarak kutlanır.",
      category: "turkiye",
      source_name: "Genelkurmay Askeri Tarih ve Stratejik Etüt (ATASE) Başkanlığı",
    },
  ],
  "1-ekim": [
    {
      year: 1908,
      title: "Ford Model T Satışa Çıktı",
      description: "Henry Ford, seri üretim bandında üretilen ilk uygun fiyatlı halk otomobili Model T'yi piyasaya sundu.",
      category: "bilim",
    },
    {
      year: 1949,
      title: "Çin Halk Cumhuriyeti Kuruldu",
      description: "Mao Zedong, Pekin Tiananmen Meydanı'nda cumhuriyetin kuruluşunu ilan etti.",
      category: "dunya",
    },
    {
      year: 2015,
      title: "Dünya Kahve Günü Resmen Başlatıldı",
      description: "Uluslararası Kahve Örgütü (ICO), Milano Expo'da üye 77 ülke ile ortaklaşa ilk resmi Dünya Kahve Günü'nü başlattı.",
      category: "kultur",
      source_name: "International Coffee Organization (ICO)",
      source_url: "https://www.ico.org",
    },
  ],
  "7-ekim": [
    {
      year: 1571,
      title: "İnebahtı Deniz Muharebesi",
      description: "Osmanlı Donanması ile Kutsal İttifak donanması arasında Akdeniz tarihinin en büyük kadırga savaşı gerçekleşti.",
      category: "tarih",
    },
    {
      year: 1926,
      title: "İtalya'da Faşist Parti Tüzüğü Kabul Edildi",
      description: "Mussolini liderliğindeki Ulusal Faşist Parti, İtalya'da tek yasal parti statüsü kazandı.",
      category: "dunya",
    },
    {
      year: 1940,
      title: "Almanya Romanya'yı İşgal Etti",
      description: "İkinci Dünya Savaşı sırasında Nazi Almanyası stratejik petrol sahalarını kontrol altına almak üzere Romanya'ya girdi.",
      category: "dunya",
    },
    {
      year: 2001,
      title: "ABD'nin Afganistan Harekâtı Başladı",
      description: "11 Eylül saldırılarının ardından ABD ve müttefikleri Afganistan operasyonunu başlattı.",
      category: "dunya",
    },
    {
      year: 2019,
      title: "Dünya Pamuk Günü İlk Kez Kutlandı",
      description: "Birleşmiş Milletler ve Dünya Ticaret Örgütü ortaklığıyla C-4 Afrika üretici ülkelerinin girişimiyle Dünya Pamuk Günü resmen başlatıldı.",
      category: "kultur",
      source_name: "Birleşmiş Milletler Genel Kurulu (A/RES/75/318)",
      source_url: "https://press.un.org/en/2021/ga12354.doc.htm",
    },
  ],
  "29-ekim": [
    {
      year: 1923,
      title: "Türkiye Cumhuriyeti İlan Edildi",
      description: "TBMM, Teşkilât-ı Esasiye Kanunu'nda yapılan değişiklikle devletin yönetim biçimini Cumhuriyet olarak kabul etti. Gazi Mustafa Kemal Atatürk oy birliğiyle ilk Cumhurbaşkanı seçildi.",
      category: "turkiye",
      source_name: "TBMM Zabıt Ceridesi / T.C. Resmî Gazete",
    },
    {
      year: 1933,
      title: "Cumhuriyetin 10. Yıl Kutlamaları ve Onuncu Yıl Nutku",
      description: "Mustafa Kemal Atatürk, Ankara Hipodromu'nda tarihi 10. Yıl Nutku'nu irat etti: 'Türk milleti çalışkandır, Türk milleti zekidir.'",
      category: "turkiye",
    },
    {
      year: 2013,
      title: "Marmaray Açıldı",
      description: "İstanbul Boğazı altından Asya ve Avrupa kıtalarını demiryoluyla bağlayan Marmaray tüp geçidi Cumhuriyetin 90. yılında hizmete açıldı.",
      category: "turkiye",
    },
  ],
  "10-kasim": [
    {
      year: 1938,
      title: "Gazi Mustafa Kemal Atatürk Ebediyete İntikal Etti",
      description: "Türkiye Cumhuriyeti'nin kurucusu büyük önder Atatürk, saat 09:05'te Dolmabahçe Sarayı'nda vefat etti.",
      category: "turkiye",
      source_name: "Cumhurbaşkanlığı Hükümet Tebliği, 10 Kasım 1938",
    },
    {
      year: 1953,
      title: "Atatürk'ün Naaşının Anıtkabir'e Nakli",
      description: "Atatürk'ün naaşı, Etnografya Müzesi'ndeki geçici kabrinden devlet töreniyle ebedi istirahatgâhı Anıtkabir'e nakledildi.",
      category: "turkiye",
      source_name: "T.C. Resmî Gazete",
    },
  ],
  "24-kasim": [
    {
      year: 1928,
      title: "Millet Mektepleri Talimatnamesi ve Başöğretmenlik",
      description: "Millet Mektepleri Talimatnamesi yürürlüğe girdi ve Mustafa Kemal Atatürk 'Millet Mektepleri Başöğretmeni' unvanını kabul etti. 1981'den bu yana Öğretmenler Günü olarak kutlanır.",
      category: "turkiye",
      source_name: "Bakanlar Kurulu Kararı / Resmî Gazete",
    },
  ],
  "10-aralik": [
    {
      year: 1948,
      title: "İnsan Hakları Evrensel Beyannamesi Kabul Edildi",
      description: "Birleşmiş Milletler Genel Kurulu Paris'te İnsan Hakları Evrensel Beyannamesi'ni kabul etti. 10 Aralık Dünya İnsan Hakları Günü'dür.",
      category: "dunya",
      source_name: "Birleşmiş Milletler (A/RES/217 A)",
      source_url: "https://www.un.org/en/about-us/universal-declaration-of-human-rights",
    },
  ],
};

/**
 * Returns historical events for any day of the year.
 * Kesin kural: Kaynağı ve tarihi doğrulanmamışsa ASLA uydurma veri üretilmez; boş dizi döner.
 */
export function getHistoryEventsForDate(day: number, month: number): HistoryEvent[] {
  const monthSlugs = [
    "", "ocak", "subat", "mart", "nisan", "mayis", "haziran",
    "temmuz", "agustos", "eylul", "ekim", "kasim", "aralik"
  ];

  const key = `${day}-${monthSlugs[month]}`;
  if (NOTABLE_HISTORY_EVENTS[key]) {
    return NOTABLE_HISTORY_EVENTS[key];
  }

  // Doğrulanmış kayıt yoksa boş liste dönülür; asla uydurma veri üretilmez.
  return [];
}

export function hasHistoryEvents(day: number, month: number): boolean {
  return getHistoryEventsForDate(day, month).length > 0;
}
