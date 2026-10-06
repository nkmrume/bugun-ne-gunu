import fs from 'fs';
import path from 'path';

const extraDays = [
  {
    slug: "dunya-hijyen-gunu",
    title: "16 Ocak Dünya Hijyen Günü",
    description: "Kişisel temizlik, el yıkama ve halk sağlığını koruma alışkanlıklarını hatırlatan gün.",
    month_no: 1, day_no: 16, category: "Sağlık",
    hashtags: ["#HijyenGunu", "#ElYikama", "#Temizlik", "#HalkSagligi"],
    affiliate_keywords: ["otomatik sabunluk sensörlü", "antibakteriyel el dezenfektanı", "bambu banyo havlusu"],
    nedir: "Kişisel hijyenin salgın hastalıklardan korunmadaki en etkili ve ucuz yöntem olduğunu vurgulamak amacıyla kutlanır.",
    nasil: "1. Ellerinizi en az 20 saniye sabunla doğru şekilde yıkayın.\n2. Yaşam alanlarınızı düzenli havalandırın ve temizleyin.\n3. Çocuklara hijyen kurallarını öğretin.",
    mesaj: "Temizlik imandandır ve sağlığın başıdır! 16 Ocak Dünya Hijyen Günü kutlu olsun. 🧼🫧"
  },
  {
    slug: "dunya-gumruk-gunu",
    title: "26 Ocak Dünya Gümrük Günü",
    description: "Uluslararası ticaretin güvenliği ve gümrük çalışanlarının fedakarlıklarını onurlandıran gün.",
    month_no: 1, day_no: 26, category: "Mesleki",
    hashtags: ["#GumrukGunu", "#26Ocak", "#GumrukMuhafaza", "#Ticaret"],
    affiliate_keywords: ["seyahat pasaport kılıfı", "valiz bavul seti", "bagaj tartısı dijital"],
    nedir: "Dünya Gümrük Örgütü'nün ilk toplantısını yaptığı 26 Ocak 1953 anısına küresel ticaretin güvenliğini kutlar.",
    nasil: "1. Gümrük emekçilerine teşekkür edin.\n2. Yasal ve kayıtlı ticaretin önemini öğrenin.\n3. Kaçakçılıkla mücadeleye dikkat çekin.",
    mesaj: "Sınırlarımızın ve ekonomimizin bekçisi tüm gümrük çalışanlarımızın Dünya Gümrük Günü kutlu olsun! 🛃🚢"
  },
  {
    slug: "sivil-savunma-gunu",
    title: "28 Şubat Sivil Savunma Günü",
    description: "Deprem, yangın ve afetlere karşı hazırlıklı olma ve sivil savunma bilincini artıran gün.",
    month_no: 2, day_no: 28, category: "Resmi",
    hashtags: ["#SivilSavunmaGunu", "#AfetBilinci", "#DepremeHazirlik", "#AFAD"],
    affiliate_keywords: ["deprem acil durum çantası", "el feneri şarjlı", "düdük pusula çok amaçlı", "ilk yardım çantası"],
    nedir: "7126 sayılı Sivil Savunma Kanunu'nun yürürlüğe girdiği 28 Şubat, afetlere karşı bilinçli toplum inşası için kutlanır.",
    nasil: "1. Evinizde ve iş yerinizde deprem çantanızı güncelleyin.\n2. Ailenizle afet toplanma alanınızı kontrol edin.\n3. Yangın ve tahliye tatbikatlarına katılın.",
    mesaj: "Afetlere hazırlıklı olmak hayat kurtarır! 28 Şubat Sivil Savunma Günü kutlu olsun. 🚨🎒"
  },
  {
    slug: "dunya-tuketici-haklari-gunu",
    title: "15 Mart Dünya Tüketici Hakları Günü",
    description: "Tüketicilerin güvenlik, bilgilendirilme ve zararların tazmini haklarını savunan uluslararası gün.",
    month_no: 3, day_no: 15, category: "Farkındalık",
    hashtags: ["#TuketiciHaklariGunu", "#BilincliTuketici", "#HaklariniBil", "#15Mart"],
    affiliate_keywords: ["tüketici hukuku el kitabı", "para yönetim bütçe defteri"],
    nedir: "1962 yılında ABD Başkanı John F. Kennedy'nin Tüketici Hakları Bildirgesi'ni açıkladığı günün anısına kutlanır.",
    nasil: "1. Alışverişlerinizde fatura ve fiş almayı ihmal etmeyin.\n2. Tüketici Hakem Heyetleri'ne başvurma haklarınızı öğrenin.\n3. Yanıltıcı reklamlara karşı bilinçli olun.",
    mesaj: "Bilinçli tüketici güçlü toplum demektir! 15 Mart Dünya Tüketici Hakları Günü kutlu olsun. 🛍️⚖️"
  },
  {
    slug: "dunya-siir-gunu",
    title: "21 Mart Dünya Şiir Günü",
    description: "Duyguların en saf ifadesi olan şiir sanatını, şairleri ve sözcüklerin büyüsünü kutlayan UNESCO günü.",
    month_no: 3, day_no: 21, category: "Kültür & Sanat",
    hashtags: ["#DunyaSiirGunu", "#SiirSokakta", "#NazimHikmet", "#CemalSureya", "#Siir"],
    affiliate_keywords: ["türk şiir antolojisi", "nazım hikmet şiirleri", "cemal süreya sevda sözleri", "dolma kalem"],
    nedir: "UNESCO tarafından 1999 yılında şiirin diller arası köprü kurma gücünü onurlandırmak amacıyla kabul edilmiştir.",
    nasil: "1. En sevdiğiniz şairden bir şiir okuyup paylaşın.\n2. Kendi duygularınızı mısralara dökün.\n3. Şiir dinletilerine katılın.",
    mesaj: "Şiir hayatın nefesidir. 21 Mart Dünya Şiir Günü'nde yüreğinizden şiirler eksik olmasın! 📜🖋️"
  },
  {
    slug: "dunya-meteoroloji-gunu",
    title: "23 Mart Dünya Meteoroloji Günü",
    description: "Hava durumu tahminleri, iklim bilimi ve erken uyarı sistemlerinin hayat kurtarıcı rolünü kutlayan gün.",
    month_no: 3, day_no: 23, category: "Çevre & Doğa",
    hashtags: ["#MeteorolojiGunu", "#HavaDurumu", "#IklimBilimi", "#WMO"],
    affiliate_keywords: ["ev tipi meteoroloji istasyonu", "dijital termometre higrometre", "barometre"],
    nedir: "Dünya Meteoroloji Örgütü'nün (WMO) 1950'de yürürlüğe giren sözleşmesinin yıl dönümü anısına kutlanır.",
    nasil: "1. İklim değişikliğinin hava olayları üzerindeki etkilerini inceleyin.\n2. Afet erken uyarı bildirimlerini takip edin.\n3. Meteoroloji çalışanlarına teşekkür edin.",
    mesaj: "Hava şartları ne olursa olsun kalbiniz güneşli olsun! 23 Mart Dünya Meteoroloji Günü kutlu olsun. ☀️🌧️🌈"
  },
  {
    slug: "dunya-saka-gunu",
    title: "1 Nisan Şaka Günü",
    description: "Tüm dünyada insanların birbirine zararsız, neşeli ve zekice şakalar yaptığı kahkaha dolu gün.",
    month_no: 4, day_no: 1, category: "Eğlence",
    hashtags: ["#1Nisan", "#SakaGunu", "#AprilFools", "#Gulumse"],
    affiliate_keywords: ["zararsız şaka malzemeleri", "esprili kupa bardak", "parti şaka oyunları"],
    nedir: "Kökeni 16. yüzyıl Fransa takvim reformuna dayanan 1 Nisan, asırlardır dünya genelinde şakalarla kutlanmaktadır.",
    nasil: "1. Arkadaşlarınıza kırıcı olmayan sevimli bir şaka yapın.\n2. Bol bol gülün ve mizahın tadını çıkarın.\n3. Size yapılan şakalara tebessümle karşılık verin.",
    mesaj: "Gülmek en güzel şifadır! 1 Nisan Şaka Günü'nüz bol tebessümlü ve kahkahalı geçsin! 🎭😄"
  },
  {
    slug: "polis-teskilati-kurulus-gunu",
    title: "10 Nisan Türk Polis Teşkilatı Kuruluş Günü",
    description: "Huzur, güvenlik ve asayişimizin teminatı olan Türk Polis Teşkilatı'nın kuruluşunu kutlayan gün.",
    month_no: 4, day_no: 10, category: "Mesleki",
    hashtags: ["#PolisHaftasi", "#10Nisan", "#TurkPolisTeskilati", "#PolisimizinYanindayiz"],
    affiliate_keywords: ["polis temalı hediye kupa", "taktik fener", "deri polis cüzdan rozet"],
    nedir: "10 Nisan 1845'te kurulan Türk Polis Teşkilatı, milletimizin can ve mal emniyetini sağlamak için görev yapmaktadır.",
    nasil: "1. Görev başındaki polis memurlarına kolaylıklar dileyin.\n2. Şehit polislerimizi dualarla anın.\n3. Trafik ve asayiş kurallarına uyun.",
    mesaj: "Huzurumuzun ve güvenliğimizin teminatı kahraman polislerimizin 10 Nisan Polis Haftası kutlu olsun! 👮‍♂️🇹🇷"
  },
  {
    slug: "dunya-pilotlar-gunu",
    title: "26 Nisan Dünya Pilotlar Günü",
    description: "Türkiye'nin 1 numaralı pilot brövesi sahibi Fesa Evrensev'in anısına tüm dünyada kutlanan havacılık günü.",
    month_no: 4, day_no: 26, category: "Mesleki",
    hashtags: ["#DunyaPilotlarGunu", "#WorldPilotsDay", "#Goklerdeyiz", "#Havacilik"],
    affiliate_keywords: ["uçak maketi metal", "pilot güneş gözlüğü aviator", "havacılık temalı saat"],
    nedir: "Türkiye Havayolu Pilotları Derneği'nin (TALPA) önerisiyle IFALPA tarafından Fesa Evrensev'in ilk uçuş günü kabul edilmiştir.",
    nasil: "1. Gökyüzünün cesur kaptanlarına teşekkür edin.\n2. Havacılık müzelerini gezin.\n3. Uçuş simülasyonu deneyin.",
    mesaj: "İstikbal göklerdedir! Kanatlarıyla dünyayı birbirine bağlayan tüm pilotlarımızın günü kutlu olsun! ✈️👨‍✈️👩‍✈️"
  },
  {
    slug: "uluslararasi-caz-gunu",
    title: "30 Nisan Uluslararası Caz Günü",
    description: "Özgürlüğün, doğaçlamanın ve diyalogun müziği olan cazı onurlandıran UNESCO günü.",
    month_no: 4, day_no: 30, category: "Kültür & Sanat",
    hashtags: ["#CazGunu", "#JazzDay", "#MuzikOzgurluktur", "#Jazz"],
    affiliate_keywords: ["plak çalar pikap bluetooth", "caz plakları efsane", "saksafon başlangıç"],
    nedir: "UNESCO iyi niyet elçisi caz efsanesi Herbie Hancock öncülüğünde 2011 yılında ilan edilmiştir.",
    nasil: "1. Miles Davis, Louis Armstrong veya Türk caz sanatçılarını dinleyin.\n2. Bir caz kulübünü ziyaret edin.\n3. Plak dinleme gecesi yapın.",
    mesaj: "Caz özgürlüğün sesidir. 30 Nisan Uluslararası Caz Günü'nde notaların büyüsüne kapılın! 🎷🎺🎶"
  },
  {
    slug: "basin-ozgurlugu-gunu",
    title: "3 Mayıs Dünya Basın Özgürlüğü Günü",
    description: "Bağımsız, sansürsüz ve özgür basının demokrasilerdeki hayati önemini hatırlatan BM günü.",
    month_no: 5, day_no: 3, category: "Farkındalık",
    hashtags: ["#BasinOzgurluguGunu", "#WorldPressFreedomDay", "#OzgurBasin", "#HaberHakki"],
    affiliate_keywords: ["gazetecilik etik kitapları", "basın tarihi araştırmaları"],
    nedir: "1993 yılında BM Genel Kurulu tarafından hükümetlere basın özgürlüğünü koruma taahhüdünü hatırlatmak için ilan edilmiştir.",
    nasil: "1. Bağımsız gazetecileri ve medya kuruluşlarını destekleyin.\n2. Dezenformasyona karşı doğru haberi teyit edin.\n3. Sansüre karşı düşünce özgürlüğünü savunun.",
    mesaj: "Özgür basın halkın nefes borusudur. 3 Mayıs Dünya Basın Özgürlüğü Günü kutlu olsun! 📰✍️"
  },
  {
    slug: "hidirellez",
    title: "5 Mayıs Hıdırellez Kültür Bayramı",
    description: "Hızır ve İlyas peygamberlerin yeryüzünde buluştuğu gün olarak kabul edilen köklü bahar bayramı.",
    month_no: 5, day_no: 5, category: "Kültür & Sanat",
    hashtags: ["#Hidirellez", "#BaharBayrami", "#DileklerKabulOlsun", "#5Mayis"],
    affiliate_keywords: ["tütsü seti doğal", "dilek feneri renkli", "hasır piknik sepeti"],
    nedir: "UNESCO İnsanlığın Somut Olmayan Kültürel Mirası Temsili Listesi'nde yer alan Hıdırellez, baharın ve bereketin müjdecisidir.",
    nasil: "1. Gül ağacının altına dileklerinizi çizin veya asın.\n2. Ateşin üzerinden atlayarak yeni başlangıçlara niyet edin.\n3. Doğada sevdiklerinizle piknik yapın.",
    mesaj: "Hızır yoldaşınız, dilekleriniz gerçek olsun! Hıdırellez Bayramınız bereket ve sağlık getirsin. 🌾🔥🌸"
  },
  {
    slug: "dunya-psikologlar-gunu",
    title: "10 Mayıs Dünya Psikologlar Günü",
    description: "İnsan ruhunu anlamak, iyileştirmek ve toplumsal esenliği sağlamak için çalışan psikologlara adanan gün.",
    month_no: 5, day_no: 10, category: "Mesleki",
    hashtags: ["#PsikologlarGunu", "#10Mayis", "#RuhSagligi", "#Psikoloji"],
    affiliate_keywords: ["psikoloji temalı kupa", "terapi not defteri", "freud biblo masa üstü"],
    nedir: "Ruh sağlığı alanında çalışan psikologların mesleki dayanışmasını güçlendirmek amacıyla kutlanır.",
    nasil: "1. Psikolog dostlarınıza tebrik mesajı iletin.\n2. Psikolojik sağlığın önemini çevrenize anlatın.\n3. Kendinize şefkat göstermeyi öğrenin.",
    mesaj: "Ruhumuza ayna tutan, karanlık yollarımızı aydınlatan tüm psikologlarımızın günü kutlu olsun! 🧠🛋️"
  },
  {
    slug: "eczacilik-gunu",
    title: "14 Mayıs Eczacılık Günü",
    description: "Türkiye'de bilimsel eczacılık eğitiminin başladığı günün anısına sağlık danışmanımız eczacılara adanan gün.",
    month_no: 5, day_no: 14, category: "Sağlık",
    hashtags: ["#EczacilikGunu", "#14Mayis", "#EczacimizaTesekkurler", "#Saglik"],
    affiliate_keywords: ["eczacı hediye seti kupa", "havan biblo seramik", "ilaç saklama kutusu haftalık"],
    nedir: "14 Mayıs 1839'da Mekteb-i Tıbbiye-i Adliye-i Şahane bünyesinde ilk eczacı sınıfının açılmasıyla bilimsel eczacılık başlamıştır.",
    nasil: "1. Mahallenizin eczacısına teşekkür edin.\n2. İlaçları mutlaka hekim ve eczacı kontrolünde kullanın.\n3. Akılcı ilaç kullanımına özen gösterin.",
    mesaj: "Sağlığımızın en yakın danışmanı olan tüm fedakar eczacılarımızın 14 Mayıs Eczacılık Günü kutlu olsun! 💊⚕️"
  },
  {
    slug: "uluslararasi-aile-gunu",
    title: "15 Mayıs Uluslararası Aile Günü",
    description: "Toplumun temel taşı olan ailenin korunması, sevgi ve dayanışmanın güçlendirilmesi için kutlanan BM günü.",
    month_no: 5, day_no: 15, category: "Farkındalık",
    hashtags: ["#AileGunu", "#FamilyDay", "#AilemHerSeyim", "#SevgiYuvasi"],
    affiliate_keywords: ["aile fotoğraf çerçevesi çoklu", "kutu kutu aile oyunu", "büyük boy piknik örtüsü"],
    nedir: "1993 yılında BM Genel Kurulu tarafından aile kurumunun önemine dikkat çekmek için kabul edilmiştir.",
    nasil: "1. Ailenizle birlikte televizyonsuz ve ekransız bir akşam yemeği yiyin.\n2. Eski aile fotoğraflarını birlikte inceleyin.\n3. Birbirinize olan sevginizi sözlerle ifade edin.",
    mesaj: "Hayattaki en büyük zenginlik huzurlu bir ailedir. 15 Mayıs Uluslararası Aile Günü kutlu olsun! 👨‍👩‍👧‍👦🏡❤️"
  },
  {
    slug: "muzeler-gunu",
    title: "18 Mayıs Müzeler Günü",
    description: "Kültürel mirasımızı koruyan, geçmiş ile gelecek arasında köprü kuran müzelerin uluslararası kutlaması.",
    month_no: 5, day_no: 18, category: "Kültür & Sanat",
    hashtags: ["#MuzelerGunu", "#InternationalMuseumDay", "#KulturelMiras", "#MuzeleriGez"],
    affiliate_keywords: ["müze kart kılıfı", "türkiye arkeoloji atlası", "sanat tarihi el kitabı"],
    nedir: "Uluslararası Müzeler Konseyi (ICOM) tarafından 1977 yılından bu yana toplumda müze bilincini yaymak için kutlanır.",
    nasil: "1. Bugün en yakın müzeyi ücretsiz veya indirimli gezin.\n2. Tarihi eserlerin korunması bilincini çocuklara aktarın.\n3. Arkeolojik kazılar hakkında bilgi edinin.",
    mesaj: "Geçmişini bilmeyen geleceğini inşa edemez. 18 Mayıs Müzeler Günü kutlu olsun! 🏛️🏺🗿"
  },
  {
    slug: "dunya-sut-gunu",
    title: "21 Mayıs Dünya Süt Günü",
    description: "Sağlıklı kemik ve kas gelişimi için sütün beslenmedeki vazgeçilmez yerini vurgulayan FAO günü.",
    month_no: 5, day_no: 21, category: "Sağlık",
    hashtags: ["#DunyaSutGunu", "#WorldMilkDay", "#SutIcSaglikBul", "#KemikSagligi"],
    affiliate_keywords: ["süt köpürtücü otomatik", "cam süt şişesi retro", "yoğurt yapma makinesi"],
    nedir: "BM Gıda ve Tarım Örgütü (FAO) tarafından süt sektörünü ve sağlıklı beslenmeyi desteklemek için ilan edilmiştir.",
    nasil: "1. Günde en az bir bardak süt veya süt ürünü tüketin.\n2. Çocuklara süt içme alışkanlığı kazandırın.\n3. Yerel süt üreticilerini destekleyin.",
    mesaj: "Sağlıklı nesiller için her gün bir bardak süt! 21 Mayıs Dünya Süt Günü kutlu olsun. 🥛🐮"
  },
  {
    slug: "biyocesitlilik-gunu",
    title: "22 Mayıs Uluslararası Biyoçeşitlilik Günü",
    description: "Gezegenimizdeki tüm türlerin, ekosistemlerin ve genetik zenginliğin korunması için BM tarafından kutlanır.",
    month_no: 5, day_no: 22, category: "Çevre & Doğa",
    hashtags: ["#BiyocesitlilikGunu", "#BiodiversityDay", "#DogayiKoru", "#TurlerYokOlmasin"],
    affiliate_keywords: ["kuş yemliği bahçe tipi", "endemik bitkiler kitabı türkiye", "doğa günlüğü"],
    nedir: "1992 Biyolojik Çeşitlilik Sözleşmesi'nin kabul edildiği gün olan 22 Mayıs, ekolojik dengenin korunması için kutlanır.",
    nasil: "1. Endemik bitki ve hayvan türlerini tanıyın.\n2. Doğal yaşam alanlarına zarar vermekten kaçının.\n3. Kimyasal kirliliği azaltın.",
    mesaj: "Doğadaki her canlı hayat zincirinin vazgeçilmez bir halkasıdır. 22 Mayıs Biyoçeşitlilik Günü kutlu olsun! 🌿🦋🦜"
  },
  {
    slug: "dunya-tutunsuz-gunu",
    title: "31 Mayıs Dünya Tütünsüz Günü",
    description: "Tütün salgınının yol açtığı ölümlere dikkat çeken ve dumansız bir dünya hedefleyen DSÖ günü.",
    month_no: 5, day_no: 31, category: "Sağlık",
    hashtags: ["#TutunsuzGun", "#WorldNoTobaccoDay", "#DumansizHava", "#SigarayiBirak"],
    affiliate_keywords: ["nefes egzersizi cihazı", "stres topu seti", "bitki çayı rahatlatıcı"],
    nedir: "Dünya Sağlık Örgütü tarafından tütün tüketimini azaltmak ve pasif içiciliği önlemek için 1987'de kabul edilmiştir.",
    nasil: "1. Bugün 24 saat boyunca sigara içmeyin ve bırakmaya ilk adımı atın.\n2. Pasif içiciliğin zararlarından çocukları koruyun.\n3. Dumansız alanları destekleyin.",
    mesaj: "Nefes al, hayatı hisset! 31 Mayıs Dünya Tütünsüz Günü'nde temiz bir havaya adım at. 🚭🫁💚"
  },
  {
    slug: "dunya-cocuk-gunu",
    title: "1 Haziran Dünya Çocuk Günü",
    description: "Çocukların refahını, güvenliğini ve mutluluğunu kutlayan uluslararası çocuk günü.",
    month_no: 6, day_no: 1, category: "Farkındalık",
    hashtags: ["#1Haziran", "#DunyaCocukGunu", "#CocuklarGulsun", "#CocukHaklari"],
    affiliate_keywords: ["akıl ve zeka oyunları çocuk", "scooter çocuk 3 tekerlekli", "çocuk hikaye kitabı seti"],
    nedir: "1925 yılında Cenevre Çocukların Refahı Dünya Konferansı'nda ilan edilen ilk uluslararası çocuk günüdür.",
    nasil: "1. Bir çocuğu sevindirin ve ona hediye verin.\n2. Çocukların oyun ve eğlence hakkına saygı gösterin.\n3. İhtiyaç sahibi çocuklara destek olun.",
    mesaj: "Dünya çocukların güldüğü kadar güzeldir! 1 Haziran Dünya Çocuk Günü kutlu olsun! 🎈👶👧"
  },
  {
    slug: "turk-isaret-dili-gunu",
    title: "7 Haziran Türk İşaret Dili Günü",
    description: "İşitme engelli bireylerin iletişim dili olan Türk İşaret Dili'nin yasal olarak tanındığı gün.",
    month_no: 6, day_no: 7, category: "Farkındalık",
    hashtags: ["#TurkIsaretDiliGunu", "#TID", "#IsitmeEngelliler", "#EngelsizIletisim"],
    affiliate_keywords: ["türk işaret dili öğrenme kitabı", "işitme cihazı pili", "görsel sözlük kartları"],
    nedir: "5378 sayılı Engelliler Kanunu'nda Türk İşaret Dili'nin resmi olarak yer aldığı 7 Haziran 2005 tarihinin anısına kutlanır.",
    nasil: "1. Türk İşaret Dili'nde temel selamlaşma ve teşekkür kelimelerini öğrenin.\n2. Kamusal yayınlarda işaret dili çevirisi talep edin.\n3. İşitme engellilerin toplumsal hayata katılımını destekleyin.",
    mesaj: "Ellerimiz konuşsun, kalplerimiz buluşsun! 7 Haziran Türk İşaret Dili Günü kutlu olsun. 🤟🤲✨"
  },
  {
    slug: "dunya-yoga-gunu",
    title: "21 Haziran Dünya Yoga Günü",
    description: "Beden, zihin ve ruh dengesini kuran kadim yoga öğretisinin evrensel faydalarını kutlayan BM günü.",
    month_no: 6, day_no: 21, category: "Sağlık",
    hashtags: ["#DunyaYogaGunu", "#YogaDay", "#ZihinBedenRuh", "#Namaste"],
    affiliate_keywords: ["yoga matı kaydırmaz tpe", "yoga bloğu köpük", "meditasyon çanı", "yoga taytı"],
    nedir: "2014 yılında BM Genel Kurulu tarafından kabul edilen gün, içsel huzur ve bütünsel sağlığı teşvik eder.",
    nasil: "1. Açık havada veya evinizde 20 dakikalık bir yoga seansı yapın.\n2. Derin nefes egzersizleriyle zihninizi dinlendirin.\n3. Bedeninizin esnekliğine kulak verin.",
    mesaj: "İçindeki huzuru keşfet. 21 Haziran Dünya Yoga Günü kutlu olsun! 🧘‍♀️🕉️🧘‍♂️"
  },
  {
    slug: "dunya-sosyal-medya-gunu",
    title: "30 Haziran Dünya Sosyal Medya Günü",
    description: "İnsanları kıtalar ötesinde birbirine bağlayan dijital iletişim devrimini kutlayan küresel gün.",
    month_no: 6, day_no: 30, category: "Eğlence",
    hashtags: ["#SosyalMedyaGunu", "#SocialMediaDay", "#DijitalDunya", "#Baglanti"],
    affiliate_keywords: ["ring light halka ışık tripodlu", "yaka mikrofonu kablosuz", "telefon sabitleyici gimbal"],
    nedir: "2010 yılında Mashable tarafından sosyal medyanın dünyayı küresel bir köye dönüştürmesini kutlamak için başlatılmıştır.",
    nasil: "1. Sosyal medyada pozitif ve ilham verici içerikler üretin.\n2. Uzun süredir görüşmediğiniz bir eski dostunuza mesaj atın.\n3. Sosyal medya kullanım sürenizi bilinçli yönetin.",
    mesaj: "Mesafeleri kaldıran, sesimizi dünyaya duyuran platformların günü kutlu olsun! 30 Haziran Dünya Sosyal Medya Günü! 📱🌐💬"
  },
  {
    slug: "uluslararasi-dostluk-gunu",
    title: "30 Temmuz Uluslararası Dostluk Günü",
    description: "Halklar, ülkeler, kültürler ve bireyler arasındaki dostluk köprülerinin barış getireceğini savunan BM günü.",
    month_no: 7, day_no: 30, category: "Eğlence",
    hashtags: ["#DostlukGunu", "#FriendshipDay", "#CanDostum", "#Dostluk"],
    affiliate_keywords: ["arkadaşlık bilekliği çift", "anı albümü yapışkanlı", "arkadaşa esprili hediye"],
    nedir: "Birleşmiş Milletler tarafından toplumlar arasında güven ve dayanışma tesis etmek için ilan edilmiştir.",
    nasil: "1. En yakın arkadaşınızı arayıp ona değer verdiğinizi söyleyin.\n2. Birlikte kahve için veya anılarınızı yad edin.\n3. Yeni insanlarla samimi dostluklar kurun.",
    mesaj: "İyi bir dost dünyalara bedeldir. Tüm vefakar dostların 30 Temmuz Uluslararası Dostluk Günü kutlu olsun! 🤝☕❤️"
  },
  {
    slug: "dunya-insani-yardim-gunu",
    title: "19 Ağustos Dünya İnsani Yardım Günü",
    description: "Kriz ve savaş bölgelerinde canları pahasına insanlara yardım eli uzatan yardım çalışanlarını anma günü.",
    month_no: 8, day_no: 19, category: "Uluslararası",
    hashtags: ["#InsaniYardimGunu", "#WorldHumanitarianDay", "#YardimEli", "#Dayanisma"],
    affiliate_keywords: ["kızılay bağış kartı", "yardım vakfı sertifikası", "çelik matara"],
    nedir: "2003 yılında BM Bağdat merkezine yapılan saldırıda hayatını kaybeden 22 yardım görevlisinin anısına kutlanır.",
    nasil: "1. Güvenilir yardım kuruluşlarına bağışta bulunun.\n2. Gönüllü yardım projelerinde aktif rol alın.\n3. İnsani değerleri savunun.",
    mesaj: "İnsanlık yardımlaşmayla yaşar. Tüm fedakar insani yardım çalışanlarına sonsuz minnetle! 19 Ağustos kutlu olsun. 🤝🕊️"
  },
  {
    slug: "gaziler-gunu",
    title: "19 Eylül Gaziler Günü",
    description: "Mustafa Kemal Atatürk'e 'Gazi' unvanı ve Mareşal rütbesinin verildiği günün anısına kutlanan milli vefa günü.",
    month_no: 9, day_no: 19, category: "Resmi",
    hashtags: ["#GazilerGunu", "#19Eylul", "#KahramanGazilerimiz", "#Ataturk"],
    affiliate_keywords: ["türk bayrağı masa üstü pirinç", "atatürk biyografisi ciltli", "rozet"],
    nedir: "19 Eylül 1921'de Sakarya Meydan Muharebesi sonrası TBMM tarafından Atatürk'e Gazilik unvanı tevcih edilmiştir.",
    nasil: "1. Muharip gazi derneklerini ziyaret edin.\n2. Kahraman gazilerimize şükran ve saygılarınızı sunun.\n3. Vatan fedakarlıklarını gençlere aktarın.",
    mesaj: "Şehit nurlanmış, gazi onurlanmış askerdir. Başta Gazi Mustafa Kemal Atatürk olmak üzere tüm gazilerimize minnetle! 🇹🇷🎖️"
  },
  {
    slug: "dunya-turizm-gunu",
    title: "27 Eylül Dünya Turizm Günü",
    description: "Farklı kültürleri tanıma, seyahat özgürlüğü ve sürdürülebilir turizmin ekonomik gücünü kutlayan BM günü.",
    month_no: 9, day_no: 27, category: "Kültür & Sanat",
    hashtags: ["#DunyaTurizmGunu", "#WorldTourismDay", "#Gezgin", "#Seyahat"],
    affiliate_keywords: ["seyahat sırt çantası kabin boy", "boyun yastığı hafızalı sünger", "evrensel priz dönüştürücü"],
    nedir: "Dünya Turizm Örgütü (UNWTO) tüzüğünün kabul edildiği gün olan 27 Eylül, küresel seyahat bilincini artırır.",
    nasil: "1. Yeni bir şehri veya tarihi bir mekanı keşfe çıkın.\n2. Yerel esnafı ve eko-turizmi destekleyin.\n3. Gezdiğiniz yerlerin doğasına ve kültürüne saygı gösterin.",
    mesaj: "Dünya bir kitaptır ve seyahat etmeyenler sadece bir sayfasını okur. 27 Eylül Dünya Turizm Günü kutlu olsun! ✈️🗺️🧳"
  },
  {
    slug: "dunya-yaslilar-gunu",
    title: "1 Ekim Dünya Yaşlılar Günü",
    description: "Tecrübeleriyle topluma ışık tutan kıymetli büyüklerimizin haklarını ve refahını koruyan BM günü.",
    month_no: 10, day_no: 1, category: "Farkındalık",
    hashtags: ["#DunyaYaslilarGunu", "#BuyuklerimizeSaygi", "#YasliHaklari", "#1Ekim"],
    affiliate_keywords: ["ortopedik baston ışıklı", "yaşlılar için tansiyon aleti konuşan", "ısıtmalı ayak masaj aleti"],
    nedir: "Birleşmiş Milletler tarafından yaşlanan nüfusun haklarına, bakımına ve kuşaklar arası dayanışmaya dikkat çekmek için ilan edilmiştir.",
    nasil: "1. Ailenizdeki ve çevrenizdeki yaşlıları ziyaret edip ellerini öpün.\n2. Huzurevlerine ziyarette bulunun.\n3. Onların hayat tecrübelerini ve hatıralarını dinleyin.",
    mesaj: "Büyüklerimiz geçmişimizin hafızası, geleceğimizin duasıdır. 1 Ekim Dünya Yaşlılar Günü kutlu olsun! 👵🧓🤍"
  },
  {
    slug: "dunya-ogretmenler-gunu-unesco",
    title: "5 Ekim Dünya Öğretmenler Günü (UNESCO)",
    description: "Dünya genelinde öğretmenlerin statüsü ve haklarını savunan UNESCO ve ILO ortak kutlama günü.",
    month_no: 10, day_no: 5, category: "Mesleki",
    hashtags: ["#DunyaOgretmenlerGunu", "#WorldTeachersDay", "#5Ekim", "#Ogretmen"],
    affiliate_keywords: ["lazer sunum kumandası", "öğretmen ajandası 2026", "isme özel kupa"],
    nedir: "1966 yılında Öğretmenlerin Statüsüne İlişkin Tavsiye Kararı'nın kabul edildiği gün olup tüm dünyada eğitimcileri onurlandırır.",
    nasil: "1. Dünyanın dört bir yanındaki öğretmenlerin emeğini takdir edin.\n2. Eğitime bütçe ayrılmasını destekleyin.\n3. Öğretmenlerinize mesaj gönderin.",
    mesaj: "Karanlığı aydınlatan tüm fedakar öğretmenlerimizin 5 Ekim Dünya Öğretmenler Günü kutlu olsun! 📚🌍🧑‍🏫"
  },
  {
    slug: "dunya-gida-gunu",
    title: "16 Ekim Dünya Gıda Günü",
    description: "Açlıkla mücadele, sürdürülebilir tarım ve gıda israfını önleme bilincini artıran FAO günü.",
    month_no: 10, day_no: 16, category: "Çevre & Doğa",
    hashtags: ["#DunyaGidaGunu", "#WorldFoodDay", "#GidaIsrafinaSon", "#AcligaSon"],
    affiliate_keywords: ["vakumlu saklama kabı seti", "hava geçirmez kavanoz", "gıda kurutucu makine"],
    nedir: "1945 yılında BM Gıda ve Tarım Örgütü'nün (FAO) kuruluş yıl dönümünde herkese yeterli ve güvenli gıda hakkını savunur.",
    nasil: "1. Tabağınıza yiyebileceğiniz kadar yemek alın, israfı önleyin.\n2. Artan yemekleri değerlendirme tarifleri uygulayın.\n3. Gıda bankalarına ve aşevlerine bağış yapın.",
    mesaj: "Gıda haktır, israf etme! 16 Ekim Dünya Gıda Günü'nde soframızı ve dünyamızı adaletle paylaşalım. 🌾🍞🍲"
  },
  {
    slug: "dunya-tasarruf-gunu",
    title: "31 Ekim Dünya Tasarruf Günü",
    description: "Finansal okuryazarlık, para biriktirme ve kaynakları verimli kullanma alışkanlığını teşvik eden gün.",
    month_no: 10, day_no: 31, category: "Eğlence",
    hashtags: ["#DunyaTasarrufGunu", "#Tasarruf", "#FinansalOkuryazarlik", "#BirimYap"],
    affiliate_keywords: ["dijital para sayan kumbara", "finansal özgürlük kitapları", "akıllı priz enerji ölçer"],
    nedir: "1924 yılında Milano'da yapılan 1. Uluslararası Tasarruf Bankası Kongresi'nde tasarruf bilincini aşılamak için kabul edilmiştir.",
    nasil: "1. Aylık bütçenizi ve gereksiz harcamalarınızı gözden geçirin.\n2. Çocuklara kumbara alıp birikim yapmayı öğretin.\n3. Enerji ve su tüketiminde tasarrufa gidin.",
    mesaj: "Damlaya damlaya göl olur! 31 Ekim Dünya Tasarruf Günü'nde geleceğin için biriktirmeye başla. 🪙💰📈"
  },
  {
    slug: "dunya-sehircilik-gunu",
    title: "8 Kasım Dünya Şehircilik Günü",
    description: "Planlı, yaşanabilir, yeşil ve afetlere dayanıklı kentler inşa etme bilincini artıran gün.",
    month_no: 11, day_no: 8, category: "Mesleki",
    hashtags: ["#DunyaSehircilikGunu", "#SehirPlanciligi", "#YasanabilirKentler", "#8Kasim"],
    affiliate_keywords: ["şehir planlama ve mimarlık kitapları", "teknik çizim kalemi seti", "maket bıçağı seti"],
    nedir: "1949 yılında Buenos Aires Üniversitesi profesörü Carlos Maria della Paolera tarafından kent planlamasının önemini anlatmak için başlatılmıştır.",
    nasil: "1. Kentinizdeki yeşil alanların ve bisiklet yollarının artmasını talep edin.\n2. Kentsel dönüşüm ve deprem güvenliği bilincini yaygınlaştırın.\n3. Şehir plancılarına teşekkür edin.",
    mesaj: "Daha yeşil, daha adil ve afetlere dirençli şehirler için 8 Kasım Dünya Şehircilik Günü kutlu olsun! 🏙️🌳🚲"
  },
  {
    slug: "uluslararasi-hosgoru-gunu",
    title: "16 Kasım Uluslararası Hoşgörü Günü",
    description: "Farklılıklara saygı, empati, diyalog ve barış içinde bir arada yaşama kültürünü kutlayan UNESCO günü.",
    month_no: 11, day_no: 16, category: "Farkındalık",
    hashtags: ["#HosgoruGunu", "#Mevlana", "#FarkliliklarZenginliktir", "#Empati"],
    affiliate_keywords: ["mevlana mesnevi seti", "felsefe ve empati kitapları", "meditasyon müziği cd"],
    nedir: "1995 UNESCO Hoşgörü İlkeleri Bildirgesi'nin imzalanmasıyla nefret söylemi ve ayrımcılıkla mücadele için kabul edilmiştir.",
    nasil: "1. 'Gel, ne olursan ol yine gel' anlayışıyla herkese önyargısız yaklaşın.\n2. Farklı fikirleri sabırla dinleyin.\n3. Hoşgörüyü ve nezaketi yayın.",
    mesaj: "Farklılıklarımız zenginliğimizdir. 16 Kasım Uluslararası Hoşgörü Günü kutlu olsun! 🤝🌈🕊️"
  },
  {
    slug: "dunya-televizyon-gunu",
    title: "21 Kasım Dünya Televizyon Günü",
    description: "Görsel habercilik, kamuoyu oluşturma ve kültürel etkileşimdeki televizyonun gücünü kutlayan BM günü.",
    month_no: 11, day_no: 21, category: "Kültür & Sanat",
    hashtags: ["#TelevizyonGunu", "#WorldTelevisionDay", "#Medya", "#Yayin"],
    affiliate_keywords: ["akıllı tv kumandası", "led tv arka aydınlatma ambiyans", "soundbar ses sistemi"],
    nedir: "1996 yılında 1. Dünya Televizyon Forumu'nun yapıldığı tarih olup medyanın küresel sorunlara dikkat çekme rolünü onurlandırır.",
    nasil: "1. Kaliteli belgeseller ve eğitici programlar izleyin.\n2. Televizyon haberciliğinin tarihini inceleyin.\n3. Ekran sürenizi dengede tutun.",
    mesaj: "Dünyayı salonumuza getiren ekranın günü! 21 Kasım Dünya Televizyon Günü kutlu olsun! 📺📡🎬"
  },
  {
    slug: "dunya-aids-gunu",
    title: "1 Aralık Dünya AIDS Günü",
    description: "HIV/AIDS konusunda doğru bilinci yaymak, ön yargıları kırmak ve hastalara destek olmak için kutlanan küresel gün.",
    month_no: 12, day_no: 1, category: "Sağlık",
    hashtags: ["#DunyaAIDSGunu", "#KirmiziKurdele", "#FarkindaOl", "#OnYargiyiKir"],
    affiliate_keywords: ["kırmızı kurdele yaka iğnesi", "bağışıklık güçlendirici vitamin"],
    nedir: "1988 yılından bu yana Dünya Sağlık Örgütü öncülüğünde kırmızı kurdele sembolüyle HIV farkındalığı için düzenlenir.",
    nasil: "1. HIV'in bulaşma ve korunma yolları hakkında doğru bilgi edinin.\n2. HIV ile yaşayan bireylere karşı ayrımcılığa dur deyin.\n3. Düzenli test yaptırın.",
    mesaj: "Bilinç hayat kurtarır, ön yargı öldürür. 1 Aralık Dünya AIDS Günü'nde farkında olalım. 🎗️❤️"
  },
  {
    slug: "dunya-toprak-gunu",
    title: "5 Aralık Dünya Toprak Günü",
    description: "Besinlerimizin yüzde 95'ini sağlayan toprağın erozyondan ve kirlilikten korunması için BM tarafından kutlanır.",
    month_no: 12, day_no: 5, category: "Çevre & Doğa",
    hashtags: ["#DunyaToprakGunu", "#WorldSoilDay", "#TopragiKoru", "#TEMA"],
    affiliate_keywords: ["organik kompost gübre", "solucan gübresi", "bahçıvan kürek seti"],
    nedir: "BM Gıda ve Tarım Örgütü (FAO) tarafından sağlıklı toprakların ve gıda güvenliğinin önemini vurgulamak için ilan edilmiştir.",
    nasil: "1. Organik atıklarınızı kompost yaparak toprağa geri kazandırın.\n2. Erozyonla mücadele eden TEMA Vakfı gibi STK'lara destek olun.\n3. Toprağı kimyasallarla kirletmeyin.",
    mesaj: "Toprak varsa hayat var! 5 Aralık Dünya Toprak Günü'nde bereketli toprağımızı koruyalım. 🌱🌍🌾"
  },
  {
    slug: "uluslararasi-dag-gunu",
    title: "11 Aralık Uluslararası Dağ Günü",
    description: "Tatlı su kaynaklarımızın ve eşsiz dağ biyoçeşitliliğinin korunmasını savunan BM günü.",
    month_no: 12, day_no: 11, category: "Çevre & Doğa",
    hashtags: ["#UluslararasiDagGunu", "#InternationalMountainDay", "#Daglar", "#Doga"],
    affiliate_keywords: ["trekking batonları katlanır", "termal dağcı çorabı", "kamp termos paslanmaz"],
    nedir: "2003 yılında BM Genel Kurulu tarafından dağ ekosistemlerinin kırılganlığına ve dağ topluluklarının sürdürülebilirliğine dikkat çekmek için kabul edilmiştir.",
    nasil: "1. Dağ yürüyüşü veya trekking yapın.\n2. Dağlık bölgelerdeki doğal yaşam alanlarını koruyun.\n3. Dağ köylerinin yerel ürünlerini destekleyin.",
    mesaj: "Göğe uzanan zirvelerimiz doğanın kalbidir. 11 Aralık Uluslararası Dağ Günü kutlu olsun! ⛰️🏔️🌲"
  },
  {
    slug: "uluslararasi-gocmenler-gunu",
    title: "18 Aralık Uluslararası Göçmenler Günü",
    description: "Dünya çapında göçmenlerin insan hakları, emekleri ve toplumsal katkılarını onurlandıran BM günü.",
    month_no: 12, day_no: 18, category: "Farkındalık",
    hashtags: ["#GocmenlerGunu", "#InternationalMigrantsDay", "#InsanOnuru", "#Goc"],
    affiliate_keywords: ["kültürlerarası sosyoloji kitapları", "dünya dilleri sözlükleri"],
    nedir: "1990'da Tüm Göçmen İşçilerin ve Aile Fertlerinin Haklarının Korunmasına Dair Uluslararası Sözleşme'nin kabul günü anısına kutlanır.",
    nasil: "1. Göçmenlerin temel insan haklarına ve onuruna saygı duyun.\n2. Irkçılığa ve yabancı düşmanlığına karşı durun.\n3. Farklı kültürlerin topluma kattığı zenginliği takdir edin.",
    mesaj: "Hepimiz aynı gökyüzünün altındayız. 18 Aralık Uluslararası Göçmenler Günü kutlu olsun! 🕊️🌍🤝"
  }
];

// Read existing generate-dataset.mjs and merge
const genScriptPath = path.resolve('scripts/generate-dataset.mjs');
let scriptContent = fs.readFileSync(genScriptPath, 'utf8');

// Insert extraDays into rawDays array
const injectionPoint = 'const rawDays = [';
const serializedExtra = extraDays.map(d => JSON.stringify(d, null, 2)).join(',\n') + ',\n';

scriptContent = scriptContent.replace(injectionPoint, `${injectionPoint}\n${serializedExtra}`);
fs.writeFileSync(genScriptPath, scriptContent, 'utf8');
console.log(`Injected ${extraDays.length} new days into scripts/generate-dataset.mjs!`);
