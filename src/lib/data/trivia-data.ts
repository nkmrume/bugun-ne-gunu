export interface TriviaQuestion {
  id: string;
  daySlug?: string;
  monthNo?: number;
  dayNo?: number;
  title: string;
  question: string;
  options: [string, string, string, string];
  correctIndex: number; // 0, 1, 2, or 3
  explanation: string;
  funFact: string;
  difficulty: "kolay" | "orta" | "zor";
  category: "Tarih" | "Kültür" | "Bilim" | "Doğa" | "Genel Kültür";
}

export const TRIVIA_QUESTIONS: TriviaQuestion[] = [
  {
    id: "q-kahve-gunu",
    daySlug: "dunya-kahve-gunu",
    monthNo: 10,
    dayNo: 1,
    title: "1 Ekim Dünya Kahve Günü",
    question: "Dünya Kahve Günü ilk kez hangi ülkede resmiyet kazanarak organize bir şekilde kutlanmıştır?",
    options: ["İtalya", "Japonya", "Brezilya", "Etiyopya"],
    correctIndex: 1,
    explanation: "İlk resmi Dünya Kahve Günü kutlaması 1983 yılında Japonya Kahve Birliği (All Japan Coffee Association) tarafından yapılmış, 2015 yılında ise Uluslararası Kahve Örgütü (ICO) tarafından evrensel gün kabul edilmiştir.",
    funFact: "Dünyada sudan sonra en çok tüketilen ve petrolden sonra küresel ticareti en çok yapılan ikinci emtia kahvedir!",
    difficulty: "orta",
    category: "Kültür",
  },
  {
    id: "q-cumhuriyet-bayrami",
    daySlug: "cumhuriyet-bayrami",
    monthNo: 10,
    dayNo: 29,
    title: "29 Ekim Cumhuriyet Bayramı",
    question: "Türkiye Büyük Millet Meclisi, 29 Ekim 1923 akşamı Cumhuriyeti tam olarak saat kaçta ilan etmiştir?",
    options: ["18:30", "20:30", "14:15", "09:00"],
    correctIndex: 1,
    explanation: "29 Ekim 1923 Pazartesi akşamı saat 20:30'da TBMM Genel Kurulu'nda Teşkilât-ı Esasîye Kanunu'nun 1. maddesi 'Türkiye Devleti'nin hükümet şekli Cumhuriyettir' olarak oy birliğiyle kabul edilmiştir.",
    funFact: "Cumhuriyet ilan edildikten hemen sonra gece saatlerinde 101 pare top atışı yapılarak tarihi müjde tüm yurda duyurulmuştur.",
    difficulty: "zor",
    category: "Tarih",
  },
  {
    id: "q-pamuk-gunu",
    daySlug: "dunya-pamuk-gunu",
    monthNo: 10,
    dayNo: 7,
    title: "7 Ekim Dünya Pamuk Günü",
    question: "Tekstil sektörünün temel hammaddesi olan pamuk, ekonomik değerinden ötürü halk arasında hangi unvanla bilinir?",
    options: ["Beyaz Altın", "Gümüş Lif", "Doğal İpek", "Toprağın İpliği"],
    correctIndex: 0,
    explanation: "Pamuk, Çukurova ve Ege başta olmak üzere tarımsal kalkınmanın lokomotifi olduğu için asırlardır 'Beyaz Altın' olarak adlandırılmaktadır. BM Genel Kurulu 2021'de 7 Ekim'i resmi gün ilan etmiştir.",
    funFact: "Standart bir balya pamuktan (yaklaşık 227 kg) tam 1.200 adet pamuklu tişört veya 3.000 çift çorap üretilebilir!",
    difficulty: "kolay",
    category: "Doğa",
  },
  {
    id: "q-ataturk-anma",
    daySlug: "ataturku-anma-gunu",
    monthNo: 11,
    dayNo: 10,
    title: "10 Kasım Atatürk'ü Anma Günü",
    question: "Gazi Mustafa Kemal Atatürk'ün aziz naaşı, Anıtkabir'in inşası tamamlanana kadar (1938-1953) nerede muhafaza edilmiştir?",
    options: [
      "Ankara Etnografya Müzesi",
      "Dolmabahçe Sarayı",
      "I. TBMM Binası",
      "Çankaya Köşkü Müzesi",
    ],
    correctIndex: 0,
    explanation: "Atatürk'ün naaşı, 21 Kasım 1938 tarihinde geçici kabir olarak Ankara Etnografya Müzesi'ne nakledilmiş ve 10 Kasım 1953'te ebedi istirahatgâhı Anıtkabir'e defnedilmiştir.",
    funFact: "10 Kasım 1953'teki nakil töreninde Atatürk'ün mezarına Türkiye'nin tüm illerinden, Kıbrıs'tan ve Selanik'teki evinin bahçesinden getirilen topraklar harmanlanmıştır.",
    difficulty: "kolay",
    category: "Tarih",
  },
  {
    id: "q-pi-gunu",
    daySlug: "pi-gunu-ve-tip-bayrami",
    monthNo: 3,
    dayNo: 14,
    title: "14 Mart Pi Günü ve Tıp Bayramı",
    question: "14 Mart (3/14) Pi Günü aynı zamanda hangi efsanevi fizikçinin doğum günüdür?",
    options: [
      "Albert Einstein",
      "Isaac Newton",
      "Nikola Tesla",
      "Galileo Galilei",
    ],
    correctIndex: 0,
    explanation: "Pi sayısı 3,14 olduğu için kutlanan 14 Mart tarihi, modern fiziğin kurucusu Albert Einstein'ın doğum günüdür (14 Mart 1879).",
    funFact: "Aynı zamanda modern kozmolojinin öncüsü Stephen Hawking de 14 Mart 2018 tarihinde hayata veda etmiştir.",
    difficulty: "orta",
    category: "Bilim",
  },
  {
    id: "q-cocuk-bayrami",
    daySlug: "ulusal-egemenlik-ve-cocuk-bayrami",
    monthNo: 4,
    dayNo: 23,
    title: "23 Nisan Ulusal Egemenlik ve Çocuk Bayramı",
    question: "Dünya tarihinde ilk kez çocuklara ulusal bir bayram armağan eden devlet adamı kimdir?",
    options: [
      "Mustafa Kemal Atatürk",
      "Mahatma Gandhi",
      "Franklin D. Roosevelt",
      "Winston Churchill",
    ],
    correctIndex: 0,
    explanation: "Mustafa Kemal Atatürk, TBMM'nin açılış günü olan 23 Nisan'ı çocuklara hediye ederek dünya çocuklarına bayram adayan ilk ve tek dünya lideri olmuştur.",
    funFact: "1979 yılından itibaren TRT Uluslararası 23 Nisan Çocuk Şenliği düzenlenmekte ve her yıl onlarca ülkeden yüzlerce yabancı çocuk Türk ailelerin evinde misafir edilmektedir.",
    difficulty: "kolay",
    category: "Tarih",
  },
  {
    id: "q-ogretmenler-gunu",
    daySlug: "ogretmenler-gunu",
    monthNo: 11,
    dayNo: 24,
    title: "24 Kasım Öğretmenler Günü",
    question: "Türkiye'de Öğretmenler Günü'nün 24 Kasım olarak seçilmesinin tarihi sebebi nedir?",
    options: [
      "Atatürk'ün 'Millet Mektepleri Başöğretmenliği' unvanını kabul ettiği gündür",
      "Köy Enstitüleri'nin kuruluş kanununun Meclis'te kabul edildiği tarihtir",
      "Tevhid-i Tedrisat (Öğretim Birliği) Kanunu'nun yürürlüğe girdiği gündür",
      "İlk Türk öğretmen okulunun açıldığı gündür",
    ],
    correctIndex: 0,
    explanation: "24 Kasım 1928'de Millet Mektepleri Talimatnamesi yürürlüğe girmiş ve Mustafa Kemal Atatürk 'Millet Mektepleri Başöğretmeni' unvanını kabul etmiştir. 1981'den bu yana Öğretmenler Günü olarak kutlanır.",
    funFact: "Dünya Öğretmenler Günü UNESCO tarafından 5 Ekim olarak kutlanırken, Türkiye köklü Cumhuriyet devrimine vefa olarak 24 Kasım'ı kutlar.",
    difficulty: "orta",
    category: "Tarih",
  },
  {
    id: "q-zafer-bayrami",
    daySlug: "zafer-bayrami",
    monthNo: 8,
    dayNo: 30,
    title: "30 Ağustos Zafer Bayramı",
    question: "Kurtuluş Savaşı'nı nihai zafere ulaştıran ve 30 Ağustos'ta sonuçlanan meydan muharebesinin askeri adı nedir?",
    options: [
      "Başkomutanlık Meydan Muharebesi (Dumlupınar)",
      "Sakarya Meydan Muharebesi",
      "I. İnönü Muharebesi",
      "Anafartalar Zaferi",
    ],
    correctIndex: 0,
    explanation: "26 Ağustos 1922'de Kocatepe'den başlayan Büyük Taarruz, 30 Ağustos'ta Dumlupınar'da bizzat Mustafa Kemal Paşa'nın sevk ve idaresinde Başkomutanlık Meydan Muharebesi ile taçlanmıştır.",
    funFact: "Zaferin hemen ardından 1 Eylül 1922'de Atatürk tarihi 'Ordular! İlk hedefiniz Akdeniz'dir, ileri!' emrini vermiştir.",
    difficulty: "kolay",
    category: "Tarih",
  },
  {
    id: "q-cevre-gunu",
    daySlug: "dunya-cevre-gunu",
    monthNo: 6,
    dayNo: 5,
    title: "5 Haziran Dünya Çevre Günü",
    question: "Dünya Çevre Günü ilk kez hangi tarihi Birleşmiş Milletler konferansında ilan edilmiştir?",
    options: [
      "1972 Stockholm İnsan Çevresi Konferansı",
      "1992 Rio Yeryüzü Zirvesi",
      "1997 Kyoto Protokolü Toplantısı",
      "2015 Paris İklim Zirvesi",
    ],
    correctIndex: 0,
    explanation: "1972 yılında İsveç'in Stockholm kentinde toplanan ilk BM Çevre Konferansı'nda 5 Haziran Dünya Çevre Günü ilan edilmiş ve BM Çevre Programı (UNEP) kurulmuştur.",
    funFact: "Her yıl Dünya Çevre Günü için küresel bir tema (örneğin 'Plastik Kirliliğine Son Ver') ve ev sahibi bir ülke seçilir.",
    difficulty: "orta",
    category: "Doğa",
  },
  {
    id: "q-tiyatro-gunu",
    daySlug: "dunya-tiyatro-gunu",
    monthNo: 3,
    dayNo: 27,
    title: "27 Mart Dünya Tiyatro Günü",
    question: "Dünya Tiyatro Günü'nde her yıl geleneksel olarak yayımlanan 'Uluslararası Bildiri'yi ilk kez 1962 yılında hangi usta isim kaleme almıştır?",
    options: [
      "Jean Cocteau",
      "Bertolt Brecht",
      "Samuel Beckett",
      "Muhsin Ertuğrul",
    ],
    correctIndex: 0,
    explanation: "Uluslararası Tiyatro Enstitüsü (ITI) tarafından 1961'de başlatılan Dünya Tiyatro Günü'nün ilk bildirisini 1962'de Fransız şair, oyun yazarı ve yönetmen Jean Cocteau yazmıştır.",
    funFact: "Türkiye'de tiyatronun öncüsü Muhsin Ertuğrul da Türk tiyatrosu için ilk ulusal bildiriyi kaleme alan isim olmuştur.",
    difficulty: "zor",
    category: "Kültür",
  },
  {
    id: "q-kitap-gunu",
    daySlug: "dunya-kitap-ve-telif-hakki-gunu",
    monthNo: 4,
    dayNo: 23,
    title: "23 Nisan Dünya Kitap Günü",
    question: "23 Nisan'ın UNESCO tarafından Dünya Kitap Günü ilan edilmesinin edebi sebebi nedir?",
    options: [
      "Shakespeare ve Cervantes'in aynı gün vefat etmiş olması",
      "Matbaanın ilk kez 23 Nisan'da icat edilmiş olması",
      "Gutenberg İncili'nin ilk basım tarihi olması",
      "Dünyanın ilk halk kütüphanesinin açılış günü olması",
    ],
    correctIndex: 0,
    explanation: "Dünya edebiyatının iki dev ismi William Shakespeare ve Miguel de Cervantes, 23 Nisan 1616 tarihinde vefat etmiştir. UNESCO bu sebeple 23 Nisan'ı Dünya Kitap Günü ilan etmiştir.",
    funFact: "Katalonya'da 23 Nisan Aziz Jordi Günü'nde geleneksel olarak erkekler kadınlara gül, kadınlar ise erkeklere kitap hediye eder!",
    difficulty: "orta",
    category: "Kültür",
  },
  {
    id: "q-kadinlar-gunu",
    daySlug: "dunya-kadinlar-gunu",
    monthNo: 3,
    dayNo: 8,
    title: "8 Mart Dünya Kadınlar Günü",
    question: "Türkiye'de kadınlara seçme ve seçilme hakkı pek çok Avrupa ülkesinden (Fransa, İtalya vb.) önce hangi yılda tanınmıştır?",
    options: ["1934", "1923", "1945", "1950"],
    correctIndex: 0,
    explanation: "5 Aralık 1934 tarihinde yapılan anayasa değişikliği ile Türk kadınlarına milletvekili seçme ve seçilme hakkı verilmiştir. Fransa kadınlara bu hakkı 1944'te, İtalya ise 1945'te tanımıştır.",
    funFact: "1935 yılında yapılan ilk genel seçimlerde TBMM'ye 18 kadın milletvekili girerek yüzde 4.5 oranında tarihi bir temsil yakalanmıştır.",
    difficulty: "kolay",
    category: "Tarih",
  },
];

/**
 * Returns the most relevant trivia question:
 * 1. Matches by daySlug if provided.
 * 2. Matches by month and day if provided.
 * 3. Rotates daily based on day of year.
 */
export function getTriviaForDay(params?: {
  slug?: string;
  month?: number;
  day?: number;
}): TriviaQuestion {
  if (params?.slug) {
    const match = TRIVIA_QUESTIONS.find((q) => q.daySlug === params.slug);
    if (match) return match;
  }

  if (params?.month && params?.day) {
    const match = TRIVIA_QUESTIONS.find(
      (q) => q.monthNo === params.month && q.dayNo === params.day
    );
    if (match) return match;
  }

  // Fallback: Rotate deterministically based on date so everyone on the same day gets the same challenge
  const now = new Date();
  const dayOfYear = Math.floor(
    (now.getTime() - new Date(now.getFullYear(), 0, 0).getTime()) / (1000 * 60 * 60 * 24)
  );
  const index = Math.abs(dayOfYear) % TRIVIA_QUESTIONS.length;

  return TRIVIA_QUESTIONS[index];
}
