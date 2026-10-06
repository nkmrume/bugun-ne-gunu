import { SpecialDay, MonthInfo } from "@/types/database";

export const MONTHS_METADATA: MonthInfo[] = [
  {
    number: 1,
    slug: "ocak",
    name: "Ocak",
    shortName: "Oca",
    season: "Kış",
    daysCount: 31,
    description: "Yılın ilk ayı olan Ocak ayında kutlanan ulusal ve uluslararası özel günler, tatiller ve etkinlikler.",
  },
  {
    number: 2,
    slug: "subat",
    name: "Şubat",
    shortName: "Şub",
    season: "Kış",
    daysCount: 28,
    description: "Şubat ayındaki sevgi dolu anlar, Sevgililer Günü, Dünya Kanser Günü ve farkındalık haftaları.",
  },
  {
    number: 3,
    slug: "mart",
    name: "Mart",
    shortName: "Mar",
    season: "İlkbahar",
    daysCount: 31,
    description: "İlkbaharın habercisi Mart ayında Dünya Kadınlar Günü, Pi Günü, Tıp Bayramı ve doğa kutlamaları.",
  },
  {
    number: 4,
    slug: "nisan",
    name: "Nisan",
    shortName: "Nis",
    season: "İlkbahar",
    daysCount: 30,
    description: "23 Nisan Ulusal Egemenlik ve Çocuk Bayramı, Dünya Kitap Günü ve baharın coşkusu.",
  },
  {
    number: 5,
    slug: "mayis",
    name: "Mayıs",
    shortName: "May",
    season: "İlkbahar",
    daysCount: 31,
    description: "1 Mayıs İşçi Bayramı, Anneler Günü, 19 Mayıs Atatürk'ü Anma Gençlik ve Spor Bayramı günleri.",
  },
  {
    number: 6,
    slug: "haziran",
    name: "Haziran",
    shortName: "Haz",
    season: "Yaz",
    daysCount: 30,
    description: "Yaz mevsiminin başlangıcı Haziran ayında Dünya Çevre Günü, Babalar Günü ve Dünya Müzik Günü.",
  },
  {
    number: 7,
    slug: "temmuz",
    name: "Temmuz",
    shortName: "Tem",
    season: "Yaz",
    daysCount: 31,
    description: "Temmuz ayında 15 Temmuz Demokrasi Günü, Dünya Çikolata Günü ve yaz festival günleri.",
  },
  {
    number: 8,
    slug: "agustos",
    name: "Ağustos",
    shortName: "Ağu",
    season: "Yaz",
    daysCount: 31,
    description: "30 Ağustos Zafer Bayramı, Dünya İnsani Yardım Günü ve Dünya Fotoğrafçılık Günü.",
  },
  {
    number: 9,
    slug: "eylul",
    name: "Eylül",
    shortName: "Eyl",
    season: "Sonbahar",
    daysCount: 30,
    description: "Sonbaharın gelişiyle Eylül ayında Dünya Barış Günü, Dünya Kuduz Günü ve Yazılımcılar Günü.",
  },
  {
    number: 10,
    slug: "ekim",
    name: "Ekim",
    shortName: "Eki",
    season: "Sonbahar",
    daysCount: 31,
    description: "29 Ekim Cumhuriyet Bayramı, Dünya Kahve Günü, Hayvanları Koruma Günü ve zengin sonbahar günleri.",
  },
  {
    number: 11,
    slug: "kasim",
    name: "Kasım",
    shortName: "Kas",
    season: "Sonbahar",
    daysCount: 30,
    description: "10 Kasım Atatürk'ü Anma Günü, 24 Kasım Öğretmenler Günü ve Dünya Çocuk Hakları Günü.",
  },
  {
    number: 12,
    slug: "aralik",
    name: "Aralık",
    shortName: "Ara",
    season: "Kış",
    daysCount: 31,
    description: "Yılın kapanış ayı Aralık'ta Dünya Türk Kahvesi Günü, Engelliler Günü, İnsan Hakları Günü ve Yılbaşı.",
  },
];

