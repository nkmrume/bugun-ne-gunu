import fs from 'fs';
import path from 'path';

// Complete curated list of 130+ special days in Turkey and worldwide for 2026
const rawDays = [
{
  "slug": "dunya-hijyen-gunu",
  "title": "16 Ocak Dünya Hijyen Günü",
  "description": "Kişisel temizlik, el yıkama ve halk sağlığını koruma alışkanlıklarını hatırlatan gün.",
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
  ],
  "nedir": "Kişisel hijyenin salgın hastalıklardan korunmadaki en etkili ve ucuz yöntem olduğunu vurgulamak amacıyla kutlanır.",
  "nasil": "1. Ellerinizi en az 20 saniye sabunla doğru şekilde yıkayın.\n2. Yaşam alanlarınızı düzenli havalandırın ve temizleyin.\n3. Çocuklara hijyen kurallarını öğretin.",
  "mesaj": "Temizlik imandandır ve sağlığın başıdır! 16 Ocak Dünya Hijyen Günü kutlu olsun. 🧼🫧"
},
{
  "slug": "dunya-gumruk-gunu",
  "title": "26 Ocak Dünya Gümrük Günü",
  "description": "Uluslararası ticaretin güvenliği ve gümrük çalışanlarının fedakarlıklarını onurlandıran gün.",
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
  ],
  "nedir": "Dünya Gümrük Örgütü'nün ilk toplantısını yaptığı 26 Ocak 1953 anısına küresel ticaretin güvenliğini kutlar.",
  "nasil": "1. Gümrük emekçilerine teşekkür edin.\n2. Yasal ve kayıtlı ticaretin önemini öğrenin.\n3. Kaçakçılıkla mücadeleye dikkat çekin.",
  "mesaj": "Sınırlarımızın ve ekonomimizin bekçisi tüm gümrük çalışanlarımızın Dünya Gümrük Günü kutlu olsun! 🛃🚢"
},
{
  "slug": "sivil-savunma-gunu",
  "title": "28 Şubat Sivil Savunma Günü",
  "description": "Deprem, yangın ve afetlere karşı hazırlıklı olma ve sivil savunma bilincini artıran gün.",
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
  ],
  "nedir": "7126 sayılı Sivil Savunma Kanunu'nun yürürlüğe girdiği 28 Şubat, afetlere karşı bilinçli toplum inşası için kutlanır.",
  "nasil": "1. Evinizde ve iş yerinizde deprem çantanızı güncelleyin.\n2. Ailenizle afet toplanma alanınızı kontrol edin.\n3. Yangın ve tahliye tatbikatlarına katılın.",
  "mesaj": "Afetlere hazırlıklı olmak hayat kurtarır! 28 Şubat Sivil Savunma Günü kutlu olsun. 🚨🎒"
},
{
  "slug": "dunya-tuketici-haklari-gunu",
  "title": "15 Mart Dünya Tüketici Hakları Günü",
  "description": "Tüketicilerin güvenlik, bilgilendirilme ve zararların tazmini haklarını savunan uluslararası gün.",
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
  ],
  "nedir": "1962 yılında ABD Başkanı John F. Kennedy'nin Tüketici Hakları Bildirgesi'ni açıkladığı günün anısına kutlanır.",
  "nasil": "1. Alışverişlerinizde fatura ve fiş almayı ihmal etmeyin.\n2. Tüketici Hakem Heyetleri'ne başvurma haklarınızı öğrenin.\n3. Yanıltıcı reklamlara karşı bilinçli olun.",
  "mesaj": "Bilinçli tüketici güçlü toplum demektir! 15 Mart Dünya Tüketici Hakları Günü kutlu olsun. 🛍️⚖️"
},
{
  "slug": "dunya-siir-gunu",
  "title": "21 Mart Dünya Şiir Günü",
  "description": "Duyguların en saf ifadesi olan şiir sanatını, şairleri ve sözcüklerin büyüsünü kutlayan UNESCO günü.",
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
  ],
  "nedir": "UNESCO tarafından 1999 yılında şiirin diller arası köprü kurma gücünü onurlandırmak amacıyla kabul edilmiştir.",
  "nasil": "1. En sevdiğiniz şairden bir şiir okuyup paylaşın.\n2. Kendi duygularınızı mısralara dökün.\n3. Şiir dinletilerine katılın.",
  "mesaj": "Şiir hayatın nefesidir. 21 Mart Dünya Şiir Günü'nde yüreğinizden şiirler eksik olmasın! 📜🖋️"
},
{
  "slug": "dunya-meteoroloji-gunu",
  "title": "23 Mart Dünya Meteoroloji Günü",
  "description": "Hava durumu tahminleri, iklim bilimi ve erken uyarı sistemlerinin hayat kurtarıcı rolünü kutlayan gün.",
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
  ],
  "nedir": "Dünya Meteoroloji Örgütü'nün (WMO) 1950'de yürürlüğe giren sözleşmesinin yıl dönümü anısına kutlanır.",
  "nasil": "1. İklim değişikliğinin hava olayları üzerindeki etkilerini inceleyin.\n2. Afet erken uyarı bildirimlerini takip edin.\n3. Meteoroloji çalışanlarına teşekkür edin.",
  "mesaj": "Hava şartları ne olursa olsun kalbiniz güneşli olsun! 23 Mart Dünya Meteoroloji Günü kutlu olsun. ☀️🌧️🌈"
},
{
  "slug": "dunya-saka-gunu",
  "title": "1 Nisan Şaka Günü",
  "description": "Tüm dünyada insanların birbirine zararsız, neşeli ve zekice şakalar yaptığı kahkaha dolu gün.",
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
  ],
  "nedir": "Kökeni 16. yüzyıl Fransa takvim reformuna dayanan 1 Nisan, asırlardır dünya genelinde şakalarla kutlanmaktadır.",
  "nasil": "1. Arkadaşlarınıza kırıcı olmayan sevimli bir şaka yapın.\n2. Bol bol gülün ve mizahın tadını çıkarın.\n3. Size yapılan şakalara tebessümle karşılık verin.",
  "mesaj": "Gülmek en güzel şifadır! 1 Nisan Şaka Günü'nüz bol tebessümlü ve kahkahalı geçsin! 🎭😄"
},
{
  "slug": "polis-teskilati-kurulus-gunu",
  "title": "10 Nisan Türk Polis Teşkilatı Kuruluş Günü",
  "description": "Huzur, güvenlik ve asayişimizin teminatı olan Türk Polis Teşkilatı'nın kuruluşunu kutlayan gün.",
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
  ],
  "nedir": "10 Nisan 1845'te kurulan Türk Polis Teşkilatı, milletimizin can ve mal emniyetini sağlamak için görev yapmaktadır.",
  "nasil": "1. Görev başındaki polis memurlarına kolaylıklar dileyin.\n2. Şehit polislerimizi dualarla anın.\n3. Trafik ve asayiş kurallarına uyun.",
  "mesaj": "Huzurumuzun ve güvenliğimizin teminatı kahraman polislerimizin 10 Nisan Polis Haftası kutlu olsun! 👮‍♂️🇹🇷"
},
{
  "slug": "dunya-pilotlar-gunu",
  "title": "26 Nisan Dünya Pilotlar Günü",
  "description": "Türkiye'nin 1 numaralı pilot brövesi sahibi Fesa Evrensev'in anısına tüm dünyada kutlanan havacılık günü.",
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
  ],
  "nedir": "Türkiye Havayolu Pilotları Derneği'nin (TALPA) önerisiyle IFALPA tarafından Fesa Evrensev'in ilk uçuş günü kabul edilmiştir.",
  "nasil": "1. Gökyüzünün cesur kaptanlarına teşekkür edin.\n2. Havacılık müzelerini gezin.\n3. Uçuş simülasyonu deneyin.",
  "mesaj": "İstikbal göklerdedir! Kanatlarıyla dünyayı birbirine bağlayan tüm pilotlarımızın günü kutlu olsun! ✈️👨‍✈️👩‍✈️"
},
{
  "slug": "uluslararasi-caz-gunu",
  "title": "30 Nisan Uluslararası Caz Günü",
  "description": "Özgürlüğün, doğaçlamanın ve diyalogun müziği olan cazı onurlandıran UNESCO günü.",
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
  ],
  "nedir": "UNESCO iyi niyet elçisi caz efsanesi Herbie Hancock öncülüğünde 2011 yılında ilan edilmiştir.",
  "nasil": "1. Miles Davis, Louis Armstrong veya Türk caz sanatçılarını dinleyin.\n2. Bir caz kulübünü ziyaret edin.\n3. Plak dinleme gecesi yapın.",
  "mesaj": "Caz özgürlüğün sesidir. 30 Nisan Uluslararası Caz Günü'nde notaların büyüsüne kapılın! 🎷🎺🎶"
},
{
  "slug": "basin-ozgurlugu-gunu",
  "title": "3 Mayıs Dünya Basın Özgürlüğü Günü",
  "description": "Bağımsız, sansürsüz ve özgür basının demokrasilerdeki hayati önemini hatırlatan BM günü.",
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
  ],
  "nedir": "1993 yılında BM Genel Kurulu tarafından hükümetlere basın özgürlüğünü koruma taahhüdünü hatırlatmak için ilan edilmiştir.",
  "nasil": "1. Bağımsız gazetecileri ve medya kuruluşlarını destekleyin.\n2. Dezenformasyona karşı doğru haberi teyit edin.\n3. Sansüre karşı düşünce özgürlüğünü savunun.",
  "mesaj": "Özgür basın halkın nefes borusudur. 3 Mayıs Dünya Basın Özgürlüğü Günü kutlu olsun! 📰✍️"
},
{
  "slug": "hidirellez",
  "title": "5 Mayıs Hıdırellez Kültür Bayramı",
  "description": "Hızır ve İlyas peygamberlerin yeryüzünde buluştuğu gün olarak kabul edilen köklü bahar bayramı.",
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
  ],
  "nedir": "UNESCO İnsanlığın Somut Olmayan Kültürel Mirası Temsili Listesi'nde yer alan Hıdırellez, baharın ve bereketin müjdecisidir.",
  "nasil": "1. Gül ağacının altına dileklerinizi çizin veya asın.\n2. Ateşin üzerinden atlayarak yeni başlangıçlara niyet edin.\n3. Doğada sevdiklerinizle piknik yapın.",
  "mesaj": "Hızır yoldaşınız, dilekleriniz gerçek olsun! Hıdırellez Bayramınız bereket ve sağlık getirsin. 🌾🔥🌸"
},
{
  "slug": "dunya-psikologlar-gunu",
  "title": "10 Mayıs Dünya Psikologlar Günü",
  "description": "İnsan ruhunu anlamak, iyileştirmek ve toplumsal esenliği sağlamak için çalışan psikologlara adanan gün.",
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
  ],
  "nedir": "Ruh sağlığı alanında çalışan psikologların mesleki dayanışmasını güçlendirmek amacıyla kutlanır.",
  "nasil": "1. Psikolog dostlarınıza tebrik mesajı iletin.\n2. Psikolojik sağlığın önemini çevrenize anlatın.\n3. Kendinize şefkat göstermeyi öğrenin.",
  "mesaj": "Ruhumuza ayna tutan, karanlık yollarımızı aydınlatan tüm psikologlarımızın günü kutlu olsun! 🧠🛋️"
},
{
  "slug": "eczacilik-gunu",
  "title": "14 Mayıs Eczacılık Günü",
  "description": "Türkiye'de bilimsel eczacılık eğitiminin başladığı günün anısına sağlık danışmanımız eczacılara adanan gün.",
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
  ],
  "nedir": "14 Mayıs 1839'da Mekteb-i Tıbbiye-i Adliye-i Şahane bünyesinde ilk eczacı sınıfının açılmasıyla bilimsel eczacılık başlamıştır.",
  "nasil": "1. Mahallenizin eczacısına teşekkür edin.\n2. İlaçları mutlaka hekim ve eczacı kontrolünde kullanın.\n3. Akılcı ilaç kullanımına özen gösterin.",
  "mesaj": "Sağlığımızın en yakın danışmanı olan tüm fedakar eczacılarımızın 14 Mayıs Eczacılık Günü kutlu olsun! 💊⚕️"
},
{
  "slug": "uluslararasi-aile-gunu",
  "title": "15 Mayıs Uluslararası Aile Günü",
  "description": "Toplumun temel taşı olan ailenin korunması, sevgi ve dayanışmanın güçlendirilmesi için kutlanan BM günü.",
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
  ],
  "nedir": "1993 yılında BM Genel Kurulu tarafından aile kurumunun önemine dikkat çekmek için kabul edilmiştir.",
  "nasil": "1. Ailenizle birlikte televizyonsuz ve ekransız bir akşam yemeği yiyin.\n2. Eski aile fotoğraflarını birlikte inceleyin.\n3. Birbirinize olan sevginizi sözlerle ifade edin.",
  "mesaj": "Hayattaki en büyük zenginlik huzurlu bir ailedir. 15 Mayıs Uluslararası Aile Günü kutlu olsun! 👨‍👩‍👧‍👦🏡❤️"
},
{
  "slug": "muzeler-gunu",
  "title": "18 Mayıs Müzeler Günü",
  "description": "Kültürel mirasımızı koruyan, geçmiş ile gelecek arasında köprü kuran müzelerin uluslararası kutlaması.",
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
  ],
  "nedir": "Uluslararası Müzeler Konseyi (ICOM) tarafından 1977 yılından bu yana toplumda müze bilincini yaymak için kutlanır.",
  "nasil": "1. Bugün en yakın müzeyi ücretsiz veya indirimli gezin.\n2. Tarihi eserlerin korunması bilincini çocuklara aktarın.\n3. Arkeolojik kazılar hakkında bilgi edinin.",
  "mesaj": "Geçmişini bilmeyen geleceğini inşa edemez. 18 Mayıs Müzeler Günü kutlu olsun! 🏛️🏺🗿"
},
{
  "slug": "dunya-sut-gunu",
  "title": "21 Mayıs Dünya Süt Günü",
  "description": "Sağlıklı kemik ve kas gelişimi için sütün beslenmedeki vazgeçilmez yerini vurgulayan FAO günü.",
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
  ],
  "nedir": "BM Gıda ve Tarım Örgütü (FAO) tarafından süt sektörünü ve sağlıklı beslenmeyi desteklemek için ilan edilmiştir.",
  "nasil": "1. Günde en az bir bardak süt veya süt ürünü tüketin.\n2. Çocuklara süt içme alışkanlığı kazandırın.\n3. Yerel süt üreticilerini destekleyin.",
  "mesaj": "Sağlıklı nesiller için her gün bir bardak süt! 21 Mayıs Dünya Süt Günü kutlu olsun. 🥛🐮"
},
{
  "slug": "biyocesitlilik-gunu",
  "title": "22 Mayıs Uluslararası Biyoçeşitlilik Günü",
  "description": "Gezegenimizdeki tüm türlerin, ekosistemlerin ve genetik zenginliğin korunması için BM tarafından kutlanır.",
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
  ],
  "nedir": "1992 Biyolojik Çeşitlilik Sözleşmesi'nin kabul edildiği gün olan 22 Mayıs, ekolojik dengenin korunması için kutlanır.",
  "nasil": "1. Endemik bitki ve hayvan türlerini tanıyın.\n2. Doğal yaşam alanlarına zarar vermekten kaçının.\n3. Kimyasal kirliliği azaltın.",
  "mesaj": "Doğadaki her canlı hayat zincirinin vazgeçilmez bir halkasıdır. 22 Mayıs Biyoçeşitlilik Günü kutlu olsun! 🌿🦋🦜"
},
{
  "slug": "dunya-tutunsuz-gunu",
  "title": "31 Mayıs Dünya Tütünsüz Günü",
  "description": "Tütün salgınının yol açtığı ölümlere dikkat çeken ve dumansız bir dünya hedefleyen DSÖ günü.",
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
  ],
  "nedir": "Dünya Sağlık Örgütü tarafından tütün tüketimini azaltmak ve pasif içiciliği önlemek için 1987'de kabul edilmiştir.",
  "nasil": "1. Bugün 24 saat boyunca sigara içmeyin ve bırakmaya ilk adımı atın.\n2. Pasif içiciliğin zararlarından çocukları koruyun.\n3. Dumansız alanları destekleyin.",
  "mesaj": "Nefes al, hayatı hisset! 31 Mayıs Dünya Tütünsüz Günü'nde temiz bir havaya adım at. 🚭🫁💚"
},
{
  "slug": "dunya-cocuk-gunu",
  "title": "1 Haziran Dünya Çocuk Günü",
  "description": "Çocukların refahını, güvenliğini ve mutluluğunu kutlayan uluslararası çocuk günü.",
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
  ],
  "nedir": "1925 yılında Cenevre Çocukların Refahı Dünya Konferansı'nda ilan edilen ilk uluslararası çocuk günüdür.",
  "nasil": "1. Bir çocuğu sevindirin ve ona hediye verin.\n2. Çocukların oyun ve eğlence hakkına saygı gösterin.\n3. İhtiyaç sahibi çocuklara destek olun.",
  "mesaj": "Dünya çocukların güldüğü kadar güzeldir! 1 Haziran Dünya Çocuk Günü kutlu olsun! 🎈👶👧"
},
{
  "slug": "turk-isaret-dili-gunu",
  "title": "7 Haziran Türk İşaret Dili Günü",
  "description": "İşitme engelli bireylerin iletişim dili olan Türk İşaret Dili'nin yasal olarak tanındığı gün.",
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
  ],
  "nedir": "5378 sayılı Engelliler Kanunu'nda Türk İşaret Dili'nin resmi olarak yer aldığı 7 Haziran 2005 tarihinin anısına kutlanır.",
  "nasil": "1. Türk İşaret Dili'nde temel selamlaşma ve teşekkür kelimelerini öğrenin.\n2. Kamusal yayınlarda işaret dili çevirisi talep edin.\n3. İşitme engellilerin toplumsal hayata katılımını destekleyin.",
  "mesaj": "Ellerimiz konuşsun, kalplerimiz buluşsun! 7 Haziran Türk İşaret Dili Günü kutlu olsun. 🤟🤲✨"
},
{
  "slug": "dunya-yoga-gunu",
  "title": "21 Haziran Dünya Yoga Günü",
  "description": "Beden, zihin ve ruh dengesini kuran kadim yoga öğretisinin evrensel faydalarını kutlayan BM günü.",
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
  ],
  "nedir": "2014 yılında BM Genel Kurulu tarafından kabul edilen gün, içsel huzur ve bütünsel sağlığı teşvik eder.",
  "nasil": "1. Açık havada veya evinizde 20 dakikalık bir yoga seansı yapın.\n2. Derin nefes egzersizleriyle zihninizi dinlendirin.\n3. Bedeninizin esnekliğine kulak verin.",
  "mesaj": "İçindeki huzuru keşfet. 21 Haziran Dünya Yoga Günü kutlu olsun! 🧘‍♀️🕉️🧘‍♂️"
},
{
  "slug": "dunya-sosyal-medya-gunu",
  "title": "30 Haziran Dünya Sosyal Medya Günü",
  "description": "İnsanları kıtalar ötesinde birbirine bağlayan dijital iletişim devrimini kutlayan küresel gün.",
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
  ],
  "nedir": "2010 yılında Mashable tarafından sosyal medyanın dünyayı küresel bir köye dönüştürmesini kutlamak için başlatılmıştır.",
  "nasil": "1. Sosyal medyada pozitif ve ilham verici içerikler üretin.\n2. Uzun süredir görüşmediğiniz bir eski dostunuza mesaj atın.\n3. Sosyal medya kullanım sürenizi bilinçli yönetin.",
  "mesaj": "Mesafeleri kaldıran, sesimizi dünyaya duyuran platformların günü kutlu olsun! 30 Haziran Dünya Sosyal Medya Günü! 📱🌐💬"
},
{
  "slug": "uluslararasi-dostluk-gunu",
  "title": "30 Temmuz Uluslararası Dostluk Günü",
  "description": "Halklar, ülkeler, kültürler ve bireyler arasındaki dostluk köprülerinin barış getireceğini savunan BM günü.",
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
  ],
  "nedir": "Birleşmiş Milletler tarafından toplumlar arasında güven ve dayanışma tesis etmek için ilan edilmiştir.",
  "nasil": "1. En yakın arkadaşınızı arayıp ona değer verdiğinizi söyleyin.\n2. Birlikte kahve için veya anılarınızı yad edin.\n3. Yeni insanlarla samimi dostluklar kurun.",
  "mesaj": "İyi bir dost dünyalara bedeldir. Tüm vefakar dostların 30 Temmuz Uluslararası Dostluk Günü kutlu olsun! 🤝☕❤️"
},
{
  "slug": "dunya-insani-yardim-gunu",
  "title": "19 Ağustos Dünya İnsani Yardım Günü",
  "description": "Kriz ve savaş bölgelerinde canları pahasına insanlara yardım eli uzatan yardım çalışanlarını anma günü.",
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
  ],
  "nedir": "2003 yılında BM Bağdat merkezine yapılan saldırıda hayatını kaybeden 22 yardım görevlisinin anısına kutlanır.",
  "nasil": "1. Güvenilir yardım kuruluşlarına bağışta bulunun.\n2. Gönüllü yardım projelerinde aktif rol alın.\n3. İnsani değerleri savunun.",
  "mesaj": "İnsanlık yardımlaşmayla yaşar. Tüm fedakar insani yardım çalışanlarına sonsuz minnetle! 19 Ağustos kutlu olsun. 🤝🕊️"
},
{
  "slug": "gaziler-gunu",
  "title": "19 Eylül Gaziler Günü",
  "description": "Mustafa Kemal Atatürk'e 'Gazi' unvanı ve Mareşal rütbesinin verildiği günün anısına kutlanan milli vefa günü.",
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
  ],
  "nedir": "19 Eylül 1921'de Sakarya Meydan Muharebesi sonrası TBMM tarafından Atatürk'e Gazilik unvanı tevcih edilmiştir.",
  "nasil": "1. Muharip gazi derneklerini ziyaret edin.\n2. Kahraman gazilerimize şükran ve saygılarınızı sunun.\n3. Vatan fedakarlıklarını gençlere aktarın.",
  "mesaj": "Şehit nurlanmış, gazi onurlanmış askerdir. Başta Gazi Mustafa Kemal Atatürk olmak üzere tüm gazilerimize minnetle! 🇹🇷🎖️"
},
{
  "slug": "dunya-turizm-gunu",
  "title": "27 Eylül Dünya Turizm Günü",
  "description": "Farklı kültürleri tanıma, seyahat özgürlüğü ve sürdürülebilir turizmin ekonomik gücünü kutlayan BM günü.",
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
  ],
  "nedir": "Dünya Turizm Örgütü (UNWTO) tüzüğünün kabul edildiği gün olan 27 Eylül, küresel seyahat bilincini artırır.",
  "nasil": "1. Yeni bir şehri veya tarihi bir mekanı keşfe çıkın.\n2. Yerel esnafı ve eko-turizmi destekleyin.\n3. Gezdiğiniz yerlerin doğasına ve kültürüne saygı gösterin.",
  "mesaj": "Dünya bir kitaptır ve seyahat etmeyenler sadece bir sayfasını okur. 27 Eylül Dünya Turizm Günü kutlu olsun! ✈️🗺️🧳"
},
{
  "slug": "dunya-yaslilar-gunu",
  "title": "1 Ekim Dünya Yaşlılar Günü",
  "description": "Tecrübeleriyle topluma ışık tutan kıymetli büyüklerimizin haklarını ve refahını koruyan BM günü.",
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
  ],
  "nedir": "Birleşmiş Milletler tarafından yaşlanan nüfusun haklarına, bakımına ve kuşaklar arası dayanışmaya dikkat çekmek için ilan edilmiştir.",
  "nasil": "1. Ailenizdeki ve çevrenizdeki yaşlıları ziyaret edip ellerini öpün.\n2. Huzurevlerine ziyarette bulunun.\n3. Onların hayat tecrübelerini ve hatıralarını dinleyin.",
  "mesaj": "Büyüklerimiz geçmişimizin hafızası, geleceğimizin duasıdır. 1 Ekim Dünya Yaşlılar Günü kutlu olsun! 👵🧓🤍"
},
{
  "slug": "dunya-ogretmenler-gunu-unesco",
  "title": "5 Ekim Dünya Öğretmenler Günü (UNESCO)",
  "description": "Dünya genelinde öğretmenlerin statüsü ve haklarını savunan UNESCO ve ILO ortak kutlama günü.",
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
  ],
  "nedir": "1966 yılında Öğretmenlerin Statüsüne İlişkin Tavsiye Kararı'nın kabul edildiği gün olup tüm dünyada eğitimcileri onurlandırır.",
  "nasil": "1. Dünyanın dört bir yanındaki öğretmenlerin emeğini takdir edin.\n2. Eğitime bütçe ayrılmasını destekleyin.\n3. Öğretmenlerinize mesaj gönderin.",
  "mesaj": "Karanlığı aydınlatan tüm fedakar öğretmenlerimizin 5 Ekim Dünya Öğretmenler Günü kutlu olsun! 📚🌍🧑‍🏫"
},
{
  "slug": "dunya-gida-gunu",
  "title": "16 Ekim Dünya Gıda Günü",
  "description": "Açlıkla mücadele, sürdürülebilir tarım ve gıda israfını önleme bilincini artıran FAO günü.",
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
  ],
  "nedir": "1945 yılında BM Gıda ve Tarım Örgütü'nün (FAO) kuruluş yıl dönümünde herkese yeterli ve güvenli gıda hakkını savunur.",
  "nasil": "1. Tabağınıza yiyebileceğiniz kadar yemek alın, israfı önleyin.\n2. Artan yemekleri değerlendirme tarifleri uygulayın.\n3. Gıda bankalarına ve aşevlerine bağış yapın.",
  "mesaj": "Gıda haktır, israf etme! 16 Ekim Dünya Gıda Günü'nde soframızı ve dünyamızı adaletle paylaşalım. 🌾🍞🍲"
},
{
  "slug": "dunya-tasarruf-gunu",
  "title": "31 Ekim Dünya Tasarruf Günü",
  "description": "Finansal okuryazarlık, para biriktirme ve kaynakları verimli kullanma alışkanlığını teşvik eden gün.",
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
  ],
  "nedir": "1924 yılında Milano'da yapılan 1. Uluslararası Tasarruf Bankası Kongresi'nde tasarruf bilincini aşılamak için kabul edilmiştir.",
  "nasil": "1. Aylık bütçenizi ve gereksiz harcamalarınızı gözden geçirin.\n2. Çocuklara kumbara alıp birikim yapmayı öğretin.\n3. Enerji ve su tüketiminde tasarrufa gidin.",
  "mesaj": "Damlaya damlaya göl olur! 31 Ekim Dünya Tasarruf Günü'nde geleceğin için biriktirmeye başla. 🪙💰📈"
},
{
  "slug": "dunya-sehircilik-gunu",
  "title": "8 Kasım Dünya Şehircilik Günü",
  "description": "Planlı, yaşanabilir, yeşil ve afetlere dayanıklı kentler inşa etme bilincini artıran gün.",
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
  ],
  "nedir": "1949 yılında Buenos Aires Üniversitesi profesörü Carlos Maria della Paolera tarafından kent planlamasının önemini anlatmak için başlatılmıştır.",
  "nasil": "1. Kentinizdeki yeşil alanların ve bisiklet yollarının artmasını talep edin.\n2. Kentsel dönüşüm ve deprem güvenliği bilincini yaygınlaştırın.\n3. Şehir plancılarına teşekkür edin.",
  "mesaj": "Daha yeşil, daha adil ve afetlere dirençli şehirler için 8 Kasım Dünya Şehircilik Günü kutlu olsun! 🏙️🌳🚲"
},
{
  "slug": "uluslararasi-hosgoru-gunu",
  "title": "16 Kasım Uluslararası Hoşgörü Günü",
  "description": "Farklılıklara saygı, empati, diyalog ve barış içinde bir arada yaşama kültürünü kutlayan UNESCO günü.",
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
  ],
  "nedir": "1995 UNESCO Hoşgörü İlkeleri Bildirgesi'nin imzalanmasıyla nefret söylemi ve ayrımcılıkla mücadele için kabul edilmiştir.",
  "nasil": "1. 'Gel, ne olursan ol yine gel' anlayışıyla herkese önyargısız yaklaşın.\n2. Farklı fikirleri sabırla dinleyin.\n3. Hoşgörüyü ve nezaketi yayın.",
  "mesaj": "Farklılıklarımız zenginliğimizdir. 16 Kasım Uluslararası Hoşgörü Günü kutlu olsun! 🤝🌈🕊️"
},
{
  "slug": "dunya-televizyon-gunu",
  "title": "21 Kasım Dünya Televizyon Günü",
  "description": "Görsel habercilik, kamuoyu oluşturma ve kültürel etkileşimdeki televizyonun gücünü kutlayan BM günü.",
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
  ],
  "nedir": "1996 yılında 1. Dünya Televizyon Forumu'nun yapıldığı tarih olup medyanın küresel sorunlara dikkat çekme rolünü onurlandırır.",
  "nasil": "1. Kaliteli belgeseller ve eğitici programlar izleyin.\n2. Televizyon haberciliğinin tarihini inceleyin.\n3. Ekran sürenizi dengede tutun.",
  "mesaj": "Dünyayı salonumuza getiren ekranın günü! 21 Kasım Dünya Televizyon Günü kutlu olsun! 📺📡🎬"
},
{
  "slug": "dunya-aids-gunu",
  "title": "1 Aralık Dünya AIDS Günü",
  "description": "HIV/AIDS konusunda doğru bilinci yaymak, ön yargıları kırmak ve hastalara destek olmak için kutlanan küresel gün.",
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
  ],
  "nedir": "1988 yılından bu yana Dünya Sağlık Örgütü öncülüğünde kırmızı kurdele sembolüyle HIV farkındalığı için düzenlenir.",
  "nasil": "1. HIV'in bulaşma ve korunma yolları hakkında doğru bilgi edinin.\n2. HIV ile yaşayan bireylere karşı ayrımcılığa dur deyin.\n3. Düzenli test yaptırın.",
  "mesaj": "Bilinç hayat kurtarır, ön yargı öldürür. 1 Aralık Dünya AIDS Günü'nde farkında olalım. 🎗️❤️"
},
{
  "slug": "dunya-toprak-gunu",
  "title": "5 Aralık Dünya Toprak Günü",
  "description": "Besinlerimizin yüzde 95'ini sağlayan toprağın erozyondan ve kirlilikten korunması için BM tarafından kutlanır.",
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
  ],
  "nedir": "BM Gıda ve Tarım Örgütü (FAO) tarafından sağlıklı toprakların ve gıda güvenliğinin önemini vurgulamak için ilan edilmiştir.",
  "nasil": "1. Organik atıklarınızı kompost yaparak toprağa geri kazandırın.\n2. Erozyonla mücadele eden TEMA Vakfı gibi STK'lara destek olun.\n3. Toprağı kimyasallarla kirletmeyin.",
  "mesaj": "Toprak varsa hayat var! 5 Aralık Dünya Toprak Günü'nde bereketli toprağımızı koruyalım. 🌱🌍🌾"
},
{
  "slug": "uluslararasi-dag-gunu",
  "title": "11 Aralık Uluslararası Dağ Günü",
  "description": "Tatlı su kaynaklarımızın ve eşsiz dağ biyoçeşitliliğinin korunmasını savunan BM günü.",
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
  ],
  "nedir": "2003 yılında BM Genel Kurulu tarafından dağ ekosistemlerinin kırılganlığına ve dağ topluluklarının sürdürülebilirliğine dikkat çekmek için kabul edilmiştir.",
  "nasil": "1. Dağ yürüyüşü veya trekking yapın.\n2. Dağlık bölgelerdeki doğal yaşam alanlarını koruyun.\n3. Dağ köylerinin yerel ürünlerini destekleyin.",
  "mesaj": "Göğe uzanan zirvelerimiz doğanın kalbidir. 11 Aralık Uluslararası Dağ Günü kutlu olsun! ⛰️🏔️🌲"
},
{
  "slug": "uluslararasi-gocmenler-gunu",
  "title": "18 Aralık Uluslararası Göçmenler Günü",
  "description": "Dünya çapında göçmenlerin insan hakları, emekleri ve toplumsal katkılarını onurlandıran BM günü.",
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
  ],
  "nedir": "1990'da Tüm Göçmen İşçilerin ve Aile Fertlerinin Haklarının Korunmasına Dair Uluslararası Sözleşme'nin kabul günü anısına kutlanır.",
  "nasil": "1. Göçmenlerin temel insan haklarına ve onuruna saygı duyun.\n2. Irkçılığa ve yabancı düşmanlığına karşı durun.\n3. Farklı kültürlerin topluma kattığı zenginliği takdir edin.",
  "mesaj": "Hepimiz aynı gökyüzünün altındayız. 18 Aralık Uluslararası Göçmenler Günü kutlu olsun! 🕊️🌍🤝"
},

  // Ocak (1)
  {
    slug: "yilbasi",
    title: "1 Ocak Yılbaşı",
    description: "Yeni bir yılın başlangıcını simgeleyen ve tüm dünyada umutla kutlanan resmi tatil günü.",
    month_no: 1, day_no: 1, category: "Resmi",
    hashtags: ["#Yilbasi", "#YeniYil", "#Hosgeldin2026", "#MutluYillar"],
    affiliate_keywords: ["yılbaşı hediyesi", "yeni yıl ajandası", "kutu kutlama oyunu", "kar küresi"],
    nedir: "Yılbaşı, Miladi takvime göre bir yılın bitip yeni bir yılın başladığı 1 Ocak günüdür. Yeni umutlar, hedefler ve başlangıçlarla tüm dünyada resmi tatil olarak kutlanır.",
    nasil: "1. Aileniz ve dostlarınızla yeni yıl hedeflerinizi paylaşın.\n2. Sevdiklerinize anlamlı tebrik kartları ve hediyeler verin.\n3. Yeni yılda kendinize sağlıklı alışkanlıklar edinin.",
    mesaj: "Yeni yılın size ve sevdiklerinize sağlık, mutluluk ve başarı getirmesini dilerim! Mutlu Yıllar! 🎉✨"
  },
  {
    slug: "dunya-braille-gunu",
    title: "4 Ocak Dünya Braille Günü",
    description: "Görme engellilerin okuma yazmasını sağlayan kabartma Braille alfabesinin mucidi Louis Braille anısına kutlanır.",
    month_no: 1, day_no: 4, category: "Farkındalık",
    hashtags: ["#BrailleGunu", "#GormeEngelliler", "#Erisilebilirlik", "#Farkindalik"],
    affiliate_keywords: ["braille alfabesi kabartma tablet", "sesli kitap aboneliği", "akıllı baston", "kabartmalı saat"],
    nedir: "Dünya Braille Günü, görme engelli bireylerin bağımsızlığı ve bilgiye erişimi için geliştirilen Braille alfabesinin önemini vurgulamak amacıyla her yıl Louis Braille'in doğum gününde kutlanır.",
    nasil: "1. Çevrenizdeki kamusal alanların ve web sitelerinin görme engelliler için erişilebilirliğini denetleyin.\n2. Braille alfabesi hakkında bilgi edinin.\n3. Görme engelliler kütüphanelerine gönüllü kitap okuma desteği verin.",
    mesaj: "Erişilebilir bir dünya herkesin hakkıdır! 4 Ocak Dünya Braille Günü kutlu olsun. ⠃⠗⠁⠊⠇⠇⠑"
  },
  {
    slug: "calisan-gazeteciler-gunu",
    title: "10 Ocak Çalışan Gazeteciler Günü",
    description: "Basın emekçilerinin haklarını güvence altına alan 212 sayılı yasanın kabul edildiği günün anısına kutlanır.",
    month_no: 1, day_no: 10, category: "Mesleki",
    hashtags: ["#CalisanGazetecilerGunu", "#10Ocak", "#BasinEmekcileri", "#OzgurBasin"],
    affiliate_keywords: ["ses kayıt cihazı profesyonel", "gazeteci çantası", "fotoğraf makinesi tripodu", "not defteri deri"],
    nedir: "10 Ocak 1961'de yürürlüğe giren ve gazetecilerin çalışma haklarını iyileştiren kanunun ardından Türkiye'de Gazeteciler Günü olarak kutlanmaya başlanmıştır.",
    nasil: "1. Tarafsız ve cesur haber yapan basın mensuplarını tebrik edin.\n2. Bağımsız gazetecilik platformlarına abonelikle destek olun.\n3. Yerel basının önemini vurgulayan paylaşımlar yapın.",
    mesaj: "Doğru ve tarafsız habercilik uğruna gece gündüz emek veren tüm gazetecilerin 10 Ocak Çalışan Gazeteciler Günü kutlu olsun! 📰📸"
  },
  {
    slug: "dunya-sarilma-gunu",
    title: "21 Ocak Dünya Sarılma Günü",
    description: "İnsanlar arasındaki sevgi bağını güçlendirmek ve sarılmanın iyileştirici gücünü hatırlatmak için kutlanır.",
    month_no: 1, day_no: 21, category: "Eğlence",
    hashtags: ["#DunyaSarilmaGunu", "#SarilmakGuzeldir", "#HugDay", "#Sevgi"],
    affiliate_keywords: ["yumuşak peluş oyuncak", "ağırlaştırılmış battaniye", "kupa bardak kalpli", "sarılma yastığı"],
    nedir: "1986 yılında Kevin Zaborney tarafından başlatılan bu özel gün, insanların birbirine duygusal destek vermesini ve sarılmanın yarattığı oksitosin hormonunun sağlığa faydalarını hatırlatır.",
    nasil: "1. Ailenize, dostlarınıza ve evcil hayvanlarınıza sımsıkı sarılın.\n2. Uzaktaki sevdiklerinize sanal bir sarılma mesajı gönderin.\n3. Çevrenize tebessüm ve pozitif enerji yayın.",
    mesaj: "Bir sarılma bin ilaca bedeldir! Sevdiklerinize sarılmayı ihmal etmeyin, 21 Ocak Dünya Sarılma Günü kutlu olsun! 🤗❤️"
  },
  {
    slug: "uluslararasi-egitim-gunu",
    title: "24 Ocak Uluslararası Eğitim Günü",
    description: "Barış ve kalkınma için eğitimin vazgeçilmez rolünü kutlamak amacıyla Birleşmiş Milletler tarafından kabul edilen gün.",
    month_no: 1, day_no: 24, category: "Farkındalık",
    hashtags: ["#EgitimGunu", "#EducationDay", "#NitelikliEgitim", "#Gelecek"],
    affiliate_keywords: ["eğitici tablet çocuk", "dünya atlası", "online eğitim kursu", "çalışma masası lambası"],
    nedir: "UNESCO ve BM Genel Kurulu tarafından ilan edilen gün, dünyadaki tüm çocukların eşit ve kaliteli eğitime erişim hakkını savunur.",
    nasil: "1. İhtiyaç sahibi okullara ve öğrencilere kırtasiye/kitap bağışında bulunun.\n2. Eğitimin fırsat eşitliği üzerindeki etkilerini tartışın.\n3. Kendinize yeni bir öğrenme hedefi belirleyin.",
    mesaj: "Eğitim dünyayı değiştirebilecek en güçlü silahtır. 24 Ocak Uluslararası Eğitim Günü kutlu olsun! 📚🎓"
  },
  {
    slug: "veri-koruma-gunu",
    title: "28 Ocak Veri Koruma Günü",
    description: "Dijital çağda kişisel verilerin gizliliği ve siber güvenlik bilincini artırmak amacıyla kutlanan küresel gün.",
    month_no: 1, day_no: 28, category: "Farkındalık",
    hashtags: ["#VeriKorumaGunu", "#KVKK", "#SiberGuvenlik", "#DataPrivacy"],
    affiliate_keywords: ["şifreli flash bellek", "donanım cüzdanı", "webcam gizlilik kapağı", "vpn aboneliği"],
    nedir: "Avrupa Konseyi'nin 108 sayılı Veri Koruma Sözleşmesi'nin imzalandığı günün anısına dijital hakları savunmak için kutlanır.",
    nasil: "1. Hesap şifrelerinizi iki aşamalı doğrulama (2FA) ile güçlendirin.\n2. İnternette paylaştığınız kişisel verileri gözden geçirin.\n3. Sosyal medya gizlilik ayarlarınızı kontrol edin.",
    mesaj: "Verileriniz sizin dijital kimliğinizdir, koruyun! 28 Ocak Veri Koruma Günü kutlu olsun. 🔒💻"
  },

  // Şubat (2)
  {
    slug: "dunya-kanser-gunu",
    title: "4 Şubat Dünya Kanser Günü",
    description: "Kanser konusunda küresel farkındalık oluşturmak, erken teşhisin hayat kurtardığını hatırlatmak için düzenlenir.",
    month_no: 2, day_no: 4, category: "Sağlık",
    hashtags: ["#DunyaKanserGunu", "#ErkenTeshisHayatKurtarir", "#KanserleMucadele", "#Saglik"],
    affiliate_keywords: ["sağlıklı beslenme kitabı", "antioksidan yeşil çay", "spor matı", "su matarası"],
    nedir: "Uluslararası Kanser Kontrol Örgütü (UICC) öncülüğünde her yıl düzenlenen küresel bir farkındalık günüdür. Kanser türlerinin erken teşhisle tedavi edilebilirliğine odaklanır.",
    nasil: "1. Düzenli sağlık taramalarınızı ve kontrollerinizi yaptırın.\n2. Sağlıklı beslenme ve hareketli yaşam tarzını benimseyin.\n3. Kanserle mücadele eden vakıf ve derneklere destek olun.",
    mesaj: "Korkma, farkında ol! Erken teşhis hayat kurtarır. 4 Şubat Dünya Kanser Günü'nde sağlığımıza sahip çıkalım. 🎗️💪"
  },
  {
    slug: "sigarayi-birakma-gunu",
    title: "9 Şubat Dünya Sigarayı Bırakma Günü",
    description: "Tütün bağımlılığının zararlarına dikkat çekmek ve dumansız hava sahasını desteklemek amacıyla kutlanır.",
    month_no: 2, day_no: 9, category: "Sağlık",
    hashtags: ["#SigarayiBirakmaGunu", "#DumansizHavaSahasi", "#SigarayiBirak", "#SaglikliYasam"],
    affiliate_keywords: ["nikotin sakızı", "stres çarkı topu", "koşu ayakkabısı", "hava temizleyici cihaz"],
    nedir: "Dünya Sağlık Örgütü tarafından tütün kullanımının azaltılması ve sigarasız bir yaşama teşvik etmek için ilan edilen gündür.",
    nasil: "1. Bugün sigarayı bırakmak için kesin bir karar alın ve tarih belirleyin.\n2. Sigara bırakma polikliniklerinden profesyonel destek alın.\n3. Sevdiklerinizi bırakmaları konusunda motive edin.",
    mesaj: "Ciğerlerine ve geleceğine bir şans ver! 9 Şubat Dünya Sigarayı Bırakma Günü'nde temiz bir nefes al. 🚭🫁"
  },
  {
    slug: "bilimde-kadinlar-gunu",
    title: "11 Şubat Bilimde Kadınlar ve Kız Çocukları Günü",
    description: "Bilim ve teknoloji alanında kadınların ve kız çocuklarının tam ve eşit erişimini teşvik eden BM günü.",
    month_no: 2, day_no: 11, category: "Farkındalık",
    hashtags: ["#BilimdeKadinlar", "#WomenInScience", "#KizCocuklari", "#STEM"],
    affiliate_keywords: ["mikroskop seti bilimsel", "marie curie kitabı", "robotik kodlama kiti", "teleskop başlangıç"],
    nedir: "UNESCO ve UN Women ortaklığında kadınların STEM (bilim, teknoloji, mühendislik, matematik) alanlarındaki rolünü güçlendirmek için kutlanır.",
    nasil: "1. Başarılı kadın bilim insanlarının ilham verici hayatlarını çocuklara anlatın.\n2. Kız çocuklarını bilimsel projelere teşvik edin.\n3. Bilimde cinsiyet eşitliğini destekleyin.",
    mesaj: "Bilimin cinsiyeti yoktur! Geleceği aydınlatan tüm kadın bilim insanlarının günü kutlu olsun! 🔬👩‍🔬"
  },
  {
    slug: "sevgililer-gunu",
    title: "14 Şubat Sevgililer Günü",
    description: "Tüm dünyada sevgi ve aşkın paylaşıldığı, Aziz Valentin'in anısına ithaf edilen romantik kutlama günü.",
    month_no: 2, day_no: 14, category: "Eğlence",
    hashtags: ["#14Subat", "#SevgililerGunu", "#ValentinesDay", "#Ask", "#Hediye"],
    affiliate_keywords: ["sevgililer günü hediye kutusu", "gümüş kolye", "çikolata kutusu lüks", "akıllı saat unisex"],
    nedir: "Kökeni Roma dönemine ve Aziz Valentine efsanesine dayanan 14 Şubat Sevgililer Günü, sevginin jestlerle ifade edildiği evrensel gündür.",
    nasil: "1. Sevdiğinize duygularınızı samimiyetle anlatan bir mektup yazın.\n2. Baş başa romantik bir akşam yemeği planlayın.\n3. Birlikte unutulmaz bir anı albümü oluşturun.",
    mesaj: "Seninle geçen her gün bir bayram! 14 Şubat Sevgililer Günümüz kutlu olsun sevgilim. ❤️🌹"
  },
  {
    slug: "dunya-kediler-gunu",
    title: "17 Şubat Dünya Kediler Günü",
    description: "Miyavlayan sevimli dostlarımızın yaşam haklarını ve sokak kedilerinin refahını hatırlatan özel gün.",
    month_no: 2, day_no: 17, category: "Çevre & Doğa",
    hashtags: ["#DunyaKedilerGunu", "#CatDay", "#KediSeverler", "#SatinAlmaSahiplen"],
    affiliate_keywords: ["kedi tırmalama tahtası", "kedi ödül maması", "otomatik kedi su pınarı", "kedi taşıma çantası"],
    nedir: "İlk kez İtalya'da başlayan ve Avrupa genelinde kabul gören 17 Şubat Kediler Günü, kedilerin bağımsız doğasına ve sokaktaki canlara saygıyı kutlar.",
    nasil: "1. Mahallenizdeki sokak kedilerine bir kap mama ve taze su bırakın.\n2. Evinizdeki kedinize ekstra sevgi ve oyun zamanı ayırın.\n3. Barınaktaki bir kediyi sahiplenmeyi değerlendirin.",
    mesaj: "Pati izleri kalbimizde! Dünyayı güzelleştiren tüm minik dostlarımızın 17 Şubat Dünya Kediler Günü kutlu olsun! 🐾🐱"
  },
  {
    slug: "dunya-sosyal-adalet-gunu",
    title: "20 Şubat Dünya Sosyal Adalet Günü",
    description: "Yoksulluk, dışlanma, işsizlik ve eşitsizlikle mücadele ederek adil bir toplum inşasını savunan BM günü.",
    month_no: 2, day_no: 20, category: "Farkındalık",
    hashtags: ["#SosyalAdaletGunu", "#Esitlik", "#Adalet", "#SocialJustice"],
    affiliate_keywords: ["insan hakları kitapları", "sosyoloji temel eserler", "felsefe klasikleri seti"],
    nedir: "Birleşmiş Milletler tarafından ilan edilen gün, tüm insanların onurlu çalışma, sosyal koruma ve adalet içinde yaşaması gerektiğini hatırlatır.",
    nasil: "1. Toplumdaki dezavantajlı grupların haklarını destekleyin.\n2. Adil ücret ve eşit işe eşit ücret ilkelerini savunun.\n3. Dayanışma ağlarına katılın.",
    mesaj: "Barış ancak adaletle mümkündür. 20 Şubat Dünya Sosyal Adalet Günü kutlu olsun! ⚖️🤝"
  },
  {
    slug: "dunya-anadili-gunu",
    title: "21 Şubat Uluslararası Anadili Günü",
    description: "Dünyadaki tüm dillerin kültürel çeşitliliğini korumak ve çok dilliliği teşvik etmek için UNESCO tarafından kutlanır.",
    month_no: 2, day_no: 21, category: "Kültür & Sanat",
    hashtags: ["#AnadiliGunu", "#MotherLanguageDay", "#KulturelCesitlilik", "#Dilimiz"],
    affiliate_keywords: ["türkçe sözlük tdk", "dünya edebiyatı klasikleri", "etimoloji sözlüğü"],
    nedir: "1952 yılında Bangladeş'te anadili hakkını savunan öğrencilerin anısına UNESCO tarafından 1999'da kabul edilmiş küresel bir gündür.",
    nasil: "1. Anadilinizdeki zengin deyimleri, atasözlerini ve edebiyatı keşfedin.\n2. Farklı kültürlerin dillerine saygı gösterin.\n3. Kaybolma tehlikesindeki yerel diller hakkında bilgi edinin.",
    mesaj: "Dil, bir milletin hafızasıdır. 21 Şubat Uluslararası Anadili Günü kutlu olsun! 🗣️📖"
  },

  // Mart (3)
  {
    slug: "yesilay-haftasi",
    title: "1 Mart Yeşilay Haftası",
    description: "Alkol, uyuşturucu, tütün ve teknoloji bağımlılığıyla mücadeleyi destekleyen ulusal farkındalık haftası.",
    month_no: 3, day_no: 1, category: "Sağlık",
    hashtags: ["#YesilayHaftasi", "#BagimsizYasa", "#Yesilay", "#Saglik"],
    affiliate_keywords: ["akıllı bileklik adımsayar", "spor matı yoga", "sağlıklı yaşam rehberi kitabı"],
    nedir: "1920 yılında kurulan Hilal-i Ahdar (Yeşilay) Cemiyeti'nin öncülüğünde bağımlılıklarla mücadele etmek amacıyla her yıl Mart ayının ilk haftasında kutlanır.",
    nasil: "1. Yeşilay'ın bağımlılıkla mücadele seminerlerine katılın.\n2. Dijital detoks yaparak ekran sürenizi azaltın.\n3. Çocuklara zararlı alışkanlıklardan uzak durmayı öğretin.",
    mesaj: "Bağımlılıklardan uzak, sağlıklı ve özgür bir yaşam için Yeşilay Haftası kutlu olsun! 🟢🌿"
  },
  {
    slug: "dunya-yaban-hayati-gunu",
    title: "3 Mart Dünya Yaban Hayatı Günü",
    description: "Nesli tükenmekte olan yabani hayvan ve bitki türlerini koruma bilincini artırmak amacıyla kutlanır.",
    month_no: 3, day_no: 3, category: "Çevre & Doğa",
    hashtags: ["#YabanHayatiGunu", "#WorldWildlifeDay", "#DogaDostu", "#BiyoCesitlilik"],
    affiliate_keywords: ["dürbün doğa gözlem", "doğa belgeselleri seti", "kamp çadırı", "kuş rehberi kitabı"],
    nedir: "CITES sözleşmesinin imzalandığı gün olan 3 Mart, vahşi yaşamın korunması ve kaçak avcılıkla mücadele için BM tarafından kabul edilmiştir.",
    nasil: "1. Yaban hayatı koruma projelerine destek verin.\n2. Doğal yaşam alanlarını kirletmeyin ve koruyun.\n3. Egzotik hayvan ticaretine karşı bilinçli olun.",
    mesaj: "Doğa canlılarıyla güzeldir! 3 Mart Dünya Yaban Hayatı Günü'nde tüm türlerin yaşam hakkını koruyalım. 🦁🌿🦉"
  },
  {
    slug: "dunya-kadinlar-gunu",
    title: "8 Mart Dünya Kadınlar Günü",
    description: "Kadınların sosyal, ekonomik, kültürel ve siyasi başarılarını kutlayan ve cinsiyet eşitliğini savunan küresel gün.",
    month_no: 3, day_no: 8, category: "Uluslararası",
    hashtags: ["#8Mart", "#DunyaKadinlarGunu", "#GucluKadinlar", "#KadinHaklari"],
    affiliate_keywords: ["kadın parfümü", "özel hediye seti", "orkide saksı çiçeği", "tasarım takı kolye"],
    nedir: "1857'de New York'ta hak mücadelesi başlatan kadın işçilerin anısına Birleşmiş Milletler tarafından kabul edilen küresel gündür.",
    nasil: "1. Kadın girişimcileri ve kadın kooperatiflerini destekleyin.\n2. Çevrenizdeki kadınlara saygı ve sevginizi gösterin.\n3. Eşit haklar için farkındalık yaratın.",
    mesaj: "Dünyayı güzelleştiren, emekleriyle hayat veren tüm güçlü kadınların 8 Mart Dünya Kadınlar Günü kutlu olsun! 🌸💪"
  },
  {
    slug: "istiklal-marsinin-kabulu",
    title: "12 Mart İstiklal Marşı'nın Kabulü",
    description: "Mehmet Akif Ersoy'un kaleme aldığı milli marşımızın TBMM tarafından kabul edilişinin anma günü.",
    month_no: 3, day_no: 12, category: "Resmi",
    hashtags: ["#12Mart", "#IstiklalMarsi", "#MehmetAkifErsoy", "#Korkma"],
    affiliate_keywords: ["safahat özel baskı", "mehmet akif ersoy biyografisi", "türk bayrağı çerçeveli"],
    nedir: "12 Mart 1921'de Türkiye Büyük Millet Meclisi tarafından kabul edilen İstiklal Marşı, milletimizin bağımsızlık azminin ebedi simgesidir.",
    nasil: "1. İstiklal Marşı'nın 10 kıtasını dikkatle okuyun ve anlamını düşünün.\n2. Mehmet Akif Ersoy'un Safahat eserini inceleyin.\n3. Okullarda düzenlenen anma programlarına katılın.",
    mesaj: "Allah bu millete bir daha İstiklal Marşı yazdırmasın! 12 Mart İstiklal Marşı'nın kabulü kutlu olsun. 🇹🇷📜"
  },
  {
    slug: "tip-bayrami",
    title: "14 Mart Tıp Bayramı",
    description: "Türkiye'de modern tıp eğitiminin başladığı günün anısına tüm sağlık çalışanlarını onurlandıran gün.",
    month_no: 3, day_no: 14, category: "Sağlık",
    hashtags: ["#TipBayrami", "#14Mart", "#DoktorlarimizaTesekkurler", "#SaglikEmekcileri"],
    affiliate_keywords: ["kişiye özel steteskop", "doktor önlüğü kaliteli", "medikal hediye kupa", "termos doktor"],
    nedir: "14 Mart 1827'de Tıphane-i Amire'nin kuruluşu ve 1919'da tıp öğrencilerinin işgale karşı direnişi anısına Tıp Bayramı olarak kutlanır.",
    nasil: "1. Doktorlarınıza ve sağlık personeline teşekkür mesajı iletin.\n2. Sağlıkta şiddete karşı farkındalık oluşturun.\n3. Sağlık taramalarınızı ihmal etmeyin.",
    mesaj: "Hayatımızı emanet ettiğimiz fedakar hekimlerimizin ve tüm sağlık çalışanlarımızın 14 Mart Tıp Bayramı kutlu olsun! 🩺🤍"
  },
  {
    slug: "pi-gunu",
    title: "14 Mart Dünya Pi Günü",
    description: "Matematiksel sabit olan Pi sayısının (3,14) onuruna dünya çapında matematikseverlerin kutladığı gün.",
    month_no: 3, day_no: 14, category: "Eğlence",
    hashtags: ["#PiGunu", "#PiDay", "#Matematik", "#Einstein", "#314"],
    affiliate_keywords: ["bilimsel hesap makinesi", "pi sayısı tişörtü", "matematik bulmaca kitapları", "rubik küp"],
    nedir: "Pi sayısı 3.14 olduğu için Mart ayının 14. günü (3/14) Pi Günü olarak kutlanır. Aynı zamanda Albert Einstein'ın doğum günüdür.",
    nasil: "1. Pi desenli pasta ve turtalar pişirin.\n2. Pi sayısının basamaklarını ezberleme yarışması yapın.\n3. Matematik belgeselleri izleyin.",
    mesaj: "Sonsuzluğa uzanan sayının günü kutlu olsun! 3,14... Dünya Pi Günü kutlu olsun! 🥧📐"
  },
  {
    slug: "canakkale-zaferi",
    title: "18 Mart Çanakkale Zaferi ve Şehitleri Anma Günü",
    description: "1915 Çanakkale Deniz Zaferi'nin ve vatanı uğruna can veren aziz şehitlerimizin anıldığı milli gün.",
    month_no: 3, day_no: 18, category: "Resmi",
    hashtags: ["#18Mart", "#CanakkaleGecilmez", "#CanakkaleZaferi", "#SehitlerimiziAniyoruz"],
    affiliate_keywords: ["çanakkale tarihi kitabı", "mustafa kemal atatürk tablosu", "türk bayrağı masa üstü"],
    nedir: "18 Mart 1915'te Türk ordusunun Çanakkale Boğazı'nda yazdığı destansı zaferin ve 'Çanakkale Geçilmez' sözünün tarihe kazındığı gündür.",
    nasil: "1. Çanakkale şehitliklerini ziyaret edin veya anma törenlerine katılın.\n2. Şehitlerimizin ruhuna dualar okuyun.\n3. Genç nesillere zaferin tarihsel önemini aktarın.",
    mesaj: "Çanakkale Geçilmez! Gazi Mustafa Kemal Atatürk ve tüm Çanakkale kahramanlarımızı rahmet ve minnetle anıyoruz. 🇹🇷🎖️"
  },
  {
    slug: "dunya-mutluluk-gunu",
    title: "20 Mart Dünya Mutluluk Günü",
    description: "Mutluluğun temel bir insan hakkı olduğunu hatırlatmak için Birleşmiş Milletler tarafından kabul edilen gün.",
    month_no: 3, day_no: 20, category: "Eğlence",
    hashtags: ["#DunyaMutlulukGunu", "#Mutluluk", "#Gulumse", "#HappinessDay"],
    affiliate_keywords: ["pozitif psikoloji kitapları", "aroma terapi uçucu yağ", "günlük şükür defteri", "renkli fincan"],
    nedir: "BM Genel Kurulu tarafından 2012 yılında ilan edilen gün, ekonomik büyümenin yanında insan mutluluğunun da ölçülmesi gerektiğini savunur.",
    nasil: "1. Bugün en az bir kişiyi nedensizce gülümsetin.\n2. Kendinize sevdiğiniz bir kahve veya tatlı ısmarlayın.\n3. Hayatınızdaki güzel anlara odaklanın.",
    mesaj: "Mutluluk paylaştıkça çoğalır! 20 Mart Dünya Mutluluk Günü'nde yüzünüzden tebessüm eksik olmasın. 😊💛"
  },
  {
    slug: "dunya-ormancilik-gunu",
    title: "21 Mart Dünya Ormancılık Günü ve Nevruz",
    description: "Baharın gelişi, doğanın uyanışı ve orman varlığının korunması amacıyla kutlanan köklü bayram.",
    month_no: 3, day_no: 21, category: "Çevre & Doğa",
    hashtags: ["#OrmancilikGunu", "#NevruzBayrami", "#BaharGeldi", "#FidanDik"],
    affiliate_keywords: ["fidan bağışı sertifikası", "bahçe bakım seti", "budama makası", "saksı tohum seti"],
    nedir: "21 Mart hem ilkbahar ekinoksunu simgeleyen Nevruz Bayramı hem de FAO tarafından ilan edilen Dünya Ormancılık Günü'dür.",
    nasil: "1. Doğaya bir fidan dikin veya TEMA'ya fidan bağışlayın.\n2. Doğa yürüyüşü (trekking) yaparak orman havası alın.\n3. Nevruz ateşi ve bahar etkinliklerine katılın.",
    mesaj: "Doğa yeşeriyor, umutlar yeşeriyor! 21 Mart Dünya Ormancılık Günü ve Nevruz Bayramımız kutlu olsun! 🌱🌸🔥"
  },
  {
    slug: "dunya-down-sendromu-gunu",
    title: "21 Mart Dünya Down Sendromu Farkındalık Günü",
    description: "+1 farkla dünyayı güzelleştiren bireylerin farkındalığını artırmak amacıyla kutlanan gün.",
    month_no: 3, day_no: 21, category: "Farkındalık",
    hashtags: ["#21Mart", "#DownSendromu", "#ArtiBirFarkla", "#GercekDostlar"],
    affiliate_keywords: ["farklı çoraplar renkli set", "özel eğitim materyali", "duyusal oyun seti"],
    nedir: "21. kromozomun 3 tane olmasından (trizomi 21) esinlenilerek 3. ayın 21. günü Dünya Down Sendromu Günü ilan edilmiştir.",
    nasil: "1. Farkındalık için rengarenk farklı çoraplar giyerek sosyal medyada paylaşın.\n2. Down sendromlu bireylerin iş hayatına ve topluma katılımını destekleyin.\n3. Sevgi dolu kalplerine ortak olun.",
    mesaj: "Down sendromu bir hastalık değil, genetik bir farklılıktır. +1 farkla yanınızdayız! 🧦💙💛"
  },
  {
    slug: "dunya-su-gunu",
    title: "22 Mart Dünya Su Günü",
    description: "Temiz su kaynaklarının korunması ve su kıtlığı tehlikesine dikkat çekmek için BM öncülüğünde kutlanır.",
    month_no: 3, day_no: 22, category: "Çevre & Doğa",
    hashtags: ["#DunyaSuGunu", "#WorldWaterDay", "#SuyuKoru", "#GeleceginiKoru"],
    affiliate_keywords: ["su arıtma cihazı filtre", "tasarruflu duş başlığı", "çelik su matarası", "musluk perlatörü"],
    nedir: "1993 yılında Birleşmiş Milletler tarafından kabul edilen gün, tatlı su kaynaklarının önemine ve su tasarrufuna dikkat çeker.",
    nasil: "1. Diş fırçalarken ve bulaşık yıkarken musluğu açık bırakmayın.\n2. Su tasarruflu başlıklar kullanın.\n3. Su ayak izinizi azaltacak adımlar atın.",
    mesaj: "Su hayattır, boşa akıtma! 22 Mart Dünya Su Günü'nde her damlanın değerini bilelim. 💧🌊"
  },
  {
    slug: "dunya-tiyatro-gunu",
    title: "27 Mart Dünya Tiyatro Günü",
    description: "Tiyatro sanatının toplumları aydınlatıcı ve birleştirici gücünü kutlamak için 1961'den beri kutlanan sanat günü.",
    month_no: 3, day_no: 27, category: "Kültür & Sanat",
    hashtags: ["#DunyaTiyatroGunu", "#Tiyatro", "#SahneSanatlari", "#27Mart"],
    affiliate_keywords: ["tiyatro oyun metinleri", "shakespeare toplu eserleri", "dürbün tiyatro tipi", "sanat tarihi kitabı"],
    nedir: "Uluslararası Tiyatro Enstitüsü tarafından başlatılan bu özel günde dünya çapında tiyatro bildirileri yayımlanır ve oyunlar sergilenir.",
    nasil: "1. Sevdiğiniz bir tiyatro oyununa bilet alıp izleyin.\n2. Yerel ve bağımsız tiyatro topluluklarına destek olun.\n3. Çocukları tiyatro ile tanıştırın.",
    mesaj: "Perdeler hiç kapanmasın! 27 Mart Dünya Tiyatro Günü kutlu olsun. 🎭🎟️"
  },

  // Nisan (4)
  {
    slug: "dunya-otizm-farkindalik-gunu",
    title: "2 Nisan Dünya Otizm Farkındalık Günü",
    description: "Otizm spektrumundaki bireylerin yaşam kalitesini artırmak ve erken teşhis bilincini yaymak için kutlanır.",
    month_no: 4, day_no: 2, category: "Sağlık",
    hashtags: ["#OtizmFarkindalikGunu", "#MaviIsikYak", "#OtizminFarkindayim", "#2Nisan"],
    affiliate_keywords: ["mavi tişört", "duyusal oda ışığı", "otizm eğitim kartları", "stres çarkı"],
    nedir: "Birleşmiş Milletler tarafından 2007 yılında ilan edilen bu günde dünya çapında anıtlar 'Mavi Işık Yak' kampanyasıyla aydınlatılır.",
    nasil: "1. Mavi kıyafet giyerek veya mavi ışık yakarak farkındalığa katılın.\n2. Otizmli bireylerin eğitimi için faaliyet gösteren STK'lara destek olun.\n3. Toplumda hoşgörü ve kabul dilini güçlendirin.",
    mesaj: "Farklıyız, eşitiz, birlikte güçlüyüz! 2 Nisan Dünya Otizm Farkındalık Günü'nde mavi ışık yakıyoruz. 💙🧩"
  },
  {
    slug: "avukatlar-gunu",
    title: "5 Nisan Avukatlar Günü",
    description: "Hak arama özgürlüğünün ve adaletin teminatı olan savunma makamı temsilcilerini onurlandıran gün.",
    month_no: 4, day_no: 5, category: "Mesleki",
    hashtags: ["#5Nisan", "#AvukatlarGunu", "#SavunmaHakki", "#Adalet"],
    affiliate_keywords: ["avukat hediye seti cübbe biblo", "adalet heykeli themis", "dolma kalem lüks", "deri evrak çantası"],
    nedir: "1958 yılında İzmir'de yapılan Türkiye Barolar Birliği toplantısında 5 Nisan tarihi Avukatlar Günü olarak kabul edilmiştir.",
    nasil: "1. Avukat dostlarınıza tebrik mesajı gönderin.\n2. Hukukun üstünlüğü ve adil yargılanma hakkına dikkat çekin.\n3. Hak arama bilincini geliştirin.",
    mesaj: "Hukukun üstünlüğü ve adaletin savunucusu tüm avukatlarımızın 5 Nisan Avukatlar Günü kutlu olsun! ⚖️📜"
  },
  {
    slug: "dunya-saglik-gunu",
    title: "7 Nisan Dünya Sağlık Günü",
    description: "Dünya Sağlık Örgütü'nün kuruluş yıl dönümünde herkes için erişilebilir sağlık hizmetlerini savunan gün.",
    month_no: 4, day_no: 7, category: "Sağlık",
    hashtags: ["#DunyaSaglikGunu", "#WorldHealthDay", "#SaglikHerkesIcin", "#SaglikliYasam"],
    affiliate_keywords: ["tansiyon aleti dijital", "ateş ölçer temassız", "vitamin multivitamin", "egzersiz lastiği"],
    nedir: "1948 yılında Dünya Sağlık Örgütü'nün (WHO) anayasasının yürürlüğe girdiği tarih olup her yıl belirlenen temalarla kutlanır.",
    nasil: "1. Sağlık kontrollerinizi aksatmayın.\n2. Düzenli yürüyüş ve egzersiz yapmayı alışkanlık haline getirin.\n3. Sağlıklı beslenme düzenine geçin.",
    mesaj: "Sağlık en büyük zenginliktir. 7 Nisan Dünya Sağlık Günü kutlu olsun! 🍎🩺"
  },
  {
    slug: "dunya-sanat-gunu",
    title: "15 Nisan Dünya Sanat Günü",
    description: "Leonardo da Vinci'nin doğum gününde sanatsal yaratıcılığı ve özgürlüğü kutlayan uluslararası gün.",
    month_no: 4, day_no: 15, category: "Kültür & Sanat",
    hashtags: ["#DunyaSanatGunu", "#WorldArtDay", "#LeonardoDaVinci", "#Sanat"],
    affiliate_keywords: ["akrilik boya seti", "resim şövalesi", "tuval seti", "eskiz defteri kaliteli"],
    nedir: "Uluslararası Sanat Derneği'nin Türkiye temsilcisi ressam Bedri Baykam'ın önerisiyle UNESCO tarafından kabul edilen küresel sanat günüdür.",
    nasil: "1. Bir sanat galerisini veya resim sergisini gezin.\n2. Yeni bir sanatsal hobi edinin (resim, seramik, heykel).\n3. Sanatçıların eserlerini paylaşarak destek olun.",
    mesaj: "Sanatsız kalan bir milletin hayat damarlarından biri kopmuş demektir. 15 Nisan Dünya Sanat Günü kutlu olsun! 🎨🖌️"
  },
  {
    slug: "dunya-gunu",
    title: "22 Nisan Dünya Günü (Earth Day)",
    description: "Gezegenimizi korumak, iklim krizini önlemek ve doğaya saygı duymak için dünya çapında kutlanan çevre günü.",
    month_no: 4, day_no: 22, category: "Çevre & Doğa",
    hashtags: ["#DunyaGunu", "#EarthDay", "#IklimKrizi", "#GezegenimiziKoru"],
    affiliate_keywords: ["güneş enerjili powerbank", "bambu pipet seti", "çevre dostu temizlik ürünleri"],
    nedir: "1970 yılında ABD'de çevre kirliliğine karşı 20 milyon insanın katıldığı protestoyla doğmuş ve küresel çevre hareketine dönüşmüştür.",
    nasil: "1. Bir günlüğüne aracınızı bırakıp toplu taşıma veya bisiklet kullanın.\n2. Enerji ve plastik tüketiminizi kısıtlayın.\n3. Fidan dikim etkinliklerine katılın.",
    mesaj: "Evimiz Dünya için harekete geçme zamanı! 22 Nisan Dünya Günü kutlu olsun. 🌍🌱"
  },
  {
    slug: "ulusal-egemenlik-ve-cocuk-bayrami",
    title: "23 Nisan Ulusal Egemenlik ve Çocuk Bayramı",
    description: "TBMM'nin açılışı ve Atatürk'ün dünya çocuklarına armağan ettiği ilk ve tek çocuk bayramı.",
    month_no: 4, day_no: 23, category: "Resmi",
    hashtags: ["#23Nisan", "#CocukBayrami", "#EgemenlikUlusundur", "#Ataturk"],
    affiliate_keywords: ["çocuk kostümü", "uçurtma seti", "çocuk zeka oyunları", "türk bayrağı balon"],
    nedir: "23 Nisan 1920'de Ankara'da TBMM açılmış ve milletin egemenliği tescillenmiştir. Dünyadaki tüm çocuklara bayram hediye edilmiştir.",
    nasil: "1. Evleri ve balkonları bayraklarla süsleyin.\n2. Çocuk şenliklerine katılın.\n3. Çocuklara günün anlamını ve Atatürk'ü anlatın.",
    mesaj: "Egemenlik kayıtsız şartsız milletindir! 23 Nisan Ulusal Egemenlik ve Çocuk Bayramımız kutlu olsun! 🇹🇷🎈"
  },
  {
    slug: "dunya-kitap-gunu",
    title: "23 Nisan Dünya Kitap ve Telif Hakkı Günü",
    description: "Shakespeare ve Cervantes'in ölüm yıl dönümünde kitap okuma sevgisini ve yazarların haklarını kutlayan gün.",
    month_no: 4, day_no: 23, category: "Kültür & Sanat",
    hashtags: ["#DunyaKitapGunu", "#KitapKurdu", "#OkumakOzgurluktur", "#Kitap"],
    affiliate_keywords: ["e-kitap okuyucu kılıfı", "ahşap kitap ayracı", "kitap okuma lambası", "roman seti çok satanlar"],
    nedir: "UNESCO tarafından 1995 yılında kitap okumayı teşvik etmek ve telif haklarını korumak amacıyla ilan edilmiştir.",
    nasil: "1. Bir arkadaşınıza en sevdiğiniz kitabı hediye edin.\n2. Yeni bir kitaba başlayın ve her gün 20 sayfa okuyun.\n3. Kütüphaneleri ziyaret edin.",
    mesaj: "Kitaplar sessiz öğretmenlerdir. 23 Nisan Dünya Kitap Günü'nde sayfaların büyüsüne kapılın! 📖✨"
  },
  {
    slug: "dunya-dans-gunu",
    title: "29 Nisan Dünya Dans Günü",
    description: "Bedenin evrensel dili olan dansın coşkusunu kutlamak için modern balenin yaratıcısı Noverre anısına kutlanır.",
    month_no: 4, day_no: 29, category: "Kültür & Sanat",
    hashtags: ["#DunyaDansGunu", "#DanceDay", "#DansEt", "#Sanat"],
    affiliate_keywords: ["dans ayakkabısı", "kablosuz kulaklık spor", "tayt spor kaliteli", "dans kursu kuponu"],
    nedir: "UNESCO Uluslararası Dans Komitesi tarafından 1982 yılından bu yana tüm dans türlerini kutlamak amacıyla düzenlenir.",
    nasil: "1. En sevdiğiniz şarkıyı açıp özgürce dans edin.\n2. Salsa, tango veya zeybek gibi yeni bir dans kursu deneyin.\n3. Dans gösterilerini izleyin.",
    mesaj: "Hayat bir danstır, ritmi yakala! 29 Nisan Dünya Dans Günü kutlu olsun! 💃🕺🎶"
  },

  // Mayıs (5)
  {
    slug: "emek-ve-dayanisma-gunu",
    title: "1 Mayıs Emek ve Dayanışma Günü",
    description: "İşçi ve emekçilerin hak mücadelelerini onurlandıran, tüm dünyada kutlanan uluslararası resmi tatil günü.",
    month_no: 5, day_no: 1, category: "Resmi",
    hashtags: ["#1Mayis", "#IsciBayrami", "#EmekVeDayanisma", "#Haklar"],
    affiliate_keywords: ["iş güvenliği ayakkabısı", "termos yemek kabı", "iş tulumu"],
    nedir: "1886 yılında Chicago'da işçilerin 8 saatlik iş günü mücadelesiyle başlayan, emeğin ve alın terinin küresel bayramıdır.",
    nasil: "1. Alın teriyle çalışan tüm emekçileri tebrik edin.\n2. İş güvenliği ve adil ücret haklarını savunun.\n3. Emek dayanışmasına katkıda bulunun.",
    mesaj: "Alın teriyle dünyayı güzelleştiren tüm emekçilerin 1 Mayıs Emek ve Dayanışma Günü kutlu olsun! 🛠️✊"
  },
  {
    slug: "anneler-gunu",
    title: "10 Mayıs Anneler Günü",
    description: "Annelerimizin karşılıksız sevgisine ve fedakarlıklarına teşekkür ettiğimiz en duygusal özel gün.",
    month_no: 5, day_no: 10, category: "Eğlence",
    hashtags: ["#AnnelerGunu", "#CanimAnnem", "#AnneSevgisi", "#HediyeFikirleri"],
    affiliate_keywords: ["anneler günü hediye seti", "robot süpürge", "kolye anne bebek figürlü", "çiçek sepeti"],
    nedir: "Modern Anneler Günü, Anna Jarvis'in annesi anısına başlattığı hareketle yaygınlaşmış olup Mayıs ayının ikinci pazarı kutlanır.",
    nasil: "1. Annenizi ziyaret edin, sarılın ve sevginizi dile getirin.\n2. Onun için özel bir kahvaltı hazırlayın.\n3. Onu mutlu edecek içten bir hediye seçin.",
    mesaj: "Cennet annelerin ayakları altındadır. Varlığıyla hayatımızı aydınlatan canım annemin ve tüm annelerin Anneler Günü kutlu olsun! 💐💖"
  },
  {
    slug: "hemsireler-gunu",
    title: "12 Mayıs Hemşireler Günü",
    description: "Modern hemşireliğin kurucusu Florence Nightingale anısına sağlık ordusunun fedakar hemşirelerine adanan gün.",
    month_no: 5, day_no: 12, category: "Sağlık",
    hashtags: ["#HemsirelerGunu", "#12Mayis", "#HemsirelereTesekkurler", "#Saglik"],
    affiliate_keywords: ["hemşire forması desenli", "ortopedik sabo terlik", "hemşire saati stetoskop", "fincan hemşire"],
    nedir: "Uluslararası Hemşireler Konseyi tarafından Florence Nightingale'in doğum günü olan 12 Mayıs'ta küresel olarak kutlanır.",
    nasil: "1. Sağlık kuruluşlarında görev yapan hemşirelere teşekkür edin.\n2. Hemşirelerin çalışma koşullarının iyileştirilmesine destek olun.\n3. Onların şefkatli emeğini takdir edin.",
    mesaj: "Şefkat dolu elleriyle yaralarımızı saran tüm hemşirelerimizin 12 Mayıs Hemşireler Günü kutlu olsun! 🩺🤍"
  },
  {
    slug: "dunya-ciftciler-gunu",
    title: "14 Mayıs Dünya Çiftçiler Günü",
    description: "Sofralarımıza gelen her lokmada emeği olan çiftçilerin ve tarım üreticilerinin uluslararası günü.",
    month_no: 5, day_no: 14, category: "Mesleki",
    hashtags: ["#DunyaCiftcilerGunu", "#14Mayis", "#TopraginEmekcileri", "#Tarim"],
    affiliate_keywords: ["bahçe eldiveni sağlam", "budama testeresi", "toprak ph ölçer", "hasır şapka"],
    nedir: "Uluslararası Tarım Üreticileri Federasyonu'nun kuruluş tarihi olan 14 Mayıs 1984'ten bu yana kutlanmaktadır.",
    nasil: "1. Yerel üreticilerden ve köy pazarlarından alışveriş yapın.\n2. Sürdürülebilir tarım uygulamalarını destekleyin.\n3. Çiftçilerin emeğine saygı gösterin.",
    mesaj: "Köylü milletin efendisidir! Gece gündüz üreten tüm çiftçilerimizin 14 Mayıs Dünya Çiftçiler Günü kutlu olsun. 🌾🚜"
  },
  {
    slug: "genclik-ve-spor-bayrami",
    title: "19 Mayıs Atatürk'ü Anma, Gençlik ve Spor Bayramı",
    description: "Atatürk'ün Samsun'a çıkarak Milli Mücadele'yi başlattığı ve Türk gençliğine armağan ettiği milli bayramımız.",
    month_no: 5, day_no: 19, category: "Resmi",
    hashtags: ["#19Mayis", "#GenclikVesporBayrami", "#Ataturk", "#Samsun1919"],
    affiliate_keywords: ["türk bayrağı spor tişörtü", "spor çantası", "basketbol topu", "atatürk imzalı rozet"],
    nedir: "19 Mayıs 1919'da Mustafa Kemal Paşa Bandırma Vapuru ile Samsun'a ayak basmış ve Kurtuluş Savaşı'nı fiilen başlatmıştır.",
    nasil: "1. Gençlik festivallerine ve spor müsabakalarına katılın.\n2. Şehir meydanlarındaki resmi törenleri izleyin.\n3. Evlerinize Türk bayrakları asın.",
    mesaj: "Ey Türk Gençliği! Birinci vazifen Türk istiklalini ve Türk cumhuriyetini ilelebet muhafaza ve müdafaa etmektir. 19 Mayıs kutlu olsun! 🇹🇷🏃‍♂️"
  },
  {
    slug: "dunya-ari-gunu",
    title: "20 Mayıs Dünya Arı Günü",
    description: "Ekosistemin ve tarımın gizli kahramanları olan arıların tozlaşmadaki hayati önemini hatırlatan BM günü.",
    month_no: 5, day_no: 20, category: "Çevre & Doğa",
    hashtags: ["#DunyaAriGunu", "#WorldBeeDay", "#ArilariKoru", "#DogayiKoru"],
    affiliate_keywords: ["doğal organik bal", "arı sütü propolis", "çiçek tohumu arı dostu"],
    nedir: "Modern arıcılığın öncüsü Anton Jansa'nın doğum günü anısına Birleşmiş Milletler tarafından kabul edilmiştir.",
    nasil: "1. Balkonunuza arıların sevdiği lavanta ve kekik gibi çiçekler ekin.\n2. Kimyasal tarım ilaçlarının azaltılmasını savunun.\n3. Gerçek arıcıları destekleyin.",
    mesaj: "Arılar yoksa hayat da yok! 20 Mayıs Dünya Arı Günü'nde minik kanatlı dostlarımızı koruyalım. 🐝🍯🌸"
  },
  {
    slug: "istanbulun-fethi",
    title: "29 Mayıs İstanbul'un Fethi",
    description: "1453 yılında Fatih Sultan Mehmet komutasındaki Osmanlı ordusunun İstanbul'u fethettiği tarihi gün.",
    month_no: 5, day_no: 29, category: "Resmi",
    hashtags: ["#29Mayis1453", "#IstanbulunFethi", "#FatihSultanMehmet", "#Fetih"],
    affiliate_keywords: ["istanbul fetih tarihi kitabı", "osmanlı tuğrası tablo", "minyatür fatih biblosu"],
    nedir: "29 Mayıs 1453'te İstanbul fethedilmiş, Orta Çağ kapanıp Yeni Çağ başlamış ve Konstantiniyye, Osmanlı'nın başkenti olmuştur.",
    nasil: "1. Tarihi Yarımada'yı ve fethin izlerini taşıyan surları ziyaret edin.\n2. Panorama 1453 Tarih Müzesi'ni gezin.\n3. İstanbul'un kültürel zenginliğini anlatan eserleri inceleyin.",
    mesaj: "Bir çağı kapatıp yeni bir çağ açan Fatih Sultan Mehmet ve kutlu ordusunu rahmetle anıyoruz. 29 Mayıs İstanbul'un Fethi kutlu olsun! 🇹🇷🏰"
  },

  // Haziran (6)
  {
    slug: "dunya-cevre-gunu",
    title: "5 Haziran Dünya Çevre Günü",
    description: "Doğayı korumak, iklim kriziyle mücadele etmek ve gezegenimizin sürdürülebilirliğini sağlamak için kutlanır.",
    month_no: 6, day_no: 5, category: "Çevre & Doğa",
    hashtags: ["#DunyaCevreGunu", "#SifirAtik", "#IklimKrizi", "#DogaDostu"],
    affiliate_keywords: ["çelik matara termos", "bez alışveriş çantası", "bambu diş fırçası seti", "kompost kutusu"],
    nedir: "1972 yılında Stockholm Çevre Konferansı'nda alınan kararla ilan edilen gün çevre bilincini küresel düzeyde artırır.",
    nasil: "1. Fidan dikin veya yerel çevre temizliği etkinliklerine katılın.\n2. Tek kullanımlık plastik tüketiminizi sıfırlayın.\n3. Su ve elektrik tasarrufu yapın.",
    mesaj: "Başka bir Dünya yok! 5 Haziran Dünya Çevre Günü'nde doğaya borcumuzu ödeyelim. 🌍🌱"
  },
  {
    slug: "dunya-okyanuslar-gunu",
    title: "8 Haziran Dünya Okyanuslar Günü",
    description: "Gezegenimizin akciğerleri olan deniz ve okyanusların plastik kirliliğinden arındırılmasını savunan gün.",
    month_no: 6, day_no: 8, category: "Çevre & Doğa",
    hashtags: ["#DunyaOkyanuslarGunu", "#WorldOceansDay", "#DenizleriKoru", "#MaviGezegen"],
    affiliate_keywords: ["deniz gözlüğü şnorkel", "mikrofiber hızlı kuruyan havlu", "su geçirmez telefon kılıfı"],
    nedir: "1992 Rio Dünya Zirvesi'nde önerilen ve 2008'de BM tarafından resmi olarak tanınan küresel okyanus koruma günüdür.",
    nasil: "1. Sahil ve plaj temizliklerine katılın.\n2. Plastik atıkların denizlere ulaşmasını engelleyin.\n3. Sürdürülebilir deniz ürünlerini tercih edin.",
    mesaj: "Mavi gezegenimizin kalbi denizler ve okyanuslardır. 8 Haziran Dünya Okyanuslar Günü kutlu olsun! 🌊🐋🐬"
  },
  {
    slug: "dunya-kan-bagiscilari-gunu",
    title: "14 Haziran Dünya Kan Bağışçıları Günü",
    description: "Gönüllü ve karşılıksız kan bağışlayarak milyonlarca insanın hayatını kurtaran kahramanları onurlandıran gün.",
    month_no: 6, day_no: 14, category: "Sağlık",
    hashtags: ["#KanBagiscilariGunu", "#KanBagisiHayatKurtarir", "#Kizilay", "#KanVerCanVer"],
    affiliate_keywords: ["kan şekeri ölçüm cihazı", "vitamin takviyesi", "sporcu su matarası"],
    nedir: "AB0 kan grubu sistemini bulan Nobel ödüllü Karl Landsteiner'in doğum gününde DSÖ öncülüğünde kutlanır.",
    nasil: "1. En yakın Kızılay kan merkezine giderek kan bağışında bulunun.\n2. Sağlıklı bireyleri kan bağışına teşvik edin.\n3. Kök hücre bağışçısı olmayı değerlendirin.",
    mesaj: "1 ünite kan 3 can kurtarır! Tüm gönüllü bağışçılarımızın 14 Haziran Dünya Kan Bağışçıları Günü kutlu olsun. 🩸❤️"
  },
  {
    slug: "babalar-gunu",
    title: "21 Haziran Babalar Günü",
    description: "Babalarımızın fedakarlıklarına, sevgisine ve rehberliğine teşekkür ettiğimiz anlamlı kutlama günü.",
    month_no: 6, day_no: 21, category: "Eğlence",
    hashtags: ["#BabalarGunu", "#CanimBabam", "#BabaSevgisi", "#HediyeFikirleri"],
    affiliate_keywords: ["babalar günü hediye kutusu", "deri cüzdan kemer seti", "tıraş makinesi seti", "erkek kol saati"],
    nedir: "Her yıl Haziran ayının üçüncü pazar günü babaların ailedeki sevgi ve koruma rolünü onurlandırmak için kutlanır.",
    nasil: "1. Babanızı arayın veya ziyaret edip ona teşekkür edin.\n2. Birlikte nostaljik bir yürüyüş veya kahve molası verin.\n3. Kullanışlı ve anlamlı bir hediye armağan edin.",
    mesaj: "Hayatımızın en güvenli sığınağı, ilk kahramanımız olan canım babamın ve tüm babaların Babalar Günü kutlu olsun! 👔💙"
  },
  {
    slug: "dunya-muzik-gunu",
    title: "21 Haziran Dünya Müzik Günü",
    description: "Yılın en uzun gününde sokaklarda, parklarda ve salonlarda müziğin evrensel dilini kutlayan müzik festivali.",
    month_no: 6, day_no: 21, category: "Kültür & Sanat",
    hashtags: ["#DunyaMuzikGunu", "#FeteDeLaMusique", "#MuzikRuhunGidasidir", "#21Haziran"],
    affiliate_keywords: ["bluetooth kulaklık", "akustik gitar başlangıç seti", "ukulele ahşap", "taşınabilir hoparlör"],
    nedir: "1982'de Fransa'da başlatılan Fête de la Musique, bugün 120 ülkede amatör ve profesyonel müzisyenlerin sokaklarda özgürce müzik yaptığı bir şölendir.",
    nasil: "1. En sevdiğiniz enstrümanı çalın veya yeni bir şarkı öğrenin.\n2. Ücretsiz sokak konserlerini izleyin.\n3. Farklı dünya müziklerini keşfedin.",
    mesaj: "Müzik ruhun gıdasıdır. Ruhu müzikle beslenen tüm dostların 21 Haziran Dünya Müzik Günü kutlu olsun! 🎵🎸🎧"
  },

  // Temmuz (7)
  {
    slug: "kabotaj-bayrami",
    title: "1 Temmuz Denizcilik ve Kabotaj Bayramı",
    description: "Türk karasularında egemenliğin ve deniz ticareti hakkının Türkiye'ye geçtiği tarihi milli bayram.",
    month_no: 7, day_no: 1, category: "Resmi",
    hashtags: ["#1Temmuz", "#KabotajBayrami", "#DenizcilikBayrami", "#MaviVatan"],
    affiliate_keywords: ["yelkenli gemi maketi", "denizci şapkası", "deniz kabuğu bileklik", "su geçirmez çanta"],
    nedir: "1 Temmuz 1926'da yürürlüğe giren Kabotaj Kanunu ile Türk limanları arasındaki deniz taşımacılığı hakkı yabancılardan alınıp Türk bayraklı gemilere verilmiştir.",
    nasil: "1. Kıyı şehirlerindeki deniz şenliklerini ve yağlı direk yarışlarını izleyin.\n2. Deniz şehitlerini anma törenlerine katılın.\n3. Türkiye'nin denizcilik tarihini okuyun.",
    mesaj: "Denizlere hakim olan cihana hakim olur! 1 Temmuz Denizcilik ve Kabotaj Bayramımız kutlu olsun! 🇹🇷⚓🚢"
  },
  {
    slug: "dunya-cikolata-gunu",
    title: "7 Temmuz Dünya Çikolata Günü",
    description: "Kakao çekirdeğinden üretilen dünyanın en sevilen tatlısının keşfini kutlayan lezzetli gün.",
    month_no: 7, day_no: 7, category: "Eğlence",
    hashtags: ["#DunyaCikolataGunu", "#WorldChocolateDay", "#CikolataSever", "#TatliKriz"],
    affiliate_keywords: ["belçika çikolatası kutusu", "çikolata fondü seti", "sıcak çikolata tozu", "çikolatalı trüf"],
    nedir: "1550 yılında çikolatanın Avrupa'ya ilk kez getirildiği günün anısına dünya çapında çikolata günü olarak kutlanır.",
    nasil: "1. Sevdiklerinizle özel bir çikolata kutusu paylaşın.\n2. Evde kendi çikolatalı tatlınızı pişirin.\n3. Yüksek kakaolu bitter çikolatanın faydalarını keşfedin.",
    mesaj: "Mutluluğun en tatlı hali! Tüm çikolataseverlerin 7 Temmuz Dünya Çikolata Günü kutlu olsun! 🍫😋"
  },
  {
    slug: "demokrasi-ve-milli-birlik-gunu",
    title: "15 Temmuz Demokrasi ve Milli Birlik Günü",
    description: "15 Temmuz 2016 darbe girişimine karşı milletimizin gösterdiği destansı direnişi ve şehitlerimizi anma günü.",
    month_no: 7, day_no: 15, category: "Resmi",
    hashtags: ["#15Temmuz", "#DemokrasiBayrami", "#MilliBirlikGunu", "#SehitlerimiziUnutmadik"],
    affiliate_keywords: ["türk bayrağı büyük boy", "15 temmuz anı kitabı", "atatürk tişörtü"],
    nedir: "15 Temmuz gecesi halkın iradesine ve demokrasimize sahip çıkarak canlarını feda eden şehit ve gazilerimizi anmak için resmi tatil ilan edilmiştir.",
    nasil: "1. Şehitlikleri ziyaret edin ve dualar okuyun.\n2. Demokrasi nöbetlerine ve anma programlarına katılın.\n3. Milli birlik ve beraberlik mesajları paylaşın.",
    mesaj: "Milletimizin iradesi hiçbir gücün önünde eğilmez! 15 Temmuz Demokrasi ve Milli Birlik Günü'nde şehitlerimizi rahmetle anıyoruz. 🇹🇷🕊️"
  },
  {
    slug: "dunya-emoji-gunu",
    title: "17 Temmuz Dünya Emoji Günü",
    description: "Dijital çağın küresel dili olan emojilerin iletişimdeki eğlenceli rolünü kutlayan internet günü.",
    month_no: 7, day_no: 17, category: "Eğlence",
    hashtags: ["#DunyaEmojiGunu", "#WorldEmojiDay", "#EmojiGunu", "#DijitalIletisim"],
    affiliate_keywords: ["emoji yastık peluş", "emoji anahtarlık", "renkli sticker çıkartma seti"],
    nedir: "Apple'ın takvim emojisinin üzerinde 17 Temmuz yazdığı için Emojipedia kurucusu Jeremy Burge tarafından 2014'te ilan edilmiştir.",
    nasil: "1. Bugün mesajlarınızda en sevdiğiniz emojileri bolca kullanın.\n2. Arkadaşlarınızla emoji tahmin oyunu oynayın.\n3. Sosyal medyada günün favori emojisini seçin.",
    mesaj: "Kelimelerin yetmediği yerde emojiler konuşur! 17 Temmuz Dünya Emoji Günü kutlu olsun! 🎉🥳🚀"
  },
  {
    slug: "dunya-satranc-gunu",
    title: "20 Temmuz Dünya Satranç Günü",
    description: "Strateji, zeka ve sabır oyunu satrancın zihinsel gelişimdeki gücünü kutlamak için FIDE öncülüğünde kutlanır.",
    month_no: 7, day_no: 20, category: "Eğlence",
    hashtags: ["#DunyaSatrancGunu", "#ChessDay", "#SatrancSeverler", "#ZekaOyunu"],
    affiliate_keywords: ["ahşap satranç takımı", "dijital satranç saati", "satranç taktikleri kitabı", "manyetik seyahat satrancı"],
    nedir: "1924 yılında Dünya Satranç Federasyonu'nun (FIDE) Paris'te kuruluşunun anısına Birleşmiş Milletler tarafından kabul edilmiştir.",
    nasil: "1. Bir dostunuzla zevkli bir satranç maçı yapın.\n2. Yeni bir açılış hamlesi veya taktik öğrenin.\n3. Çocuklara satranç öğretin.",
    mesaj: "Hayat da satranç gibidir, her hamle geleceğini belirler. 20 Temmuz Dünya Satranç Günü kutlu olsun! ♟️👑"
  },

  // Ağustos (8)
  {
    slug: "dunya-solaklar-gunu",
    title: "13 Ağustos Dünya Solaklar Günü",
    description: "Dünya nüfusunun yaklaşık yüzde 10'unu oluşturan solakların günlük hayattaki zorluklarına dikkat çeken gün.",
    month_no: 8, day_no: 13, category: "Eğlence",
    hashtags: ["#DunyaSolaklarGunu", "#LefthandersDay", "#SolaklarGunu", "#SolEl"],
    affiliate_keywords: ["solaklar için makas", "sol el ergonomik mouse", "solaklar için dolma kalem"],
    nedir: "1976 yılında Dean R. Campbell tarafından solakların sağ el odaklı dünyada yaşadığı zorluklara eğlenceli ve eğitici bir bakış açısıyla başlatılmıştır.",
    nasil: "1. Sağ elinizi kullanan biriyseniz bugün bir süre sol elinizle yazı yazmayı deneyin.\n2. Solak arkadaşlarınıza özel hediyeler verin.\n3. Solakların başarılarını kutlayın.",
    mesaj: "Farklı açıdan gören ve sol eliyle dünyayı güzelleştiren tüm solakların günü kutlu olsun! ✍️🖐️"
  },
  {
    slug: "dunya-fotografcilik-gunu",
    title: "19 Ağustos Dünya Fotoğrafçılık Günü",
    description: "Anı ölümsüzleştiren fotoğraf sanatının doğuşunu (Dagerreyotipi patentini) kutlayan küresel sanat günü.",
    month_no: 8, day_no: 19, category: "Kültür & Sanat",
    hashtags: ["#FotografcilikGunu", "#WorldPhotographyDay", "#FotografSever", "#Kadraj"],
    affiliate_keywords: ["fotoğraf makinesi askısı", "lens temizleme kiti", "telefon için fotoğraf lensi", "fotoğraf albümü"],
    nedir: "1839 yılında Fransız hükümetinin Dagerreyotipi buluşunu tüm dünyaya ücretsiz hediye ettiği 19 Ağustos günü fotoğrafçılığın doğum günü sayılır.",
    nasil: "1. Makinenizi veya telefonunuzu alıp şehri kadrajınıza alın.\n2. En sevdiğiniz fotoğrafları sergileyin veya paylaşın.\n3. Fotoğrafçılık kursu veya eğitim videosu izleyin.",
    mesaj: "Hayatı durdurup anı ölümsüzleştiren tüm fotoğraf tutkunlarının 19 Ağustos Dünya Fotoğrafçılık Günü kutlu olsun! 📷✨"
  },
  {
    slug: "dunya-kopekler-gunu",
    title: "26 Ağustos Dünya Köpekler Günü",
    description: "İnsanın en sadık dostu köpeklerin yaşam hakkını ve barınaklardaki sahipsiz canları hatırlatan gün.",
    month_no: 8, day_no: 26, category: "Çevre & Doğa",
    hashtags: ["#DunyaKopeklerGunu", "#DogDay", "#CanDostum", "#SatinAlmaSahiplen"],
    affiliate_keywords: ["köpek tasması ve künyesi", "köpek ödül bisküvisi", "köpek diş temizleme oyuncağı", "köpek yatağı ortopedik"],
    nedir: "2004 yılında hayvan savunucusu Colleen Paige tarafından kurtarma köpeklerine ve sahiplenmeye dikkat çekmek amacıyla başlatılmıştır.",
    nasil: "1. Köpeğinize uzun ve keyifli bir yürüyüş yaptırın.\n2. Sokak köpeklerine mama ve su bırakın.\n3. Barınaktan bir dost sahiplenmeyi değerlendirin.",
    mesaj: "Karşılıksız sevginin ve sadakatin adı! Tüm sevimli can dostlarımızın 26 Ağustos Dünya Köpekler Günü kutlu olsun! 🐶🦴"
  },
  {
    slug: "zafer-bayrami",
    title: "30 Ağustos Zafer Bayramı",
    description: "1922 Büyük Taarruz ve Başkomutanlık Meydan Muharebesi zaferini kutladığımız büyük milli bayramımız.",
    month_no: 8, day_no: 30, category: "Resmi",
    hashtags: ["#30Agustos", "#ZaferBayrami", "#BaskanMustafaKemal", "#BuyukTaarruz", "#Turkiye"],
    affiliate_keywords: ["türk bayrağı araba süsü", "atatürk tişörtü", "kurtuluş savaşı tarihi kitabı", "rozet"],
    nedir: "Gazi Mustafa Kemal Atatürk başkumandanlığında Türk ordusunun vatan topraklarını işgalden temizlediği kesin zafer günüdür.",
    nasil: "1. Resmi geçit törenlerini ve Türk Yıldızları gösterilerini izleyin.\n2. Şehitlikleri ziyaret ederek dua edin.\n3. Evlerinizi ve iş yerlerinizi Türk bayraklarıyla donatın.",
    mesaj: "30 Ağustos, Türk milletinin bağımsızlığından asla vazgeçmeyeceğinin belgesidir. Zafer Bayramımız kutlu olsun! 🇹🇷🎖️"
  },

  // Eylül (9)
  {
    slug: "dunya-baris-gunu",
    title: "1 Eylül Dünya Barış Günü",
    description: "İkinci Dünya Savaşı'nın başladığı günde savaşların sona ermesi ve küresel barışın tesisi için kutlanan gün.",
    month_no: 9, day_no: 1, category: "Farkındalık",
    hashtags: ["#1Eylul", "#DunyaBarisGunu", "#YurttaSulhCihandaSulh", "#Baris"],
    affiliate_keywords: ["barış güvercini kolye", "barış temalı tişört", "felsefe ve barış kitapları"],
    nedir: "1 Eylül 1939'da Almanya'nın Polonya'yı işgaliyle başlayan 2. Dünya Savaşı'nın yıkımını unutmamak için ilan edilen barış günüdür.",
    nasil: "1. 'Yurtta sulh, cihanda sulh' ilkesini hatırlayın ve savunun.\n2. Çevrenizdeki anlaşmazlıkları diyalog ve empatiyle çözün.\n3. Barış mesajları paylaşın.",
    mesaj: "Savaşın kazananı, barışın kaybedeni olmaz. 1 Eylül Dünya Barış Günü'nde tüm dünyaya huzur diliyoruz. 🕊️🌍"
  },
  {
    slug: "dunya-yazilimcilar-gunu",
    title: "13 Eylül Dünya Yazılımcılar Günü",
    description: "Yılın 256. gününde (2 üzeri 8) dijital dünyayı inşa eden tüm yazılım geliştiricileri onurlandıran gün.",
    month_no: 9, day_no: 13, category: "Mesleki",
    hashtags: ["#YazilimcilarGunu", "#ProgrammersDay", "#Coding", "#DeveloperLife", "#256Day"],
    affiliate_keywords: ["mekanik klavye rgb", "ergonomik mouse", "yazılımcı tişörtü", "monitör standı"],
    nedir: "1 baytın alabileceği farklı değer sayısı olan 256'ncı günde kutlanan uluslararası programcılar günüdür.",
    nasil: "1. Açık kaynak projelere katkıda bulunun.\n2. Yeni bir programlama dili veya framework öğrenin.\n3. Yazılımcı arkadaşınıza kahve ısmarlayın.",
    mesaj: "while(alive) { code(); coffee(); } 🚀 Sıfır hatalı commit'ler ve bugsız günler dileriz! 💻✨"
  },
  {
    slug: "dunya-alzheimer-gunu",
    title: "21 Eylül Dünya Alzheimer Günü",
    description: "Alzheimer hastalığına ve demansa dikkat çekmek, hasta ve hasta yakınlarına destek olmak için kutlanır.",
    month_no: 9, day_no: 21, category: "Sağlık",
    hashtags: ["#AlzheimerGunu", "#Unutma", "#ErkenTeshis", "#AlzheimerFarkindalik"],
    affiliate_keywords: ["hafıza güçlendirme bulmaca kitabı", "akıl oyunları seti yetişkin", "akıllı saat gps yaşlı"],
    nedir: "Dünya Sağlık Örgütü ve Uluslararası Alzheimer Birliği tarafından hafıza kaybı ve nörodejeneratif süreçler hakkında bilinç oluşturmak için düzenlenir.",
    nasil: "1. Zihinsel aktiviteler ve bulmacalarla beyninizi zinde tutun.\n2. Yaşlı aile bireylerinizle kaliteli zaman geçirin.\n3. Alzheimer derneklerine destek olun.",
    mesaj: "Bizi biz yapan anılarımızdır. 21 Eylül Dünya Alzheimer Günü'nde sevdiklerimizi unutmayalım, yanlarında olalım. 🧠💜"
  },
  {
    slug: "dunya-kuduz-gunu",
    title: "28 Eylül Dünya Kuduz Günü",
    description: "Kuduz hastalığı konusunda farkındalık yaratmak ve aşının hayati önemini vurgulamak için kutlanır.",
    month_no: 9, day_no: 28, category: "Sağlık",
    hashtags: ["#DunyaKuduzGunu", "#KuduzFarkindaligi", "#AsiHayatKurtarir", "#28Eylul"],
    affiliate_keywords: ["kedi köpek taşıma çantası", "köpek tasması ve künyesi", "veteriner bakım seti"],
    nedir: "Kuduz aşısını bulan Louis Pasteur'ün ölüm yıl dönümü olan 28 Eylül'de WHO ve GARC öncülüğünde düzenlenir.",
    nasil: "1. Evcil hayvanlarınızın yıllık kuduz aşılarını aksatmayın.\n2. Sokak hayvanlarının aşılanmasına destek olun.\n3. Isırılma durumunda derhal hastaneye başvurun.",
    mesaj: "Aşı hayat kurtarır! 28 Eylül Dünya Kuduz Günü'nde can dostlarımızı koruyalım, kuduzu birlikte sıfırlayalım. 🐾💉"
  },
  {
    slug: "bilgiye-evrensel-erisim-gunu",
    title: "28 Eylül Uluslararası Bilgiye Evrensel Erişim Günü",
    description: "Bilginin serbestçe yayılması ve şeffaf toplumların inşası için UNESCO öncülüğünde kutlanır.",
    month_no: 9, day_no: 28, category: "Farkındalık",
    hashtags: ["#BilgiyeErisimGunu", "#UNESCO", "#AcikBilgi", "#DijitalHaklar"],
    affiliate_keywords: ["e-kitap okuyucu", "bilimsel kitaplar", "hızlı okuma kitap seti"],
    nedir: "Vatandaşların kamu bilgilerine erişim hakkını ve basın özgürlüğünü güvence altına almayı hedefler.",
    nasil: "1. Açık kaynak kütüphaneleri ve veri setlerini keşfedin.\n2. Dijital okuryazarlığı destekleyin.\n3. Bilgiye erişim hakkını savunun.",
    mesaj: "Bilgi güçtür, özgürce erişildiğinde toplumu dönüştürür. 28 Eylül Bilgiye Evrensel Erişim Günü kutlu olsun! 📚🌐"
  },
  {
    slug: "dunya-kalp-gunu",
    title: "29 Eylül Dünya Kalp Günü",
    description: "Kalp ve damar hastalıklarına karşı sağlıklı yaşam, beslenme ve egzersiz bilincini artıran küresel sağlık günü.",
    month_no: 9, day_no: 29, category: "Sağlık",
    hashtags: ["#DunyaKalpGunu", "#KalbiniKoru", "#WorldHeartDay", "#SaglikliKalp"],
    affiliate_keywords: ["akıllı saat nabız ölçer", "kolesterol diyeti kitabı", "koşu bandı ev tipi"],
    nedir: "Dünya Kalp Federasyonu tarafından kardiyovasküler hastalıkların önlenmesine dikkat çekmek için kutlanır.",
    nasil: "1. Günde en az 30 dakika tempolu yürüyüş yapın.\n2. Tuzu, şekeri ve doymuş yağları azaltın.\n3. Sigarayı bırakın ve kalp kontrollerinizi yaptırın.",
    mesaj: "Her atışında sevgi var, kalbini koru! 29 Eylül Dünya Kalp Günü kutlu olsun. ❤️🩺"
  },

  // Ekim (10)
  {
    slug: "dunya-kahve-gunu",
    title: "1 Ekim Dünya Kahve Günü",
    description: "Her yıl 1 Ekim'de kahve üreticilerinin emeğini ve dünyanın en sevilen içeceğinin lezzetini kutlayan gün.",
    month_no: 10, day_no: 1, category: "Eğlence",
    hashtags: ["#DunyaKahveGunu", "#Kahve", "#CoffeeDay", "#KahveSever", "#1Ekim"],
    affiliate_keywords: ["filtre kahve makinesi", "nitelikli çekirdek kahve", "termos kupa", "french press", "chemex"],
    nedir: "Uluslararası Kahve Örgütü (ICO) tarafından 2015 yılında resmi olarak başlatılan küresel bir kutlama günüdür.",
    nasil: "1. V60, Chemex veya geleneksel Türk kahvesi demleyin.\n2. Yerel bağımsız kahvecileri ziyaret edin.\n3. İş arkadaşlarınızla kahve molası verin.",
    mesaj: "Bir fincan kahvenin kırk yıl hatırı vardır, Dünya Kahve Günü kutlu olsun! ☕✨"
  },
  {
    slug: "hayvanlari-koruma-gunu",
    title: "4 Ekim Hayvanları Koruma Günü",
    description: "Tüm canlıların yaşam haklarına saygı duymak ve sokak hayvanlarının refahını artırmak amacıyla kutlanır.",
    month_no: 10, day_no: 4, category: "Çevre & Doğa",
    hashtags: ["#4Ekim", "#HayvanlariKorumaGunu", "#SatinAlmaSahiplen", "#CanDostlarimiz"],
    affiliate_keywords: ["kedi maması 15kg", "köpek maması premium", "kuş yemi ve kafesi", "otomatik su sebili pet"],
    nedir: "1931 yılında Floransa'da çevre bilimcilerin girişimiyle tehlike altındaki türleri korumak için başlatılmıştır.",
    nasil: "1. Bir kap su ve bir kap mama bırakın.\n2. Barınakları ziyaret edip sahiplenmeyi değerlendirin.\n3. Hayvan sevgisini çocuklara aşılayın.",
    mesaj: "Onlar bize emanet! Dünyayı paylaştığımız tüm can dostlarımızın 4 Ekim Hayvanları Koruma Günü kutlu olsun. 🐶🐱🐦"
  },
  {
    slug: "dunya-ruh-sagligi-gunu",
    title: "10 Ekim Dünya Ruh Sağlığı Günü",
    description: "Ruh sağlığının genel sağlığın ayrılmaz bir parçası olduğunu vurgulayan ve psikolojik desteği savunan gün.",
    month_no: 10, day_no: 10, category: "Sağlık",
    hashtags: ["#RuhSagligiGunu", "#WorldMentalHealthDay", "#YalnizDegilsin", "#Psikoloji"],
    affiliate_keywords: ["psikoloji kitapları çok satanlar", "meditasyon minderi", "aromaterapi difüzör"],
    nedir: "Dünya Ruh Sağlığı Federasyonu tarafından ruh sağlığı sorunlarına yönelik damgalamayı kırmak amacıyla kutlanır.",
    nasil: "1. Kendi ruh halinizi dinleyin ve dinlenmeye vakit ayırın.\n2. Bir yakınınızın halini hatırını içtenlikle sorun.\n3. İhtiyaç duyduğunuzda profesyonel psikolojik destek alın.",
    mesaj: "Zihnin de bedenin kadar özen ister. 10 Ekim Dünya Ruh Sağlığı Günü'nde kendine şefkat göster. 🧠💚"
  },
  {
    slug: "dunya-kiz-cocuklari-gunu",
    title: "11 Ekim Dünya Kız Çocukları Günü",
    description: "Kız çocuklarının eğitim, sağlık, eşitlik ve güçlendirilmesi haklarına dikkat çekmek için BM tarafından kutlanır.",
    month_no: 10, day_no: 11, category: "Farkındalık",
    hashtags: ["#KizCocuklariGunu", "#DayOfTheGirl", "#GucluKizlar", "#EgitimHerkesIcin"],
    affiliate_keywords: ["ilham veren kadınlar çocuk kitabı", "bilim seti kız çocuk", "kodlama oyuncakları"],
    nedir: "2012 yılında Türkiye, Kanada ve Peru'nun öncülüğünde BM Genel Kurulu'nda kabul edilen küresel bir farkındalık günüdür.",
    nasil: "1. Kız çocuklarının eğitimine destek veren burs fonlarına bağış yapın.\n2. Kız çocuklarına hayallerinin peşinden gitme cesareti verin.\n3. Cinsiyetçi kalıpları yıkın.",
    mesaj: "Kız çocukları okursa dünya değişir! 11 Ekim Dünya Kız Çocukları Günü kutlu olsun. 👧📚✨"
  },
  {
    slug: "cumhuriyet-bayrami",
    title: "29 Ekim Cumhuriyet Bayramı",
    description: "Türkiye Cumhuriyeti'nin 1923 yılında Gazi Mustafa Kemal Atatürk tarafından ilan edildiği en büyük ulusal bayramımız.",
    month_no: 10, day_no: 29, category: "Resmi",
    hashtags: ["#29Ekim", "#CumhuriyetBayrami", "#Ataturk", "#Cumhuriyet103Yasinda", "#Turkiye"],
    affiliate_keywords: ["türk bayrağı büyük boy", "atatürk rozeti", "nutuk özel baskı", "fener alayı meşalesi"],
    nedir: "29 Ekim 1923'te TBMM'de Cumhuriyet ilan edilmiş ve egemenlik kayıtsız şartsız millete teslim edilmiştir.",
    nasil: "1. Evlerinize ve caddelere Türk Bayrakları asın.\n2. Törenlere, geçit alaylarına ve fener alaylarına katılın.\n3. Cumhuriyet değerlerini ve Atatürk ilkelerini hatırlayın.",
    mesaj: "Cumhuriyetimizin ışığında, Atamızın izinde daima ileriye! 29 Ekim Cumhuriyet Bayramımız kutlu olsun! 🇹🇷✨"
  },

  // Kasım (11)
  {
    slug: "losemili-cocuklar-haftasi",
    title: "2-8 Kasım Lösemili Çocuklar Haftası",
    description: "Lösemi hastalığı konusunda bilinç oluşturmak ve minik kahramanlara umut olmak amacıyla düzenlenen farkındalık haftası.",
    month_no: 11, day_no: 2, category: "Sağlık",
    hashtags: ["#LosemiliCocuklarHaftasi", "#MaskemiTakarimFarkindalikYaratirim", "#LÖSEV", "#Umut"],
    affiliate_keywords: ["lösev hediyelik eşya", "renkli maske seti", "çocuk boyama seti"],
    nedir: "LÖSEV öncülüğünde löseminin önlenebilir ve tedavi edilebilir bir hastalık olduğunu anlatmak amacıyla kutlanır.",
    nasil: "1. Maske takarak sosyal medyada farkındalık fotoğrafları paylaşın.\n2. LÖSEV'e bağışta bulunun.\n3. Lösemi tedavisi gören çocuklara sevgi ve moral gönderin.",
    mesaj: "Maskemizi takıyoruz, minik kahramanlarımızın yanındayız! Lösemili Çocuklar Haftası kutlu olsun. 🧡🎗️"
  },
  {
    slug: "ataturku-anma-gunu",
    title: "10 Kasım Atatürk'ü Anma Günü",
    description: "Türkiye Cumhuriyeti'nin kurucusu Gazi Mustafa Kemal Atatürk'ün ebediyete intikalinin yıl dönümü ve anma günü.",
    month_no: 11, day_no: 10, category: "Resmi",
    hashtags: ["#10Kasim", "#Ataturk", "#SaygiVeOzlemle", "#0905", "#Turkiye"],
    affiliate_keywords: ["atatürk portresi çerçeveli", "atatürk biyografi kitabı", "atatürk imzalı kupa", "nutuk ciltli"],
    nedir: "10 Kasım 1938 günü saat 09:05'te Dolmabahçe Sarayı'nda vefat eden Atatürk'ün anısına her yıl ulusal saygı duruşuyla icra edilir.",
    nasil: "1. Saat 09:05'te sirenler eşliğinde 2 dakikalık saygı duruşunda bulunun.\n2. Anıtkabir'i ve Atatürk müzelerini ziyaret edin.\n3. Onun fikirlerini ve mirasını okuyun.",
    mesaj: "Beni görmek demek mutlaka yüzümü görmek değildir. Fikirlerimi anlıyorsanız bu kafidir. Saygı, sevgi ve özlemle anıyoruz. 🇹🇷🖤"
  },
  {
    slug: "dunya-diyabet-gunu",
    title: "14 Kasım Dünya Diyabet Günü",
    description: "İnsülinin kaşifi Frederick Banting'in doğum gününde diyabet hastalığı ve dengeli beslenme bilincini artıran gün.",
    month_no: 11, day_no: 14, category: "Sağlık",
    hashtags: ["#DiyabetGunu", "#MaviHalka", "#SekerHastaligi", "#DengeliBeslen"],
    affiliate_keywords: ["şeker ölçüm cihazı stripli", "şekersiz tatlandırıcı", "diyabet tarifleri kitabı"],
    nedir: "Uluslararası Diyabet Federasyonu ve DSÖ tarafından artan şeker hastalığı riskine karşı 'Mavi Halka' sembolüyle kutlanır.",
    nasil: "1. Kan şekeri ölçümünüzü ve HbA1c testinizi yaptırın.\n2. Şekerli ve işlenmiş gıdalardan uzak durun.\n3. Günlük hareketinizi artırın.",
    mesaj: "Farkında ol, kontrol sende olsun! 14 Kasım Dünya Diyabet Günü'nde sağlıklı yaşamı seçelim. 🔵🩺"
  },
  {
    slug: "dunya-cocuk-haklari-gunu",
    title: "20 Kasım Dünya Çocuk Hakları Günü",
    description: "BM Çocuk Haklarına Dair Sözleşme'nin kabul edildiği gün, her çocuğun sağlık, eğitim ve korunma hakkını savunur.",
    month_no: 11, day_no: 20, category: "Farkındalık",
    hashtags: ["#CocukHaklariGunu", "#HerCocukIcinHaklar", "#UNICEF", "#Gelecegimiz"],
    affiliate_keywords: ["çocuk hakları resimli kitap", "eğitici kutu oyunları", "çocuk gelişim kitapları"],
    nedir: "20 Kasım 1989'da Birleşmiş Milletler Genel Kurulu tarafından Çocuk Hakları Sözleşmesi oy birliğiyle kabul edilmiştir.",
    nasil: "1. Çocukların sesini dinleyin ve fikirlerine saygı gösterin.\n2. Çocuk istismarı ve çocuk işçiliğine karşı ses çıkarın.\n3. Çocuk koruma derneklerine destek verin.",
    mesaj: "Bütün çocuklar sevgi dolu ve eşit bir dünyayı hak eder! 20 Kasım Dünya Çocuk Hakları Günü kutlu olsun. 🧒🎈👧"
  },
  {
    slug: "dis-hekimleri-gunu",
    title: "22 Kasım Diş Hekimleri Günü",
    description: "Türkiye'de ilk Dişçi Mektebi'nin kuruluş yıl dönümünde ağız ve diş sağlığı kahramanlarına adanan gün.",
    month_no: 11, day_no: 22, category: "Sağlık",
    hashtags: ["#DisHekimleriGunu", "#AgizVeDisSagligi", "#Gulumse", "#DisHekimi"],
    affiliate_keywords: ["şarjlı diş fırçası", "ağız duşu cihazı", "diş hekimi esprili kupa", "diş ipi seti"],
    nedir: "22 Kasım 1908'de Dişçi Mekteb-i Aliyesi kurulmuş ve bu hafta Ağız Diş Sağlığı Haftası olarak kutlanmaya başlanmıştır.",
    nasil: "1. 6 aylık rutin diş hekimi kontrolünüzü yaptırın.\n2. Günde 2 kez dişlerinizi fırçalayın ve diş ipi kullanın.\n3. Diş hekiminize teşekkür edin.",
    mesaj: "Sağlıklı gülüşlerimizin mimarı diş hekimlerimizin 22 Kasım Diş Hekimleri Günü kutlu olsun! 🦷🪥"
  },
  {
    slug: "ogretmenler-gunu",
    title: "24 Kasım Öğretmenler Günü",
    description: "Mustafa Kemal Atatürk'ün Millet Mektepleri Başöğretmenliği unvanını kabul ettiği günün anısına kutlanır.",
    month_no: 11, day_no: 24, category: "Mesleki",
    hashtags: ["#24Kasim", "#OgretmenlerGunu", "#Basogretmen", "#CanimOgretmenim"],
    affiliate_keywords: ["isme özel öğretmen dolma kalemi", "öğretmenler günü hediye kutusu", "çiçek buketi", "deri ajanda"],
    nedir: "24 Kasım 1928'de Atatürk Başöğretmen unvanını kabul etmiş, 1981'den bu yana Türkiye'de Öğretmenler Günü olarak kutlanmaktadır.",
    nasil: "1. Öğretmenlerinizi arayıp vefa ve teşekkürlerinizi iletin.\n2. Emekli öğretmenleri ziyaret edin.\n3. Eğitime katkı sağlayan projelere destek verin.",
    mesaj: "Geleceğimizin mimarı fedakar öğretmenlerimizin 24 Kasım Öğretmenler Günü kutlu olsun! 💐🧑‍🏫"
  },

  // Aralık (12)
  {
    slug: "dunya-engelliler-gunu",
    title: "3 Aralık Dünya Engelliler Günü",
    description: "Engelli bireylerin haklarına, toplumsal hayata tam katılımlarına ve erişilebilirliğe dikkat çeken BM günü.",
    month_no: 12, day_no: 3, category: "Farkındalık",
    hashtags: ["#3Aralik", "#DunyaEngellilerGunu", "#SevgiVarsaEngelYok", "#Erisilebilirlik"],
    affiliate_keywords: ["tekerlekli sandalye minderi", "ergonomik tutacak seti", "sesli uyarı cihazı"],
    nedir: "1992 yılında BM Genel Kurulu tarafından engellilerin haklarını savunmak ve farkındalık yaratmak amacıyla ilan edilmiştir.",
    nasil: "1. Şehirlerimizin ve binalarımızın engelsiz ve erişilebilir olmasını talep edin.\n2. Engelli otoparklarına ve rampalarına araç park etmeyin.\n3. Sevgi ve empatiyle engelleri birlikte kaldırın.",
    mesaj: "En büyük engel sevgisizliktir. 3 Aralık Dünya Engelliler Günü'nde engelleri sevgi ve dayanışmayla aşıyoruz! ♿🤝💛"
  },
  {
    slug: "dunya-turk-kahvesi-gunu",
    title: "5 Aralık Dünya Türk Kahvesi Günü",
    description: "UNESCO tarafından Somut Olmayan Kültürel Miras listesine alınan Türk Kahvesi kültürünün küresel kutlaması.",
    month_no: 12, day_no: 5, category: "Kültür & Sanat",
    hashtags: ["#DunyaTurkKahvesiGunu", "#TurkKahvesi", "#UNESCO", "#KahveKulturu"],
    affiliate_keywords: ["otomatik türk kahvesi makinesi", "bakır cezve seti", "türk kahvesi fincan takımı", "hacı bekir lokumu"],
    nedir: "5 Aralık 2013'te UNESCO, Türk Kahvesi Kültürü ve Geleneği'ni İnsanlığın Somut Olmayan Kültürel Mirası Temsili Listesi'ne kaydetmiştir.",
    nasil: "1. Bakır cezvede bol köpüklü okkalı bir Türk kahvesi pişirin.\n2. Yanında lokum ve bir bardak su ile geleneksel sunum yapın.\n3. Sevdiklerinizle kırk yıllık hatır sohbeti edin.",
    mesaj: "Gönül ne kahve ister ne kahvehane, gönül sohbet ister kahve bahane. 5 Aralık Dünya Türk Kahvesi Günü kutlu olsun! ☕🇹🇷"
  },
  {
    slug: "dunya-kadin-haklari-gunu",
    title: "5 Aralık Dünya Kadın Hakları Günü",
    description: "Türk kadınlarına seçme ve seçilme hakkının birçok Avrupa ülkesinden önce verildiği tarihi gün.",
    month_no: 12, day_no: 5, category: "Farkındalık",
    hashtags: ["#5Aralik", "#KadinHaklariGunu", "#SecmeVeSecilmeHakki", "#Ataturk"],
    affiliate_keywords: ["kadın liderler biyografi kitabı", "özel tasarım takı seti", "fular ipek"],
    nedir: "5 Aralık 1934'te Gazi Mustafa Kemal Atatürk'ün önderliğinde Türk kadınlarına milletvekili seçme ve seçilme hakkı tanınmıştır.",
    nasil: "1. Kadınların siyasette ve yönetimde eşit temsilini savunun.\n2. Atatürk'ün kadın haklarına verdiği önemi hatırlayın.\n3. Kadınların başarılarını kutlayın.",
    mesaj: "Dünyada hiçbir milletin kadını 'Ben Anadolu kadınından daha fazla çalıştım' diyemez. 5 Aralık Kadın Hakları Günü kutlu olsun! 🇹🇷👩‍💼"
  },
  {
    slug: "dunya-insan-haklari-gunu",
    title: "10 Aralık Dünya İnsan Hakları Günü",
    description: "1948 yılında BM İnsan Hakları Evrensel Beyannamesi'nin kabul edildiği, temel hak ve özgürlüklerin günü.",
    month_no: 12, day_no: 10, category: "Farkındalık",
    hashtags: ["#10Aralik", "#InsanHaklariGunu", "#HumanRightsDay", "#Esitlik"],
    affiliate_keywords: ["insan hakları evrensel beyannamesi kitap", "felsefe ve etik kitapları"],
    nedir: "Tüm insanların özgür, eşit ve onurlu doğduğunu dünyaya ilan eden İnsan Hakları Evrensel Beyannamesi'nin kabul günüdür.",
    nasil: "1. İnsan Hakları Evrensel Beyannamesi'nin maddelerini okuyun.\n2. Ayrımcılığa ve adaletsizliğe karşı ses çıkarın.\n3. İnsan hakları savunucularını destekleyin.",
    mesaj: "Bütün insanlar hür, haysiyet ve haklar bakımından eşit doğarlar. 10 Aralık İnsan Hakları Günü kutlu olsun! ⚖️🕊️"
  },
  {
    slug: "en-uzun-gece",
    title: "21 Aralık En Uzun Gece (Kış Gündönümü)",
    description: "Kuzey yarımkürede yılın en uzun gecesinin yaşandığı ve kış mevsiminin astronomik olarak başladığı gün.",
    month_no: 12, day_no: 21, category: "Eğlence",
    hashtags: ["#21Aralik", "#EnUzunGece", "#KisGundonumu", "#Gece"],
    affiliate_keywords: ["kokulu mum seti", "polar battaniye", "film izleme projeksiyon", "termos kupa"],
    nedir: "Kuzey yarımkürede Güneş ışınlarının Oğlak Dönencesi'ne dik geldiği, en uzun gecenin ve en kısa gündüzün yaşandığı doğa olayıdır.",
    nasil: "1. Sıcak çikolatanızı veya kahvenizi alıp sevdiklerinizle uzun bir film maratonu yapın.\n2. Kitap okuyarak gecenin sessizliğinin tadını çıkarın.\n3. Gece yürüyüşü yapıp kış havasını hissedin.",
    mesaj: "En uzun gece bile yerini aydınlık bir sabaha bırakır! 21 Aralık Kış Gündönümü kutlu ve huzurlu olsun. 🌙❄️⭐"
  },
  {
    slug: "yilbasi-gecesi",
    title: "31 Aralık Yılbaşı Gecesi",
    description: "Bir yılın son anlarını geride bırakıp yeni umutlarla gelecek yıla adım atılan tüm dünyada coşkuyla kutlanan gece.",
    month_no: 12, day_no: 31, category: "Eğlence",
    hashtags: ["#YilbasiGecesi", "#GuleGule2026", "#YeniYilKutlamasi", "#31Aralik"],
    affiliate_keywords: ["yılbaşı çam ağacı süsü", "parti kutlama şapkası", "kutu masa oyunu", "ışıklı peri led"],
    nedir: "Eski yılı uğurlayıp yeni yılın ilk dakikalarını karşılamak için aile ve dostlarla bir araya gelinen evrensel kutlama gecesidir.",
    nasil: "1. Sevdiklerinizle zengin bir yılbaşı sofrasında toplanın.\n2. Geçen yılın anılarını yad edin ve geleceğe dilekler tutun.\n3. Geri sayımla yeni yılı coşkuyla karşılayın.",
    mesaj: "Giden yıl tüm yorgunlukları alsın, gelen yıl tüm hayallerinizi gerçekleştirsin! Yılbaşı geceniz kutlu olsun! 🎆🥂✨"
  }
];

