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
    id: "f8b9a112-9844-48f8-b3f1-000000000001",
    slug: "dunya-kahve-gunu",
    title: "Dünya Kahve Günü",
    description: "Her yıl 1 Ekim'de kutlanan Dünya Kahve Günü, kahve üreticilerinin emeğini onurlandırmak ve dünyanın en sevilen içeceğinin lezzetini kutlamak için düzenlenir.",
    content: `## Dünya Kahve Günü Nedir?
Dünya Kahve Günü (International Coffee Day), 2015 yılında Uluslararası Kahve Örgütü (ICO) tarafından resmi olarak başlatılan küresel bir kutlama günüdür. Bu özel günün temel amacı, kahve çiftçilerinin zorlu çalışma koşullarına ve adil ticaret prensiplerine dikkat çekmek, aynı zamanda milyonlarca insanın gününü aydınlatan bu eşsiz içeceğin kültürel zenginliğini kutlamaktır.

Her gün dünya genelinde 3 milyardan fazla fincan kahve tüketilmektedir. Çekirdeğin yetiştiği Etiyopya ve Kolombiya dağlarından, espresso fincanınıza uzanan büyüleyici yolculuk kutlanmayı hak ediyor.

### Tarihçesi
Farklı ülkelerde daha önce farklı tarihlerde kutlanan ulusal kahve günleri, 2014 yılında Milano Expo organizasyonunda alınan kararla tek bir çatı altında toplanmış ve 1 Ekim resmi Dünya Kahve Günü ilan edilmiştir.

---

## Dünya Kahve Günü Nasıl Kutlanır?
1. **Yeni Bir Demleme Yöntemi Deneyin:** Evinizde V60, Chemex, Aeropress veya geleneksel Türk Kahvesi cezvesiyle farklı bir çekirdek demleyin.
2. **Yerel Nitelikli Kahvecileri Destekleyin:** Mahallenizdeki bağımsız üçüncü nesil kahvecileri ziyaret ederek güne özel indirim ve etkinliklere katılın.
3. **Ofiste Kahve Molası Verin:** İş arkadaşlarınızla kahve eşliğinde keyifli bir sohbet molası planlayın.
4. **Adil Ticaret Çekirdekleri Seçin:** Sürdürülebilir tarımı ve çiftçileri destekleyen sertifikalı kahveleri tercih edin.

---

## Sosyal Medya Paylaşım ve Kutlama Mesajları
* "Bir fincan kahvenin kırk yıl hatırı vardır, Dünya Kahve Günü kutlu olsun! ☕✨"
* "Hayat kahveyle başlar! Tüm kahveseverlerin 1 Ekim Dünya Kahve Günü'nü en lezzetli dileklerimle kutlarım."
* "Kokusuyla uyandıran, tadıyla günümüze anlam katan kahveye teşekkür günü. #DunyaKahveGunu"`,
    celebration_date: "2026-10-01",
    month_no: 10,
    day_no: 1,
    category: "Eğlence",
    hashtags: ["#DunyaKahveGunu", "#Kahve", "#CoffeeDay", "#KahveSever", "#1Ekim"],
    affiliate_keywords: ["filtre kahve makinesi", "nitelikli çekirdek kahve", "termos kupa", "french press", "chemex kahve demleme"],
  },
  {
    id: "f8b9a112-9844-48f8-b3f1-000000000002",
    slug: "dunya-kuduz-gunu",
    title: "Dünya Kuduz Günü",
    description: "Her yıl 28 Eylül'de kutlanan Dünya Kuduz Günü, kuduz hastalığı konusunda farkındalık yaratmak ve aşılamanın hayati önemini vurgulamak amacıyla düzenlenir.",
    content: `## Dünya Kuduz Günü Nedir?
Dünya Kuduz Günü, kuduz aşısını geliştiren Fransız kimyager ve mikrobiyolog Louis Pasteur'ün ölüm yıl dönümü olan 28 Eylül tarihinde her yıl düzenlenmektedir. Dünya Sağlık Örgütü (WHO) ve Küresel Kuduz Kontrolü Birliği (GARC) ortaklığında yürütülen küresel bir farkındalık girişimidir.

Kuduz, yüzde 100 önlenebilir bir viral hastalık olmasına rağmen dünya çapında her yıl on binlerce insanın ve hayvanın hayatına mal olmaktadır.

---

## Nasıl Farkındalık Sağlanır?
1. Evcil dostlarımızın (kedi ve köpekler) yıllık kuduz aşılarını aksatmadan yaptırın.
2. Sokaktaki canların aşılanması ve kısırlaştırılması için yerel belediyelerin ve veterinerlerin çalışmalarına destek olun.
3. Çocuklara tanımadıkları ve agresif davranan hayvanlara nasıl güvenli yaklaşmaları gerektiğini öğretin.

---

## Sosyal Medya Mesajları
* "Aşı hayat kurtarır! 28 Eylül Dünya Kuduz Günü'nde can dostlarımızın sağlığını koruyalım, kuduzu birlikte sıfırlayalım. 🐾💉"
* "Kuduz yüzde 100 önlenebilir! Sevimli dostlarımızın aşılarını ihmal etmeyelim. #DunyaKuduzGunu"`,
    celebration_date: "2026-09-28",
    month_no: 9,
    day_no: 28,
    category: "Sağlık",
    hashtags: ["#DunyaKuduzGunu", "#KuduzFarkindaligi", "#AsiHayatKurtarir", "#28Eylul"],
    affiliate_keywords: ["kedi köpek taşıma çantası", "köpek tasması ve künyesi", "veteriner bakım seti", "evcil hayvan vitamini"],
  },
  {
    id: "f8b9a112-9844-48f8-b3f1-000000000003",
    slug: "bilgiye-evrensel-erisim-gunu",
    title: "Uluslararası Bilgiye Evrensel Erişim Günü",
    description: "28 Eylül Uluslararası Bilgiye Evrensel Erişim Günü, bilginin serbestçe yayılması ve şeffaf toplumların inşası için UNESCO öncülüğünde kutlanır.",
    content: `## Bilgiye Evrensel Erişim Günü Nedir?
UNESCO tarafından ilan edilen bu özel gün, vatandaşların kamu bilgilerine erişim hakkını (bilgi edinme hakkı) ve basın özgürlüğünü güvence altına almayı hedefler. Bilgiye erişim; insan haklarının, demokrasinin ve sürdürülebilir kalkınmanın en temel direğidir.

---

## Nasıl Kutlanır?
1. Açık kaynaklı kütüphaneleri, bilimsel makaleleri ve kamuya açık veri setlerini keşfedin.
2. Toplumda dijital okuryazarlığın gelişmesine katkıda bulunacak kaynakları paylaşın.
3. Kütüphaneleri ve bağımsız arşivleri ziyaret edin.

---

## Sosyal Medya Mesajları
* "Bilgi güçtür, özgürce erişildiğinde ise toplumu dönüştürür. 28 Eylül Uluslararası Bilgiye Evrensel Erişim Günü kutlu olsun! 📚🌐"
* "Şeffaflık ve adalet ancak bilgiye özgür erişimle mümkündür. #BilgiyeErisimGunu"`,
    celebration_date: "2026-09-28",
    month_no: 9,
    day_no: 28,
    category: "Farkındalık",
    hashtags: ["#BilgiyeErisimGunu", "#UNESCO", "#AcikBilgi", "#DijitalHaklar"],
    affiliate_keywords: ["e-kitap okuyucu", "bilimsel kitaplar", "hızlı okuma kitap seti", "masa lambası"],
  },
  {
    id: "f8b9a112-9844-48f8-b3f1-000000000004",
    slug: "cumhuriyet-bayrami",
    title: "29 Ekim Cumhuriyet Bayramı",
    description: "Türkiye Cumhuriyeti'nin 1923 yılında Gazi Mustafa Kemal Atatürk ve silah arkadaşları tarafından ilan edildiği en büyük ulusal bayramımız.",
    content: `## 29 Ekim Cumhuriyet Bayramı Nedir?
29 Ekim 1923 tarihinde Türkiye Büyük Millet Meclisi tarafından Cumhuriyet idaresi resmen ilan edilmiş ve Gazi Mustafa Kemal Atatürk, Türkiye Cumhuriyeti'nin ilk Cumhurbaşkanı seçilmiştir. Egemenliğin kayıtsız şartsız millete verildiği bu kutlu gün, Türkiye Cumhuriyeti'nin ve Kuzey Kıbrıs Türk Cumhuriyeti'nin en büyük ulusal bayramıdır.

---

## Nasıl Kutlanır?
1. Evlerin pencerelerine, balkonlara ve caddelere Türk Bayrakları asılır.
2. Anıtkabir ve il/ilçe meydanlarındaki resmi törenlere, geçit alaylarına ve fener alaylarına katılınır.
3. Okullarda şiirler okunur, cumhuriyet değerleri ve Atatürk ilkeleri üzerine konuşmalar yapılır.

---

## Sosyal Medya Mesajları
* "Cumhuriyetimizin ışığında, Atamızın izinde daima ileriye! 29 Ekim Cumhuriyet Bayramımız kutlu olsun! 🇹🇷"
* "Ey yükselen yeni nesil! İstikbal sizsiniz. Cumhuriyeti biz kurduk, onu yükseltecek ve yaşatacak sizsiniz. 🇹🇷✨"
* "Cumhuriyetimizin 103. yılı kutlu ve ebedi olsun! Ne mutlu Türküm diyene!"`,
    celebration_date: "2026-10-29",
    month_no: 10,
    day_no: 29,
    category: "Resmi",
    hashtags: ["#29Ekim", "#CumhuriyetBayrami", "#Ataturk", "#Cumhuriyet103Yasinda", "#Turkiye"],
    affiliate_keywords: ["türk bayrağı büyük boy", "atatürk rozeti", "nutuk özel baskı", "fener alayı meşalesi"],
  },
  {
    id: "f8b9a112-9844-48f8-b3f1-000000000005",
    slug: "hayvanlari-koruma-gunu",
    title: "4 Ekim Hayvanları Koruma Günü",
    description: "Doğadaki tüm canlıların yaşam haklarına saygı duymak ve sokak hayvanlarının refahını artırmak amacıyla kutlanan uluslararası gün.",
    content: `## Hayvanları Koruma Günü Nedir?
İlk olarak 1931 yılında Floransa'da çevre bilimcilerin girişimiyle başlatılan 4 Ekim Dünya Hayvanları Koruma Günü, tehlike altındaki türlerin korunması ve evcil/sokak hayvanlarının yaşam şartlarının iyileştirilmesi için farkındalık yaratır.

---

## Nasıl Kutlanır?
1. Bir kap su ve bir kap mama bırakarak sokak hayvanlarını besleyin.
2. Barınakları ziyaret edin ve bir can sahiplenmeyi değerlendirin ("Satın alma, sahiplen!").
3. Çocuklara hayvan sevgisini aşılayan kitaplar ve belgeseller izletin.

---

## Sosyal Medya Mesajları
* "Onlar bize emanet! Dünyayı paylaştığımız tüm can dostlarımızın 4 Ekim Hayvanları Koruma Günü kutlu olsun. 🐶🐱🐦"
* "Bir kap su, bir kap mama hayat kurtarır. Sevgiyle koruyalım! #4EkimHayvanlariKorumaGunu"`,
    celebration_date: "2026-10-04",
    month_no: 10,
    day_no: 4,
    category: "Çevre & Doğa",
    hashtags: ["#4Ekim", "#HayvanlariKorumaGunu", "#SatinAlmaSahiplen", "#CanDostlarimiz"],
    affiliate_keywords: ["kedi maması 15kg", "köpek maması premium", "kuş yemi ve kafesi", "otomatik su sebili pet"],
  },
  {
    id: "f8b9a112-9844-48f8-b3f1-000000000006",
    slug: "ataturku-anma-gunu",
    title: "10 Kasım Atatürk'ü Anma Günü",
    description: "Türkiye Cumhuriyeti'nin kurucusu Gazi Mustafa Kemal Atatürk'ün aramızdan ayrılışının yıl dönümü ve anma günü.",
    content: `## 10 Kasım Atatürk'ü Anma Günü Nedir?
10 Kasım 1938 günü saat 09:05'te Dolmabahçe Sarayı'nda ebediyete intikal eden Türkiye Cumhuriyeti'nin kurucusu ve ilk Cumhurbaşkanı Mustafa Kemal Atatürk'ün anısına her yıl 10 Kasım'da düzenlenen ulusal yas ve anma günüdür.

---

## Nasıl Anılır?
1. Saat 09:05'te çalan sirenlerle birlikte saygı duruşunda bulunulur.
2. Türkiye Büyük Millet Meclisi ve tüm resmi kurumlarda bayraklar yarıya indirilir.
3. Anıtkabir ziyaret edilir ve okullarda anma törenleri icra edilir.

---

## Sosyal Medya Mesajları
* "Beni görmek demek mutlaka yüzümü görmek değildir. Fikirlerimi, duygularımı anlıyorsanız ve hissediyorsanız bu kafidir. Saygı, minnet ve özlemle anıyoruz. 🇹🇷🖤"
* "10 Kasım: Fikirler ölmez! Atamızı saygı ve rahmetle anıyoruz."`,
    celebration_date: "2026-11-10",
    month_no: 11,
    day_no: 10,
    category: "Resmi",
    hashtags: ["#10Kasim", "#Ataturk", "#SaygiVeOzlemle", "#0905", "#Turkiye"],
    affiliate_keywords: ["atatürk portresi çerçeveli", "atatürk biyografi kitabı", "atatürk imzalı kupa", "nutuk ciltli"],
  },
  {
    id: "f8b9a112-9844-48f8-b3f1-000000000007",
    slug: "ogretmenler-gunu",
    title: "24 Kasım Öğretmenler Günü",
    description: "Mustafa Kemal Atatürk'ün Millet Mektepleri Başöğretmenliği unvanını kabul ettiği günün anısına kutlanan özel gün.",
    content: `## Öğretmenler Günü Nedir?
24 Kasım 1928, Mustafa Kemal Atatürk'ün 'Millet Mektepleri Başöğretmenliği' unvanını kabul ettiği gündür. 1981 yılından itibaren Türkiye'de her 24 Kasım Öğretmenler Günü olarak coşkuyla kutlanmaktadır.

---

## Nasıl Kutlanır?
1. Öğretmenlerimize teşekkür mesajları gönderilir veya el yapımı hediyeler verilir.
2. Emekli öğretmenler ziyaret edilir ve vefa gösterilir.
3. Okullarda öğretmenler için özel etkinlikler ve korolar düzenlenir.

---

## Sosyal Medya Mesajları
* "Geleceğimizin mimarı olan fedakar öğretmenlerimizin 24 Kasım Öğretmenler Günü kutlu olsun! 💐"
* "Bana bir harf öğretenin kırk yıl kölesi olurum. Başöğretmen Atatürk ve tüm öğretmenlerimize saygıyla."`,
    celebration_date: "2026-11-24",
    month_no: 11,
    day_no: 24,
    category: "Mesleki",
    hashtags: ["#24Kasim", "#OgretmenlerGunu", "#Basogretmen", "#CanimOgretmenim"],
    affiliate_keywords: ["isme özel öğretmen dolma kalemi", "öğretmenler günü hediye kutusu", "çiçek buketi", "deri ajanda"],
  },
  {
    id: "f8b9a112-9844-48f8-b3f1-000000000008",
    slug: "ulusal-egemenlik-ve-cocuk-bayrami",
    title: "23 Nisan Ulusal Egemenlik ve Çocuk Bayramı",
    description: "Türkiye Büyük Millet Meclisi'nin açılışı ve Atatürk'ün dünya çocuklarına armağan ettiği tek çocuk bayramı.",
    content: `## 23 Nisan Nedir?
23 Nisan 1920'de Ankara'da TBMM açılmış ve milletin iradesi tescillenmiştir. Atatürk bu tarihi günü dünya çocuklarına bayram olarak hediye etmiştir. Dünyadaki ilk ve tek çocuk bayramıdır.

---

## Nasıl Kutlanır?
1. Stadyum gösterileri ve çocuk şenlikleri yapılır.
2. Çocuklar bir günlüğüne devlet makamlarına ve belediye başkanlıklarına otururlar.
3. Dünyanın dört bir yanından gelen misafir çocuklar ağırlanır.

---

## Sosyal Medya Mesajları
* "Küçük hanımlar, küçük beyler! Sizler geleceğin bir gülü, yıldızı ve ikbal ışığısınız. 23 Nisan kutlu olsun! 🇹🇷🎈"`,
    celebration_date: "2026-04-23",
    month_no: 4,
    day_no: 23,
    category: "Resmi",
    hashtags: ["#23Nisan", "#CocukBayrami", "#EgemenlikUlusundur", "#Ataturk"],
    affiliate_keywords: ["çocuk kostümü", "uçurtma seti", "çocuk zeka oyunları", "türk bayrağı balon"],
  },
  {
    id: "f8b9a112-9844-48f8-b3f1-000000000009",
    slug: "dunya-kadinlar-gunu",
    title: "8 Mart Dünya Kadınlar Günü",
    description: "Kadınların sosyal, ekonomik, kültürel ve siyasi başarılarını kutlayan ve cinsiyet eşitliğini savunan küresel gün.",
    content: `## 8 Mart Dünya Kadınlar Günü Nedir?
1857 yılında New York'ta tekstil işçisi kadınların başlattığı hak mücadelesinin anısına Birleşmiş Milletler tarafından tanınan küresel bir gündür.

---

## Nasıl Kutlanır?
1. Kadın girişimcilerin ürünleri tercih edilerek destek verilir.
2. Cinsiyet eşitliği sempozyumları ve etkinlikleri düzenlenir.
3. Sevdiklerimize saygı ve takdirlerimizi iletiriz.

---

## Sosyal Medya Mesajları
* "Dünyayı güzelleştiren, emekleriyle hayat veren tüm güçlü kadınların 8 Mart Dünya Kadınlar Günü kutlu olsun! 🌸💪"`,
    celebration_date: "2026-03-08",
    month_no: 3,
    day_no: 8,
    category: "Uluslararası",
    hashtags: ["#8Mart", "#DunyaKadinlarGunu", "#GucluKadinlar", "#KadinHaklari"],
    affiliate_keywords: ["kadın parfümü", "özel hediye seti", "orkide saksı çiçeği", "tasarım takı kolye"],
  },
  {
    id: "f8b9a112-9844-48f8-b3f1-000000000010",
    slug: "dunya-yazilimcilar-gunu",
    title: "Dünya Yazılımcılar Günü",
    description: "Yılın 256. gününde (2 üzeri 8) dijital dünyayı inşa eden tüm yazılım geliştiricileri onurlandırmak için kutlanır.",
    content: `## Dünya Yazılımcılar Günü Nedir?
Programmer's Day (Yazılımcılar Günü), 1 baytlık bir değerin alabileceği farklı değer sayısı olan 256'ncı günde kutlanır (artık yıllarda 12 Eylül, normal yıllarda 13 Eylül).

---

## Nasıl Kutlanır?
1. Açık kaynak projelere katkıda bulunun (pull request gönderin).
2. Yeni bir programlama dili veya framework öğrenmeye başlayın.
3. Çalışma arkadaşınıza kahve veya kod incelemesi ikram edin.

---

## Sosyal Medya Mesajları
* "while(alive) { code(); coffee(); } 🚀 Dünya Yazılımcılar Günü kutlu olsun! #ProgrammersDay"
* "Bug'sız, sıfır hatalı commit'ler dileriz! 💻✨"`,
    celebration_date: "2026-09-13",
    month_no: 9,
    day_no: 13,
    category: "Mesleki",
    hashtags: ["#YazilimcilarGunu", "#ProgrammersDay", "#Coding", "#DeveloperLife", "#256Day"],
    affiliate_keywords: ["mekanik klavye rgb", "ergonomik mouse", "yazılımcı tişörtü", "monitör standı"],
  },
  {
    id: "f8b9a112-9844-48f8-b3f1-000000000011",
    slug: "dunya-cevre-gunu",
    title: "5 Haziran Dünya Çevre Günü",
    description: "Doğayı korumak, iklim kriziyle mücadele etmek ve gezegenimizin sürdürülebilirliğini sağlamak için Birleşmiş Milletler öncülüğünde kutlanır.",
    content: `## Dünya Çevre Günü Nedir?
1972 yılında Stockholm İnsan Çevresi Konferansı'nda alınan kararla ilan edilen 5 Haziran, doğayı koruma bilincini artırmak amacıyla dünya genelinde 150'den fazla ülkede kutlanmaktadır.

---

## Nasıl Kutlanır?
1. Fidan dikin veya yerel çevre temizliği etkinliklerine katılın.
2. Tek kullanımlık plastik tüketiminizi sıfıra indirmeye çalışın.
3. Enerji ve su tasarrufu sağlayan adımlar atın.

---

## Sosyal Medya Mesajları
* "Başka bir Dünya yok! Gelecek nesillere yaşanabilir bir gezegen bırakmak için 5 Haziran Dünya Çevre Günü'nde harekete geçelim. 🌍🌱"`,
    celebration_date: "2026-06-05",
    month_no: 6,
    day_no: 5,
    category: "Çevre & Doğa",
    hashtags: ["#DunyaCevreGunu", "#SifirAtik", "#IklimKrizi", "#DogaDostu"],
    affiliate_keywords: ["çelik matara termos", "bez alışveriş çantası", "bambu diş fırçası seti", "kompost kutusu"],
  },
  {
    id: "f8b9a112-9844-48f8-b3f1-000000000012",
    slug: "dunya-turk-kahvesi-gunu",
    title: "5 Aralık Dünya Türk Kahvesi Günü",
    description: "UNESCO tarafından Somut Olmayan Kültürel Miras listesine alınan Türk Kahvesi kültürünün tüm dünyada kutlandığı özel gün.",
    content: `## Dünya Türk Kahvesi Günü Nedir?
5 Aralık 2013'te UNESCO, 'Türk Kahvesi Kültürü ve Geleneği'ni İnsanlığın Somut Olmayan Kültürel Mirası Temsili Listesi'ne kaydetmiştir. Bu tarihi kararın anısına 5 Aralık tüm dünyada Dünya Türk Kahvesi Günü olarak kutlanır.

---

## Nasıl Kutlanır?
1. Bakır cezvede bol köpüklü okkalı bir Türk kahvesi pişirin.
2. Sevdiklerinizle 'bir fincan kahvenin kırk yıl hatırı' eşliğinde derin sohbetler edin.
3. Yanında lokum ve bir bardak su ile geleneksel sunum yapın.

---

## Sosyal Medya Mesajları
* "Gönül ne kahve ister ne kahvehane, gönül sohbet ister kahve bahane. 5 Aralık Dünya Türk Kahvesi Günü kutlu olsun! ☕🇹🇷"`,
    celebration_date: "2026-12-05",
    month_no: 12,
    day_no: 5,
    category: "Kültür & Sanat",
    hashtags: ["#DunyaTurkKahvesiGunu", "#TurkKahvesi", "#UNESCO", "#KahveKulturu"],
    affiliate_keywords: ["otomatik türk kahvesi makinesi", "bakır cezve seti", "türk kahvesi fincan takımı", "hacı bekir lokumu"],
  },
  {
    id: "f8b9a112-9844-48f8-b3f1-000000000013",
    slug: "pi-gunu",
    title: "14 Mart Dünya Pi Günü",
    description: "Matematiksel sabit olan Pi sayısının (3,14) onuruna dünya genelindeki matematikçiler ve bilim meraklıları tarafından kutlanan gün.",
    content: `## Pi Günü Nedir?
Pi sayısı yaklaşık olarak 3.14159... olduğu için, Amerikan tarih formatında 3. ayın 14'ü (3/14) Pi Günü olarak kabul edilmiştir. Ayrıca bu gün Albert Einstein'ın doğum günüdür.

---

## Nasıl Kutlanır?
1. Pi sayısı desenli turtalar veya pastalar pişirin (Pie).
2. Pi sayısının virgülden sonraki basamaklarını ezberleme yarışması yapın.
3. Matematik ve bilim temalı belgeseller izleyin.

---

## Sosyal Medya Mesajları
* "Sonsuzluğa uzanan sayının günü kutlu olsun! 3,14... Dünya Pi Günü ve Tıp Bayramı kutlu olsun! 🥧📐"`,
    celebration_date: "2026-03-14",
    month_no: 3,
    day_no: 14,
    category: "Eğlence",
    hashtags: ["#PiGunu", "#PiDay", "#Matematik", "#Einstein", "#314"],
    affiliate_keywords: ["bilimsel hesap makinesi", "pi sayısı tişörtü", "matematik bulmaca kitapları", "rubik küp"],
  },
  {
    id: "f8b9a112-9844-48f8-b3f1-000000000014",
    slug: "sevgililer-gunu",
    title: "14 Şubat Sevgililer Günü",
    description: "Tüm dünyada sevgi ve aşkın paylaşıldığı, Aziz Valentin'in anısına ithaf edilen romantik kutlama günü.",
    content: `## Sevgililer Günü Nedir?
Kökeni Roma dönemine ve Aziz Valentine efsanesine dayanan 14 Şubat Sevgililer Günü, günümüzde insanların birbirine olan sevgisini kartlar, hediyeler ve romantik jestlerle ifade ettiği evrensel bir gündür.

---

## Nasıl Kutlanır?
1. Sevdiğinize duygularınızı samimiyetle anlatan bir mektup yazın.
2. Birlikte baş başa romantik bir akşam yemeği planlayın.
3. Birlikte çekildiğiniz fotoğraflardan oluşan anı albümü hazırlayın.

---

## Sosyal Medya Mesajları
* "Seninle geçen her gün bir bayram! 14 Şubat Sevgililer Günümüz kutlu olsun sevgilim. ❤️🌹"`,
    celebration_date: "2026-02-14",
    month_no: 2,
    day_no: 14,
    category: "Eğlence",
    hashtags: ["#14Subat", "#SevgililerGunu", "#ValentinesDay", "#Ask", "#Hediye"],
    affiliate_keywords: ["sevgililer günü hediye kutusu", "gümüş kolye", "çikolata kutusu lüks", "akıllı saat unisex"],
  },
  {
    id: "f8b9a112-9844-48f8-b3f1-000000000015",
    slug: "zafer-bayrami",
    title: "30 Ağustos Zafer Bayramı",
    description: "1922'de Dumlupınar'da Başkomutan Mustafa Kemal Paşa komutasındaki Türk ordusunun kazandığı Büyük Taarruz zaferi.",
    content: `## 30 Ağustos Zafer Bayramı Nedir?
1922 yılında Dumlupınar'da Gazi Mustafa Kemal Atatürk'ün başkumandanlığında zaferle sonuçlanan Başkomutanlık Meydan Muharebesi'ni (Büyük Taarruz) anmak için kutlanan resmi ve ulusal bayramdır.

---

## Nasıl Kutlanır?
1. Askeri geçit törenleri ve Türk Yıldızları hava gösterileri izlenir.
2. Şehitlikler ziyaret edilerek dualar okunur.
3. Bütün cadde ve evler al bayraklarla donatılır.

---

## Sosyal Medya Mesajları
* "30 Ağustos, Türk milletinin bağımsızlığından asla taviz vermeyeceğinin tarihe altın harflerle yazılmış belgesidir. Zafer Bayramımız kutlu olsun! 🇹🇷"`,
    celebration_date: "2026-08-30",
    month_no: 8,
    day_no: 30,
    category: "Resmi",
    hashtags: ["#30Agustos", "#ZaferBayrami", "#BaskanMustafaKemal", "#BuyukTaarruz", "#Turkiye"],
    affiliate_keywords: ["türk bayrağı araba süsü", "atatürk tişörtü", "kurtuluş savaşı tarihi kitabı", "rozet"],
  },
  {
    id: "f8b9a112-9844-48f8-b3f1-000000000016",
    slug: "dunya-tiyatro-gunu",
    title: "27 Mart Dünya Tiyatro Günü",
    description: "Tiyatro sanatının toplumları birleştirici ve aydınlatıcı gücünü kutlamak için 1961'den beri kutlanan uluslararası sanat günü.",
    content: `## Dünya Tiyatro Günü Nedir?
Uluslararası Tiyatro Enstitüsü (ITI) tarafından 1961 yılında kurulan Dünya Tiyatro Günü'nde her yıl dünya çapında ünlü bir tiyatro insanı tarafından uluslararası bildiri kaleme alınır.

---

## Nasıl Kutlanır?
1. Şehir tiyatrolarında ücretsiz veya indirimli sergilenen oyunlara bilet alın.
2. Tiyatro metinleri okuyun ve sahne sanatlarının tarihini inceleyin.
3. Çocukları tiyatroyla tanıştırmak için kukla veya çocuk tiyatrosuna götürün.

---

## Sosyal Medya Mesajları
* "Bütün dünya bir sahnedir, kadın erkek bütün insanlar da birer oyuncu... 27 Mart Dünya Tiyatro Günü kutlu olsun! 🎭🎟️"`,
    celebration_date: "2026-03-27",
    month_no: 3,
    day_no: 27,
    category: "Kültür & Sanat",
    hashtags: ["#DunyaTiyatroGunu", "#Tiyatro", "#SahneSanatlari", "#27Mart"],
    affiliate_keywords: ["tiyatro oyun metinleri", "shakespeare toplu eserleri", "dürbün tiyatro tipi", "sanat tarihi kitabı"],
  },
  {
    id: "f8b9a112-9844-48f8-b3f1-000000000017",
    slug: "dunya-muzik-gunu",
    title: "21 Haziran Dünya Müzik Günü",
    description: "Yılın en uzun gününde sokaklarda, parklarda ve salonlarda müziğin evrensel dilini kutlayan 'Fête de la Musique'.",
    content: `## Dünya Müzik Günü Nedir?
İlk olarak 1982'de Fransa'da Kültür Bakanı Jack Lang öncülüğünde başlatılan Fête de la Musique, bugün 120'den fazla ülkede amatör ve profesyonel tüm müzisyenlerin sokaklarda özgürce müzik icra ettiği dev bir festivale dönüşmüştür.

---

## Nasıl Kutlanır?
1. Kulaklığınızı takıp yeni türlerde çalma listeleri keşfedin.
2. Bir enstrüman öğrenmeye ilk adımı atın (gitar, ukulele veya piyano).
3. Sokak sanatçılarını dinleyin ve destekleyin.

---

## Sosyal Medya Mesajları
* "Müzik ruhun gıdasıdır. Ruhu müzikle beslenen tüm dostların 21 Haziran Dünya Müzik Günü kutlu olsun! 🎵🎸🎧"`,
    celebration_date: "2026-06-21",
    month_no: 6,
    day_no: 21,
    category: "Kültür & Sanat",
    hashtags: ["#DunyaMuzikGunu", "#FeteDeLaMusique", "#MuzikGunu", "#EnUzunGun"],
    affiliate_keywords: ["bluetooth kulaklık", "akustik gitar başlangıç seti", "ukulele ahşap", "taşınabilir hoparlör"],
  },
  {
    id: "f8b9a112-9844-48f8-b3f1-000000000018",
    slug: "anneler-gunu",
    title: "Anneler Günü",
    description: "Her yıl Mayıs ayının ikinci pazar günü kutlanan, annelerimizin sonsuz şefkat ve sevgisine teşekkür ettiğimiz en duygusal gün.",
    content: `## Anneler Günü Nedir?
Modern Anneler Günü, Anna Jarvis'in 1908 yılında kendi annesinin anısına başlattığı anma etkinliğiyle şekillenmiş ve dünya çapında yaygınlaşmıştır. Türkiye'de de her yıl Mayıs ayının ikinci pazar günü kutlanır.

---

## Nasıl Kutlanır?
1. Annenizi ziyaret edin, sımsıkı sarılın ve teşekkür edin.
2. Onun için özel bir kahvaltı veya en sevdiği yemeği hazırlayın.
3. Hayatını kolaylaştıracak veya onu mutlu edecek anlamlı bir hediye seçin.

---

## Sosyal Medya Mesajları
* "Cennet annelerin ayakları altındadır. Varlığıyla dünyamızı aydınlatan canım annemin ve tüm annelerin Anneler Günü kutlu olsun! 💐💖"`,
    celebration_date: "2026-05-10",
    month_no: 5,
    day_no: 10,
    category: "Eğlence",
    hashtags: ["#AnnelerGunu", "#CanimAnnem", "#AnneSevgisi", "#HediyeFikirleri"],
    affiliate_keywords: ["anneler günü hediye seti", "robot süpürge", "kolye anne bebek figürlü", "çiçek sepeti"],
  },
];