export const INITIAL_SPECIAL_DAYS: SpecialDay[] = [
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000001",
    "slug": "dunya-hijyen-gunu",
    "title": "16 Ocak Dünya Hijyen Günü",
    "description": "Kişisel temizlik, el yıkama ve halk sağlığını koruma alışkanlıklarını hatırlatan gün.",
    "content": "## 16 Ocak Dünya Hijyen Günü Nedir?\nKişisel hijyenin salgın hastalıklardan korunmadaki en etkili ve ucuz yöntem olduğunu vurgulamak amacıyla kutlanır.\n\n### Tarihçesi ve Önemi\nKişisel hijyenin salgın hastalıklardan korunmadaki en etkili ve ucuz yöntem olduğunu vurgulamak amacıyla kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 16 Ocak Dünya Hijyen Günü Nasıl Kutlanır?\n1. Ellerinizi en az 20 saniye sabunla doğru şekilde yıkayın.\n2. Yaşam alanlarınızı düzenli havalandırın ve temizleyin.\n3. Çocuklara hijyen kurallarını öğretin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Temizlik imandandır ve sağlığın başıdır! 16 Ocak Dünya Hijyen Günü kutlu olsun. 🧼🫧\"\n* \"16 Ocak Dünya Hijyen Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #HijyenGunu #ElYikama #Temizlik\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-hijyen-gunu\"",
    "celebration_date": "2026-01-16",
    "month_no": 1,
    "day_no": 16,
    "category": "Sağlık",
    "hashtags": [
      "#HijyenGunu",
      "#ElYikama",
      "#Temizlik",
      "#HalkSagligi"
    ],
    "affiliate_keywords": [
      "otomatik sabunluk sensörlü",
      "antibakteriyel el dezenfektanı",
      "bambu banyo havlusu"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000002",
    "slug": "dunya-gumruk-gunu",
    "title": "26 Ocak Dünya Gümrük Günü",
    "description": "Uluslararası ticaretin güvenliği ve gümrük çalışanlarının fedakarlıklarını onurlandıran gün.",
    "content": "## 26 Ocak Dünya Gümrük Günü Nedir?\nDünya Gümrük Örgütü'nün ilk toplantısını yaptığı 26 Ocak 1953 anısına küresel ticaretin güvenliğini kutlar.\n\n### Tarihçesi ve Önemi\nDünya Gümrük Örgütü'nün ilk toplantısını yaptığı 26 Ocak 1953 anısına küresel ticaretin güvenliğini kutlar. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 26 Ocak Dünya Gümrük Günü Nasıl Kutlanır?\n1. Gümrük emekçilerine teşekkür edin.\n2. Yasal ve kayıtlı ticaretin önemini öğrenin.\n3. Kaçakçılıkla mücadeleye dikkat çekin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Sınırlarımızın ve ekonomimizin bekçisi tüm gümrük çalışanlarımızın Dünya Gümrük Günü kutlu olsun! 🛃🚢\"\n* \"26 Ocak Dünya Gümrük Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #GumrukGunu #26Ocak #GumrukMuhafaza\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-gumruk-gunu\"",
    "celebration_date": "2026-01-26",
    "month_no": 1,
    "day_no": 26,
    "category": "Mesleki",
    "hashtags": [
      "#GumrukGunu",
      "#26Ocak",
      "#GumrukMuhafaza",
      "#Ticaret"
    ],
    "affiliate_keywords": [
      "seyahat pasaport kılıfı",
      "valiz bavul seti",
      "bagaj tartısı dijital"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000003",
    "slug": "sivil-savunma-gunu",
    "title": "28 Şubat Sivil Savunma Günü",
    "description": "Deprem, yangın ve afetlere karşı hazırlıklı olma ve sivil savunma bilincini artıran gün.",
    "content": "## 28 Şubat Sivil Savunma Günü Nedir?\n7126 sayılı Sivil Savunma Kanunu'nun yürürlüğe girdiği 28 Şubat, afetlere karşı bilinçli toplum inşası için kutlanır.\n\n### Tarihçesi ve Önemi\n7126 sayılı Sivil Savunma Kanunu'nun yürürlüğe girdiği 28 Şubat, afetlere karşı bilinçli toplum inşası için kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 28 Şubat Sivil Savunma Günü Nasıl Kutlanır?\n1. Evinizde ve iş yerinizde deprem çantanızı güncelleyin.\n2. Ailenizle afet toplanma alanınızı kontrol edin.\n3. Yangın ve tahliye tatbikatlarına katılın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Afetlere hazırlıklı olmak hayat kurtarır! 28 Şubat Sivil Savunma Günü kutlu olsun. 🚨🎒\"\n* \"28 Şubat Sivil Savunma Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #SivilSavunmaGunu #AfetBilinci #DepremeHazirlik\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #sivil-savunma-gunu\"",
    "celebration_date": "2026-02-28",
    "month_no": 2,
    "day_no": 28,
    "category": "Resmi",
    "hashtags": [
      "#SivilSavunmaGunu",
      "#AfetBilinci",
      "#DepremeHazirlik",
      "#AFAD"
    ],
    "affiliate_keywords": [
      "deprem acil durum çantası",
      "el feneri şarjlı",
      "düdük pusula çok amaçlı",
      "ilk yardım çantası"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000004",
    "slug": "dunya-tuketici-haklari-gunu",
    "title": "15 Mart Dünya Tüketici Hakları Günü",
    "description": "Tüketicilerin güvenlik, bilgilendirilme ve zararların tazmini haklarını savunan uluslararası gün.",
    "content": "## 15 Mart Dünya Tüketici Hakları Günü Nedir?\n1962 yılında ABD Başkanı John F. Kennedy'nin Tüketici Hakları Bildirgesi'ni açıkladığı günün anısına kutlanır.\n\n### Tarihçesi ve Önemi\n1962 yılında ABD Başkanı John F. Kennedy'nin Tüketici Hakları Bildirgesi'ni açıkladığı günün anısına kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 15 Mart Dünya Tüketici Hakları Günü Nasıl Kutlanır?\n1. Alışverişlerinizde fatura ve fiş almayı ihmal etmeyin.\n2. Tüketici Hakem Heyetleri'ne başvurma haklarınızı öğrenin.\n3. Yanıltıcı reklamlara karşı bilinçli olun.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Bilinçli tüketici güçlü toplum demektir! 15 Mart Dünya Tüketici Hakları Günü kutlu olsun. 🛍️⚖️\"\n* \"15 Mart Dünya Tüketici Hakları Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #TuketiciHaklariGunu #BilincliTuketici #HaklariniBil\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-tuketici-haklari-gunu\"",
    "celebration_date": "2026-03-15",
    "month_no": 3,
    "day_no": 15,
    "category": "Farkındalık",
    "hashtags": [
      "#TuketiciHaklariGunu",
      "#BilincliTuketici",
      "#HaklariniBil",
      "#15Mart"
    ],
    "affiliate_keywords": [
      "tüketici hukuku el kitabı",
      "para yönetim bütçe defteri"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000005",
    "slug": "dunya-siir-gunu",
    "title": "21 Mart Dünya Şiir Günü",
    "description": "Duyguların en saf ifadesi olan şiir sanatını, şairleri ve sözcüklerin büyüsünü kutlayan UNESCO günü.",
    "content": "## 21 Mart Dünya Şiir Günü Nedir?\nUNESCO tarafından 1999 yılında şiirin diller arası köprü kurma gücünü onurlandırmak amacıyla kabul edilmiştir.\n\n### Tarihçesi ve Önemi\nUNESCO tarafından 1999 yılında şiirin diller arası köprü kurma gücünü onurlandırmak amacıyla kabul edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 21 Mart Dünya Şiir Günü Nasıl Kutlanır?\n1. En sevdiğiniz şairden bir şiir okuyup paylaşın.\n2. Kendi duygularınızı mısralara dökün.\n3. Şiir dinletilerine katılın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Şiir hayatın nefesidir. 21 Mart Dünya Şiir Günü'nde yüreğinizden şiirler eksik olmasın! 📜🖋️\"\n* \"21 Mart Dünya Şiir Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaSiirGunu #SiirSokakta #NazimHikmet\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-siir-gunu\"",
    "celebration_date": "2026-03-21",
    "month_no": 3,
    "day_no": 21,
    "category": "Kültür & Sanat",
    "hashtags": [
      "#DunyaSiirGunu",
      "#SiirSokakta",
      "#NazimHikmet",
      "#CemalSureya",
      "#Siir"
    ],
    "affiliate_keywords": [
      "türk şiir antolojisi",
      "nazım hikmet şiirleri",
      "cemal süreya sevda sözleri",
      "dolma kalem"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000006",
    "slug": "dunya-meteoroloji-gunu",
    "title": "23 Mart Dünya Meteoroloji Günü",
    "description": "Hava durumu tahminleri, iklim bilimi ve erken uyarı sistemlerinin hayat kurtarıcı rolünü kutlayan gün.",
    "content": "## 23 Mart Dünya Meteoroloji Günü Nedir?\nDünya Meteoroloji Örgütü'nün (WMO) 1950'de yürürlüğe giren sözleşmesinin yıl dönümü anısına kutlanır.\n\n### Tarihçesi ve Önemi\nDünya Meteoroloji Örgütü'nün (WMO) 1950'de yürürlüğe giren sözleşmesinin yıl dönümü anısına kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 23 Mart Dünya Meteoroloji Günü Nasıl Kutlanır?\n1. İklim değişikliğinin hava olayları üzerindeki etkilerini inceleyin.\n2. Afet erken uyarı bildirimlerini takip edin.\n3. Meteoroloji çalışanlarına teşekkür edin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Hava şartları ne olursa olsun kalbiniz güneşli olsun! 23 Mart Dünya Meteoroloji Günü kutlu olsun. ☀️🌧️🌈\"\n* \"23 Mart Dünya Meteoroloji Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #MeteorolojiGunu #HavaDurumu #IklimBilimi\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-meteoroloji-gunu\"",
    "celebration_date": "2026-03-23",
    "month_no": 3,
    "day_no": 23,
    "category": "Çevre & Doğa",
    "hashtags": [
      "#MeteorolojiGunu",
      "#HavaDurumu",
      "#IklimBilimi",
      "#WMO"
    ],
    "affiliate_keywords": [
      "ev tipi meteoroloji istasyonu",
      "dijital termometre higrometre",
      "barometre"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000007",
    "slug": "dunya-saka-gunu",
    "title": "1 Nisan Şaka Günü",
    "description": "Tüm dünyada insanların birbirine zararsız, neşeli ve zekice şakalar yaptığı kahkaha dolu gün.",
    "content": "## 1 Nisan Şaka Günü Nedir?\nKökeni 16. yüzyıl Fransa takvim reformuna dayanan 1 Nisan, asırlardır dünya genelinde şakalarla kutlanmaktadır.\n\n### Tarihçesi ve Önemi\nKökeni 16. yüzyıl Fransa takvim reformuna dayanan 1 Nisan, asırlardır dünya genelinde şakalarla kutlanmaktadır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 1 Nisan Şaka Günü Nasıl Kutlanır?\n1. Arkadaşlarınıza kırıcı olmayan sevimli bir şaka yapın.\n2. Bol bol gülün ve mizahın tadını çıkarın.\n3. Size yapılan şakalara tebessümle karşılık verin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Gülmek en güzel şifadır! 1 Nisan Şaka Günü'nüz bol tebessümlü ve kahkahalı geçsin! 🎭😄\"\n* \"1 Nisan Şaka Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #1Nisan #SakaGunu #AprilFools\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-saka-gunu\"",
    "celebration_date": "2026-04-01",
    "month_no": 4,
    "day_no": 1,
    "category": "Eğlence",
    "hashtags": [
      "#1Nisan",
      "#SakaGunu",
      "#AprilFools",
      "#Gulumse"
    ],
    "affiliate_keywords": [
      "zararsız şaka malzemeleri",
      "esprili kupa bardak",
      "parti şaka oyunları"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000008",
    "slug": "polis-teskilati-kurulus-gunu",
    "title": "10 Nisan Türk Polis Teşkilatı Kuruluş Günü",
    "description": "Huzur, güvenlik ve asayişimizin teminatı olan Türk Polis Teşkilatı'nın kuruluşunu kutlayan gün.",
    "content": "## 10 Nisan Türk Polis Teşkilatı Kuruluş Günü Nedir?\n10 Nisan 1845'te kurulan Türk Polis Teşkilatı, milletimizin can ve mal emniyetini sağlamak için görev yapmaktadır.\n\n### Tarihçesi ve Önemi\n10 Nisan 1845'te kurulan Türk Polis Teşkilatı, milletimizin can ve mal emniyetini sağlamak için görev yapmaktadır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 10 Nisan Türk Polis Teşkilatı Kuruluş Günü Nasıl Kutlanır?\n1. Görev başındaki polis memurlarına kolaylıklar dileyin.\n2. Şehit polislerimizi dualarla anın.\n3. Trafik ve asayiş kurallarına uyun.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Huzurumuzun ve güvenliğimizin teminatı kahraman polislerimizin 10 Nisan Polis Haftası kutlu olsun! 👮‍♂️🇹🇷\"\n* \"10 Nisan Türk Polis Teşkilatı Kuruluş Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #PolisHaftasi #10Nisan #TurkPolisTeskilati\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #polis-teskilati-kurulus-gunu\"",
    "celebration_date": "2026-04-10",
    "month_no": 4,
    "day_no": 10,
    "category": "Mesleki",
    "hashtags": [
      "#PolisHaftasi",
      "#10Nisan",
      "#TurkPolisTeskilati",
      "#PolisimizinYanindayiz"
    ],
    "affiliate_keywords": [
      "polis temalı hediye kupa",
      "taktik fener",
      "deri polis cüzdan rozet"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000009",
    "slug": "dunya-pilotlar-gunu",
    "title": "26 Nisan Dünya Pilotlar Günü",
    "description": "Türkiye'nin 1 numaralı pilot brövesi sahibi Fesa Evrensev'in anısına tüm dünyada kutlanan havacılık günü.",
    "content": "## 26 Nisan Dünya Pilotlar Günü Nedir?\nTürkiye Havayolu Pilotları Derneği'nin (TALPA) önerisiyle IFALPA tarafından Fesa Evrensev'in ilk uçuş günü kabul edilmiştir.\n\n### Tarihçesi ve Önemi\nTürkiye Havayolu Pilotları Derneği'nin (TALPA) önerisiyle IFALPA tarafından Fesa Evrensev'in ilk uçuş günü kabul edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 26 Nisan Dünya Pilotlar Günü Nasıl Kutlanır?\n1. Gökyüzünün cesur kaptanlarına teşekkür edin.\n2. Havacılık müzelerini gezin.\n3. Uçuş simülasyonu deneyin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"İstikbal göklerdedir! Kanatlarıyla dünyayı birbirine bağlayan tüm pilotlarımızın günü kutlu olsun! ✈️👨‍✈️👩‍✈️\"\n* \"26 Nisan Dünya Pilotlar Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaPilotlarGunu #WorldPilotsDay #Goklerdeyiz\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-pilotlar-gunu\"",
    "celebration_date": "2026-04-26",
    "month_no": 4,
    "day_no": 26,
    "category": "Mesleki",
    "hashtags": [
      "#DunyaPilotlarGunu",
      "#WorldPilotsDay",
      "#Goklerdeyiz",
      "#Havacilik"
    ],
    "affiliate_keywords": [
      "uçak maketi metal",
      "pilot güneş gözlüğü aviator",
      "havacılık temalı saat"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000010",
    "slug": "uluslararasi-caz-gunu",
    "title": "30 Nisan Uluslararası Caz Günü",
    "description": "Özgürlüğün, doğaçlamanın ve diyalogun müziği olan cazı onurlandıran UNESCO günü.",
    "content": "## 30 Nisan Uluslararası Caz Günü Nedir?\nUNESCO iyi niyet elçisi caz efsanesi Herbie Hancock öncülüğünde 2011 yılında ilan edilmiştir.\n\n### Tarihçesi ve Önemi\nUNESCO iyi niyet elçisi caz efsanesi Herbie Hancock öncülüğünde 2011 yılında ilan edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 30 Nisan Uluslararası Caz Günü Nasıl Kutlanır?\n1. Miles Davis, Louis Armstrong veya Türk caz sanatçılarını dinleyin.\n2. Bir caz kulübünü ziyaret edin.\n3. Plak dinleme gecesi yapın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Caz özgürlüğün sesidir. 30 Nisan Uluslararası Caz Günü'nde notaların büyüsüne kapılın! 🎷🎺🎶\"\n* \"30 Nisan Uluslararası Caz Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #CazGunu #JazzDay #MuzikOzgurluktur\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #uluslararasi-caz-gunu\"",
    "celebration_date": "2026-04-30",
    "month_no": 4,
    "day_no": 30,
    "category": "Kültür & Sanat",
    "hashtags": [
      "#CazGunu",
      "#JazzDay",
      "#MuzikOzgurluktur",
      "#Jazz"
    ],
    "affiliate_keywords": [
      "plak çalar pikap bluetooth",
      "caz plakları efsane",
      "saksafon başlangıç"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000011",
    "slug": "basin-ozgurlugu-gunu",
    "title": "3 Mayıs Dünya Basın Özgürlüğü Günü",
    "description": "Bağımsız, sansürsüz ve özgür basının demokrasilerdeki hayati önemini hatırlatan BM günü.",
    "content": "## 3 Mayıs Dünya Basın Özgürlüğü Günü Nedir?\n1993 yılında BM Genel Kurulu tarafından hükümetlere basın özgürlüğünü koruma taahhüdünü hatırlatmak için ilan edilmiştir.\n\n### Tarihçesi ve Önemi\n1993 yılında BM Genel Kurulu tarafından hükümetlere basın özgürlüğünü koruma taahhüdünü hatırlatmak için ilan edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 3 Mayıs Dünya Basın Özgürlüğü Günü Nasıl Kutlanır?\n1. Bağımsız gazetecileri ve medya kuruluşlarını destekleyin.\n2. Dezenformasyona karşı doğru haberi teyit edin.\n3. Sansüre karşı düşünce özgürlüğünü savunun.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Özgür basın halkın nefes borusudur. 3 Mayıs Dünya Basın Özgürlüğü Günü kutlu olsun! 📰✍️\"\n* \"3 Mayıs Dünya Basın Özgürlüğü Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #BasinOzgurluguGunu #WorldPressFreedomDay #OzgurBasin\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #basin-ozgurlugu-gunu\"",
    "celebration_date": "2026-05-03",
    "month_no": 5,
    "day_no": 3,
    "category": "Farkındalık",
    "hashtags": [
      "#BasinOzgurluguGunu",
      "#WorldPressFreedomDay",
      "#OzgurBasin",
      "#HaberHakki"
    ],
    "affiliate_keywords": [
      "gazetecilik etik kitapları",
      "basın tarihi araştırmaları"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000012",
    "slug": "hidirellez",
    "title": "5 Mayıs Hıdırellez Kültür Bayramı",
    "description": "Hızır ve İlyas peygamberlerin yeryüzünde buluştuğu gün olarak kabul edilen köklü bahar bayramı.",
    "content": "## 5 Mayıs Hıdırellez Kültür Bayramı Nedir?\nUNESCO İnsanlığın Somut Olmayan Kültürel Mirası Temsili Listesi'nde yer alan Hıdırellez, baharın ve bereketin müjdecisidir.\n\n### Tarihçesi ve Önemi\nUNESCO İnsanlığın Somut Olmayan Kültürel Mirası Temsili Listesi'nde yer alan Hıdırellez, baharın ve bereketin müjdecisidir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 5 Mayıs Hıdırellez Kültür Bayramı Nasıl Kutlanır?\n1. Gül ağacının altına dileklerinizi çizin veya asın.\n2. Ateşin üzerinden atlayarak yeni başlangıçlara niyet edin.\n3. Doğada sevdiklerinizle piknik yapın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Hızır yoldaşınız, dilekleriniz gerçek olsun! Hıdırellez Bayramınız bereket ve sağlık getirsin. 🌾🔥🌸\"\n* \"5 Mayıs Hıdırellez Kültür Bayramı kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #Hidirellez #BaharBayrami #DileklerKabulOlsun\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #hidirellez\"",
    "celebration_date": "2026-05-05",
    "month_no": 5,
    "day_no": 5,
    "category": "Kültür & Sanat",
    "hashtags": [
      "#Hidirellez",
      "#BaharBayrami",
      "#DileklerKabulOlsun",
      "#5Mayis"
    ],
    "affiliate_keywords": [
      "tütsü seti doğal",
      "dilek feneri renkli",
      "hasır piknik sepeti"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000013",
    "slug": "dunya-psikologlar-gunu",
    "title": "10 Mayıs Dünya Psikologlar Günü",
    "description": "İnsan ruhunu anlamak, iyileştirmek ve toplumsal esenliği sağlamak için çalışan psikologlara adanan gün.",
    "content": "## 10 Mayıs Dünya Psikologlar Günü Nedir?\nRuh sağlığı alanında çalışan psikologların mesleki dayanışmasını güçlendirmek amacıyla kutlanır.\n\n### Tarihçesi ve Önemi\nRuh sağlığı alanında çalışan psikologların mesleki dayanışmasını güçlendirmek amacıyla kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 10 Mayıs Dünya Psikologlar Günü Nasıl Kutlanır?\n1. Psikolog dostlarınıza tebrik mesajı iletin.\n2. Psikolojik sağlığın önemini çevrenize anlatın.\n3. Kendinize şefkat göstermeyi öğrenin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Ruhumuza ayna tutan, karanlık yollarımızı aydınlatan tüm psikologlarımızın günü kutlu olsun! 🧠🛋️\"\n* \"10 Mayıs Dünya Psikologlar Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #PsikologlarGunu #10Mayis #RuhSagligi\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-psikologlar-gunu\"",
    "celebration_date": "2026-05-10",
    "month_no": 5,
    "day_no": 10,
    "category": "Mesleki",
    "hashtags": [
      "#PsikologlarGunu",
      "#10Mayis",
      "#RuhSagligi",
      "#Psikoloji"
    ],
    "affiliate_keywords": [
      "psikoloji temalı kupa",
      "terapi not defteri",
      "freud biblo masa üstü"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000014",
    "slug": "eczacilik-gunu",
    "title": "14 Mayıs Eczacılık Günü",
    "description": "Türkiye'de bilimsel eczacılık eğitiminin başladığı günün anısına sağlık danışmanımız eczacılara adanan gün.",
    "content": "## 14 Mayıs Eczacılık Günü Nedir?\n14 Mayıs 1839'da Mekteb-i Tıbbiye-i Adliye-i Şahane bünyesinde ilk eczacı sınıfının açılmasıyla bilimsel eczacılık başlamıştır.\n\n### Tarihçesi ve Önemi\n14 Mayıs 1839'da Mekteb-i Tıbbiye-i Adliye-i Şahane bünyesinde ilk eczacı sınıfının açılmasıyla bilimsel eczacılık başlamıştır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 14 Mayıs Eczacılık Günü Nasıl Kutlanır?\n1. Mahallenizin eczacısına teşekkür edin.\n2. İlaçları mutlaka hekim ve eczacı kontrolünde kullanın.\n3. Akılcı ilaç kullanımına özen gösterin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Sağlığımızın en yakın danışmanı olan tüm fedakar eczacılarımızın 14 Mayıs Eczacılık Günü kutlu olsun! 💊⚕️\"\n* \"14 Mayıs Eczacılık Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #EczacilikGunu #14Mayis #EczacimizaTesekkurler\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #eczacilik-gunu\"",
    "celebration_date": "2026-05-14",
    "month_no": 5,
    "day_no": 14,
    "category": "Sağlık",
    "hashtags": [
      "#EczacilikGunu",
      "#14Mayis",
      "#EczacimizaTesekkurler",
      "#Saglik"
    ],
    "affiliate_keywords": [
      "eczacı hediye seti kupa",
      "havan biblo seramik",
      "ilaç saklama kutusu haftalık"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000015",
    "slug": "uluslararasi-aile-gunu",
    "title": "15 Mayıs Uluslararası Aile Günü",
    "description": "Toplumun temel taşı olan ailenin korunması, sevgi ve dayanışmanın güçlendirilmesi için kutlanan BM günü.",
    "content": "## 15 Mayıs Uluslararası Aile Günü Nedir?\n1993 yılında BM Genel Kurulu tarafından aile kurumunun önemine dikkat çekmek için kabul edilmiştir.\n\n### Tarihçesi ve Önemi\n1993 yılında BM Genel Kurulu tarafından aile kurumunun önemine dikkat çekmek için kabul edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 15 Mayıs Uluslararası Aile Günü Nasıl Kutlanır?\n1. Ailenizle birlikte televizyonsuz ve ekransız bir akşam yemeği yiyin.\n2. Eski aile fotoğraflarını birlikte inceleyin.\n3. Birbirinize olan sevginizi sözlerle ifade edin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Hayattaki en büyük zenginlik huzurlu bir ailedir. 15 Mayıs Uluslararası Aile Günü kutlu olsun! 👨‍👩‍👧‍👦🏡❤️\"\n* \"15 Mayıs Uluslararası Aile Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #AileGunu #FamilyDay #AilemHerSeyim\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #uluslararasi-aile-gunu\"",
    "celebration_date": "2026-05-15",
    "month_no": 5,
    "day_no": 15,
    "category": "Farkındalık",
    "hashtags": [
      "#AileGunu",
      "#FamilyDay",
      "#AilemHerSeyim",
      "#SevgiYuvasi"
    ],
    "affiliate_keywords": [
      "aile fotoğraf çerçevesi çoklu",
      "kutu kutu aile oyunu",
      "büyük boy piknik örtüsü"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000016",
    "slug": "muzeler-gunu",
    "title": "18 Mayıs Müzeler Günü",
    "description": "Kültürel mirasımızı koruyan, geçmiş ile gelecek arasında köprü kuran müzelerin uluslararası kutlaması.",
    "content": "## 18 Mayıs Müzeler Günü Nedir?\nUluslararası Müzeler Konseyi (ICOM) tarafından 1977 yılından bu yana toplumda müze bilincini yaymak için kutlanır.\n\n### Tarihçesi ve Önemi\nUluslararası Müzeler Konseyi (ICOM) tarafından 1977 yılından bu yana toplumda müze bilincini yaymak için kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 18 Mayıs Müzeler Günü Nasıl Kutlanır?\n1. Bugün en yakın müzeyi ücretsiz veya indirimli gezin.\n2. Tarihi eserlerin korunması bilincini çocuklara aktarın.\n3. Arkeolojik kazılar hakkında bilgi edinin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Geçmişini bilmeyen geleceğini inşa edemez. 18 Mayıs Müzeler Günü kutlu olsun! 🏛️🏺🗿\"\n* \"18 Mayıs Müzeler Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #MuzelerGunu #InternationalMuseumDay #KulturelMiras\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #muzeler-gunu\"",
    "celebration_date": "2026-05-18",
    "month_no": 5,
    "day_no": 18,
    "category": "Kültür & Sanat",
    "hashtags": [
      "#MuzelerGunu",
      "#InternationalMuseumDay",
      "#KulturelMiras",
      "#MuzeleriGez"
    ],
    "affiliate_keywords": [
      "müze kart kılıfı",
      "türkiye arkeoloji atlası",
      "sanat tarihi el kitabı"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000017",
    "slug": "dunya-sut-gunu",
    "title": "21 Mayıs Dünya Süt Günü",
    "description": "Sağlıklı kemik ve kas gelişimi için sütün beslenmedeki vazgeçilmez yerini vurgulayan FAO günü.",
    "content": "## 21 Mayıs Dünya Süt Günü Nedir?\nBM Gıda ve Tarım Örgütü (FAO) tarafından süt sektörünü ve sağlıklı beslenmeyi desteklemek için ilan edilmiştir.\n\n### Tarihçesi ve Önemi\nBM Gıda ve Tarım Örgütü (FAO) tarafından süt sektörünü ve sağlıklı beslenmeyi desteklemek için ilan edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 21 Mayıs Dünya Süt Günü Nasıl Kutlanır?\n1. Günde en az bir bardak süt veya süt ürünü tüketin.\n2. Çocuklara süt içme alışkanlığı kazandırın.\n3. Yerel süt üreticilerini destekleyin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Sağlıklı nesiller için her gün bir bardak süt! 21 Mayıs Dünya Süt Günü kutlu olsun. 🥛🐮\"\n* \"21 Mayıs Dünya Süt Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaSutGunu #WorldMilkDay #SutIcSaglikBul\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-sut-gunu\"",
    "celebration_date": "2026-05-21",
    "month_no": 5,
    "day_no": 21,
    "category": "Sağlık",
    "hashtags": [
      "#DunyaSutGunu",
      "#WorldMilkDay",
      "#SutIcSaglikBul",
      "#KemikSagligi"
    ],
    "affiliate_keywords": [
      "süt köpürtücü otomatik",
      "cam süt şişesi retro",
      "yoğurt yapma makinesi"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000018",
    "slug": "biyocesitlilik-gunu",
    "title": "22 Mayıs Uluslararası Biyoçeşitlilik Günü",
    "description": "Gezegenimizdeki tüm türlerin, ekosistemlerin ve genetik zenginliğin korunması için BM tarafından kutlanır.",
    "content": "## 22 Mayıs Uluslararası Biyoçeşitlilik Günü Nedir?\n1992 Biyolojik Çeşitlilik Sözleşmesi'nin kabul edildiği gün olan 22 Mayıs, ekolojik dengenin korunması için kutlanır.\n\n### Tarihçesi ve Önemi\n1992 Biyolojik Çeşitlilik Sözleşmesi'nin kabul edildiği gün olan 22 Mayıs, ekolojik dengenin korunması için kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 22 Mayıs Uluslararası Biyoçeşitlilik Günü Nasıl Kutlanır?\n1. Endemik bitki ve hayvan türlerini tanıyın.\n2. Doğal yaşam alanlarına zarar vermekten kaçının.\n3. Kimyasal kirliliği azaltın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Doğadaki her canlı hayat zincirinin vazgeçilmez bir halkasıdır. 22 Mayıs Biyoçeşitlilik Günü kutlu olsun! 🌿🦋🦜\"\n* \"22 Mayıs Uluslararası Biyoçeşitlilik Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #BiyocesitlilikGunu #BiodiversityDay #DogayiKoru\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #biyocesitlilik-gunu\"",
    "celebration_date": "2026-05-22",
    "month_no": 5,
    "day_no": 22,
    "category": "Çevre & Doğa",
    "hashtags": [
      "#BiyocesitlilikGunu",
      "#BiodiversityDay",
      "#DogayiKoru",
      "#TurlerYokOlmasin"
    ],
    "affiliate_keywords": [
      "kuş yemliği bahçe tipi",
      "endemik bitkiler kitabı türkiye",
      "doğa günlüğü"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000019",
    "slug": "dunya-tutunsuz-gunu",
    "title": "31 Mayıs Dünya Tütünsüz Günü",
    "description": "Tütün salgınının yol açtığı ölümlere dikkat çeken ve dumansız bir dünya hedefleyen DSÖ günü.",
    "content": "## 31 Mayıs Dünya Tütünsüz Günü Nedir?\nDünya Sağlık Örgütü tarafından tütün tüketimini azaltmak ve pasif içiciliği önlemek için 1987'de kabul edilmiştir.\n\n### Tarihçesi ve Önemi\nDünya Sağlık Örgütü tarafından tütün tüketimini azaltmak ve pasif içiciliği önlemek için 1987'de kabul edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 31 Mayıs Dünya Tütünsüz Günü Nasıl Kutlanır?\n1. Bugün 24 saat boyunca sigara içmeyin ve bırakmaya ilk adımı atın.\n2. Pasif içiciliğin zararlarından çocukları koruyun.\n3. Dumansız alanları destekleyin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Nefes al, hayatı hisset! 31 Mayıs Dünya Tütünsüz Günü'nde temiz bir havaya adım at. 🚭🫁💚\"\n* \"31 Mayıs Dünya Tütünsüz Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #TutunsuzGun #WorldNoTobaccoDay #DumansizHava\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-tutunsuz-gunu\"",
    "celebration_date": "2026-05-31",
    "month_no": 5,
    "day_no": 31,
    "category": "Sağlık",
    "hashtags": [
      "#TutunsuzGun",
      "#WorldNoTobaccoDay",
      "#DumansizHava",
      "#SigarayiBirak"
    ],
    "affiliate_keywords": [
      "nefes egzersizi cihazı",
      "stres topu seti",
      "bitki çayı rahatlatıcı"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000020",
    "slug": "dunya-cocuk-gunu",
    "title": "1 Haziran Dünya Çocuk Günü",
    "description": "Çocukların refahını, güvenliğini ve mutluluğunu kutlayan uluslararası çocuk günü.",
    "content": "## 1 Haziran Dünya Çocuk Günü Nedir?\n1925 yılında Cenevre Çocukların Refahı Dünya Konferansı'nda ilan edilen ilk uluslararası çocuk günüdür.\n\n### Tarihçesi ve Önemi\n1925 yılında Cenevre Çocukların Refahı Dünya Konferansı'nda ilan edilen ilk uluslararası çocuk günüdür. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 1 Haziran Dünya Çocuk Günü Nasıl Kutlanır?\n1. Bir çocuğu sevindirin ve ona hediye verin.\n2. Çocukların oyun ve eğlence hakkına saygı gösterin.\n3. İhtiyaç sahibi çocuklara destek olun.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Dünya çocukların güldüğü kadar güzeldir! 1 Haziran Dünya Çocuk Günü kutlu olsun! 🎈👶👧\"\n* \"1 Haziran Dünya Çocuk Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #1Haziran #DunyaCocukGunu #CocuklarGulsun\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-cocuk-gunu\"",
    "celebration_date": "2026-06-01",
    "month_no": 6,
    "day_no": 1,
    "category": "Farkındalık",
    "hashtags": [
      "#1Haziran",
      "#DunyaCocukGunu",
      "#CocuklarGulsun",
      "#CocukHaklari"
    ],
    "affiliate_keywords": [
      "akıl ve zeka oyunları çocuk",
      "scooter çocuk 3 tekerlekli",
      "çocuk hikaye kitabı seti"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000021",
    "slug": "turk-isaret-dili-gunu",
    "title": "7 Haziran Türk İşaret Dili Günü",
    "description": "İşitme engelli bireylerin iletişim dili olan Türk İşaret Dili'nin yasal olarak tanındığı gün.",
    "content": "## 7 Haziran Türk İşaret Dili Günü Nedir?\n5378 sayılı Engelliler Kanunu'nda Türk İşaret Dili'nin resmi olarak yer aldığı 7 Haziran 2005 tarihinin anısına kutlanır.\n\n### Tarihçesi ve Önemi\n5378 sayılı Engelliler Kanunu'nda Türk İşaret Dili'nin resmi olarak yer aldığı 7 Haziran 2005 tarihinin anısına kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 7 Haziran Türk İşaret Dili Günü Nasıl Kutlanır?\n1. Türk İşaret Dili'nde temel selamlaşma ve teşekkür kelimelerini öğrenin.\n2. Kamusal yayınlarda işaret dili çevirisi talep edin.\n3. İşitme engellilerin toplumsal hayata katılımını destekleyin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Ellerimiz konuşsun, kalplerimiz buluşsun! 7 Haziran Türk İşaret Dili Günü kutlu olsun. 🤟🤲✨\"\n* \"7 Haziran Türk İşaret Dili Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #TurkIsaretDiliGunu #TID #IsitmeEngelliler\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #turk-isaret-dili-gunu\"",
    "celebration_date": "2026-06-07",
    "month_no": 6,
    "day_no": 7,
    "category": "Farkındalık",
    "hashtags": [
      "#TurkIsaretDiliGunu",
      "#TID",
      "#IsitmeEngelliler",
      "#EngelsizIletisim"
    ],
    "affiliate_keywords": [
      "türk işaret dili öğrenme kitabı",
      "işitme cihazı pili",
      "görsel sözlük kartları"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000022",
    "slug": "dunya-yoga-gunu",
    "title": "21 Haziran Dünya Yoga Günü",
    "description": "Beden, zihin ve ruh dengesini kuran kadim yoga öğretisinin evrensel faydalarını kutlayan BM günü.",
    "content": "## 21 Haziran Dünya Yoga Günü Nedir?\n2014 yılında BM Genel Kurulu tarafından kabul edilen gün, içsel huzur ve bütünsel sağlığı teşvik eder.\n\n### Tarihçesi ve Önemi\n2014 yılında BM Genel Kurulu tarafından kabul edilen gün, içsel huzur ve bütünsel sağlığı teşvik eder. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 21 Haziran Dünya Yoga Günü Nasıl Kutlanır?\n1. Açık havada veya evinizde 20 dakikalık bir yoga seansı yapın.\n2. Derin nefes egzersizleriyle zihninizi dinlendirin.\n3. Bedeninizin esnekliğine kulak verin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"İçindeki huzuru keşfet. 21 Haziran Dünya Yoga Günü kutlu olsun! 🧘‍♀️🕉️🧘‍♂️\"\n* \"21 Haziran Dünya Yoga Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaYogaGunu #YogaDay #ZihinBedenRuh\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-yoga-gunu\"",
    "celebration_date": "2026-06-21",
    "month_no": 6,
    "day_no": 21,
    "category": "Sağlık",
    "hashtags": [
      "#DunyaYogaGunu",
      "#YogaDay",
      "#ZihinBedenRuh",
      "#Namaste"
    ],
    "affiliate_keywords": [
      "yoga matı kaydırmaz tpe",
      "yoga bloğu köpük",
      "meditasyon çanı",
      "yoga taytı"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000023",
    "slug": "dunya-sosyal-medya-gunu",
    "title": "30 Haziran Dünya Sosyal Medya Günü",
    "description": "İnsanları kıtalar ötesinde birbirine bağlayan dijital iletişim devrimini kutlayan küresel gün.",
    "content": "## 30 Haziran Dünya Sosyal Medya Günü Nedir?\n2010 yılında Mashable tarafından sosyal medyanın dünyayı küresel bir köye dönüştürmesini kutlamak için başlatılmıştır.\n\n### Tarihçesi ve Önemi\n2010 yılında Mashable tarafından sosyal medyanın dünyayı küresel bir köye dönüştürmesini kutlamak için başlatılmıştır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 30 Haziran Dünya Sosyal Medya Günü Nasıl Kutlanır?\n1. Sosyal medyada pozitif ve ilham verici içerikler üretin.\n2. Uzun süredir görüşmediğiniz bir eski dostunuza mesaj atın.\n3. Sosyal medya kullanım sürenizi bilinçli yönetin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Mesafeleri kaldıran, sesimizi dünyaya duyuran platformların günü kutlu olsun! 30 Haziran Dünya Sosyal Medya Günü! 📱🌐💬\"\n* \"30 Haziran Dünya Sosyal Medya Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #SosyalMedyaGunu #SocialMediaDay #DijitalDunya\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-sosyal-medya-gunu\"",
    "celebration_date": "2026-06-30",
    "month_no": 6,
    "day_no": 30,
    "category": "Eğlence",
    "hashtags": [
      "#SosyalMedyaGunu",
      "#SocialMediaDay",
      "#DijitalDunya",
      "#Baglanti"
    ],
    "affiliate_keywords": [
      "ring light halka ışık tripodlu",
      "yaka mikrofonu kablosuz",
      "telefon sabitleyici gimbal"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000024",
    "slug": "uluslararasi-dostluk-gunu",
    "title": "30 Temmuz Uluslararası Dostluk Günü",
    "description": "Halklar, ülkeler, kültürler ve bireyler arasındaki dostluk köprülerinin barış getireceğini savunan BM günü.",
    "content": "## 30 Temmuz Uluslararası Dostluk Günü Nedir?\nBirleşmiş Milletler tarafından toplumlar arasında güven ve dayanışma tesis etmek için ilan edilmiştir.\n\n### Tarihçesi ve Önemi\nBirleşmiş Milletler tarafından toplumlar arasında güven ve dayanışma tesis etmek için ilan edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 30 Temmuz Uluslararası Dostluk Günü Nasıl Kutlanır?\n1. En yakın arkadaşınızı arayıp ona değer verdiğinizi söyleyin.\n2. Birlikte kahve için veya anılarınızı yad edin.\n3. Yeni insanlarla samimi dostluklar kurun.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"İyi bir dost dünyalara bedeldir. Tüm vefakar dostların 30 Temmuz Uluslararası Dostluk Günü kutlu olsun! 🤝☕❤️\"\n* \"30 Temmuz Uluslararası Dostluk Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DostlukGunu #FriendshipDay #CanDostum\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #uluslararasi-dostluk-gunu\"",
    "celebration_date": "2026-07-30",
    "month_no": 7,
    "day_no": 30,
    "category": "Eğlence",
    "hashtags": [
      "#DostlukGunu",
      "#FriendshipDay",
      "#CanDostum",
      "#Dostluk"
    ],
    "affiliate_keywords": [
      "arkadaşlık bilekliği çift",
      "anı albümü yapışkanlı",
      "arkadaşa esprili hediye"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000025",
    "slug": "dunya-insani-yardim-gunu",
    "title": "19 Ağustos Dünya İnsani Yardım Günü",
    "description": "Kriz ve savaş bölgelerinde canları pahasına insanlara yardım eli uzatan yardım çalışanlarını anma günü.",
    "content": "## 19 Ağustos Dünya İnsani Yardım Günü Nedir?\n2003 yılında BM Bağdat merkezine yapılan saldırıda hayatını kaybeden 22 yardım görevlisinin anısına kutlanır.\n\n### Tarihçesi ve Önemi\n2003 yılında BM Bağdat merkezine yapılan saldırıda hayatını kaybeden 22 yardım görevlisinin anısına kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 19 Ağustos Dünya İnsani Yardım Günü Nasıl Kutlanır?\n1. Güvenilir yardım kuruluşlarına bağışta bulunun.\n2. Gönüllü yardım projelerinde aktif rol alın.\n3. İnsani değerleri savunun.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"İnsanlık yardımlaşmayla yaşar. Tüm fedakar insani yardım çalışanlarına sonsuz minnetle! 19 Ağustos kutlu olsun. 🤝🕊️\"\n* \"19 Ağustos Dünya İnsani Yardım Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #InsaniYardimGunu #WorldHumanitarianDay #YardimEli\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-insani-yardim-gunu\"",
    "celebration_date": "2026-08-19",
    "month_no": 8,
    "day_no": 19,
    "category": "Uluslararası",
    "hashtags": [
      "#InsaniYardimGunu",
      "#WorldHumanitarianDay",
      "#YardimEli",
      "#Dayanisma"
    ],
    "affiliate_keywords": [
      "kızılay bağış kartı",
      "yardım vakfı sertifikası",
      "çelik matara"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000026",
    "slug": "gaziler-gunu",
    "title": "19 Eylül Gaziler Günü",
    "description": "Mustafa Kemal Atatürk'e 'Gazi' unvanı ve Mareşal rütbesinin verildiği günün anısına kutlanan milli vefa günü.",
    "content": "## 19 Eylül Gaziler Günü Nedir?\n19 Eylül 1921'de Sakarya Meydan Muharebesi sonrası TBMM tarafından Atatürk'e Gazilik unvanı tevcih edilmiştir.\n\n### Tarihçesi ve Önemi\n19 Eylül 1921'de Sakarya Meydan Muharebesi sonrası TBMM tarafından Atatürk'e Gazilik unvanı tevcih edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 19 Eylül Gaziler Günü Nasıl Kutlanır?\n1. Muharip gazi derneklerini ziyaret edin.\n2. Kahraman gazilerimize şükran ve saygılarınızı sunun.\n3. Vatan fedakarlıklarını gençlere aktarın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Şehit nurlanmış, gazi onurlanmış askerdir. Başta Gazi Mustafa Kemal Atatürk olmak üzere tüm gazilerimize minnetle! 🇹🇷🎖️\"\n* \"19 Eylül Gaziler Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #GazilerGunu #19Eylul #KahramanGazilerimiz\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #gaziler-gunu\"",
    "celebration_date": "2026-09-19",
    "month_no": 9,
    "day_no": 19,
    "category": "Resmi",
    "hashtags": [
      "#GazilerGunu",
      "#19Eylul",
      "#KahramanGazilerimiz",
      "#Ataturk"
    ],
    "affiliate_keywords": [
      "türk bayrağı masa üstü pirinç",
      "atatürk biyografisi ciltli",
      "rozet"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000027",
    "slug": "dunya-turizm-gunu",
    "title": "27 Eylül Dünya Turizm Günü",
    "description": "Farklı kültürleri tanıma, seyahat özgürlüğü ve sürdürülebilir turizmin ekonomik gücünü kutlayan BM günü.",
    "content": "## 27 Eylül Dünya Turizm Günü Nedir?\nDünya Turizm Örgütü (UNWTO) tüzüğünün kabul edildiği gün olan 27 Eylül, küresel seyahat bilincini artırır.\n\n### Tarihçesi ve Önemi\nDünya Turizm Örgütü (UNWTO) tüzüğünün kabul edildiği gün olan 27 Eylül, küresel seyahat bilincini artırır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 27 Eylül Dünya Turizm Günü Nasıl Kutlanır?\n1. Yeni bir şehri veya tarihi bir mekanı keşfe çıkın.\n2. Yerel esnafı ve eko-turizmi destekleyin.\n3. Gezdiğiniz yerlerin doğasına ve kültürüne saygı gösterin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Dünya bir kitaptır ve seyahat etmeyenler sadece bir sayfasını okur. 27 Eylül Dünya Turizm Günü kutlu olsun! ✈️🗺️🧳\"\n* \"27 Eylül Dünya Turizm Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaTurizmGunu #WorldTourismDay #Gezgin\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-turizm-gunu\"",
    "celebration_date": "2026-09-27",
    "month_no": 9,
    "day_no": 27,
    "category": "Kültür & Sanat",
    "hashtags": [
      "#DunyaTurizmGunu",
      "#WorldTourismDay",
      "#Gezgin",
      "#Seyahat"
    ],
    "affiliate_keywords": [
      "seyahat sırt çantası kabin boy",
      "boyun yastığı hafızalı sünger",
      "evrensel priz dönüştürücü"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000028",
    "slug": "dunya-yaslilar-gunu",
    "title": "1 Ekim Dünya Yaşlılar Günü",
    "description": "Tecrübeleriyle topluma ışık tutan kıymetli büyüklerimizin haklarını ve refahını koruyan BM günü.",
    "content": "## 1 Ekim Dünya Yaşlılar Günü Nedir?\nBirleşmiş Milletler tarafından yaşlanan nüfusun haklarına, bakımına ve kuşaklar arası dayanışmaya dikkat çekmek için ilan edilmiştir.\n\n### Tarihçesi ve Önemi\nBirleşmiş Milletler tarafından yaşlanan nüfusun haklarına, bakımına ve kuşaklar arası dayanışmaya dikkat çekmek için ilan edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 1 Ekim Dünya Yaşlılar Günü Nasıl Kutlanır?\n1. Ailenizdeki ve çevrenizdeki yaşlıları ziyaret edip ellerini öpün.\n2. Huzurevlerine ziyarette bulunun.\n3. Onların hayat tecrübelerini ve hatıralarını dinleyin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Büyüklerimiz geçmişimizin hafızası, geleceğimizin duasıdır. 1 Ekim Dünya Yaşlılar Günü kutlu olsun! 👵🧓🤍\"\n* \"1 Ekim Dünya Yaşlılar Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaYaslilarGunu #BuyuklerimizeSaygi #YasliHaklari\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-yaslilar-gunu\"",
    "celebration_date": "2026-10-01",
    "month_no": 10,
    "day_no": 1,
    "category": "Farkındalık",
    "hashtags": [
      "#DunyaYaslilarGunu",
      "#BuyuklerimizeSaygi",
      "#YasliHaklari",
      "#1Ekim"
    ],
    "affiliate_keywords": [
      "ortopedik baston ışıklı",
      "yaşlılar için tansiyon aleti konuşan",
      "ısıtmalı ayak masaj aleti"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000029",
    "slug": "dunya-ogretmenler-gunu-unesco",
    "title": "5 Ekim Dünya Öğretmenler Günü (UNESCO)",
    "description": "Dünya genelinde öğretmenlerin statüsü ve haklarını savunan UNESCO ve ILO ortak kutlama günü.",
    "content": "## 5 Ekim Dünya Öğretmenler Günü (UNESCO) Nedir?\n1966 yılında Öğretmenlerin Statüsüne İlişkin Tavsiye Kararı'nın kabul edildiği gün olup tüm dünyada eğitimcileri onurlandırır.\n\n### Tarihçesi ve Önemi\n1966 yılında Öğretmenlerin Statüsüne İlişkin Tavsiye Kararı'nın kabul edildiği gün olup tüm dünyada eğitimcileri onurlandırır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 5 Ekim Dünya Öğretmenler Günü (UNESCO) Nasıl Kutlanır?\n1. Dünyanın dört bir yanındaki öğretmenlerin emeğini takdir edin.\n2. Eğitime bütçe ayrılmasını destekleyin.\n3. Öğretmenlerinize mesaj gönderin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Karanlığı aydınlatan tüm fedakar öğretmenlerimizin 5 Ekim Dünya Öğretmenler Günü kutlu olsun! 📚🌍🧑‍🏫\"\n* \"5 Ekim Dünya Öğretmenler Günü (UNESCO) kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaOgretmenlerGunu #WorldTeachersDay #5Ekim\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-ogretmenler-gunu-unesco\"",
    "celebration_date": "2026-10-05",
    "month_no": 10,
    "day_no": 5,
    "category": "Mesleki",
    "hashtags": [
      "#DunyaOgretmenlerGunu",
      "#WorldTeachersDay",
      "#5Ekim",
      "#Ogretmen"
    ],
    "affiliate_keywords": [
      "lazer sunum kumandası",
      "öğretmen ajandası 2026",
      "isme özel kupa"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000030",
    "slug": "dunya-gida-gunu",
    "title": "16 Ekim Dünya Gıda Günü",
    "description": "Açlıkla mücadele, sürdürülebilir tarım ve gıda israfını önleme bilincini artıran FAO günü.",
    "content": "## 16 Ekim Dünya Gıda Günü Nedir?\n1945 yılında BM Gıda ve Tarım Örgütü'nün (FAO) kuruluş yıl dönümünde herkese yeterli ve güvenli gıda hakkını savunur.\n\n### Tarihçesi ve Önemi\n1945 yılında BM Gıda ve Tarım Örgütü'nün (FAO) kuruluş yıl dönümünde herkese yeterli ve güvenli gıda hakkını savunur. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 16 Ekim Dünya Gıda Günü Nasıl Kutlanır?\n1. Tabağınıza yiyebileceğiniz kadar yemek alın, israfı önleyin.\n2. Artan yemekleri değerlendirme tarifleri uygulayın.\n3. Gıda bankalarına ve aşevlerine bağış yapın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Gıda haktır, israf etme! 16 Ekim Dünya Gıda Günü'nde soframızı ve dünyamızı adaletle paylaşalım. 🌾🍞🍲\"\n* \"16 Ekim Dünya Gıda Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaGidaGunu #WorldFoodDay #GidaIsrafinaSon\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-gida-gunu\"",
    "celebration_date": "2026-10-16",
    "month_no": 10,
    "day_no": 16,
    "category": "Çevre & Doğa",
    "hashtags": [
      "#DunyaGidaGunu",
      "#WorldFoodDay",
      "#GidaIsrafinaSon",
      "#AcligaSon"
    ],
    "affiliate_keywords": [
      "vakumlu saklama kabı seti",
      "hava geçirmez kavanoz",
      "gıda kurutucu makine"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000031",
    "slug": "dunya-tasarruf-gunu",
    "title": "31 Ekim Dünya Tasarruf Günü",
    "description": "Finansal okuryazarlık, para biriktirme ve kaynakları verimli kullanma alışkanlığını teşvik eden gün.",
    "content": "## 31 Ekim Dünya Tasarruf Günü Nedir?\n1924 yılında Milano'da yapılan 1. Uluslararası Tasarruf Bankası Kongresi'nde tasarruf bilincini aşılamak için kabul edilmiştir.\n\n### Tarihçesi ve Önemi\n1924 yılında Milano'da yapılan 1. Uluslararası Tasarruf Bankası Kongresi'nde tasarruf bilincini aşılamak için kabul edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 31 Ekim Dünya Tasarruf Günü Nasıl Kutlanır?\n1. Aylık bütçenizi ve gereksiz harcamalarınızı gözden geçirin.\n2. Çocuklara kumbara alıp birikim yapmayı öğretin.\n3. Enerji ve su tüketiminde tasarrufa gidin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Damlaya damlaya göl olur! 31 Ekim Dünya Tasarruf Günü'nde geleceğin için biriktirmeye başla. 🪙💰📈\"\n* \"31 Ekim Dünya Tasarruf Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaTasarrufGunu #Tasarruf #FinansalOkuryazarlik\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-tasarruf-gunu\"",
    "celebration_date": "2026-10-31",
    "month_no": 10,
    "day_no": 31,
    "category": "Eğlence",
    "hashtags": [
      "#DunyaTasarrufGunu",
      "#Tasarruf",
      "#FinansalOkuryazarlik",
      "#BirimYap"
    ],
    "affiliate_keywords": [
      "dijital para sayan kumbara",
      "finansal özgürlük kitapları",
      "akıllı priz enerji ölçer"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000032",
    "slug": "dunya-sehircilik-gunu",
    "title": "8 Kasım Dünya Şehircilik Günü",
    "description": "Planlı, yaşanabilir, yeşil ve afetlere dayanıklı kentler inşa etme bilincini artıran gün.",
    "content": "## 8 Kasım Dünya Şehircilik Günü Nedir?\n1949 yılında Buenos Aires Üniversitesi profesörü Carlos Maria della Paolera tarafından kent planlamasının önemini anlatmak için başlatılmıştır.\n\n### Tarihçesi ve Önemi\n1949 yılında Buenos Aires Üniversitesi profesörü Carlos Maria della Paolera tarafından kent planlamasının önemini anlatmak için başlatılmıştır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 8 Kasım Dünya Şehircilik Günü Nasıl Kutlanır?\n1. Kentinizdeki yeşil alanların ve bisiklet yollarının artmasını talep edin.\n2. Kentsel dönüşüm ve deprem güvenliği bilincini yaygınlaştırın.\n3. Şehir plancılarına teşekkür edin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Daha yeşil, daha adil ve afetlere dirençli şehirler için 8 Kasım Dünya Şehircilik Günü kutlu olsun! 🏙️🌳🚲\"\n* \"8 Kasım Dünya Şehircilik Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaSehircilikGunu #SehirPlanciligi #YasanabilirKentler\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-sehircilik-gunu\"",
    "celebration_date": "2026-11-08",
    "month_no": 11,
    "day_no": 8,
    "category": "Mesleki",
    "hashtags": [
      "#DunyaSehircilikGunu",
      "#SehirPlanciligi",
      "#YasanabilirKentler",
      "#8Kasim"
    ],
    "affiliate_keywords": [
      "şehir planlama ve mimarlık kitapları",
      "teknik çizim kalemi seti",
      "maket bıçağı seti"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000033",
    "slug": "uluslararasi-hosgoru-gunu",
    "title": "16 Kasım Uluslararası Hoşgörü Günü",
    "description": "Farklılıklara saygı, empati, diyalog ve barış içinde bir arada yaşama kültürünü kutlayan UNESCO günü.",
    "content": "## 16 Kasım Uluslararası Hoşgörü Günü Nedir?\n1995 UNESCO Hoşgörü İlkeleri Bildirgesi'nin imzalanmasıyla nefret söylemi ve ayrımcılıkla mücadele için kabul edilmiştir.\n\n### Tarihçesi ve Önemi\n1995 UNESCO Hoşgörü İlkeleri Bildirgesi'nin imzalanmasıyla nefret söylemi ve ayrımcılıkla mücadele için kabul edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 16 Kasım Uluslararası Hoşgörü Günü Nasıl Kutlanır?\n1. 'Gel, ne olursan ol yine gel' anlayışıyla herkese önyargısız yaklaşın.\n2. Farklı fikirleri sabırla dinleyin.\n3. Hoşgörüyü ve nezaketi yayın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Farklılıklarımız zenginliğimizdir. 16 Kasım Uluslararası Hoşgörü Günü kutlu olsun! 🤝🌈🕊️\"\n* \"16 Kasım Uluslararası Hoşgörü Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #HosgoruGunu #Mevlana #FarkliliklarZenginliktir\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #uluslararasi-hosgoru-gunu\"",
    "celebration_date": "2026-11-16",
    "month_no": 11,
    "day_no": 16,
    "category": "Farkındalık",
    "hashtags": [
      "#HosgoruGunu",
      "#Mevlana",
      "#FarkliliklarZenginliktir",
      "#Empati"
    ],
    "affiliate_keywords": [
      "mevlana mesnevi seti",
      "felsefe ve empati kitapları",
      "meditasyon müziği cd"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000034",
    "slug": "dunya-televizyon-gunu",
    "title": "21 Kasım Dünya Televizyon Günü",
    "description": "Görsel habercilik, kamuoyu oluşturma ve kültürel etkileşimdeki televizyonun gücünü kutlayan BM günü.",
    "content": "## 21 Kasım Dünya Televizyon Günü Nedir?\n1996 yılında 1. Dünya Televizyon Forumu'nun yapıldığı tarih olup medyanın küresel sorunlara dikkat çekme rolünü onurlandırır.\n\n### Tarihçesi ve Önemi\n1996 yılında 1. Dünya Televizyon Forumu'nun yapıldığı tarih olup medyanın küresel sorunlara dikkat çekme rolünü onurlandırır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 21 Kasım Dünya Televizyon Günü Nasıl Kutlanır?\n1. Kaliteli belgeseller ve eğitici programlar izleyin.\n2. Televizyon haberciliğinin tarihini inceleyin.\n3. Ekran sürenizi dengede tutun.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Dünyayı salonumuza getiren ekranın günü! 21 Kasım Dünya Televizyon Günü kutlu olsun! 📺📡🎬\"\n* \"21 Kasım Dünya Televizyon Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #TelevizyonGunu #WorldTelevisionDay #Medya\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-televizyon-gunu\"",
    "celebration_date": "2026-11-21",
    "month_no": 11,
    "day_no": 21,
    "category": "Kültür & Sanat",
    "hashtags": [
      "#TelevizyonGunu",
      "#WorldTelevisionDay",
      "#Medya",
      "#Yayin"
    ],
    "affiliate_keywords": [
      "akıllı tv kumandası",
      "led tv arka aydınlatma ambiyans",
      "soundbar ses sistemi"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000035",
    "slug": "dunya-aids-gunu",
    "title": "1 Aralık Dünya AIDS Günü",
    "description": "HIV/AIDS konusunda doğru bilinci yaymak, ön yargıları kırmak ve hastalara destek olmak için kutlanan küresel gün.",
    "content": "## 1 Aralık Dünya AIDS Günü Nedir?\n1988 yılından bu yana Dünya Sağlık Örgütü öncülüğünde kırmızı kurdele sembolüyle HIV farkındalığı için düzenlenir.\n\n### Tarihçesi ve Önemi\n1988 yılından bu yana Dünya Sağlık Örgütü öncülüğünde kırmızı kurdele sembolüyle HIV farkındalığı için düzenlenir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 1 Aralık Dünya AIDS Günü Nasıl Kutlanır?\n1. HIV'in bulaşma ve korunma yolları hakkında doğru bilgi edinin.\n2. HIV ile yaşayan bireylere karşı ayrımcılığa dur deyin.\n3. Düzenli test yaptırın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Bilinç hayat kurtarır, ön yargı öldürür. 1 Aralık Dünya AIDS Günü'nde farkında olalım. 🎗️❤️\"\n* \"1 Aralık Dünya AIDS Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaAIDSGunu #KirmiziKurdele #FarkindaOl\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-aids-gunu\"",
    "celebration_date": "2026-12-01",
    "month_no": 12,
    "day_no": 1,
    "category": "Sağlık",
    "hashtags": [
      "#DunyaAIDSGunu",
      "#KirmiziKurdele",
      "#FarkindaOl",
      "#OnYargiyiKir"
    ],
    "affiliate_keywords": [
      "kırmızı kurdele yaka iğnesi",
      "bağışıklık güçlendirici vitamin"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000036",
    "slug": "dunya-toprak-gunu",
    "title": "5 Aralık Dünya Toprak Günü",
    "description": "Besinlerimizin yüzde 95'ini sağlayan toprağın erozyondan ve kirlilikten korunması için BM tarafından kutlanır.",
    "content": "## 5 Aralık Dünya Toprak Günü Nedir?\nBM Gıda ve Tarım Örgütü (FAO) tarafından sağlıklı toprakların ve gıda güvenliğinin önemini vurgulamak için ilan edilmiştir.\n\n### Tarihçesi ve Önemi\nBM Gıda ve Tarım Örgütü (FAO) tarafından sağlıklı toprakların ve gıda güvenliğinin önemini vurgulamak için ilan edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 5 Aralık Dünya Toprak Günü Nasıl Kutlanır?\n1. Organik atıklarınızı kompost yaparak toprağa geri kazandırın.\n2. Erozyonla mücadele eden TEMA Vakfı gibi STK'lara destek olun.\n3. Toprağı kimyasallarla kirletmeyin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Toprak varsa hayat var! 5 Aralık Dünya Toprak Günü'nde bereketli toprağımızı koruyalım. 🌱🌍🌾\"\n* \"5 Aralık Dünya Toprak Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaToprakGunu #WorldSoilDay #TopragiKoru\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-toprak-gunu\"",
    "celebration_date": "2026-12-05",
    "month_no": 12,
    "day_no": 5,
    "category": "Çevre & Doğa",
    "hashtags": [
      "#DunyaToprakGunu",
      "#WorldSoilDay",
      "#TopragiKoru",
      "#TEMA"
    ],
    "affiliate_keywords": [
      "organik kompost gübre",
      "solucan gübresi",
      "bahçıvan kürek seti"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000037",
    "slug": "uluslararasi-dag-gunu",
    "title": "11 Aralık Uluslararası Dağ Günü",
    "description": "Tatlı su kaynaklarımızın ve eşsiz dağ biyoçeşitliliğinin korunmasını savunan BM günü.",
    "content": "## 11 Aralık Uluslararası Dağ Günü Nedir?\n2003 yılında BM Genel Kurulu tarafından dağ ekosistemlerinin kırılganlığına ve dağ topluluklarının sürdürülebilirliğine dikkat çekmek için kabul edilmiştir.\n\n### Tarihçesi ve Önemi\n2003 yılında BM Genel Kurulu tarafından dağ ekosistemlerinin kırılganlığına ve dağ topluluklarının sürdürülebilirliğine dikkat çekmek için kabul edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 11 Aralık Uluslararası Dağ Günü Nasıl Kutlanır?\n1. Dağ yürüyüşü veya trekking yapın.\n2. Dağlık bölgelerdeki doğal yaşam alanlarını koruyun.\n3. Dağ köylerinin yerel ürünlerini destekleyin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Göğe uzanan zirvelerimiz doğanın kalbidir. 11 Aralık Uluslararası Dağ Günü kutlu olsun! ⛰️🏔️🌲\"\n* \"11 Aralık Uluslararası Dağ Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #UluslararasiDagGunu #InternationalMountainDay #Daglar\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #uluslararasi-dag-gunu\"",
    "celebration_date": "2026-12-11",
    "month_no": 12,
    "day_no": 11,
    "category": "Çevre & Doğa",
    "hashtags": [
      "#UluslararasiDagGunu",
      "#InternationalMountainDay",
      "#Daglar",
      "#Doga"
    ],
    "affiliate_keywords": [
      "trekking batonları katlanır",
      "termal dağcı çorabı",
      "kamp termos paslanmaz"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000038",
    "slug": "uluslararasi-gocmenler-gunu",
    "title": "18 Aralık Uluslararası Göçmenler Günü",
    "description": "Dünya çapında göçmenlerin insan hakları, emekleri ve toplumsal katkılarını onurlandıran BM günü.",
    "content": "## 18 Aralık Uluslararası Göçmenler Günü Nedir?\n1990'da Tüm Göçmen İşçilerin ve Aile Fertlerinin Haklarının Korunmasına Dair Uluslararası Sözleşme'nin kabul günü anısına kutlanır.\n\n### Tarihçesi ve Önemi\n1990'da Tüm Göçmen İşçilerin ve Aile Fertlerinin Haklarının Korunmasına Dair Uluslararası Sözleşme'nin kabul günü anısına kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 18 Aralık Uluslararası Göçmenler Günü Nasıl Kutlanır?\n1. Göçmenlerin temel insan haklarına ve onuruna saygı duyun.\n2. Irkçılığa ve yabancı düşmanlığına karşı durun.\n3. Farklı kültürlerin topluma kattığı zenginliği takdir edin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Hepimiz aynı gökyüzünün altındayız. 18 Aralık Uluslararası Göçmenler Günü kutlu olsun! 🕊️🌍🤝\"\n* \"18 Aralık Uluslararası Göçmenler Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #GocmenlerGunu #InternationalMigrantsDay #InsanOnuru\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #uluslararasi-gocmenler-gunu\"",
    "celebration_date": "2026-12-18",
    "month_no": 12,
    "day_no": 18,
    "category": "Farkındalık",
    "hashtags": [
      "#GocmenlerGunu",
      "#InternationalMigrantsDay",
      "#InsanOnuru",
      "#Goc"
    ],
    "affiliate_keywords": [
      "kültürlerarası sosyoloji kitapları",
      "dünya dilleri sözlükleri"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000039",
    "slug": "yilbasi",
    "title": "1 Ocak Yılbaşı",
    "description": "Yeni bir yılın başlangıcını simgeleyen ve tüm dünyada umutla kutlanan resmi tatil günü.",
    "content": "## 1 Ocak Yılbaşı Nedir?\nYılbaşı, Miladi takvime göre bir yılın bitip yeni bir yılın başladığı 1 Ocak günüdür. Yeni umutlar, hedefler ve başlangıçlarla tüm dünyada resmi tatil olarak kutlanır.\n\n### Tarihçesi ve Önemi\nYılbaşı, Miladi takvime göre bir yılın bitip yeni bir yılın başladığı 1 Ocak günüdür. Yeni umutlar, hedefler ve başlangıçlarla tüm dünyada resmi tatil olarak kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 1 Ocak Yılbaşı Nasıl Kutlanır?\n1. Aileniz ve dostlarınızla yeni yıl hedeflerinizi paylaşın.\n2. Sevdiklerinize anlamlı tebrik kartları ve hediyeler verin.\n3. Yeni yılda kendinize sağlıklı alışkanlıklar edinin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Yeni yılın size ve sevdiklerinize sağlık, mutluluk ve başarı getirmesini dilerim! Mutlu Yıllar! 🎉✨\"\n* \"1 Ocak Yılbaşı kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #Yilbasi #YeniYil #Hosgeldin2026\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #yilbasi\"",
    "celebration_date": "2026-01-01",
    "month_no": 1,
    "day_no": 1,
    "category": "Resmi",
    "hashtags": [
      "#Yilbasi",
      "#YeniYil",
      "#Hosgeldin2026",
      "#MutluYillar"
    ],
    "affiliate_keywords": [
      "yılbaşı hediyesi",
      "yeni yıl ajandası",
      "kutu kutlama oyunu",
      "kar küresi"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000040",
    "slug": "dunya-braille-gunu",
    "title": "4 Ocak Dünya Braille Günü",
    "description": "Görme engellilerin okuma yazmasını sağlayan kabartma Braille alfabesinin mucidi Louis Braille anısına kutlanır.",
    "content": "## 4 Ocak Dünya Braille Günü Nedir?\nDünya Braille Günü, görme engelli bireylerin bağımsızlığı ve bilgiye erişimi için geliştirilen Braille alfabesinin önemini vurgulamak amacıyla her yıl Louis Braille'in doğum gününde kutlanır.\n\n### Tarihçesi ve Önemi\nDünya Braille Günü, görme engelli bireylerin bağımsızlığı ve bilgiye erişimi için geliştirilen Braille alfabesinin önemini vurgulamak amacıyla her yıl Louis Braille'in doğum gününde kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 4 Ocak Dünya Braille Günü Nasıl Kutlanır?\n1. Çevrenizdeki kamusal alanların ve web sitelerinin görme engelliler için erişilebilirliğini denetleyin.\n2. Braille alfabesi hakkında bilgi edinin.\n3. Görme engelliler kütüphanelerine gönüllü kitap okuma desteği verin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Erişilebilir bir dünya herkesin hakkıdır! 4 Ocak Dünya Braille Günü kutlu olsun. ⠃⠗⠁⠊⠇⠇⠑\"\n* \"4 Ocak Dünya Braille Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #BrailleGunu #GormeEngelliler #Erisilebilirlik\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-braille-gunu\"",
    "celebration_date": "2026-01-04",
    "month_no": 1,
    "day_no": 4,
    "category": "Farkındalık",
    "hashtags": [
      "#BrailleGunu",
      "#GormeEngelliler",
      "#Erisilebilirlik",
      "#Farkindalik"
    ],
    "affiliate_keywords": [
      "braille alfabesi kabartma tablet",
      "sesli kitap aboneliği",
      "akıllı baston",
      "kabartmalı saat"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000041",
    "slug": "calisan-gazeteciler-gunu",
    "title": "10 Ocak Çalışan Gazeteciler Günü",
    "description": "Basın emekçilerinin haklarını güvence altına alan 212 sayılı yasanın kabul edildiği günün anısına kutlanır.",
    "content": "## 10 Ocak Çalışan Gazeteciler Günü Nedir?\n10 Ocak 1961'de yürürlüğe giren ve gazetecilerin çalışma haklarını iyileştiren kanunun ardından Türkiye'de Gazeteciler Günü olarak kutlanmaya başlanmıştır.\n\n### Tarihçesi ve Önemi\n10 Ocak 1961'de yürürlüğe giren ve gazetecilerin çalışma haklarını iyileştiren kanunun ardından Türkiye'de Gazeteciler Günü olarak kutlanmaya başlanmıştır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 10 Ocak Çalışan Gazeteciler Günü Nasıl Kutlanır?\n1. Tarafsız ve cesur haber yapan basın mensuplarını tebrik edin.\n2. Bağımsız gazetecilik platformlarına abonelikle destek olun.\n3. Yerel basının önemini vurgulayan paylaşımlar yapın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Doğru ve tarafsız habercilik uğruna gece gündüz emek veren tüm gazetecilerin 10 Ocak Çalışan Gazeteciler Günü kutlu olsun! 📰📸\"\n* \"10 Ocak Çalışan Gazeteciler Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #CalisanGazetecilerGunu #10Ocak #BasinEmekcileri\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #calisan-gazeteciler-gunu\"",
    "celebration_date": "2026-01-10",
    "month_no": 1,
    "day_no": 10,
    "category": "Mesleki",
    "hashtags": [
      "#CalisanGazetecilerGunu",
      "#10Ocak",
      "#BasinEmekcileri",
      "#OzgurBasin"
    ],
    "affiliate_keywords": [
      "ses kayıt cihazı profesyonel",
      "gazeteci çantası",
      "fotoğraf makinesi tripodu",
      "not defteri deri"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000042",
    "slug": "dunya-sarilma-gunu",
    "title": "21 Ocak Dünya Sarılma Günü",
    "description": "İnsanlar arasındaki sevgi bağını güçlendirmek ve sarılmanın iyileştirici gücünü hatırlatmak için kutlanır.",
    "content": "## 21 Ocak Dünya Sarılma Günü Nedir?\n1986 yılında Kevin Zaborney tarafından başlatılan bu özel gün, insanların birbirine duygusal destek vermesini ve sarılmanın yarattığı oksitosin hormonunun sağlığa faydalarını hatırlatır.\n\n### Tarihçesi ve Önemi\n1986 yılında Kevin Zaborney tarafından başlatılan bu özel gün, insanların birbirine duygusal destek vermesini ve sarılmanın yarattığı oksitosin hormonunun sağlığa faydalarını hatırlatır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 21 Ocak Dünya Sarılma Günü Nasıl Kutlanır?\n1. Ailenize, dostlarınıza ve evcil hayvanlarınıza sımsıkı sarılın.\n2. Uzaktaki sevdiklerinize sanal bir sarılma mesajı gönderin.\n3. Çevrenize tebessüm ve pozitif enerji yayın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Bir sarılma bin ilaca bedeldir! Sevdiklerinize sarılmayı ihmal etmeyin, 21 Ocak Dünya Sarılma Günü kutlu olsun! 🤗❤️\"\n* \"21 Ocak Dünya Sarılma Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaSarilmaGunu #SarilmakGuzeldir #HugDay\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-sarilma-gunu\"",
    "celebration_date": "2026-01-21",
    "month_no": 1,
    "day_no": 21,
    "category": "Eğlence",
    "hashtags": [
      "#DunyaSarilmaGunu",
      "#SarilmakGuzeldir",
      "#HugDay",
      "#Sevgi"
    ],
    "affiliate_keywords": [
      "yumuşak peluş oyuncak",
      "ağırlaştırılmış battaniye",
      "kupa bardak kalpli",
      "sarılma yastığı"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000043",
    "slug": "uluslararasi-egitim-gunu",
    "title": "24 Ocak Uluslararası Eğitim Günü",
    "description": "Barış ve kalkınma için eğitimin vazgeçilmez rolünü kutlamak amacıyla Birleşmiş Milletler tarafından kabul edilen gün.",
    "content": "## 24 Ocak Uluslararası Eğitim Günü Nedir?\nUNESCO ve BM Genel Kurulu tarafından ilan edilen gün, dünyadaki tüm çocukların eşit ve kaliteli eğitime erişim hakkını savunur.\n\n### Tarihçesi ve Önemi\nUNESCO ve BM Genel Kurulu tarafından ilan edilen gün, dünyadaki tüm çocukların eşit ve kaliteli eğitime erişim hakkını savunur. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 24 Ocak Uluslararası Eğitim Günü Nasıl Kutlanır?\n1. İhtiyaç sahibi okullara ve öğrencilere kırtasiye/kitap bağışında bulunun.\n2. Eğitimin fırsat eşitliği üzerindeki etkilerini tartışın.\n3. Kendinize yeni bir öğrenme hedefi belirleyin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Eğitim dünyayı değiştirebilecek en güçlü silahtır. 24 Ocak Uluslararası Eğitim Günü kutlu olsun! 📚🎓\"\n* \"24 Ocak Uluslararası Eğitim Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #EgitimGunu #EducationDay #NitelikliEgitim\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #uluslararasi-egitim-gunu\"",
    "celebration_date": "2026-01-24",
    "month_no": 1,
    "day_no": 24,
    "category": "Farkındalık",
    "hashtags": [
      "#EgitimGunu",
      "#EducationDay",
      "#NitelikliEgitim",
      "#Gelecek"
    ],
    "affiliate_keywords": [
      "eğitici tablet çocuk",
      "dünya atlası",
      "online eğitim kursu",
      "çalışma masası lambası"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000044",
    "slug": "veri-koruma-gunu",
    "title": "28 Ocak Veri Koruma Günü",
    "description": "Dijital çağda kişisel verilerin gizliliği ve siber güvenlik bilincini artırmak amacıyla kutlanan küresel gün.",
    "content": "## 28 Ocak Veri Koruma Günü Nedir?\nAvrupa Konseyi'nin 108 sayılı Veri Koruma Sözleşmesi'nin imzalandığı günün anısına dijital hakları savunmak için kutlanır.\n\n### Tarihçesi ve Önemi\nAvrupa Konseyi'nin 108 sayılı Veri Koruma Sözleşmesi'nin imzalandığı günün anısına dijital hakları savunmak için kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 28 Ocak Veri Koruma Günü Nasıl Kutlanır?\n1. Hesap şifrelerinizi iki aşamalı doğrulama (2FA) ile güçlendirin.\n2. İnternette paylaştığınız kişisel verileri gözden geçirin.\n3. Sosyal medya gizlilik ayarlarınızı kontrol edin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Verileriniz sizin dijital kimliğinizdir, koruyun! 28 Ocak Veri Koruma Günü kutlu olsun. 🔒💻\"\n* \"28 Ocak Veri Koruma Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #VeriKorumaGunu #KVKK #SiberGuvenlik\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #veri-koruma-gunu\"",
    "celebration_date": "2026-01-28",
    "month_no": 1,
    "day_no": 28,
    "category": "Farkındalık",
    "hashtags": [
      "#VeriKorumaGunu",
      "#KVKK",
      "#SiberGuvenlik",
      "#DataPrivacy"
    ],
    "affiliate_keywords": [
      "şifreli flash bellek",
      "donanım cüzdanı",
      "webcam gizlilik kapağı",
      "vpn aboneliği"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000045",
    "slug": "dunya-kanser-gunu",
    "title": "4 Şubat Dünya Kanser Günü",
    "description": "Kanser konusunda küresel farkındalık oluşturmak, erken teşhisin hayat kurtardığını hatırlatmak için düzenlenir.",
    "content": "## 4 Şubat Dünya Kanser Günü Nedir?\nUluslararası Kanser Kontrol Örgütü (UICC) öncülüğünde her yıl düzenlenen küresel bir farkındalık günüdür. Kanser türlerinin erken teşhisle tedavi edilebilirliğine odaklanır.\n\n### Tarihçesi ve Önemi\nUluslararası Kanser Kontrol Örgütü (UICC) öncülüğünde her yıl düzenlenen küresel bir farkındalık günüdür. Kanser türlerinin erken teşhisle tedavi edilebilirliğine odaklanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 4 Şubat Dünya Kanser Günü Nasıl Kutlanır?\n1. Düzenli sağlık taramalarınızı ve kontrollerinizi yaptırın.\n2. Sağlıklı beslenme ve hareketli yaşam tarzını benimseyin.\n3. Kanserle mücadele eden vakıf ve derneklere destek olun.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Korkma, farkında ol! Erken teşhis hayat kurtarır. 4 Şubat Dünya Kanser Günü'nde sağlığımıza sahip çıkalım. 🎗️💪\"\n* \"4 Şubat Dünya Kanser Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaKanserGunu #ErkenTeshisHayatKurtarir #KanserleMucadele\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kanser-gunu\"",
    "celebration_date": "2026-02-04",
    "month_no": 2,
    "day_no": 4,
    "category": "Sağlık",
    "hashtags": [
      "#DunyaKanserGunu",
      "#ErkenTeshisHayatKurtarir",
      "#KanserleMucadele",
      "#Saglik"
    ],
    "affiliate_keywords": [
      "sağlıklı beslenme kitabı",
      "antioksidan yeşil çay",
      "spor matı",
      "su matarası"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000046",
    "slug": "sigarayi-birakma-gunu",
    "title": "9 Şubat Dünya Sigarayı Bırakma Günü",
    "description": "Tütün bağımlılığının zararlarına dikkat çekmek ve dumansız hava sahasını desteklemek amacıyla kutlanır.",
    "content": "## 9 Şubat Dünya Sigarayı Bırakma Günü Nedir?\nDünya Sağlık Örgütü tarafından tütün kullanımının azaltılması ve sigarasız bir yaşama teşvik etmek için ilan edilen gündür.\n\n### Tarihçesi ve Önemi\nDünya Sağlık Örgütü tarafından tütün kullanımının azaltılması ve sigarasız bir yaşama teşvik etmek için ilan edilen gündür. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 9 Şubat Dünya Sigarayı Bırakma Günü Nasıl Kutlanır?\n1. Bugün sigarayı bırakmak için kesin bir karar alın ve tarih belirleyin.\n2. Sigara bırakma polikliniklerinden profesyonel destek alın.\n3. Sevdiklerinizi bırakmaları konusunda motive edin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Ciğerlerine ve geleceğine bir şans ver! 9 Şubat Dünya Sigarayı Bırakma Günü'nde temiz bir nefes al. 🚭🫁\"\n* \"9 Şubat Dünya Sigarayı Bırakma Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #SigarayiBirakmaGunu #DumansizHavaSahasi #SigarayiBirak\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #sigarayi-birakma-gunu\"",
    "celebration_date": "2026-02-09",
    "month_no": 2,
    "day_no": 9,
    "category": "Sağlık",
    "hashtags": [
      "#SigarayiBirakmaGunu",
      "#DumansizHavaSahasi",
      "#SigarayiBirak",
      "#SaglikliYasam"
    ],
    "affiliate_keywords": [
      "nikotin sakızı",
      "stres çarkı topu",
      "koşu ayakkabısı",
      "hava temizleyici cihaz"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000047",
    "slug": "bilimde-kadinlar-gunu",
    "title": "11 Şubat Bilimde Kadınlar ve Kız Çocukları Günü",
    "description": "Bilim ve teknoloji alanında kadınların ve kız çocuklarının tam ve eşit erişimini teşvik eden BM günü.",
    "content": "## 11 Şubat Bilimde Kadınlar ve Kız Çocukları Günü Nedir?\nUNESCO ve UN Women ortaklığında kadınların STEM (bilim, teknoloji, mühendislik, matematik) alanlarındaki rolünü güçlendirmek için kutlanır.\n\n### Tarihçesi ve Önemi\nUNESCO ve UN Women ortaklığında kadınların STEM (bilim, teknoloji, mühendislik, matematik) alanlarındaki rolünü güçlendirmek için kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 11 Şubat Bilimde Kadınlar ve Kız Çocukları Günü Nasıl Kutlanır?\n1. Başarılı kadın bilim insanlarının ilham verici hayatlarını çocuklara anlatın.\n2. Kız çocuklarını bilimsel projelere teşvik edin.\n3. Bilimde cinsiyet eşitliğini destekleyin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Bilimin cinsiyeti yoktur! Geleceği aydınlatan tüm kadın bilim insanlarının günü kutlu olsun! 🔬👩‍🔬\"\n* \"11 Şubat Bilimde Kadınlar ve Kız Çocukları Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #BilimdeKadinlar #WomenInScience #KizCocuklari\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #bilimde-kadinlar-gunu\"",
    "celebration_date": "2026-02-11",
    "month_no": 2,
    "day_no": 11,
    "category": "Farkındalık",
    "hashtags": [
      "#BilimdeKadinlar",
      "#WomenInScience",
      "#KizCocuklari",
      "#STEM"
    ],
    "affiliate_keywords": [
      "mikroskop seti bilimsel",
      "marie curie kitabı",
      "robotik kodlama kiti",
      "teleskop başlangıç"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000048",
    "slug": "sevgililer-gunu",
    "title": "14 Şubat Sevgililer Günü",
    "description": "Tüm dünyada sevgi ve aşkın paylaşıldığı, Aziz Valentin'in anısına ithaf edilen romantik kutlama günü.",
    "content": "## 14 Şubat Sevgililer Günü Nedir?\nKökeni Roma dönemine ve Aziz Valentine efsanesine dayanan 14 Şubat Sevgililer Günü, sevginin jestlerle ifade edildiği evrensel gündür.\n\n### Tarihçesi ve Önemi\nKökeni Roma dönemine ve Aziz Valentine efsanesine dayanan 14 Şubat Sevgililer Günü, sevginin jestlerle ifade edildiği evrensel gündür. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 14 Şubat Sevgililer Günü Nasıl Kutlanır?\n1. Sevdiğinize duygularınızı samimiyetle anlatan bir mektup yazın.\n2. Baş başa romantik bir akşam yemeği planlayın.\n3. Birlikte unutulmaz bir anı albümü oluşturun.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Seninle geçen her gün bir bayram! 14 Şubat Sevgililer Günümüz kutlu olsun sevgilim. ❤️🌹\"\n* \"14 Şubat Sevgililer Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #14Subat #SevgililerGunu #ValentinesDay\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #sevgililer-gunu\"",
    "celebration_date": "2026-02-14",
    "month_no": 2,
    "day_no": 14,
    "category": "Eğlence",
    "hashtags": [
      "#14Subat",
      "#SevgililerGunu",
      "#ValentinesDay",
      "#Ask",
      "#Hediye"
    ],
    "affiliate_keywords": [
      "sevgililer günü hediye kutusu",
      "gümüş kolye",
      "çikolata kutusu lüks",
      "akıllı saat unisex"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000049",
    "slug": "dunya-kediler-gunu",
    "title": "17 Şubat Dünya Kediler Günü",
    "description": "Miyavlayan sevimli dostlarımızın yaşam haklarını ve sokak kedilerinin refahını hatırlatan özel gün.",
    "content": "## 17 Şubat Dünya Kediler Günü Nedir?\nİlk kez İtalya'da başlayan ve Avrupa genelinde kabul gören 17 Şubat Kediler Günü, kedilerin bağımsız doğasına ve sokaktaki canlara saygıyı kutlar.\n\n### Tarihçesi ve Önemi\nİlk kez İtalya'da başlayan ve Avrupa genelinde kabul gören 17 Şubat Kediler Günü, kedilerin bağımsız doğasına ve sokaktaki canlara saygıyı kutlar. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 17 Şubat Dünya Kediler Günü Nasıl Kutlanır?\n1. Mahallenizdeki sokak kedilerine bir kap mama ve taze su bırakın.\n2. Evinizdeki kedinize ekstra sevgi ve oyun zamanı ayırın.\n3. Barınaktaki bir kediyi sahiplenmeyi değerlendirin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Pati izleri kalbimizde! Dünyayı güzelleştiren tüm minik dostlarımızın 17 Şubat Dünya Kediler Günü kutlu olsun! 🐾🐱\"\n* \"17 Şubat Dünya Kediler Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaKedilerGunu #CatDay #KediSeverler\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kediler-gunu\"",
    "celebration_date": "2026-02-17",
    "month_no": 2,
    "day_no": 17,
    "category": "Çevre & Doğa",
    "hashtags": [
      "#DunyaKedilerGunu",
      "#CatDay",
      "#KediSeverler",
      "#SatinAlmaSahiplen"
    ],
    "affiliate_keywords": [
      "kedi tırmalama tahtası",
      "kedi ödül maması",
      "otomatik kedi su pınarı",
      "kedi taşıma çantası"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000050",
    "slug": "dunya-sosyal-adalet-gunu",
    "title": "20 Şubat Dünya Sosyal Adalet Günü",
    "description": "Yoksulluk, dışlanma, işsizlik ve eşitsizlikle mücadele ederek adil bir toplum inşasını savunan BM günü.",
    "content": "## 20 Şubat Dünya Sosyal Adalet Günü Nedir?\nBirleşmiş Milletler tarafından ilan edilen gün, tüm insanların onurlu çalışma, sosyal koruma ve adalet içinde yaşaması gerektiğini hatırlatır.\n\n### Tarihçesi ve Önemi\nBirleşmiş Milletler tarafından ilan edilen gün, tüm insanların onurlu çalışma, sosyal koruma ve adalet içinde yaşaması gerektiğini hatırlatır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 20 Şubat Dünya Sosyal Adalet Günü Nasıl Kutlanır?\n1. Toplumdaki dezavantajlı grupların haklarını destekleyin.\n2. Adil ücret ve eşit işe eşit ücret ilkelerini savunun.\n3. Dayanışma ağlarına katılın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Barış ancak adaletle mümkündür. 20 Şubat Dünya Sosyal Adalet Günü kutlu olsun! ⚖️🤝\"\n* \"20 Şubat Dünya Sosyal Adalet Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #SosyalAdaletGunu #Esitlik #Adalet\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-sosyal-adalet-gunu\"",
    "celebration_date": "2026-02-20",
    "month_no": 2,
    "day_no": 20,
    "category": "Farkındalık",
    "hashtags": [
      "#SosyalAdaletGunu",
      "#Esitlik",
      "#Adalet",
      "#SocialJustice"
    ],
    "affiliate_keywords": [
      "insan hakları kitapları",
      "sosyoloji temel eserler",
      "felsefe klasikleri seti"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000051",
    "slug": "dunya-anadili-gunu",
    "title": "21 Şubat Uluslararası Anadili Günü",
    "description": "Dünyadaki tüm dillerin kültürel çeşitliliğini korumak ve çok dilliliği teşvik etmek için UNESCO tarafından kutlanır.",
    "content": "## 21 Şubat Uluslararası Anadili Günü Nedir?\n1952 yılında Bangladeş'te anadili hakkını savunan öğrencilerin anısına UNESCO tarafından 1999'da kabul edilmiş küresel bir gündür.\n\n### Tarihçesi ve Önemi\n1952 yılında Bangladeş'te anadili hakkını savunan öğrencilerin anısına UNESCO tarafından 1999'da kabul edilmiş küresel bir gündür. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 21 Şubat Uluslararası Anadili Günü Nasıl Kutlanır?\n1. Anadilinizdeki zengin deyimleri, atasözlerini ve edebiyatı keşfedin.\n2. Farklı kültürlerin dillerine saygı gösterin.\n3. Kaybolma tehlikesindeki yerel diller hakkında bilgi edinin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Dil, bir milletin hafızasıdır. 21 Şubat Uluslararası Anadili Günü kutlu olsun! 🗣️📖\"\n* \"21 Şubat Uluslararası Anadili Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #AnadiliGunu #MotherLanguageDay #KulturelCesitlilik\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-anadili-gunu\"",
    "celebration_date": "2026-02-21",
    "month_no": 2,
    "day_no": 21,
    "category": "Kültür & Sanat",
    "hashtags": [
      "#AnadiliGunu",
      "#MotherLanguageDay",
      "#KulturelCesitlilik",
      "#Dilimiz"
    ],
    "affiliate_keywords": [
      "türkçe sözlük tdk",
      "dünya edebiyatı klasikleri",
      "etimoloji sözlüğü"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000052",
    "slug": "yesilay-haftasi",
    "title": "1 Mart Yeşilay Haftası",
    "description": "Alkol, uyuşturucu, tütün ve teknoloji bağımlılığıyla mücadeleyi destekleyen ulusal farkındalık haftası.",
    "content": "## 1 Mart Yeşilay Haftası Nedir?\n1920 yılında kurulan Hilal-i Ahdar (Yeşilay) Cemiyeti'nin öncülüğünde bağımlılıklarla mücadele etmek amacıyla her yıl Mart ayının ilk haftasında kutlanır.\n\n### Tarihçesi ve Önemi\n1920 yılında kurulan Hilal-i Ahdar (Yeşilay) Cemiyeti'nin öncülüğünde bağımlılıklarla mücadele etmek amacıyla her yıl Mart ayının ilk haftasında kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 1 Mart Yeşilay Haftası Nasıl Kutlanır?\n1. Yeşilay'ın bağımlılıkla mücadele seminerlerine katılın.\n2. Dijital detoks yaparak ekran sürenizi azaltın.\n3. Çocuklara zararlı alışkanlıklardan uzak durmayı öğretin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Bağımlılıklardan uzak, sağlıklı ve özgür bir yaşam için Yeşilay Haftası kutlu olsun! 🟢🌿\"\n* \"1 Mart Yeşilay Haftası kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #YesilayHaftasi #BagimsizYasa #Yesilay\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #yesilay-haftasi\"",
    "celebration_date": "2026-03-01",
    "month_no": 3,
    "day_no": 1,
    "category": "Sağlık",
    "hashtags": [
      "#YesilayHaftasi",
      "#BagimsizYasa",
      "#Yesilay",
      "#Saglik"
    ],
    "affiliate_keywords": [
      "akıllı bileklik adımsayar",
      "spor matı yoga",
      "sağlıklı yaşam rehberi kitabı"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000053",
    "slug": "dunya-yaban-hayati-gunu",
    "title": "3 Mart Dünya Yaban Hayatı Günü",
    "description": "Nesli tükenmekte olan yabani hayvan ve bitki türlerini koruma bilincini artırmak amacıyla kutlanır.",
    "content": "## 3 Mart Dünya Yaban Hayatı Günü Nedir?\nCITES sözleşmesinin imzalandığı gün olan 3 Mart, vahşi yaşamın korunması ve kaçak avcılıkla mücadele için BM tarafından kabul edilmiştir.\n\n### Tarihçesi ve Önemi\nCITES sözleşmesinin imzalandığı gün olan 3 Mart, vahşi yaşamın korunması ve kaçak avcılıkla mücadele için BM tarafından kabul edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 3 Mart Dünya Yaban Hayatı Günü Nasıl Kutlanır?\n1. Yaban hayatı koruma projelerine destek verin.\n2. Doğal yaşam alanlarını kirletmeyin ve koruyun.\n3. Egzotik hayvan ticaretine karşı bilinçli olun.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Doğa canlılarıyla güzeldir! 3 Mart Dünya Yaban Hayatı Günü'nde tüm türlerin yaşam hakkını koruyalım. 🦁🌿🦉\"\n* \"3 Mart Dünya Yaban Hayatı Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #YabanHayatiGunu #WorldWildlifeDay #DogaDostu\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-yaban-hayati-gunu\"",
    "celebration_date": "2026-03-03",
    "month_no": 3,
    "day_no": 3,
    "category": "Çevre & Doğa",
    "hashtags": [
      "#YabanHayatiGunu",
      "#WorldWildlifeDay",
      "#DogaDostu",
      "#BiyoCesitlilik"
    ],
    "affiliate_keywords": [
      "dürbün doğa gözlem",
      "doğa belgeselleri seti",
      "kamp çadırı",
      "kuş rehberi kitabı"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000054",
    "slug": "dunya-kadinlar-gunu",
    "title": "8 Mart Dünya Kadınlar Günü",
    "description": "Kadınların sosyal, ekonomik, kültürel ve siyasi başarılarını kutlayan ve cinsiyet eşitliğini savunan küresel gün.",
    "content": "## 8 Mart Dünya Kadınlar Günü Nedir?\n1857'de New York'ta hak mücadelesi başlatan kadın işçilerin anısına Birleşmiş Milletler tarafından kabul edilen küresel gündür.\n\n### Tarihçesi ve Önemi\n1857'de New York'ta hak mücadelesi başlatan kadın işçilerin anısına Birleşmiş Milletler tarafından kabul edilen küresel gündür. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 8 Mart Dünya Kadınlar Günü Nasıl Kutlanır?\n1. Kadın girişimcileri ve kadın kooperatiflerini destekleyin.\n2. Çevrenizdeki kadınlara saygı ve sevginizi gösterin.\n3. Eşit haklar için farkındalık yaratın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Dünyayı güzelleştiren, emekleriyle hayat veren tüm güçlü kadınların 8 Mart Dünya Kadınlar Günü kutlu olsun! 🌸💪\"\n* \"8 Mart Dünya Kadınlar Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #8Mart #DunyaKadinlarGunu #GucluKadinlar\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kadinlar-gunu\"",
    "celebration_date": "2026-03-08",
    "month_no": 3,
    "day_no": 8,
    "category": "Uluslararası",
    "hashtags": [
      "#8Mart",
      "#DunyaKadinlarGunu",
      "#GucluKadinlar",
      "#KadinHaklari"
    ],
    "affiliate_keywords": [
      "kadın parfümü",
      "özel hediye seti",
      "orkide saksı çiçeği",
      "tasarım takı kolye"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000055",
    "slug": "istiklal-marsinin-kabulu",
    "title": "12 Mart İstiklal Marşı'nın Kabulü",
    "description": "Mehmet Akif Ersoy'un kaleme aldığı milli marşımızın TBMM tarafından kabul edilişinin anma günü.",
    "content": "## 12 Mart İstiklal Marşı'nın Kabulü Nedir?\n12 Mart 1921'de Türkiye Büyük Millet Meclisi tarafından kabul edilen İstiklal Marşı, milletimizin bağımsızlık azminin ebedi simgesidir.\n\n### Tarihçesi ve Önemi\n12 Mart 1921'de Türkiye Büyük Millet Meclisi tarafından kabul edilen İstiklal Marşı, milletimizin bağımsızlık azminin ebedi simgesidir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 12 Mart İstiklal Marşı'nın Kabulü Nasıl Kutlanır?\n1. İstiklal Marşı'nın 10 kıtasını dikkatle okuyun ve anlamını düşünün.\n2. Mehmet Akif Ersoy'un Safahat eserini inceleyin.\n3. Okullarda düzenlenen anma programlarına katılın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Allah bu millete bir daha İstiklal Marşı yazdırmasın! 12 Mart İstiklal Marşı'nın kabulü kutlu olsun. 🇹🇷📜\"\n* \"12 Mart İstiklal Marşı'nın Kabulü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #12Mart #IstiklalMarsi #MehmetAkifErsoy\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #istiklal-marsinin-kabulu\"",
    "celebration_date": "2026-03-12",
    "month_no": 3,
    "day_no": 12,
    "category": "Resmi",
    "hashtags": [
      "#12Mart",
      "#IstiklalMarsi",
      "#MehmetAkifErsoy",
      "#Korkma"
    ],
    "affiliate_keywords": [
      "safahat özel baskı",
      "mehmet akif ersoy biyografisi",
      "türk bayrağı çerçeveli"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000056",
    "slug": "tip-bayrami",
    "title": "14 Mart Tıp Bayramı",
    "description": "Türkiye'de modern tıp eğitiminin başladığı günün anısına tüm sağlık çalışanlarını onurlandıran gün.",
    "content": "## 14 Mart Tıp Bayramı Nedir?\n14 Mart 1827'de Tıphane-i Amire'nin kuruluşu ve 1919'da tıp öğrencilerinin işgale karşı direnişi anısına Tıp Bayramı olarak kutlanır.\n\n### Tarihçesi ve Önemi\n14 Mart 1827'de Tıphane-i Amire'nin kuruluşu ve 1919'da tıp öğrencilerinin işgale karşı direnişi anısına Tıp Bayramı olarak kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 14 Mart Tıp Bayramı Nasıl Kutlanır?\n1. Doktorlarınıza ve sağlık personeline teşekkür mesajı iletin.\n2. Sağlıkta şiddete karşı farkındalık oluşturun.\n3. Sağlık taramalarınızı ihmal etmeyin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Hayatımızı emanet ettiğimiz fedakar hekimlerimizin ve tüm sağlık çalışanlarımızın 14 Mart Tıp Bayramı kutlu olsun! 🩺🤍\"\n* \"14 Mart Tıp Bayramı kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #TipBayrami #14Mart #DoktorlarimizaTesekkurler\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #tip-bayrami\"",
    "celebration_date": "2026-03-14",
    "month_no": 3,
    "day_no": 14,
    "category": "Sağlık",
    "hashtags": [
      "#TipBayrami",
      "#14Mart",
      "#DoktorlarimizaTesekkurler",
      "#SaglikEmekcileri"
    ],
    "affiliate_keywords": [
      "kişiye özel steteskop",
      "doktor önlüğü kaliteli",
      "medikal hediye kupa",
      "termos doktor"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000057",
    "slug": "pi-gunu",
    "title": "14 Mart Dünya Pi Günü",
    "description": "Matematiksel sabit olan Pi sayısının (3,14) onuruna dünya çapında matematikseverlerin kutladığı gün.",
    "content": "## 14 Mart Dünya Pi Günü Nedir?\nPi sayısı 3.14 olduğu için Mart ayının 14. günü (3/14) Pi Günü olarak kutlanır. Aynı zamanda Albert Einstein'ın doğum günüdür.\n\n### Tarihçesi ve Önemi\nPi sayısı 3.14 olduğu için Mart ayının 14. günü (3/14) Pi Günü olarak kutlanır. Aynı zamanda Albert Einstein'ın doğum günüdür. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 14 Mart Dünya Pi Günü Nasıl Kutlanır?\n1. Pi desenli pasta ve turtalar pişirin.\n2. Pi sayısının basamaklarını ezberleme yarışması yapın.\n3. Matematik belgeselleri izleyin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Sonsuzluğa uzanan sayının günü kutlu olsun! 3,14... Dünya Pi Günü kutlu olsun! 🥧📐\"\n* \"14 Mart Dünya Pi Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #PiGunu #PiDay #Matematik\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #pi-gunu\"",
    "celebration_date": "2026-03-14",
    "month_no": 3,
    "day_no": 14,
    "category": "Eğlence",
    "hashtags": [
      "#PiGunu",
      "#PiDay",
      "#Matematik",
      "#Einstein",
      "#314"
    ],
    "affiliate_keywords": [
      "bilimsel hesap makinesi",
      "pi sayısı tişörtü",
      "matematik bulmaca kitapları",
      "rubik küp"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000058",
    "slug": "canakkale-zaferi",
    "title": "18 Mart Çanakkale Zaferi ve Şehitleri Anma Günü",
    "description": "1915 Çanakkale Deniz Zaferi'nin ve vatanı uğruna can veren aziz şehitlerimizin anıldığı milli gün.",
    "content": "## 18 Mart Çanakkale Zaferi ve Şehitleri Anma Günü Nedir?\n18 Mart 1915'te Türk ordusunun Çanakkale Boğazı'nda yazdığı destansı zaferin ve 'Çanakkale Geçilmez' sözünün tarihe kazındığı gündür.\n\n### Tarihçesi ve Önemi\n18 Mart 1915'te Türk ordusunun Çanakkale Boğazı'nda yazdığı destansı zaferin ve 'Çanakkale Geçilmez' sözünün tarihe kazındığı gündür. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 18 Mart Çanakkale Zaferi ve Şehitleri Anma Günü Nasıl Kutlanır?\n1. Çanakkale şehitliklerini ziyaret edin veya anma törenlerine katılın.\n2. Şehitlerimizin ruhuna dualar okuyun.\n3. Genç nesillere zaferin tarihsel önemini aktarın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Çanakkale Geçilmez! Gazi Mustafa Kemal Atatürk ve tüm Çanakkale kahramanlarımızı rahmet ve minnetle anıyoruz. 🇹🇷🎖️\"\n* \"18 Mart Çanakkale Zaferi ve Şehitleri Anma Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #18Mart #CanakkaleGecilmez #CanakkaleZaferi\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #canakkale-zaferi\"",
    "celebration_date": "2026-03-18",
    "month_no": 3,
    "day_no": 18,
    "category": "Resmi",
    "hashtags": [
      "#18Mart",
      "#CanakkaleGecilmez",
      "#CanakkaleZaferi",
      "#SehitlerimiziAniyoruz"
    ],
    "affiliate_keywords": [
      "çanakkale tarihi kitabı",
      "mustafa kemal atatürk tablosu",
      "türk bayrağı masa üstü"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000059",
    "slug": "dunya-mutluluk-gunu",
    "title": "20 Mart Dünya Mutluluk Günü",
    "description": "Mutluluğun temel bir insan hakkı olduğunu hatırlatmak için Birleşmiş Milletler tarafından kabul edilen gün.",
    "content": "## 20 Mart Dünya Mutluluk Günü Nedir?\nBM Genel Kurulu tarafından 2012 yılında ilan edilen gün, ekonomik büyümenin yanında insan mutluluğunun da ölçülmesi gerektiğini savunur.\n\n### Tarihçesi ve Önemi\nBM Genel Kurulu tarafından 2012 yılında ilan edilen gün, ekonomik büyümenin yanında insan mutluluğunun da ölçülmesi gerektiğini savunur. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 20 Mart Dünya Mutluluk Günü Nasıl Kutlanır?\n1. Bugün en az bir kişiyi nedensizce gülümsetin.\n2. Kendinize sevdiğiniz bir kahve veya tatlı ısmarlayın.\n3. Hayatınızdaki güzel anlara odaklanın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Mutluluk paylaştıkça çoğalır! 20 Mart Dünya Mutluluk Günü'nde yüzünüzden tebessüm eksik olmasın. 😊💛\"\n* \"20 Mart Dünya Mutluluk Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaMutlulukGunu #Mutluluk #Gulumse\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-mutluluk-gunu\"",
    "celebration_date": "2026-03-20",
    "month_no": 3,
    "day_no": 20,
    "category": "Eğlence",
    "hashtags": [
      "#DunyaMutlulukGunu",
      "#Mutluluk",
      "#Gulumse",
      "#HappinessDay"
    ],
    "affiliate_keywords": [
      "pozitif psikoloji kitapları",
      "aroma terapi uçucu yağ",
      "günlük şükür defteri",
      "renkli fincan"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000060",
    "slug": "dunya-ormancilik-gunu",
    "title": "21 Mart Dünya Ormancılık Günü ve Nevruz",
    "description": "Baharın gelişi, doğanın uyanışı ve orman varlığının korunması amacıyla kutlanan köklü bayram.",
    "content": "## 21 Mart Dünya Ormancılık Günü ve Nevruz Nedir?\n21 Mart hem ilkbahar ekinoksunu simgeleyen Nevruz Bayramı hem de FAO tarafından ilan edilen Dünya Ormancılık Günü'dür.\n\n### Tarihçesi ve Önemi\n21 Mart hem ilkbahar ekinoksunu simgeleyen Nevruz Bayramı hem de FAO tarafından ilan edilen Dünya Ormancılık Günü'dür. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 21 Mart Dünya Ormancılık Günü ve Nevruz Nasıl Kutlanır?\n1. Doğaya bir fidan dikin veya TEMA'ya fidan bağışlayın.\n2. Doğa yürüyüşü (trekking) yaparak orman havası alın.\n3. Nevruz ateşi ve bahar etkinliklerine katılın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Doğa yeşeriyor, umutlar yeşeriyor! 21 Mart Dünya Ormancılık Günü ve Nevruz Bayramımız kutlu olsun! 🌱🌸🔥\"\n* \"21 Mart Dünya Ormancılık Günü ve Nevruz kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #OrmancilikGunu #NevruzBayrami #BaharGeldi\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-ormancilik-gunu\"",
    "celebration_date": "2026-03-21",
    "month_no": 3,
    "day_no": 21,
    "category": "Çevre & Doğa",
    "hashtags": [
      "#OrmancilikGunu",
      "#NevruzBayrami",
      "#BaharGeldi",
      "#FidanDik"
    ],
    "affiliate_keywords": [
      "fidan bağışı sertifikası",
      "bahçe bakım seti",
      "budama makası",
      "saksı tohum seti"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000061",
    "slug": "dunya-down-sendromu-gunu",
    "title": "21 Mart Dünya Down Sendromu Farkındalık Günü",
    "description": "+1 farkla dünyayı güzelleştiren bireylerin farkındalığını artırmak amacıyla kutlanan gün.",
    "content": "## 21 Mart Dünya Down Sendromu Farkındalık Günü Nedir?\n21. kromozomun 3 tane olmasından (trizomi 21) esinlenilerek 3. ayın 21. günü Dünya Down Sendromu Günü ilan edilmiştir.\n\n### Tarihçesi ve Önemi\n21. kromozomun 3 tane olmasından (trizomi 21) esinlenilerek 3. ayın 21. günü Dünya Down Sendromu Günü ilan edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 21 Mart Dünya Down Sendromu Farkındalık Günü Nasıl Kutlanır?\n1. Farkındalık için rengarenk farklı çoraplar giyerek sosyal medyada paylaşın.\n2. Down sendromlu bireylerin iş hayatına ve topluma katılımını destekleyin.\n3. Sevgi dolu kalplerine ortak olun.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Down sendromu bir hastalık değil, genetik bir farklılıktır. +1 farkla yanınızdayız! 🧦💙💛\"\n* \"21 Mart Dünya Down Sendromu Farkındalık Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #21Mart #DownSendromu #ArtiBirFarkla\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-down-sendromu-gunu\"",
    "celebration_date": "2026-03-21",
    "month_no": 3,
    "day_no": 21,
    "category": "Farkındalık",
    "hashtags": [
      "#21Mart",
      "#DownSendromu",
      "#ArtiBirFarkla",
      "#GercekDostlar"
    ],
    "affiliate_keywords": [
      "farklı çoraplar renkli set",
      "özel eğitim materyali",
      "duyusal oyun seti"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000062",
    "slug": "dunya-su-gunu",
    "title": "22 Mart Dünya Su Günü",
    "description": "Temiz su kaynaklarının korunması ve su kıtlığı tehlikesine dikkat çekmek için BM öncülüğünde kutlanır.",
    "content": "## 22 Mart Dünya Su Günü Nedir?\n1993 yılında Birleşmiş Milletler tarafından kabul edilen gün, tatlı su kaynaklarının önemine ve su tasarrufuna dikkat çeker.\n\n### Tarihçesi ve Önemi\n1993 yılında Birleşmiş Milletler tarafından kabul edilen gün, tatlı su kaynaklarının önemine ve su tasarrufuna dikkat çeker. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 22 Mart Dünya Su Günü Nasıl Kutlanır?\n1. Diş fırçalarken ve bulaşık yıkarken musluğu açık bırakmayın.\n2. Su tasarruflu başlıklar kullanın.\n3. Su ayak izinizi azaltacak adımlar atın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Su hayattır, boşa akıtma! 22 Mart Dünya Su Günü'nde her damlanın değerini bilelim. 💧🌊\"\n* \"22 Mart Dünya Su Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaSuGunu #WorldWaterDay #SuyuKoru\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-su-gunu\"",
    "celebration_date": "2026-03-22",
    "month_no": 3,
    "day_no": 22,
    "category": "Çevre & Doğa",
    "hashtags": [
      "#DunyaSuGunu",
      "#WorldWaterDay",
      "#SuyuKoru",
      "#GeleceginiKoru"
    ],
    "affiliate_keywords": [
      "su arıtma cihazı filtre",
      "tasarruflu duş başlığı",
      "çelik su matarası",
      "musluk perlatörü"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000063",
    "slug": "dunya-tiyatro-gunu",
    "title": "27 Mart Dünya Tiyatro Günü",
    "description": "Tiyatro sanatının toplumları aydınlatıcı ve birleştirici gücünü kutlamak için 1961'den beri kutlanan sanat günü.",
    "content": "## 27 Mart Dünya Tiyatro Günü Nedir?\nUluslararası Tiyatro Enstitüsü tarafından başlatılan bu özel günde dünya çapında tiyatro bildirileri yayımlanır ve oyunlar sergilenir.\n\n### Tarihçesi ve Önemi\nUluslararası Tiyatro Enstitüsü tarafından başlatılan bu özel günde dünya çapında tiyatro bildirileri yayımlanır ve oyunlar sergilenir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 27 Mart Dünya Tiyatro Günü Nasıl Kutlanır?\n1. Sevdiğiniz bir tiyatro oyununa bilet alıp izleyin.\n2. Yerel ve bağımsız tiyatro topluluklarına destek olun.\n3. Çocukları tiyatro ile tanıştırın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Perdeler hiç kapanmasın! 27 Mart Dünya Tiyatro Günü kutlu olsun. 🎭🎟️\"\n* \"27 Mart Dünya Tiyatro Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaTiyatroGunu #Tiyatro #SahneSanatlari\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-tiyatro-gunu\"",
    "celebration_date": "2026-03-27",
    "month_no": 3,
    "day_no": 27,
    "category": "Kültür & Sanat",
    "hashtags": [
      "#DunyaTiyatroGunu",
      "#Tiyatro",
      "#SahneSanatlari",
      "#27Mart"
    ],
    "affiliate_keywords": [
      "tiyatro oyun metinleri",
      "shakespeare toplu eserleri",
      "dürbün tiyatro tipi",
      "sanat tarihi kitabı"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000064",
    "slug": "dunya-otizm-farkindalik-gunu",
    "title": "2 Nisan Dünya Otizm Farkındalık Günü",
    "description": "Otizm spektrumundaki bireylerin yaşam kalitesini artırmak ve erken teşhis bilincini yaymak için kutlanır.",
    "content": "## 2 Nisan Dünya Otizm Farkındalık Günü Nedir?\nBirleşmiş Milletler tarafından 2007 yılında ilan edilen bu günde dünya çapında anıtlar 'Mavi Işık Yak' kampanyasıyla aydınlatılır.\n\n### Tarihçesi ve Önemi\nBirleşmiş Milletler tarafından 2007 yılında ilan edilen bu günde dünya çapında anıtlar 'Mavi Işık Yak' kampanyasıyla aydınlatılır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 2 Nisan Dünya Otizm Farkındalık Günü Nasıl Kutlanır?\n1. Mavi kıyafet giyerek veya mavi ışık yakarak farkındalığa katılın.\n2. Otizmli bireylerin eğitimi için faaliyet gösteren STK'lara destek olun.\n3. Toplumda hoşgörü ve kabul dilini güçlendirin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Farklıyız, eşitiz, birlikte güçlüyüz! 2 Nisan Dünya Otizm Farkındalık Günü'nde mavi ışık yakıyoruz. 💙🧩\"\n* \"2 Nisan Dünya Otizm Farkındalık Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #OtizmFarkindalikGunu #MaviIsikYak #OtizminFarkindayim\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-otizm-farkindalik-gunu\"",
    "celebration_date": "2026-04-02",
    "month_no": 4,
    "day_no": 2,
    "category": "Sağlık",
    "hashtags": [
      "#OtizmFarkindalikGunu",
      "#MaviIsikYak",
      "#OtizminFarkindayim",
      "#2Nisan"
    ],
    "affiliate_keywords": [
      "mavi tişört",
      "duyusal oda ışığı",
      "otizm eğitim kartları",
      "stres çarkı"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000065",
    "slug": "avukatlar-gunu",
    "title": "5 Nisan Avukatlar Günü",
    "description": "Hak arama özgürlüğünün ve adaletin teminatı olan savunma makamı temsilcilerini onurlandıran gün.",
    "content": "## 5 Nisan Avukatlar Günü Nedir?\n1958 yılında İzmir'de yapılan Türkiye Barolar Birliği toplantısında 5 Nisan tarihi Avukatlar Günü olarak kabul edilmiştir.\n\n### Tarihçesi ve Önemi\n1958 yılında İzmir'de yapılan Türkiye Barolar Birliği toplantısında 5 Nisan tarihi Avukatlar Günü olarak kabul edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 5 Nisan Avukatlar Günü Nasıl Kutlanır?\n1. Avukat dostlarınıza tebrik mesajı gönderin.\n2. Hukukun üstünlüğü ve adil yargılanma hakkına dikkat çekin.\n3. Hak arama bilincini geliştirin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Hukukun üstünlüğü ve adaletin savunucusu tüm avukatlarımızın 5 Nisan Avukatlar Günü kutlu olsun! ⚖️📜\"\n* \"5 Nisan Avukatlar Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #5Nisan #AvukatlarGunu #SavunmaHakki\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #avukatlar-gunu\"",
    "celebration_date": "2026-04-05",
    "month_no": 4,
    "day_no": 5,
    "category": "Mesleki",
    "hashtags": [
      "#5Nisan",
      "#AvukatlarGunu",
      "#SavunmaHakki",
      "#Adalet"
    ],
    "affiliate_keywords": [
      "avukat hediye seti cübbe biblo",
      "adalet heykeli themis",
      "dolma kalem lüks",
      "deri evrak çantası"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000066",
    "slug": "dunya-saglik-gunu",
    "title": "7 Nisan Dünya Sağlık Günü",
    "description": "Dünya Sağlık Örgütü'nün kuruluş yıl dönümünde herkes için erişilebilir sağlık hizmetlerini savunan gün.",
    "content": "## 7 Nisan Dünya Sağlık Günü Nedir?\n1948 yılında Dünya Sağlık Örgütü'nün (WHO) anayasasının yürürlüğe girdiği tarih olup her yıl belirlenen temalarla kutlanır.\n\n### Tarihçesi ve Önemi\n1948 yılında Dünya Sağlık Örgütü'nün (WHO) anayasasının yürürlüğe girdiği tarih olup her yıl belirlenen temalarla kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 7 Nisan Dünya Sağlık Günü Nasıl Kutlanır?\n1. Sağlık kontrollerinizi aksatmayın.\n2. Düzenli yürüyüş ve egzersiz yapmayı alışkanlık haline getirin.\n3. Sağlıklı beslenme düzenine geçin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Sağlık en büyük zenginliktir. 7 Nisan Dünya Sağlık Günü kutlu olsun! 🍎🩺\"\n* \"7 Nisan Dünya Sağlık Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaSaglikGunu #WorldHealthDay #SaglikHerkesIcin\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-saglik-gunu\"",
    "celebration_date": "2026-04-07",
    "month_no": 4,
    "day_no": 7,
    "category": "Sağlık",
    "hashtags": [
      "#DunyaSaglikGunu",
      "#WorldHealthDay",
      "#SaglikHerkesIcin",
      "#SaglikliYasam"
    ],
    "affiliate_keywords": [
      "tansiyon aleti dijital",
      "ateş ölçer temassız",
      "vitamin multivitamin",
      "egzersiz lastiği"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000067",
    "slug": "dunya-sanat-gunu",
    "title": "15 Nisan Dünya Sanat Günü",
    "description": "Leonardo da Vinci'nin doğum gününde sanatsal yaratıcılığı ve özgürlüğü kutlayan uluslararası gün.",
    "content": "## 15 Nisan Dünya Sanat Günü Nedir?\nUluslararası Sanat Derneği'nin Türkiye temsilcisi ressam Bedri Baykam'ın önerisiyle UNESCO tarafından kabul edilen küresel sanat günüdür.\n\n### Tarihçesi ve Önemi\nUluslararası Sanat Derneği'nin Türkiye temsilcisi ressam Bedri Baykam'ın önerisiyle UNESCO tarafından kabul edilen küresel sanat günüdür. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 15 Nisan Dünya Sanat Günü Nasıl Kutlanır?\n1. Bir sanat galerisini veya resim sergisini gezin.\n2. Yeni bir sanatsal hobi edinin (resim, seramik, heykel).\n3. Sanatçıların eserlerini paylaşarak destek olun.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Sanatsız kalan bir milletin hayat damarlarından biri kopmuş demektir. 15 Nisan Dünya Sanat Günü kutlu olsun! 🎨🖌️\"\n* \"15 Nisan Dünya Sanat Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaSanatGunu #WorldArtDay #LeonardoDaVinci\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-sanat-gunu\"",
    "celebration_date": "2026-04-15",
    "month_no": 4,
    "day_no": 15,
    "category": "Kültür & Sanat",
    "hashtags": [
      "#DunyaSanatGunu",
      "#WorldArtDay",
      "#LeonardoDaVinci",
      "#Sanat"
    ],
    "affiliate_keywords": [
      "akrilik boya seti",
      "resim şövalesi",
      "tuval seti",
      "eskiz defteri kaliteli"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000068",
    "slug": "dunya-gunu",
    "title": "22 Nisan Dünya Günü (Earth Day)",
    "description": "Gezegenimizi korumak, iklim krizini önlemek ve doğaya saygı duymak için dünya çapında kutlanan çevre günü.",
    "content": "## 22 Nisan Dünya Günü (Earth Day) Nedir?\n1970 yılında ABD'de çevre kirliliğine karşı 20 milyon insanın katıldığı protestoyla doğmuş ve küresel çevre hareketine dönüşmüştür.\n\n### Tarihçesi ve Önemi\n1970 yılında ABD'de çevre kirliliğine karşı 20 milyon insanın katıldığı protestoyla doğmuş ve küresel çevre hareketine dönüşmüştür. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 22 Nisan Dünya Günü (Earth Day) Nasıl Kutlanır?\n1. Bir günlüğüne aracınızı bırakıp toplu taşıma veya bisiklet kullanın.\n2. Enerji ve plastik tüketiminizi kısıtlayın.\n3. Fidan dikim etkinliklerine katılın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Evimiz Dünya için harekete geçme zamanı! 22 Nisan Dünya Günü kutlu olsun. 🌍🌱\"\n* \"22 Nisan Dünya Günü (Earth Day) kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaGunu #EarthDay #IklimKrizi\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-gunu\"",
    "celebration_date": "2026-04-22",
    "month_no": 4,
    "day_no": 22,
    "category": "Çevre & Doğa",
    "hashtags": [
      "#DunyaGunu",
      "#EarthDay",
      "#IklimKrizi",
      "#GezegenimiziKoru"
    ],
    "affiliate_keywords": [
      "güneş enerjili powerbank",
      "bambu pipet seti",
      "çevre dostu temizlik ürünleri"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000069",
    "slug": "ulusal-egemenlik-ve-cocuk-bayrami",
    "title": "23 Nisan Ulusal Egemenlik ve Çocuk Bayramı",
    "description": "TBMM'nin açılışı ve Atatürk'ün dünya çocuklarına armağan ettiği ilk ve tek çocuk bayramı.",
    "content": "## 23 Nisan Ulusal Egemenlik ve Çocuk Bayramı Nedir?\n23 Nisan 1920'de Ankara'da TBMM açılmış ve milletin egemenliği tescillenmiştir. Dünyadaki tüm çocuklara bayram hediye edilmiştir.\n\n### Tarihçesi ve Önemi\n23 Nisan 1920'de Ankara'da TBMM açılmış ve milletin egemenliği tescillenmiştir. Dünyadaki tüm çocuklara bayram hediye edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 23 Nisan Ulusal Egemenlik ve Çocuk Bayramı Nasıl Kutlanır?\n1. Evleri ve balkonları bayraklarla süsleyin.\n2. Çocuk şenliklerine katılın.\n3. Çocuklara günün anlamını ve Atatürk'ü anlatın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Egemenlik kayıtsız şartsız milletindir! 23 Nisan Ulusal Egemenlik ve Çocuk Bayramımız kutlu olsun! 🇹🇷🎈\"\n* \"23 Nisan Ulusal Egemenlik ve Çocuk Bayramı kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #23Nisan #CocukBayrami #EgemenlikUlusundur\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #ulusal-egemenlik-ve-cocuk-bayrami\"",
    "celebration_date": "2026-04-23",
    "month_no": 4,
    "day_no": 23,
    "category": "Resmi",
    "hashtags": [
      "#23Nisan",
      "#CocukBayrami",
      "#EgemenlikUlusundur",
      "#Ataturk"
    ],
    "affiliate_keywords": [
      "çocuk kostümü",
      "uçurtma seti",
      "çocuk zeka oyunları",
      "türk bayrağı balon"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000070",
    "slug": "dunya-kitap-gunu",
    "title": "23 Nisan Dünya Kitap ve Telif Hakkı Günü",
    "description": "Shakespeare ve Cervantes'in ölüm yıl dönümünde kitap okuma sevgisini ve yazarların haklarını kutlayan gün.",
    "content": "## 23 Nisan Dünya Kitap ve Telif Hakkı Günü Nedir?\nUNESCO tarafından 1995 yılında kitap okumayı teşvik etmek ve telif haklarını korumak amacıyla ilan edilmiştir.\n\n### Tarihçesi ve Önemi\nUNESCO tarafından 1995 yılında kitap okumayı teşvik etmek ve telif haklarını korumak amacıyla ilan edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 23 Nisan Dünya Kitap ve Telif Hakkı Günü Nasıl Kutlanır?\n1. Bir arkadaşınıza en sevdiğiniz kitabı hediye edin.\n2. Yeni bir kitaba başlayın ve her gün 20 sayfa okuyun.\n3. Kütüphaneleri ziyaret edin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Kitaplar sessiz öğretmenlerdir. 23 Nisan Dünya Kitap Günü'nde sayfaların büyüsüne kapılın! 📖✨\"\n* \"23 Nisan Dünya Kitap ve Telif Hakkı Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaKitapGunu #KitapKurdu #OkumakOzgurluktur\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kitap-gunu\"",
    "celebration_date": "2026-04-23",
    "month_no": 4,
    "day_no": 23,
    "category": "Kültür & Sanat",
    "hashtags": [
      "#DunyaKitapGunu",
      "#KitapKurdu",
      "#OkumakOzgurluktur",
      "#Kitap"
    ],
    "affiliate_keywords": [
      "e-kitap okuyucu kılıfı",
      "ahşap kitap ayracı",
      "kitap okuma lambası",
      "roman seti çok satanlar"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000071",
    "slug": "dunya-dans-gunu",
    "title": "29 Nisan Dünya Dans Günü",
    "description": "Bedenin evrensel dili olan dansın coşkusunu kutlamak için modern balenin yaratıcısı Noverre anısına kutlanır.",
    "content": "## 29 Nisan Dünya Dans Günü Nedir?\nUNESCO Uluslararası Dans Komitesi tarafından 1982 yılından bu yana tüm dans türlerini kutlamak amacıyla düzenlenir.\n\n### Tarihçesi ve Önemi\nUNESCO Uluslararası Dans Komitesi tarafından 1982 yılından bu yana tüm dans türlerini kutlamak amacıyla düzenlenir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 29 Nisan Dünya Dans Günü Nasıl Kutlanır?\n1. En sevdiğiniz şarkıyı açıp özgürce dans edin.\n2. Salsa, tango veya zeybek gibi yeni bir dans kursu deneyin.\n3. Dans gösterilerini izleyin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Hayat bir danstır, ritmi yakala! 29 Nisan Dünya Dans Günü kutlu olsun! 💃🕺🎶\"\n* \"29 Nisan Dünya Dans Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaDansGunu #DanceDay #DansEt\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-dans-gunu\"",
    "celebration_date": "2026-04-29",
    "month_no": 4,
    "day_no": 29,
    "category": "Kültür & Sanat",
    "hashtags": [
      "#DunyaDansGunu",
      "#DanceDay",
      "#DansEt",
      "#Sanat"
    ],
    "affiliate_keywords": [
      "dans ayakkabısı",
      "kablosuz kulaklık spor",
      "tayt spor kaliteli",
      "dans kursu kuponu"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000072",
    "slug": "emek-ve-dayanisma-gunu",
    "title": "1 Mayıs Emek ve Dayanışma Günü",
    "description": "İşçi ve emekçilerin hak mücadelelerini onurlandıran, tüm dünyada kutlanan uluslararası resmi tatil günü.",
    "content": "## 1 Mayıs Emek ve Dayanışma Günü Nedir?\n1886 yılında Chicago'da işçilerin 8 saatlik iş günü mücadelesiyle başlayan, emeğin ve alın terinin küresel bayramıdır.\n\n### Tarihçesi ve Önemi\n1886 yılında Chicago'da işçilerin 8 saatlik iş günü mücadelesiyle başlayan, emeğin ve alın terinin küresel bayramıdır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 1 Mayıs Emek ve Dayanışma Günü Nasıl Kutlanır?\n1. Alın teriyle çalışan tüm emekçileri tebrik edin.\n2. İş güvenliği ve adil ücret haklarını savunun.\n3. Emek dayanışmasına katkıda bulunun.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Alın teriyle dünyayı güzelleştiren tüm emekçilerin 1 Mayıs Emek ve Dayanışma Günü kutlu olsun! 🛠️✊\"\n* \"1 Mayıs Emek ve Dayanışma Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #1Mayis #IsciBayrami #EmekVeDayanisma\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #emek-ve-dayanisma-gunu\"",
    "celebration_date": "2026-05-01",
    "month_no": 5,
    "day_no": 1,
    "category": "Resmi",
    "hashtags": [
      "#1Mayis",
      "#IsciBayrami",
      "#EmekVeDayanisma",
      "#Haklar"
    ],
    "affiliate_keywords": [
      "iş güvenliği ayakkabısı",
      "termos yemek kabı",
      "iş tulumu"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000073",
    "slug": "anneler-gunu",
    "title": "10 Mayıs Anneler Günü",
    "description": "Annelerimizin karşılıksız sevgisine ve fedakarlıklarına teşekkür ettiğimiz en duygusal özel gün.",
    "content": "## 10 Mayıs Anneler Günü Nedir?\nModern Anneler Günü, Anna Jarvis'in annesi anısına başlattığı hareketle yaygınlaşmış olup Mayıs ayının ikinci pazarı kutlanır.\n\n### Tarihçesi ve Önemi\nModern Anneler Günü, Anna Jarvis'in annesi anısına başlattığı hareketle yaygınlaşmış olup Mayıs ayının ikinci pazarı kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 10 Mayıs Anneler Günü Nasıl Kutlanır?\n1. Annenizi ziyaret edin, sarılın ve sevginizi dile getirin.\n2. Onun için özel bir kahvaltı hazırlayın.\n3. Onu mutlu edecek içten bir hediye seçin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Cennet annelerin ayakları altındadır. Varlığıyla hayatımızı aydınlatan canım annemin ve tüm annelerin Anneler Günü kutlu olsun! 💐💖\"\n* \"10 Mayıs Anneler Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #AnnelerGunu #CanimAnnem #AnneSevgisi\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #anneler-gunu\"",
    "celebration_date": "2026-05-10",
    "month_no": 5,
    "day_no": 10,
    "category": "Eğlence",
    "hashtags": [
      "#AnnelerGunu",
      "#CanimAnnem",
      "#AnneSevgisi",
      "#HediyeFikirleri"
    ],
    "affiliate_keywords": [
      "anneler günü hediye seti",
      "robot süpürge",
      "kolye anne bebek figürlü",
      "çiçek sepeti"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000074",
    "slug": "hemsireler-gunu",
    "title": "12 Mayıs Hemşireler Günü",
    "description": "Modern hemşireliğin kurucusu Florence Nightingale anısına sağlık ordusunun fedakar hemşirelerine adanan gün.",
    "content": "## 12 Mayıs Hemşireler Günü Nedir?\nUluslararası Hemşireler Konseyi tarafından Florence Nightingale'in doğum günü olan 12 Mayıs'ta küresel olarak kutlanır.\n\n### Tarihçesi ve Önemi\nUluslararası Hemşireler Konseyi tarafından Florence Nightingale'in doğum günü olan 12 Mayıs'ta küresel olarak kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 12 Mayıs Hemşireler Günü Nasıl Kutlanır?\n1. Sağlık kuruluşlarında görev yapan hemşirelere teşekkür edin.\n2. Hemşirelerin çalışma koşullarının iyileştirilmesine destek olun.\n3. Onların şefkatli emeğini takdir edin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Şefkat dolu elleriyle yaralarımızı saran tüm hemşirelerimizin 12 Mayıs Hemşireler Günü kutlu olsun! 🩺🤍\"\n* \"12 Mayıs Hemşireler Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #HemsirelerGunu #12Mayis #HemsirelereTesekkurler\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #hemsireler-gunu\"",
    "celebration_date": "2026-05-12",
    "month_no": 5,
    "day_no": 12,
    "category": "Sağlık",
    "hashtags": [
      "#HemsirelerGunu",
      "#12Mayis",
      "#HemsirelereTesekkurler",
      "#Saglik"
    ],
    "affiliate_keywords": [
      "hemşire forması desenli",
      "ortopedik sabo terlik",
      "hemşire saati stetoskop",
      "fincan hemşire"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000075",
    "slug": "dunya-ciftciler-gunu",
    "title": "14 Mayıs Dünya Çiftçiler Günü",
    "description": "Sofralarımıza gelen her lokmada emeği olan çiftçilerin ve tarım üreticilerinin uluslararası günü.",
    "content": "## 14 Mayıs Dünya Çiftçiler Günü Nedir?\nUluslararası Tarım Üreticileri Federasyonu'nun kuruluş tarihi olan 14 Mayıs 1984'ten bu yana kutlanmaktadır.\n\n### Tarihçesi ve Önemi\nUluslararası Tarım Üreticileri Federasyonu'nun kuruluş tarihi olan 14 Mayıs 1984'ten bu yana kutlanmaktadır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 14 Mayıs Dünya Çiftçiler Günü Nasıl Kutlanır?\n1. Yerel üreticilerden ve köy pazarlarından alışveriş yapın.\n2. Sürdürülebilir tarım uygulamalarını destekleyin.\n3. Çiftçilerin emeğine saygı gösterin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Köylü milletin efendisidir! Gece gündüz üreten tüm çiftçilerimizin 14 Mayıs Dünya Çiftçiler Günü kutlu olsun. 🌾🚜\"\n* \"14 Mayıs Dünya Çiftçiler Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaCiftcilerGunu #14Mayis #TopraginEmekcileri\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-ciftciler-gunu\"",
    "celebration_date": "2026-05-14",
    "month_no": 5,
    "day_no": 14,
    "category": "Mesleki",
    "hashtags": [
      "#DunyaCiftcilerGunu",
      "#14Mayis",
      "#TopraginEmekcileri",
      "#Tarim"
    ],
    "affiliate_keywords": [
      "bahçe eldiveni sağlam",
      "budama testeresi",
      "toprak ph ölçer",
      "hasır şapka"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000076",
    "slug": "genclik-ve-spor-bayrami",
    "title": "19 Mayıs Atatürk'ü Anma, Gençlik ve Spor Bayramı",
    "description": "Atatürk'ün Samsun'a çıkarak Milli Mücadele'yi başlattığı ve Türk gençliğine armağan ettiği milli bayramımız.",
    "content": "## 19 Mayıs Atatürk'ü Anma, Gençlik ve Spor Bayramı Nedir?\n19 Mayıs 1919'da Mustafa Kemal Paşa Bandırma Vapuru ile Samsun'a ayak basmış ve Kurtuluş Savaşı'nı fiilen başlatmıştır.\n\n### Tarihçesi ve Önemi\n19 Mayıs 1919'da Mustafa Kemal Paşa Bandırma Vapuru ile Samsun'a ayak basmış ve Kurtuluş Savaşı'nı fiilen başlatmıştır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 19 Mayıs Atatürk'ü Anma, Gençlik ve Spor Bayramı Nasıl Kutlanır?\n1. Gençlik festivallerine ve spor müsabakalarına katılın.\n2. Şehir meydanlarındaki resmi törenleri izleyin.\n3. Evlerinize Türk bayrakları asın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Ey Türk Gençliği! Birinci vazifen Türk istiklalini ve Türk cumhuriyetini ilelebet muhafaza ve müdafaa etmektir. 19 Mayıs kutlu olsun! 🇹🇷🏃‍♂️\"\n* \"19 Mayıs Atatürk'ü Anma, Gençlik ve Spor Bayramı kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #19Mayis #GenclikVesporBayrami #Ataturk\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #genclik-ve-spor-bayrami\"",
    "celebration_date": "2026-05-19",
    "month_no": 5,
    "day_no": 19,
    "category": "Resmi",
    "hashtags": [
      "#19Mayis",
      "#GenclikVesporBayrami",
      "#Ataturk",
      "#Samsun1919"
    ],
    "affiliate_keywords": [
      "türk bayrağı spor tişörtü",
      "spor çantası",
      "basketbol topu",
      "atatürk imzalı rozet"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000077",
    "slug": "dunya-ari-gunu",
    "title": "20 Mayıs Dünya Arı Günü",
    "description": "Ekosistemin ve tarımın gizli kahramanları olan arıların tozlaşmadaki hayati önemini hatırlatan BM günü.",
    "content": "## 20 Mayıs Dünya Arı Günü Nedir?\nModern arıcılığın öncüsü Anton Jansa'nın doğum günü anısına Birleşmiş Milletler tarafından kabul edilmiştir.\n\n### Tarihçesi ve Önemi\nModern arıcılığın öncüsü Anton Jansa'nın doğum günü anısına Birleşmiş Milletler tarafından kabul edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 20 Mayıs Dünya Arı Günü Nasıl Kutlanır?\n1. Balkonunuza arıların sevdiği lavanta ve kekik gibi çiçekler ekin.\n2. Kimyasal tarım ilaçlarının azaltılmasını savunun.\n3. Gerçek arıcıları destekleyin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Arılar yoksa hayat da yok! 20 Mayıs Dünya Arı Günü'nde minik kanatlı dostlarımızı koruyalım. 🐝🍯🌸\"\n* \"20 Mayıs Dünya Arı Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaAriGunu #WorldBeeDay #ArilariKoru\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-ari-gunu\"",
    "celebration_date": "2026-05-20",
    "month_no": 5,
    "day_no": 20,
    "category": "Çevre & Doğa",
    "hashtags": [
      "#DunyaAriGunu",
      "#WorldBeeDay",
      "#ArilariKoru",
      "#DogayiKoru"
    ],
    "affiliate_keywords": [
      "doğal organik bal",
      "arı sütü propolis",
      "çiçek tohumu arı dostu"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000078",
    "slug": "istanbulun-fethi",
    "title": "29 Mayıs İstanbul'un Fethi",
    "description": "1453 yılında Fatih Sultan Mehmet komutasındaki Osmanlı ordusunun İstanbul'u fethettiği tarihi gün.",
    "content": "## 29 Mayıs İstanbul'un Fethi Nedir?\n29 Mayıs 1453'te İstanbul fethedilmiş, Orta Çağ kapanıp Yeni Çağ başlamış ve Konstantiniyye, Osmanlı'nın başkenti olmuştur.\n\n### Tarihçesi ve Önemi\n29 Mayıs 1453'te İstanbul fethedilmiş, Orta Çağ kapanıp Yeni Çağ başlamış ve Konstantiniyye, Osmanlı'nın başkenti olmuştur. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 29 Mayıs İstanbul'un Fethi Nasıl Kutlanır?\n1. Tarihi Yarımada'yı ve fethin izlerini taşıyan surları ziyaret edin.\n2. Panorama 1453 Tarih Müzesi'ni gezin.\n3. İstanbul'un kültürel zenginliğini anlatan eserleri inceleyin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Bir çağı kapatıp yeni bir çağ açan Fatih Sultan Mehmet ve kutlu ordusunu rahmetle anıyoruz. 29 Mayıs İstanbul'un Fethi kutlu olsun! 🇹🇷🏰\"\n* \"29 Mayıs İstanbul'un Fethi kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #29Mayis1453 #IstanbulunFethi #FatihSultanMehmet\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #istanbulun-fethi\"",
    "celebration_date": "2026-05-29",
    "month_no": 5,
    "day_no": 29,
    "category": "Resmi",
    "hashtags": [
      "#29Mayis1453",
      "#IstanbulunFethi",
      "#FatihSultanMehmet",
      "#Fetih"
    ],
    "affiliate_keywords": [
      "istanbul fetih tarihi kitabı",
      "osmanlı tuğrası tablo",
      "minyatür fatih biblosu"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000079",
    "slug": "dunya-cevre-gunu",
    "title": "5 Haziran Dünya Çevre Günü",
    "description": "Doğayı korumak, iklim kriziyle mücadele etmek ve gezegenimizin sürdürülebilirliğini sağlamak için kutlanır.",
    "content": "## 5 Haziran Dünya Çevre Günü Nedir?\n1972 yılında Stockholm Çevre Konferansı'nda alınan kararla ilan edilen gün çevre bilincini küresel düzeyde artırır.\n\n### Tarihçesi ve Önemi\n1972 yılında Stockholm Çevre Konferansı'nda alınan kararla ilan edilen gün çevre bilincini küresel düzeyde artırır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 5 Haziran Dünya Çevre Günü Nasıl Kutlanır?\n1. Fidan dikin veya yerel çevre temizliği etkinliklerine katılın.\n2. Tek kullanımlık plastik tüketiminizi sıfırlayın.\n3. Su ve elektrik tasarrufu yapın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Başka bir Dünya yok! 5 Haziran Dünya Çevre Günü'nde doğaya borcumuzu ödeyelim. 🌍🌱\"\n* \"5 Haziran Dünya Çevre Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaCevreGunu #SifirAtik #IklimKrizi\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-cevre-gunu\"",
    "celebration_date": "2026-06-05",
    "month_no": 6,
    "day_no": 5,
    "category": "Çevre & Doğa",
    "hashtags": [
      "#DunyaCevreGunu",
      "#SifirAtik",
      "#IklimKrizi",
      "#DogaDostu"
    ],
    "affiliate_keywords": [
      "çelik matara termos",
      "bez alışveriş çantası",
      "bambu diş fırçası seti",
      "kompost kutusu"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000080",
    "slug": "dunya-okyanuslar-gunu",
    "title": "8 Haziran Dünya Okyanuslar Günü",
    "description": "Gezegenimizin akciğerleri olan deniz ve okyanusların plastik kirliliğinden arındırılmasını savunan gün.",
    "content": "## 8 Haziran Dünya Okyanuslar Günü Nedir?\n1992 Rio Dünya Zirvesi'nde önerilen ve 2008'de BM tarafından resmi olarak tanınan küresel okyanus koruma günüdür.\n\n### Tarihçesi ve Önemi\n1992 Rio Dünya Zirvesi'nde önerilen ve 2008'de BM tarafından resmi olarak tanınan küresel okyanus koruma günüdür. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 8 Haziran Dünya Okyanuslar Günü Nasıl Kutlanır?\n1. Sahil ve plaj temizliklerine katılın.\n2. Plastik atıkların denizlere ulaşmasını engelleyin.\n3. Sürdürülebilir deniz ürünlerini tercih edin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Mavi gezegenimizin kalbi denizler ve okyanuslardır. 8 Haziran Dünya Okyanuslar Günü kutlu olsun! 🌊🐋🐬\"\n* \"8 Haziran Dünya Okyanuslar Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaOkyanuslarGunu #WorldOceansDay #DenizleriKoru\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-okyanuslar-gunu\"",
    "celebration_date": "2026-06-08",
    "month_no": 6,
    "day_no": 8,
    "category": "Çevre & Doğa",
    "hashtags": [
      "#DunyaOkyanuslarGunu",
      "#WorldOceansDay",
      "#DenizleriKoru",
      "#MaviGezegen"
    ],
    "affiliate_keywords": [
      "deniz gözlüğü şnorkel",
      "mikrofiber hızlı kuruyan havlu",
      "su geçirmez telefon kılıfı"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000081",
    "slug": "dunya-kan-bagiscilari-gunu",
    "title": "14 Haziran Dünya Kan Bağışçıları Günü",
    "description": "Gönüllü ve karşılıksız kan bağışlayarak milyonlarca insanın hayatını kurtaran kahramanları onurlandıran gün.",
    "content": "## 14 Haziran Dünya Kan Bağışçıları Günü Nedir?\nAB0 kan grubu sistemini bulan Nobel ödüllü Karl Landsteiner'in doğum gününde DSÖ öncülüğünde kutlanır.\n\n### Tarihçesi ve Önemi\nAB0 kan grubu sistemini bulan Nobel ödüllü Karl Landsteiner'in doğum gününde DSÖ öncülüğünde kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 14 Haziran Dünya Kan Bağışçıları Günü Nasıl Kutlanır?\n1. En yakın Kızılay kan merkezine giderek kan bağışında bulunun.\n2. Sağlıklı bireyleri kan bağışına teşvik edin.\n3. Kök hücre bağışçısı olmayı değerlendirin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"1 ünite kan 3 can kurtarır! Tüm gönüllü bağışçılarımızın 14 Haziran Dünya Kan Bağışçıları Günü kutlu olsun. 🩸❤️\"\n* \"14 Haziran Dünya Kan Bağışçıları Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #KanBagiscilariGunu #KanBagisiHayatKurtarir #Kizilay\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kan-bagiscilari-gunu\"",
    "celebration_date": "2026-06-14",
    "month_no": 6,
    "day_no": 14,
    "category": "Sağlık",
    "hashtags": [
      "#KanBagiscilariGunu",
      "#KanBagisiHayatKurtarir",
      "#Kizilay",
      "#KanVerCanVer"
    ],
    "affiliate_keywords": [
      "kan şekeri ölçüm cihazı",
      "vitamin takviyesi",
      "sporcu su matarası"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000082",
    "slug": "babalar-gunu",
    "title": "21 Haziran Babalar Günü",
    "description": "Babalarımızın fedakarlıklarına, sevgisine ve rehberliğine teşekkür ettiğimiz anlamlı kutlama günü.",
    "content": "## 21 Haziran Babalar Günü Nedir?\nHer yıl Haziran ayının üçüncü pazar günü babaların ailedeki sevgi ve koruma rolünü onurlandırmak için kutlanır.\n\n### Tarihçesi ve Önemi\nHer yıl Haziran ayının üçüncü pazar günü babaların ailedeki sevgi ve koruma rolünü onurlandırmak için kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 21 Haziran Babalar Günü Nasıl Kutlanır?\n1. Babanızı arayın veya ziyaret edip ona teşekkür edin.\n2. Birlikte nostaljik bir yürüyüş veya kahve molası verin.\n3. Kullanışlı ve anlamlı bir hediye armağan edin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Hayatımızın en güvenli sığınağı, ilk kahramanımız olan canım babamın ve tüm babaların Babalar Günü kutlu olsun! 👔💙\"\n* \"21 Haziran Babalar Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #BabalarGunu #CanimBabam #BabaSevgisi\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #babalar-gunu\"",
    "celebration_date": "2026-06-21",
    "month_no": 6,
    "day_no": 21,
    "category": "Eğlence",
    "hashtags": [
      "#BabalarGunu",
      "#CanimBabam",
      "#BabaSevgisi",
      "#HediyeFikirleri"
    ],
    "affiliate_keywords": [
      "babalar günü hediye kutusu",
      "deri cüzdan kemer seti",
      "tıraş makinesi seti",
      "erkek kol saati"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000083",
    "slug": "dunya-muzik-gunu",
    "title": "21 Haziran Dünya Müzik Günü",
    "description": "Yılın en uzun gününde sokaklarda, parklarda ve salonlarda müziğin evrensel dilini kutlayan müzik festivali.",
    "content": "## 21 Haziran Dünya Müzik Günü Nedir?\n1982'de Fransa'da başlatılan Fête de la Musique, bugün 120 ülkede amatör ve profesyonel müzisyenlerin sokaklarda özgürce müzik yaptığı bir şölendir.\n\n### Tarihçesi ve Önemi\n1982'de Fransa'da başlatılan Fête de la Musique, bugün 120 ülkede amatör ve profesyonel müzisyenlerin sokaklarda özgürce müzik yaptığı bir şölendir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 21 Haziran Dünya Müzik Günü Nasıl Kutlanır?\n1. En sevdiğiniz enstrümanı çalın veya yeni bir şarkı öğrenin.\n2. Ücretsiz sokak konserlerini izleyin.\n3. Farklı dünya müziklerini keşfedin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Müzik ruhun gıdasıdır. Ruhu müzikle beslenen tüm dostların 21 Haziran Dünya Müzik Günü kutlu olsun! 🎵🎸🎧\"\n* \"21 Haziran Dünya Müzik Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaMuzikGunu #FeteDeLaMusique #MuzikRuhunGidasidir\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-muzik-gunu\"",
    "celebration_date": "2026-06-21",
    "month_no": 6,
    "day_no": 21,
    "category": "Kültür & Sanat",
    "hashtags": [
      "#DunyaMuzikGunu",
      "#FeteDeLaMusique",
      "#MuzikRuhunGidasidir",
      "#21Haziran"
    ],
    "affiliate_keywords": [
      "bluetooth kulaklık",
      "akustik gitar başlangıç seti",
      "ukulele ahşap",
      "taşınabilir hoparlör"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000084",
    "slug": "kabotaj-bayrami",
    "title": "1 Temmuz Denizcilik ve Kabotaj Bayramı",
    "description": "Türk karasularında egemenliğin ve deniz ticareti hakkının Türkiye'ye geçtiği tarihi milli bayram.",
    "content": "## 1 Temmuz Denizcilik ve Kabotaj Bayramı Nedir?\n1 Temmuz 1926'da yürürlüğe giren Kabotaj Kanunu ile Türk limanları arasındaki deniz taşımacılığı hakkı yabancılardan alınıp Türk bayraklı gemilere verilmiştir.\n\n### Tarihçesi ve Önemi\n1 Temmuz 1926'da yürürlüğe giren Kabotaj Kanunu ile Türk limanları arasındaki deniz taşımacılığı hakkı yabancılardan alınıp Türk bayraklı gemilere verilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 1 Temmuz Denizcilik ve Kabotaj Bayramı Nasıl Kutlanır?\n1. Kıyı şehirlerindeki deniz şenliklerini ve yağlı direk yarışlarını izleyin.\n2. Deniz şehitlerini anma törenlerine katılın.\n3. Türkiye'nin denizcilik tarihini okuyun.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Denizlere hakim olan cihana hakim olur! 1 Temmuz Denizcilik ve Kabotaj Bayramımız kutlu olsun! 🇹🇷⚓🚢\"\n* \"1 Temmuz Denizcilik ve Kabotaj Bayramı kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #1Temmuz #KabotajBayrami #DenizcilikBayrami\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #kabotaj-bayrami\"",
    "celebration_date": "2026-07-01",
    "month_no": 7,
    "day_no": 1,
    "category": "Resmi",
    "hashtags": [
      "#1Temmuz",
      "#KabotajBayrami",
      "#DenizcilikBayrami",
      "#MaviVatan"
    ],
    "affiliate_keywords": [
      "yelkenli gemi maketi",
      "denizci şapkası",
      "deniz kabuğu bileklik",
      "su geçirmez çanta"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000085",
    "slug": "dunya-cikolata-gunu",
    "title": "7 Temmuz Dünya Çikolata Günü",
    "description": "Kakao çekirdeğinden üretilen dünyanın en sevilen tatlısının keşfini kutlayan lezzetli gün.",
    "content": "## 7 Temmuz Dünya Çikolata Günü Nedir?\n1550 yılında çikolatanın Avrupa'ya ilk kez getirildiği günün anısına dünya çapında çikolata günü olarak kutlanır.\n\n### Tarihçesi ve Önemi\n1550 yılında çikolatanın Avrupa'ya ilk kez getirildiği günün anısına dünya çapında çikolata günü olarak kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 7 Temmuz Dünya Çikolata Günü Nasıl Kutlanır?\n1. Sevdiklerinizle özel bir çikolata kutusu paylaşın.\n2. Evde kendi çikolatalı tatlınızı pişirin.\n3. Yüksek kakaolu bitter çikolatanın faydalarını keşfedin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Mutluluğun en tatlı hali! Tüm çikolataseverlerin 7 Temmuz Dünya Çikolata Günü kutlu olsun! 🍫😋\"\n* \"7 Temmuz Dünya Çikolata Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaCikolataGunu #WorldChocolateDay #CikolataSever\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-cikolata-gunu\"",
    "celebration_date": "2026-07-07",
    "month_no": 7,
    "day_no": 7,
    "category": "Eğlence",
    "hashtags": [
      "#DunyaCikolataGunu",
      "#WorldChocolateDay",
      "#CikolataSever",
      "#TatliKriz"
    ],
    "affiliate_keywords": [
      "belçika çikolatası kutusu",
      "çikolata fondü seti",
      "sıcak çikolata tozu",
      "çikolatalı trüf"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000086",
    "slug": "demokrasi-ve-milli-birlik-gunu",
    "title": "15 Temmuz Demokrasi ve Milli Birlik Günü",
    "description": "15 Temmuz 2016 darbe girişimine karşı milletimizin gösterdiği destansı direnişi ve şehitlerimizi anma günü.",
    "content": "## 15 Temmuz Demokrasi ve Milli Birlik Günü Nedir?\n15 Temmuz gecesi halkın iradesine ve demokrasimize sahip çıkarak canlarını feda eden şehit ve gazilerimizi anmak için resmi tatil ilan edilmiştir.\n\n### Tarihçesi ve Önemi\n15 Temmuz gecesi halkın iradesine ve demokrasimize sahip çıkarak canlarını feda eden şehit ve gazilerimizi anmak için resmi tatil ilan edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 15 Temmuz Demokrasi ve Milli Birlik Günü Nasıl Kutlanır?\n1. Şehitlikleri ziyaret edin ve dualar okuyun.\n2. Demokrasi nöbetlerine ve anma programlarına katılın.\n3. Milli birlik ve beraberlik mesajları paylaşın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Milletimizin iradesi hiçbir gücün önünde eğilmez! 15 Temmuz Demokrasi ve Milli Birlik Günü'nde şehitlerimizi rahmetle anıyoruz. 🇹🇷🕊️\"\n* \"15 Temmuz Demokrasi ve Milli Birlik Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #15Temmuz #DemokrasiBayrami #MilliBirlikGunu\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #demokrasi-ve-milli-birlik-gunu\"",
    "celebration_date": "2026-07-15",
    "month_no": 7,
    "day_no": 15,
    "category": "Resmi",
    "hashtags": [
      "#15Temmuz",
      "#DemokrasiBayrami",
      "#MilliBirlikGunu",
      "#SehitlerimiziUnutmadik"
    ],
    "affiliate_keywords": [
      "türk bayrağı büyük boy",
      "15 temmuz anı kitabı",
      "atatürk tişörtü"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000087",
    "slug": "dunya-emoji-gunu",
    "title": "17 Temmuz Dünya Emoji Günü",
    "description": "Dijital çağın küresel dili olan emojilerin iletişimdeki eğlenceli rolünü kutlayan internet günü.",
    "content": "## 17 Temmuz Dünya Emoji Günü Nedir?\nApple'ın takvim emojisinin üzerinde 17 Temmuz yazdığı için Emojipedia kurucusu Jeremy Burge tarafından 2014'te ilan edilmiştir.\n\n### Tarihçesi ve Önemi\nApple'ın takvim emojisinin üzerinde 17 Temmuz yazdığı için Emojipedia kurucusu Jeremy Burge tarafından 2014'te ilan edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 17 Temmuz Dünya Emoji Günü Nasıl Kutlanır?\n1. Bugün mesajlarınızda en sevdiğiniz emojileri bolca kullanın.\n2. Arkadaşlarınızla emoji tahmin oyunu oynayın.\n3. Sosyal medyada günün favori emojisini seçin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Kelimelerin yetmediği yerde emojiler konuşur! 17 Temmuz Dünya Emoji Günü kutlu olsun! 🎉🥳🚀\"\n* \"17 Temmuz Dünya Emoji Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaEmojiGunu #WorldEmojiDay #EmojiGunu\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-emoji-gunu\"",
    "celebration_date": "2026-07-17",
    "month_no": 7,
    "day_no": 17,
    "category": "Eğlence",
    "hashtags": [
      "#DunyaEmojiGunu",
      "#WorldEmojiDay",
      "#EmojiGunu",
      "#DijitalIletisim"
    ],
    "affiliate_keywords": [
      "emoji yastık peluş",
      "emoji anahtarlık",
      "renkli sticker çıkartma seti"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000088",
    "slug": "dunya-satranc-gunu",
    "title": "20 Temmuz Dünya Satranç Günü",
    "description": "Strateji, zeka ve sabır oyunu satrancın zihinsel gelişimdeki gücünü kutlamak için FIDE öncülüğünde kutlanır.",
    "content": "## 20 Temmuz Dünya Satranç Günü Nedir?\n1924 yılında Dünya Satranç Federasyonu'nun (FIDE) Paris'te kuruluşunun anısına Birleşmiş Milletler tarafından kabul edilmiştir.\n\n### Tarihçesi ve Önemi\n1924 yılında Dünya Satranç Federasyonu'nun (FIDE) Paris'te kuruluşunun anısına Birleşmiş Milletler tarafından kabul edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 20 Temmuz Dünya Satranç Günü Nasıl Kutlanır?\n1. Bir dostunuzla zevkli bir satranç maçı yapın.\n2. Yeni bir açılış hamlesi veya taktik öğrenin.\n3. Çocuklara satranç öğretin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Hayat da satranç gibidir, her hamle geleceğini belirler. 20 Temmuz Dünya Satranç Günü kutlu olsun! ♟️👑\"\n* \"20 Temmuz Dünya Satranç Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaSatrancGunu #ChessDay #SatrancSeverler\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-satranc-gunu\"",
    "celebration_date": "2026-07-20",
    "month_no": 7,
    "day_no": 20,
    "category": "Eğlence",
    "hashtags": [
      "#DunyaSatrancGunu",
      "#ChessDay",
      "#SatrancSeverler",
      "#ZekaOyunu"
    ],
    "affiliate_keywords": [
      "ahşap satranç takımı",
      "dijital satranç saati",
      "satranç taktikleri kitabı",
      "manyetik seyahat satrancı"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000089",
    "slug": "dunya-solaklar-gunu",
    "title": "13 Ağustos Dünya Solaklar Günü",
    "description": "Dünya nüfusunun yaklaşık yüzde 10'unu oluşturan solakların günlük hayattaki zorluklarına dikkat çeken gün.",
    "content": "## 13 Ağustos Dünya Solaklar Günü Nedir?\n1976 yılında Dean R. Campbell tarafından solakların sağ el odaklı dünyada yaşadığı zorluklara eğlenceli ve eğitici bir bakış açısıyla başlatılmıştır.\n\n### Tarihçesi ve Önemi\n1976 yılında Dean R. Campbell tarafından solakların sağ el odaklı dünyada yaşadığı zorluklara eğlenceli ve eğitici bir bakış açısıyla başlatılmıştır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 13 Ağustos Dünya Solaklar Günü Nasıl Kutlanır?\n1. Sağ elinizi kullanan biriyseniz bugün bir süre sol elinizle yazı yazmayı deneyin.\n2. Solak arkadaşlarınıza özel hediyeler verin.\n3. Solakların başarılarını kutlayın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Farklı açıdan gören ve sol eliyle dünyayı güzelleştiren tüm solakların günü kutlu olsun! ✍️🖐️\"\n* \"13 Ağustos Dünya Solaklar Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaSolaklarGunu #LefthandersDay #SolaklarGunu\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-solaklar-gunu\"",
    "celebration_date": "2026-08-13",
    "month_no": 8,
    "day_no": 13,
    "category": "Eğlence",
    "hashtags": [
      "#DunyaSolaklarGunu",
      "#LefthandersDay",
      "#SolaklarGunu",
      "#SolEl"
    ],
    "affiliate_keywords": [
      "solaklar için makas",
      "sol el ergonomik mouse",
      "solaklar için dolma kalem"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000090",
    "slug": "dunya-fotografcilik-gunu",
    "title": "19 Ağustos Dünya Fotoğrafçılık Günü",
    "description": "Anı ölümsüzleştiren fotoğraf sanatının doğuşunu (Dagerreyotipi patentini) kutlayan küresel sanat günü.",
    "content": "## 19 Ağustos Dünya Fotoğrafçılık Günü Nedir?\n1839 yılında Fransız hükümetinin Dagerreyotipi buluşunu tüm dünyaya ücretsiz hediye ettiği 19 Ağustos günü fotoğrafçılığın doğum günü sayılır.\n\n### Tarihçesi ve Önemi\n1839 yılında Fransız hükümetinin Dagerreyotipi buluşunu tüm dünyaya ücretsiz hediye ettiği 19 Ağustos günü fotoğrafçılığın doğum günü sayılır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 19 Ağustos Dünya Fotoğrafçılık Günü Nasıl Kutlanır?\n1. Makinenizi veya telefonunuzu alıp şehri kadrajınıza alın.\n2. En sevdiğiniz fotoğrafları sergileyin veya paylaşın.\n3. Fotoğrafçılık kursu veya eğitim videosu izleyin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Hayatı durdurup anı ölümsüzleştiren tüm fotoğraf tutkunlarının 19 Ağustos Dünya Fotoğrafçılık Günü kutlu olsun! 📷✨\"\n* \"19 Ağustos Dünya Fotoğrafçılık Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #FotografcilikGunu #WorldPhotographyDay #FotografSever\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-fotografcilik-gunu\"",
    "celebration_date": "2026-08-19",
    "month_no": 8,
    "day_no": 19,
    "category": "Kültür & Sanat",
    "hashtags": [
      "#FotografcilikGunu",
      "#WorldPhotographyDay",
      "#FotografSever",
      "#Kadraj"
    ],
    "affiliate_keywords": [
      "fotoğraf makinesi askısı",
      "lens temizleme kiti",
      "telefon için fotoğraf lensi",
      "fotoğraf albümü"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000091",
    "slug": "dunya-kopekler-gunu",
    "title": "26 Ağustos Dünya Köpekler Günü",
    "description": "İnsanın en sadık dostu köpeklerin yaşam hakkını ve barınaklardaki sahipsiz canları hatırlatan gün.",
    "content": "## 26 Ağustos Dünya Köpekler Günü Nedir?\n2004 yılında hayvan savunucusu Colleen Paige tarafından kurtarma köpeklerine ve sahiplenmeye dikkat çekmek amacıyla başlatılmıştır.\n\n### Tarihçesi ve Önemi\n2004 yılında hayvan savunucusu Colleen Paige tarafından kurtarma köpeklerine ve sahiplenmeye dikkat çekmek amacıyla başlatılmıştır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 26 Ağustos Dünya Köpekler Günü Nasıl Kutlanır?\n1. Köpeğinize uzun ve keyifli bir yürüyüş yaptırın.\n2. Sokak köpeklerine mama ve su bırakın.\n3. Barınaktan bir dost sahiplenmeyi değerlendirin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Karşılıksız sevginin ve sadakatin adı! Tüm sevimli can dostlarımızın 26 Ağustos Dünya Köpekler Günü kutlu olsun! 🐶🦴\"\n* \"26 Ağustos Dünya Köpekler Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaKopeklerGunu #DogDay #CanDostum\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kopekler-gunu\"",
    "celebration_date": "2026-08-26",
    "month_no": 8,
    "day_no": 26,
    "category": "Çevre & Doğa",
    "hashtags": [
      "#DunyaKopeklerGunu",
      "#DogDay",
      "#CanDostum",
      "#SatinAlmaSahiplen"
    ],
    "affiliate_keywords": [
      "köpek tasması ve künyesi",
      "köpek ödül bisküvisi",
      "köpek diş temizleme oyuncağı",
      "köpek yatağı ortopedik"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000092",
    "slug": "zafer-bayrami",
    "title": "30 Ağustos Zafer Bayramı",
    "description": "1922 Büyük Taarruz ve Başkomutanlık Meydan Muharebesi zaferini kutladığımız büyük milli bayramımız.",
    "content": "## 30 Ağustos Zafer Bayramı Nedir?\nGazi Mustafa Kemal Atatürk başkumandanlığında Türk ordusunun vatan topraklarını işgalden temizlediği kesin zafer günüdür.\n\n### Tarihçesi ve Önemi\nGazi Mustafa Kemal Atatürk başkumandanlığında Türk ordusunun vatan topraklarını işgalden temizlediği kesin zafer günüdür. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 30 Ağustos Zafer Bayramı Nasıl Kutlanır?\n1. Resmi geçit törenlerini ve Türk Yıldızları gösterilerini izleyin.\n2. Şehitlikleri ziyaret ederek dua edin.\n3. Evlerinizi ve iş yerlerinizi Türk bayraklarıyla donatın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"30 Ağustos, Türk milletinin bağımsızlığından asla vazgeçmeyeceğinin belgesidir. Zafer Bayramımız kutlu olsun! 🇹🇷🎖️\"\n* \"30 Ağustos Zafer Bayramı kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #30Agustos #ZaferBayrami #BaskanMustafaKemal\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #zafer-bayrami\"",
    "celebration_date": "2026-08-30",
    "month_no": 8,
    "day_no": 30,
    "category": "Resmi",
    "hashtags": [
      "#30Agustos",
      "#ZaferBayrami",
      "#BaskanMustafaKemal",
      "#BuyukTaarruz",
      "#Turkiye"
    ],
    "affiliate_keywords": [
      "türk bayrağı araba süsü",
      "atatürk tişörtü",
      "kurtuluş savaşı tarihi kitabı",
      "rozet"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000093",
    "slug": "dunya-baris-gunu",
    "title": "1 Eylül Dünya Barış Günü",
    "description": "İkinci Dünya Savaşı'nın başladığı günde savaşların sona ermesi ve küresel barışın tesisi için kutlanan gün.",
    "content": "## 1 Eylül Dünya Barış Günü Nedir?\n1 Eylül 1939'da Almanya'nın Polonya'yı işgaliyle başlayan 2. Dünya Savaşı'nın yıkımını unutmamak için ilan edilen barış günüdür.\n\n### Tarihçesi ve Önemi\n1 Eylül 1939'da Almanya'nın Polonya'yı işgaliyle başlayan 2. Dünya Savaşı'nın yıkımını unutmamak için ilan edilen barış günüdür. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 1 Eylül Dünya Barış Günü Nasıl Kutlanır?\n1. 'Yurtta sulh, cihanda sulh' ilkesini hatırlayın ve savunun.\n2. Çevrenizdeki anlaşmazlıkları diyalog ve empatiyle çözün.\n3. Barış mesajları paylaşın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Savaşın kazananı, barışın kaybedeni olmaz. 1 Eylül Dünya Barış Günü'nde tüm dünyaya huzur diliyoruz. 🕊️🌍\"\n* \"1 Eylül Dünya Barış Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #1Eylul #DunyaBarisGunu #YurttaSulhCihandaSulh\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-baris-gunu\"",
    "celebration_date": "2026-09-01",
    "month_no": 9,
    "day_no": 1,
    "category": "Farkındalık",
    "hashtags": [
      "#1Eylul",
      "#DunyaBarisGunu",
      "#YurttaSulhCihandaSulh",
      "#Baris"
    ],
    "affiliate_keywords": [
      "barış güvercini kolye",
      "barış temalı tişört",
      "felsefe ve barış kitapları"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000094",
    "slug": "dunya-yazilimcilar-gunu",
    "title": "13 Eylül Dünya Yazılımcılar Günü",
    "description": "Yılın 256. gününde (2 üzeri 8) dijital dünyayı inşa eden tüm yazılım geliştiricileri onurlandıran gün.",
    "content": "## 13 Eylül Dünya Yazılımcılar Günü Nedir?\n1 baytın alabileceği farklı değer sayısı olan 256'ncı günde kutlanan uluslararası programcılar günüdür.\n\n### Tarihçesi ve Önemi\n1 baytın alabileceği farklı değer sayısı olan 256'ncı günde kutlanan uluslararası programcılar günüdür. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 13 Eylül Dünya Yazılımcılar Günü Nasıl Kutlanır?\n1. Açık kaynak projelere katkıda bulunun.\n2. Yeni bir programlama dili veya framework öğrenin.\n3. Yazılımcı arkadaşınıza kahve ısmarlayın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"while(alive) { code(); coffee(); } 🚀 Sıfır hatalı commit'ler ve bugsız günler dileriz! 💻✨\"\n* \"13 Eylül Dünya Yazılımcılar Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #YazilimcilarGunu #ProgrammersDay #Coding\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-yazilimcilar-gunu\"",
    "celebration_date": "2026-09-13",
    "month_no": 9,
    "day_no": 13,
    "category": "Mesleki",
    "hashtags": [
      "#YazilimcilarGunu",
      "#ProgrammersDay",
      "#Coding",
      "#DeveloperLife",
      "#256Day"
    ],
    "affiliate_keywords": [
      "mekanik klavye rgb",
      "ergonomik mouse",
      "yazılımcı tişörtü",
      "monitör standı"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000095",
    "slug": "dunya-alzheimer-gunu",
    "title": "21 Eylül Dünya Alzheimer Günü",
    "description": "Alzheimer hastalığına ve demansa dikkat çekmek, hasta ve hasta yakınlarına destek olmak için kutlanır.",
    "content": "## 21 Eylül Dünya Alzheimer Günü Nedir?\nDünya Sağlık Örgütü ve Uluslararası Alzheimer Birliği tarafından hafıza kaybı ve nörodejeneratif süreçler hakkında bilinç oluşturmak için düzenlenir.\n\n### Tarihçesi ve Önemi\nDünya Sağlık Örgütü ve Uluslararası Alzheimer Birliği tarafından hafıza kaybı ve nörodejeneratif süreçler hakkında bilinç oluşturmak için düzenlenir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 21 Eylül Dünya Alzheimer Günü Nasıl Kutlanır?\n1. Zihinsel aktiviteler ve bulmacalarla beyninizi zinde tutun.\n2. Yaşlı aile bireylerinizle kaliteli zaman geçirin.\n3. Alzheimer derneklerine destek olun.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Bizi biz yapan anılarımızdır. 21 Eylül Dünya Alzheimer Günü'nde sevdiklerimizi unutmayalım, yanlarında olalım. 🧠💜\"\n* \"21 Eylül Dünya Alzheimer Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #AlzheimerGunu #Unutma #ErkenTeshis\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-alzheimer-gunu\"",
    "celebration_date": "2026-09-21",
    "month_no": 9,
    "day_no": 21,
    "category": "Sağlık",
    "hashtags": [
      "#AlzheimerGunu",
      "#Unutma",
      "#ErkenTeshis",
      "#AlzheimerFarkindalik"
    ],
    "affiliate_keywords": [
      "hafıza güçlendirme bulmaca kitabı",
      "akıl oyunları seti yetişkin",
      "akıllı saat gps yaşlı"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000096",
    "slug": "dunya-kuduz-gunu",
    "title": "28 Eylül Dünya Kuduz Günü",
    "description": "Kuduz hastalığı konusunda farkındalık yaratmak ve aşının hayati önemini vurgulamak için kutlanır.",
    "content": "## 28 Eylül Dünya Kuduz Günü Nedir?\nKuduz aşısını bulan Louis Pasteur'ün ölüm yıl dönümü olan 28 Eylül'de WHO ve GARC öncülüğünde düzenlenir.\n\n### Tarihçesi ve Önemi\nKuduz aşısını bulan Louis Pasteur'ün ölüm yıl dönümü olan 28 Eylül'de WHO ve GARC öncülüğünde düzenlenir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 28 Eylül Dünya Kuduz Günü Nasıl Kutlanır?\n1. Evcil hayvanlarınızın yıllık kuduz aşılarını aksatmayın.\n2. Sokak hayvanlarının aşılanmasına destek olun.\n3. Isırılma durumunda derhal hastaneye başvurun.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Aşı hayat kurtarır! 28 Eylül Dünya Kuduz Günü'nde can dostlarımızı koruyalım, kuduzu birlikte sıfırlayalım. 🐾💉\"\n* \"28 Eylül Dünya Kuduz Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaKuduzGunu #KuduzFarkindaligi #AsiHayatKurtarir\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kuduz-gunu\"",
    "celebration_date": "2026-09-28",
    "month_no": 9,
    "day_no": 28,
    "category": "Sağlık",
    "hashtags": [
      "#DunyaKuduzGunu",
      "#KuduzFarkindaligi",
      "#AsiHayatKurtarir",
      "#28Eylul"
    ],
    "affiliate_keywords": [
      "kedi köpek taşıma çantası",
      "köpek tasması ve künyesi",
      "veteriner bakım seti"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000097",
    "slug": "bilgiye-evrensel-erisim-gunu",
    "title": "28 Eylül Uluslararası Bilgiye Evrensel Erişim Günü",
    "description": "Bilginin serbestçe yayılması ve şeffaf toplumların inşası için UNESCO öncülüğünde kutlanır.",
    "content": "## 28 Eylül Uluslararası Bilgiye Evrensel Erişim Günü Nedir?\nVatandaşların kamu bilgilerine erişim hakkını ve basın özgürlüğünü güvence altına almayı hedefler.\n\n### Tarihçesi ve Önemi\nVatandaşların kamu bilgilerine erişim hakkını ve basın özgürlüğünü güvence altına almayı hedefler. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 28 Eylül Uluslararası Bilgiye Evrensel Erişim Günü Nasıl Kutlanır?\n1. Açık kaynak kütüphaneleri ve veri setlerini keşfedin.\n2. Dijital okuryazarlığı destekleyin.\n3. Bilgiye erişim hakkını savunun.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Bilgi güçtür, özgürce erişildiğinde toplumu dönüştürür. 28 Eylül Bilgiye Evrensel Erişim Günü kutlu olsun! 📚🌐\"\n* \"28 Eylül Uluslararası Bilgiye Evrensel Erişim Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #BilgiyeErisimGunu #UNESCO #AcikBilgi\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #bilgiye-evrensel-erisim-gunu\"",
    "celebration_date": "2026-09-28",
    "month_no": 9,
    "day_no": 28,
    "category": "Farkındalık",
    "hashtags": [
      "#BilgiyeErisimGunu",
      "#UNESCO",
      "#AcikBilgi",
      "#DijitalHaklar"
    ],
    "affiliate_keywords": [
      "e-kitap okuyucu",
      "bilimsel kitaplar",
      "hızlı okuma kitap seti"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000098",
    "slug": "dunya-kalp-gunu",
    "title": "29 Eylül Dünya Kalp Günü",
    "description": "Kalp ve damar hastalıklarına karşı sağlıklı yaşam, beslenme ve egzersiz bilincini artıran küresel sağlık günü.",
    "content": "## 29 Eylül Dünya Kalp Günü Nedir?\nDünya Kalp Federasyonu tarafından kardiyovasküler hastalıkların önlenmesine dikkat çekmek için kutlanır.\n\n### Tarihçesi ve Önemi\nDünya Kalp Federasyonu tarafından kardiyovasküler hastalıkların önlenmesine dikkat çekmek için kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 29 Eylül Dünya Kalp Günü Nasıl Kutlanır?\n1. Günde en az 30 dakika tempolu yürüyüş yapın.\n2. Tuzu, şekeri ve doymuş yağları azaltın.\n3. Sigarayı bırakın ve kalp kontrollerinizi yaptırın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Her atışında sevgi var, kalbini koru! 29 Eylül Dünya Kalp Günü kutlu olsun. ❤️🩺\"\n* \"29 Eylül Dünya Kalp Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaKalpGunu #KalbiniKoru #WorldHeartDay\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kalp-gunu\"",
    "celebration_date": "2026-09-29",
    "month_no": 9,
    "day_no": 29,
    "category": "Sağlık",
    "hashtags": [
      "#DunyaKalpGunu",
      "#KalbiniKoru",
      "#WorldHeartDay",
      "#SaglikliKalp"
    ],
    "affiliate_keywords": [
      "akıllı saat nabız ölçer",
      "kolesterol diyeti kitabı",
      "koşu bandı ev tipi"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000099",
    "slug": "dunya-kahve-gunu",
    "title": "1 Ekim Dünya Kahve Günü",
    "description": "Her yıl 1 Ekim'de kahve üreticilerinin emeğini ve dünyanın en sevilen içeceğinin lezzetini kutlayan gün.",
    "content": "## 1 Ekim Dünya Kahve Günü Nedir?\nUluslararası Kahve Örgütü (ICO) tarafından 2015 yılında resmi olarak başlatılan küresel bir kutlama günüdür.\n\n### Tarihçesi ve Önemi\nUluslararası Kahve Örgütü (ICO) tarafından 2015 yılında resmi olarak başlatılan küresel bir kutlama günüdür. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 1 Ekim Dünya Kahve Günü Nasıl Kutlanır?\n1. V60, Chemex veya geleneksel Türk kahvesi demleyin.\n2. Yerel bağımsız kahvecileri ziyaret edin.\n3. İş arkadaşlarınızla kahve molası verin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Bir fincan kahvenin kırk yıl hatırı vardır, Dünya Kahve Günü kutlu olsun! ☕✨\"\n* \"1 Ekim Dünya Kahve Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaKahveGunu #Kahve #CoffeeDay\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kahve-gunu\"",
    "celebration_date": "2026-10-01",
    "month_no": 10,
    "day_no": 1,
    "category": "Eğlence",
    "hashtags": [
      "#DunyaKahveGunu",
      "#Kahve",
      "#CoffeeDay",
      "#KahveSever",
      "#1Ekim"
    ],
    "affiliate_keywords": [
      "filtre kahve makinesi",
      "nitelikli çekirdek kahve",
      "termos kupa",
      "french press",
      "chemex"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000100",
    "slug": "hayvanlari-koruma-gunu",
    "title": "4 Ekim Hayvanları Koruma Günü",
    "description": "Tüm canlıların yaşam haklarına saygı duymak ve sokak hayvanlarının refahını artırmak amacıyla kutlanır.",
    "content": "## 4 Ekim Hayvanları Koruma Günü Nedir?\n1931 yılında Floransa'da çevre bilimcilerin girişimiyle tehlike altındaki türleri korumak için başlatılmıştır.\n\n### Tarihçesi ve Önemi\n1931 yılında Floransa'da çevre bilimcilerin girişimiyle tehlike altındaki türleri korumak için başlatılmıştır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 4 Ekim Hayvanları Koruma Günü Nasıl Kutlanır?\n1. Bir kap su ve bir kap mama bırakın.\n2. Barınakları ziyaret edip sahiplenmeyi değerlendirin.\n3. Hayvan sevgisini çocuklara aşılayın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Onlar bize emanet! Dünyayı paylaştığımız tüm can dostlarımızın 4 Ekim Hayvanları Koruma Günü kutlu olsun. 🐶🐱🐦\"\n* \"4 Ekim Hayvanları Koruma Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #4Ekim #HayvanlariKorumaGunu #SatinAlmaSahiplen\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #hayvanlari-koruma-gunu\"",
    "celebration_date": "2026-10-04",
    "month_no": 10,
    "day_no": 4,
    "category": "Çevre & Doğa",
    "hashtags": [
      "#4Ekim",
      "#HayvanlariKorumaGunu",
      "#SatinAlmaSahiplen",
      "#CanDostlarimiz"
    ],
    "affiliate_keywords": [
      "kedi maması 15kg",
      "köpek maması premium",
      "kuş yemi ve kafesi",
      "otomatik su sebili pet"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000101",
    "slug": "dunya-ruh-sagligi-gunu",
    "title": "10 Ekim Dünya Ruh Sağlığı Günü",
    "description": "Ruh sağlığının genel sağlığın ayrılmaz bir parçası olduğunu vurgulayan ve psikolojik desteği savunan gün.",
    "content": "## 10 Ekim Dünya Ruh Sağlığı Günü Nedir?\nDünya Ruh Sağlığı Federasyonu tarafından ruh sağlığı sorunlarına yönelik damgalamayı kırmak amacıyla kutlanır.\n\n### Tarihçesi ve Önemi\nDünya Ruh Sağlığı Federasyonu tarafından ruh sağlığı sorunlarına yönelik damgalamayı kırmak amacıyla kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 10 Ekim Dünya Ruh Sağlığı Günü Nasıl Kutlanır?\n1. Kendi ruh halinizi dinleyin ve dinlenmeye vakit ayırın.\n2. Bir yakınınızın halini hatırını içtenlikle sorun.\n3. İhtiyaç duyduğunuzda profesyonel psikolojik destek alın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Zihnin de bedenin kadar özen ister. 10 Ekim Dünya Ruh Sağlığı Günü'nde kendine şefkat göster. 🧠💚\"\n* \"10 Ekim Dünya Ruh Sağlığı Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #RuhSagligiGunu #WorldMentalHealthDay #YalnizDegilsin\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-ruh-sagligi-gunu\"",
    "celebration_date": "2026-10-10",
    "month_no": 10,
    "day_no": 10,
    "category": "Sağlık",
    "hashtags": [
      "#RuhSagligiGunu",
      "#WorldMentalHealthDay",
      "#YalnizDegilsin",
      "#Psikoloji"
    ],
    "affiliate_keywords": [
      "psikoloji kitapları çok satanlar",
      "meditasyon minderi",
      "aromaterapi difüzör"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000102",
    "slug": "dunya-kiz-cocuklari-gunu",
    "title": "11 Ekim Dünya Kız Çocukları Günü",
    "description": "Kız çocuklarının eğitim, sağlık, eşitlik ve güçlendirilmesi haklarına dikkat çekmek için BM tarafından kutlanır.",
    "content": "## 11 Ekim Dünya Kız Çocukları Günü Nedir?\n2012 yılında Türkiye, Kanada ve Peru'nun öncülüğünde BM Genel Kurulu'nda kabul edilen küresel bir farkındalık günüdür.\n\n### Tarihçesi ve Önemi\n2012 yılında Türkiye, Kanada ve Peru'nun öncülüğünde BM Genel Kurulu'nda kabul edilen küresel bir farkındalık günüdür. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 11 Ekim Dünya Kız Çocukları Günü Nasıl Kutlanır?\n1. Kız çocuklarının eğitimine destek veren burs fonlarına bağış yapın.\n2. Kız çocuklarına hayallerinin peşinden gitme cesareti verin.\n3. Cinsiyetçi kalıpları yıkın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Kız çocukları okursa dünya değişir! 11 Ekim Dünya Kız Çocukları Günü kutlu olsun. 👧📚✨\"\n* \"11 Ekim Dünya Kız Çocukları Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #KizCocuklariGunu #DayOfTheGirl #GucluKizlar\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kiz-cocuklari-gunu\"",
    "celebration_date": "2026-10-11",
    "month_no": 10,
    "day_no": 11,
    "category": "Farkındalık",
    "hashtags": [
      "#KizCocuklariGunu",
      "#DayOfTheGirl",
      "#GucluKizlar",
      "#EgitimHerkesIcin"
    ],
    "affiliate_keywords": [
      "ilham veren kadınlar çocuk kitabı",
      "bilim seti kız çocuk",
      "kodlama oyuncakları"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000103",
    "slug": "cumhuriyet-bayrami",
    "title": "29 Ekim Cumhuriyet Bayramı",
    "description": "Türkiye Cumhuriyeti'nin 1923 yılında Gazi Mustafa Kemal Atatürk tarafından ilan edildiği en büyük ulusal bayramımız.",
    "content": "## 29 Ekim Cumhuriyet Bayramı Nedir?\n29 Ekim 1923'te TBMM'de Cumhuriyet ilan edilmiş ve egemenlik kayıtsız şartsız millete teslim edilmiştir.\n\n### Tarihçesi ve Önemi\n29 Ekim 1923'te TBMM'de Cumhuriyet ilan edilmiş ve egemenlik kayıtsız şartsız millete teslim edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 29 Ekim Cumhuriyet Bayramı Nasıl Kutlanır?\n1. Evlerinize ve caddelere Türk Bayrakları asın.\n2. Törenlere, geçit alaylarına ve fener alaylarına katılın.\n3. Cumhuriyet değerlerini ve Atatürk ilkelerini hatırlayın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Cumhuriyetimizin ışığında, Atamızın izinde daima ileriye! 29 Ekim Cumhuriyet Bayramımız kutlu olsun! 🇹🇷✨\"\n* \"29 Ekim Cumhuriyet Bayramı kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #29Ekim #CumhuriyetBayrami #Ataturk\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #cumhuriyet-bayrami\"",
    "celebration_date": "2026-10-29",
    "month_no": 10,
    "day_no": 29,
    "category": "Resmi",
    "hashtags": [
      "#29Ekim",
      "#CumhuriyetBayrami",
      "#Ataturk",
      "#Cumhuriyet103Yasinda",
      "#Turkiye"
    ],
    "affiliate_keywords": [
      "türk bayrağı büyük boy",
      "atatürk rozeti",
      "nutuk özel baskı",
      "fener alayı meşalesi"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000104",
    "slug": "losemili-cocuklar-haftasi",
    "title": "2-8 Kasım Lösemili Çocuklar Haftası",
    "description": "Lösemi hastalığı konusunda bilinç oluşturmak ve minik kahramanlara umut olmak amacıyla düzenlenen farkındalık haftası.",
    "content": "## 2-8 Kasım Lösemili Çocuklar Haftası Nedir?\nLÖSEV öncülüğünde löseminin önlenebilir ve tedavi edilebilir bir hastalık olduğunu anlatmak amacıyla kutlanır.\n\n### Tarihçesi ve Önemi\nLÖSEV öncülüğünde löseminin önlenebilir ve tedavi edilebilir bir hastalık olduğunu anlatmak amacıyla kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 2-8 Kasım Lösemili Çocuklar Haftası Nasıl Kutlanır?\n1. Maske takarak sosyal medyada farkındalık fotoğrafları paylaşın.\n2. LÖSEV'e bağışta bulunun.\n3. Lösemi tedavisi gören çocuklara sevgi ve moral gönderin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Maskemizi takıyoruz, minik kahramanlarımızın yanındayız! Lösemili Çocuklar Haftası kutlu olsun. 🧡🎗️\"\n* \"2-8 Kasım Lösemili Çocuklar Haftası kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #LosemiliCocuklarHaftasi #MaskemiTakarimFarkindalikYaratirim #LÖSEV\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #losemili-cocuklar-haftasi\"",
    "celebration_date": "2026-11-02",
    "month_no": 11,
    "day_no": 2,
    "category": "Sağlık",
    "hashtags": [
      "#LosemiliCocuklarHaftasi",
      "#MaskemiTakarimFarkindalikYaratirim",
      "#LÖSEV",
      "#Umut"
    ],
    "affiliate_keywords": [
      "lösev hediyelik eşya",
      "renkli maske seti",
      "çocuk boyama seti"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000105",
    "slug": "ataturku-anma-gunu",
    "title": "10 Kasım Atatürk'ü Anma Günü",
    "description": "Türkiye Cumhuriyeti'nin kurucusu Gazi Mustafa Kemal Atatürk'ün ebediyete intikalinin yıl dönümü ve anma günü.",
    "content": "## 10 Kasım Atatürk'ü Anma Günü Nedir?\n10 Kasım 1938 günü saat 09:05'te Dolmabahçe Sarayı'nda vefat eden Atatürk'ün anısına her yıl ulusal saygı duruşuyla icra edilir.\n\n### Tarihçesi ve Önemi\n10 Kasım 1938 günü saat 09:05'te Dolmabahçe Sarayı'nda vefat eden Atatürk'ün anısına her yıl ulusal saygı duruşuyla icra edilir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 10 Kasım Atatürk'ü Anma Günü Nasıl Kutlanır?\n1. Saat 09:05'te sirenler eşliğinde 2 dakikalık saygı duruşunda bulunun.\n2. Anıtkabir'i ve Atatürk müzelerini ziyaret edin.\n3. Onun fikirlerini ve mirasını okuyun.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Beni görmek demek mutlaka yüzümü görmek değildir. Fikirlerimi anlıyorsanız bu kafidir. Saygı, sevgi ve özlemle anıyoruz. 🇹🇷🖤\"\n* \"10 Kasım Atatürk'ü Anma Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #10Kasim #Ataturk #SaygiVeOzlemle\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #ataturku-anma-gunu\"",
    "celebration_date": "2026-11-10",
    "month_no": 11,
    "day_no": 10,
    "category": "Resmi",
    "hashtags": [
      "#10Kasim",
      "#Ataturk",
      "#SaygiVeOzlemle",
      "#0905",
      "#Turkiye"
    ],
    "affiliate_keywords": [
      "atatürk portresi çerçeveli",
      "atatürk biyografi kitabı",
      "atatürk imzalı kupa",
      "nutuk ciltli"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000106",
    "slug": "dunya-diyabet-gunu",
    "title": "14 Kasım Dünya Diyabet Günü",
    "description": "İnsülinin kaşifi Frederick Banting'in doğum gününde diyabet hastalığı ve dengeli beslenme bilincini artıran gün.",
    "content": "## 14 Kasım Dünya Diyabet Günü Nedir?\nUluslararası Diyabet Federasyonu ve DSÖ tarafından artan şeker hastalığı riskine karşı 'Mavi Halka' sembolüyle kutlanır.\n\n### Tarihçesi ve Önemi\nUluslararası Diyabet Federasyonu ve DSÖ tarafından artan şeker hastalığı riskine karşı 'Mavi Halka' sembolüyle kutlanır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 14 Kasım Dünya Diyabet Günü Nasıl Kutlanır?\n1. Kan şekeri ölçümünüzü ve HbA1c testinizi yaptırın.\n2. Şekerli ve işlenmiş gıdalardan uzak durun.\n3. Günlük hareketinizi artırın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Farkında ol, kontrol sende olsun! 14 Kasım Dünya Diyabet Günü'nde sağlıklı yaşamı seçelim. 🔵🩺\"\n* \"14 Kasım Dünya Diyabet Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DiyabetGunu #MaviHalka #SekerHastaligi\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-diyabet-gunu\"",
    "celebration_date": "2026-11-14",
    "month_no": 11,
    "day_no": 14,
    "category": "Sağlık",
    "hashtags": [
      "#DiyabetGunu",
      "#MaviHalka",
      "#SekerHastaligi",
      "#DengeliBeslen"
    ],
    "affiliate_keywords": [
      "şeker ölçüm cihazı stripli",
      "şekersiz tatlandırıcı",
      "diyabet tarifleri kitabı"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000107",
    "slug": "dunya-cocuk-haklari-gunu",
    "title": "20 Kasım Dünya Çocuk Hakları Günü",
    "description": "BM Çocuk Haklarına Dair Sözleşme'nin kabul edildiği gün, her çocuğun sağlık, eğitim ve korunma hakkını savunur.",
    "content": "## 20 Kasım Dünya Çocuk Hakları Günü Nedir?\n20 Kasım 1989'da Birleşmiş Milletler Genel Kurulu tarafından Çocuk Hakları Sözleşmesi oy birliğiyle kabul edilmiştir.\n\n### Tarihçesi ve Önemi\n20 Kasım 1989'da Birleşmiş Milletler Genel Kurulu tarafından Çocuk Hakları Sözleşmesi oy birliğiyle kabul edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 20 Kasım Dünya Çocuk Hakları Günü Nasıl Kutlanır?\n1. Çocukların sesini dinleyin ve fikirlerine saygı gösterin.\n2. Çocuk istismarı ve çocuk işçiliğine karşı ses çıkarın.\n3. Çocuk koruma derneklerine destek verin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Bütün çocuklar sevgi dolu ve eşit bir dünyayı hak eder! 20 Kasım Dünya Çocuk Hakları Günü kutlu olsun. 🧒🎈👧\"\n* \"20 Kasım Dünya Çocuk Hakları Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #CocukHaklariGunu #HerCocukIcinHaklar #UNICEF\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-cocuk-haklari-gunu\"",
    "celebration_date": "2026-11-20",
    "month_no": 11,
    "day_no": 20,
    "category": "Farkındalık",
    "hashtags": [
      "#CocukHaklariGunu",
      "#HerCocukIcinHaklar",
      "#UNICEF",
      "#Gelecegimiz"
    ],
    "affiliate_keywords": [
      "çocuk hakları resimli kitap",
      "eğitici kutu oyunları",
      "çocuk gelişim kitapları"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000108",
    "slug": "dis-hekimleri-gunu",
    "title": "22 Kasım Diş Hekimleri Günü",
    "description": "Türkiye'de ilk Dişçi Mektebi'nin kuruluş yıl dönümünde ağız ve diş sağlığı kahramanlarına adanan gün.",
    "content": "## 22 Kasım Diş Hekimleri Günü Nedir?\n22 Kasım 1908'de Dişçi Mekteb-i Aliyesi kurulmuş ve bu hafta Ağız Diş Sağlığı Haftası olarak kutlanmaya başlanmıştır.\n\n### Tarihçesi ve Önemi\n22 Kasım 1908'de Dişçi Mekteb-i Aliyesi kurulmuş ve bu hafta Ağız Diş Sağlığı Haftası olarak kutlanmaya başlanmıştır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 22 Kasım Diş Hekimleri Günü Nasıl Kutlanır?\n1. 6 aylık rutin diş hekimi kontrolünüzü yaptırın.\n2. Günde 2 kez dişlerinizi fırçalayın ve diş ipi kullanın.\n3. Diş hekiminize teşekkür edin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Sağlıklı gülüşlerimizin mimarı diş hekimlerimizin 22 Kasım Diş Hekimleri Günü kutlu olsun! 🦷🪥\"\n* \"22 Kasım Diş Hekimleri Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DisHekimleriGunu #AgizVeDisSagligi #Gulumse\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dis-hekimleri-gunu\"",
    "celebration_date": "2026-11-22",
    "month_no": 11,
    "day_no": 22,
    "category": "Sağlık",
    "hashtags": [
      "#DisHekimleriGunu",
      "#AgizVeDisSagligi",
      "#Gulumse",
      "#DisHekimi"
    ],
    "affiliate_keywords": [
      "şarjlı diş fırçası",
      "ağız duşu cihazı",
      "diş hekimi esprili kupa",
      "diş ipi seti"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000109",
    "slug": "ogretmenler-gunu",
    "title": "24 Kasım Öğretmenler Günü",
    "description": "Mustafa Kemal Atatürk'ün Millet Mektepleri Başöğretmenliği unvanını kabul ettiği günün anısına kutlanır.",
    "content": "## 24 Kasım Öğretmenler Günü Nedir?\n24 Kasım 1928'de Atatürk Başöğretmen unvanını kabul etmiş, 1981'den bu yana Türkiye'de Öğretmenler Günü olarak kutlanmaktadır.\n\n### Tarihçesi ve Önemi\n24 Kasım 1928'de Atatürk Başöğretmen unvanını kabul etmiş, 1981'den bu yana Türkiye'de Öğretmenler Günü olarak kutlanmaktadır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 24 Kasım Öğretmenler Günü Nasıl Kutlanır?\n1. Öğretmenlerinizi arayıp vefa ve teşekkürlerinizi iletin.\n2. Emekli öğretmenleri ziyaret edin.\n3. Eğitime katkı sağlayan projelere destek verin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Geleceğimizin mimarı fedakar öğretmenlerimizin 24 Kasım Öğretmenler Günü kutlu olsun! 💐🧑‍🏫\"\n* \"24 Kasım Öğretmenler Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #24Kasim #OgretmenlerGunu #Basogretmen\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #ogretmenler-gunu\"",
    "celebration_date": "2026-11-24",
    "month_no": 11,
    "day_no": 24,
    "category": "Mesleki",
    "hashtags": [
      "#24Kasim",
      "#OgretmenlerGunu",
      "#Basogretmen",
      "#CanimOgretmenim"
    ],
    "affiliate_keywords": [
      "isme özel öğretmen dolma kalemi",
      "öğretmenler günü hediye kutusu",
      "çiçek buketi",
      "deri ajanda"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000110",
    "slug": "dunya-engelliler-gunu",
    "title": "3 Aralık Dünya Engelliler Günü",
    "description": "Engelli bireylerin haklarına, toplumsal hayata tam katılımlarına ve erişilebilirliğe dikkat çeken BM günü.",
    "content": "## 3 Aralık Dünya Engelliler Günü Nedir?\n1992 yılında BM Genel Kurulu tarafından engellilerin haklarını savunmak ve farkındalık yaratmak amacıyla ilan edilmiştir.\n\n### Tarihçesi ve Önemi\n1992 yılında BM Genel Kurulu tarafından engellilerin haklarını savunmak ve farkındalık yaratmak amacıyla ilan edilmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 3 Aralık Dünya Engelliler Günü Nasıl Kutlanır?\n1. Şehirlerimizin ve binalarımızın engelsiz ve erişilebilir olmasını talep edin.\n2. Engelli otoparklarına ve rampalarına araç park etmeyin.\n3. Sevgi ve empatiyle engelleri birlikte kaldırın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"En büyük engel sevgisizliktir. 3 Aralık Dünya Engelliler Günü'nde engelleri sevgi ve dayanışmayla aşıyoruz! ♿🤝💛\"\n* \"3 Aralık Dünya Engelliler Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #3Aralik #DunyaEngellilerGunu #SevgiVarsaEngelYok\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-engelliler-gunu\"",
    "celebration_date": "2026-12-03",
    "month_no": 12,
    "day_no": 3,
    "category": "Farkındalık",
    "hashtags": [
      "#3Aralik",
      "#DunyaEngellilerGunu",
      "#SevgiVarsaEngelYok",
      "#Erisilebilirlik"
    ],
    "affiliate_keywords": [
      "tekerlekli sandalye minderi",
      "ergonomik tutacak seti",
      "sesli uyarı cihazı"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000111",
    "slug": "dunya-turk-kahvesi-gunu",
    "title": "5 Aralık Dünya Türk Kahvesi Günü",
    "description": "UNESCO tarafından Somut Olmayan Kültürel Miras listesine alınan Türk Kahvesi kültürünün küresel kutlaması.",
    "content": "## 5 Aralık Dünya Türk Kahvesi Günü Nedir?\n5 Aralık 2013'te UNESCO, Türk Kahvesi Kültürü ve Geleneği'ni İnsanlığın Somut Olmayan Kültürel Mirası Temsili Listesi'ne kaydetmiştir.\n\n### Tarihçesi ve Önemi\n5 Aralık 2013'te UNESCO, Türk Kahvesi Kültürü ve Geleneği'ni İnsanlığın Somut Olmayan Kültürel Mirası Temsili Listesi'ne kaydetmiştir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 5 Aralık Dünya Türk Kahvesi Günü Nasıl Kutlanır?\n1. Bakır cezvede bol köpüklü okkalı bir Türk kahvesi pişirin.\n2. Yanında lokum ve bir bardak su ile geleneksel sunum yapın.\n3. Sevdiklerinizle kırk yıllık hatır sohbeti edin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Gönül ne kahve ister ne kahvehane, gönül sohbet ister kahve bahane. 5 Aralık Dünya Türk Kahvesi Günü kutlu olsun! ☕🇹🇷\"\n* \"5 Aralık Dünya Türk Kahvesi Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #DunyaTurkKahvesiGunu #TurkKahvesi #UNESCO\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-turk-kahvesi-gunu\"",
    "celebration_date": "2026-12-05",
    "month_no": 12,
    "day_no": 5,
    "category": "Kültür & Sanat",
    "hashtags": [
      "#DunyaTurkKahvesiGunu",
      "#TurkKahvesi",
      "#UNESCO",
      "#KahveKulturu"
    ],
    "affiliate_keywords": [
      "otomatik türk kahvesi makinesi",
      "bakır cezve seti",
      "türk kahvesi fincan takımı",
      "hacı bekir lokumu"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000112",
    "slug": "dunya-kadin-haklari-gunu",
    "title": "5 Aralık Dünya Kadın Hakları Günü",
    "description": "Türk kadınlarına seçme ve seçilme hakkının birçok Avrupa ülkesinden önce verildiği tarihi gün.",
    "content": "## 5 Aralık Dünya Kadın Hakları Günü Nedir?\n5 Aralık 1934'te Gazi Mustafa Kemal Atatürk'ün önderliğinde Türk kadınlarına milletvekili seçme ve seçilme hakkı tanınmıştır.\n\n### Tarihçesi ve Önemi\n5 Aralık 1934'te Gazi Mustafa Kemal Atatürk'ün önderliğinde Türk kadınlarına milletvekili seçme ve seçilme hakkı tanınmıştır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 5 Aralık Dünya Kadın Hakları Günü Nasıl Kutlanır?\n1. Kadınların siyasette ve yönetimde eşit temsilini savunun.\n2. Atatürk'ün kadın haklarına verdiği önemi hatırlayın.\n3. Kadınların başarılarını kutlayın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Dünyada hiçbir milletin kadını 'Ben Anadolu kadınından daha fazla çalıştım' diyemez. 5 Aralık Kadın Hakları Günü kutlu olsun! 🇹🇷👩‍💼\"\n* \"5 Aralık Dünya Kadın Hakları Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #5Aralik #KadinHaklariGunu #SecmeVeSecilmeHakki\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-kadin-haklari-gunu\"",
    "celebration_date": "2026-12-05",
    "month_no": 12,
    "day_no": 5,
    "category": "Farkındalık",
    "hashtags": [
      "#5Aralik",
      "#KadinHaklariGunu",
      "#SecmeVeSecilmeHakki",
      "#Ataturk"
    ],
    "affiliate_keywords": [
      "kadın liderler biyografi kitabı",
      "özel tasarım takı seti",
      "fular ipek"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000113",
    "slug": "dunya-insan-haklari-gunu",
    "title": "10 Aralık Dünya İnsan Hakları Günü",
    "description": "1948 yılında BM İnsan Hakları Evrensel Beyannamesi'nin kabul edildiği, temel hak ve özgürlüklerin günü.",
    "content": "## 10 Aralık Dünya İnsan Hakları Günü Nedir?\nTüm insanların özgür, eşit ve onurlu doğduğunu dünyaya ilan eden İnsan Hakları Evrensel Beyannamesi'nin kabul günüdür.\n\n### Tarihçesi ve Önemi\nTüm insanların özgür, eşit ve onurlu doğduğunu dünyaya ilan eden İnsan Hakları Evrensel Beyannamesi'nin kabul günüdür. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 10 Aralık Dünya İnsan Hakları Günü Nasıl Kutlanır?\n1. İnsan Hakları Evrensel Beyannamesi'nin maddelerini okuyun.\n2. Ayrımcılığa ve adaletsizliğe karşı ses çıkarın.\n3. İnsan hakları savunucularını destekleyin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Bütün insanlar hür, haysiyet ve haklar bakımından eşit doğarlar. 10 Aralık İnsan Hakları Günü kutlu olsun! ⚖️🕊️\"\n* \"10 Aralık Dünya İnsan Hakları Günü kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #10Aralik #InsanHaklariGunu #HumanRightsDay\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #dunya-insan-haklari-gunu\"",
    "celebration_date": "2026-12-10",
    "month_no": 12,
    "day_no": 10,
    "category": "Farkındalık",
    "hashtags": [
      "#10Aralik",
      "#InsanHaklariGunu",
      "#HumanRightsDay",
      "#Esitlik"
    ],
    "affiliate_keywords": [
      "insan hakları evrensel beyannamesi kitap",
      "felsefe ve etik kitapları"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000114",
    "slug": "en-uzun-gece",
    "title": "21 Aralık En Uzun Gece (Kış Gündönümü)",
    "description": "Kuzey yarımkürede yılın en uzun gecesinin yaşandığı ve kış mevsiminin astronomik olarak başladığı gün.",
    "content": "## 21 Aralık En Uzun Gece (Kış Gündönümü) Nedir?\nKuzey yarımkürede Güneş ışınlarının Oğlak Dönencesi'ne dik geldiği, en uzun gecenin ve en kısa gündüzün yaşandığı doğa olayıdır.\n\n### Tarihçesi ve Önemi\nKuzey yarımkürede Güneş ışınlarının Oğlak Dönencesi'ne dik geldiği, en uzun gecenin ve en kısa gündüzün yaşandığı doğa olayıdır. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 21 Aralık En Uzun Gece (Kış Gündönümü) Nasıl Kutlanır?\n1. Sıcak çikolatanızı veya kahvenizi alıp sevdiklerinizle uzun bir film maratonu yapın.\n2. Kitap okuyarak gecenin sessizliğinin tadını çıkarın.\n3. Gece yürüyüşü yapıp kış havasını hissedin.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"En uzun gece bile yerini aydınlık bir sabaha bırakır! 21 Aralık Kış Gündönümü kutlu ve huzurlu olsun. 🌙❄️⭐\"\n* \"21 Aralık En Uzun Gece (Kış Gündönümü) kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #21Aralik #EnUzunGece #KisGundonumu\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #en-uzun-gece\"",
    "celebration_date": "2026-12-21",
    "month_no": 12,
    "day_no": 21,
    "category": "Eğlence",
    "hashtags": [
      "#21Aralik",
      "#EnUzunGece",
      "#KisGundonumu",
      "#Gece"
    ],
    "affiliate_keywords": [
      "kokulu mum seti",
      "polar battaniye",
      "film izleme projeksiyon",
      "termos kupa"
    ]
  },
  {
    "id": "f8b9a112-9844-48f8-b3f1-000000000115",
    "slug": "yilbasi-gecesi",
    "title": "31 Aralık Yılbaşı Gecesi",
    "description": "Bir yılın son anlarını geride bırakıp yeni umutlarla gelecek yıla adım atılan tüm dünyada coşkuyla kutlanan gece.",
    "content": "## 31 Aralık Yılbaşı Gecesi Nedir?\nEski yılı uğurlayıp yeni yılın ilk dakikalarını karşılamak için aile ve dostlarla bir araya gelinen evrensel kutlama gecesidir.\n\n### Tarihçesi ve Önemi\nEski yılı uğurlayıp yeni yılın ilk dakikalarını karşılamak için aile ve dostlarla bir araya gelinen evrensel kutlama gecesidir. Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.\n\n---\n\n## 31 Aralık Yılbaşı Gecesi Nasıl Kutlanır?\n1. Sevdiklerinizle zengin bir yılbaşı sofrasında toplanın.\n2. Geçen yılın anılarını yad edin ve geleceğe dilekler tutun.\n3. Geri sayımla yeni yılı coşkuyla karşılayın.\n\n---\n\n## Sosyal Medya Paylaşım ve Kutlama Mesajları\n* \"Giden yıl tüm yorgunlukları alsın, gelen yıl tüm hayallerinizi gerçekleştirsin! Yılbaşı geceniz kutlu olsun! 🎆🥂✨\"\n* \"31 Aralık Yılbaşı Gecesi kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. #YilbasiGecesi #GuleGule2026 #YeniYilKutlamasi\"\n* \"Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #yilbasi-gecesi\"",
    "celebration_date": "2026-12-31",
    "month_no": 12,
    "day_no": 31,
    "category": "Eğlence",
    "hashtags": [
      "#YilbasiGecesi",
      "#GuleGule2026",
      "#YeniYilKutlamasi",
      "#31Aralik"
    ],
    "affiliate_keywords": [
      "yılbaşı çam ağacı süsü",
      "parti kutlama şapkası",
      "kutu masa oyunu",
      "ışıklı peri led"
    ]
  }
];