// Helper to construct full Markdown content and standard SpecialDay objects
const fullDays = rawDays.map((d, index) => {
  const content = `## ${d.title} Nedir?
${d.nedir}

### Tarihçesi ve Önemi
${d.nedir} Bu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle anılmaktadır.

---

## ${d.title} Nasıl Kutlanır?
${d.nasil}

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "${d.mesaj}"
* "${d.title} kutlu olsun! Bu anlamlı günde sevgi, neşe ve farkındalığın çoğalmasını dileriz. ${d.hashtags.slice(0, 3).join(' ')}"
* "Bugünün getirdiği mutluluk tüm hayatınıza yansısın. #${d.slug}"`;

  const monthStr = String(d.month_no).padStart(2, '0');
  const dayStr = String(d.day_no).padStart(2, '0');
  const celebration_date = `2026-${monthStr}-${dayStr}`;

  return {
    id: `f8b9a112-9844-48f8-b3f1-${String(index + 1).padStart(12, '0')}`,
    slug: d.slug,
    title: d.title,
    description: d.description,
    content: content,
    celebration_date: celebration_date,
    month_no: d.month_no,
    day_no: d.day_no,
    category: d.category,
    hashtags: d.hashtags,
    affiliate_keywords: d.affiliate_keywords
  };
});

// Write to special-days-data.ts
const targetFile = path.resolve('src/lib/data/special-days-data.ts');
const fileHeader = `import { SpecialDay, MonthInfo } from "@/types/database";

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

export const INITIAL_SPECIAL_DAYS: SpecialDay[] = ${JSON.stringify(fullDays, null, 2)};
`;

fs.writeFileSync(targetFile, fileHeader, 'utf8');
console.log(`Generated ${fullDays.length} special days in ${targetFile}`);

// Also generate full SQL seed file
const sqlFile = path.resolve('supabase/schema.sql');
let sqlContent = `-- ========================================================
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
`;

const values = fullDays.map(d => {
  const esc = (str) => str.replace(/'/g, "''");
  const tags = "ARRAY[" + d.hashtags.map(t => `'${esc(t)}'`).join(',') + "]";
  const kws = "ARRAY[" + d.affiliate_keywords.map(k => `'${esc(k)}'`).join(',') + "]";
  return `('${d.id}', '${d.slug}', '${esc(d.title)}', '${esc(d.description)}', '${esc(d.content)}', '${d.celebration_date}', ${d.month_no}, ${d.day_no}, '${esc(d.category)}', ${tags}, ${kws})`;
}).join(',\n');

sqlContent += values + ';\n';
fs.writeFileSync(sqlFile, sqlContent, 'utf8');
console.log(`Updated schema.sql with all special days!`);
