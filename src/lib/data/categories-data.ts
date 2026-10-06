import { SpecialDayCategory } from "@/types/database";

export interface CategoryInfo {
  slug: string;
  name: string;
  category: SpecialDayCategory;
  description: string;
  longDescription: string;
  iconName: string;
  badgeVariant: "default" | "secondary" | "success" | "warning" | "red" | "purple" | "blue";
  gradient: string;
}

export const CATEGORIES_METADATA: CategoryInfo[] = [
  {
    slug: "resmi",
    name: "Resmi & Milli Bayramlar",
    category: "Resmi",
    description: "Türkiye Cumhuriyeti'nin bağımsızlık, egemenlik ve zaferlerini simgeleyen resmi tatiller ve bayramlar.",
    longDescription: "29 Ekim Cumhuriyet Bayramı, 23 Nisan Çocuk Bayramı, 19 Mayıs Gençlik Bayramı ve 30 Ağustos Zafer Bayramı başta olmak üzere tüm resmi ve milli tatil günleri.",
    iconName: "Landmark",
    badgeVariant: "red",
    gradient: "from-red-500 to-rose-600",
  },
  {
    slug: "eglence",
    name: "Eğlence & Yaşam",
    category: "Eğlence",
    description: "Kahve, çikolata, sevgililer günü, dostluk ve hayatın keyifli anlarını kutlayan popüler günler.",
    longDescription: "Dünya Kahve Günü, Sevgililer Günü, Anneler Günü, Dünya Çikolata Günü ve yaşamın güzelliklerini kutlayan neşeli etkinlikler.",
    iconName: "PartyPopper",
    badgeVariant: "warning",
    gradient: "from-amber-500 to-orange-600",
  },
  {
    slug: "saglik",
    name: "Sağlık & Tıp",
    category: "Sağlık",
    description: "Hastalıklar konusunda farkındalık yaratan, sağlıklı yaşamı ve tıp çalışanlarını destekleyen günler.",
    longDescription: "Tıp Bayramı, Dünya Ruh Sağlığı Günü, Kanser Farkındalığı, Kalp Günü ve sağlık personeline teşekkür edilen anlamlı günler.",
    iconName: "HeartPulse",
    badgeVariant: "blue",
    gradient: "from-sky-500 to-blue-600",
  },
  {
    slug: "cevre-doga",
    name: "Çevre, Doğa & Hayvanlar",
    category: "Çevre & Doğa",
    description: "Gezegenimizi, doğal kaynaklarımızı, ormanları ve can dostlarımızı korumak için kutlanan günler.",
    longDescription: "Dünya Çevre Günü, Hayvanları Koruma Günü, Dünya Su Günü, Toprak Günü ve iklim krizine dikkat çeken ekolojik farkındalık takvimi.",
    iconName: "Leaf",
    badgeVariant: "success",
    gradient: "from-emerald-500 to-teal-600",
  },
  {
    slug: "kultur-sanat",
    name: "Kültür, Sanat & Edebiyat",
    category: "Kültür & Sanat",
    description: "Tiyatro, müzik, sinema, kitap, resim ve somut olmayan kültürel miras kutlamaları.",
    longDescription: "Dünya Tiyatro Günü, Dünya Müzik Günü, Dünya Kitap Günü, Türk Kahvesi Günü ve sanatsal yaratıcılığı onurlandıran özel günler.",
    iconName: "Palette",
    badgeVariant: "purple",
    gradient: "from-purple-500 to-indigo-600",
  },
  {
    slug: "mesleki",
    name: "Mesleki Günler & Haftalar",
    category: "Mesleki",
    description: "Farklı meslek gruplarının toplumdaki emek ve katkılarını onurlandıran özel meslek günleri.",
    longDescription: "Öğretmenler Günü, Dünya Yazılımcılar Günü, Gazeteciler Günü, Mühendisler Günü, Avukatlar Günü ve mesleki takdir haftaları.",
    iconName: "Briefcase",
    badgeVariant: "secondary",
    gradient: "from-zinc-600 to-zinc-800",
  },
  {
    slug: "farkindalik",
    name: "Sosyal Farkındalık & Haklar",
    category: "Farkındalık",
    description: "İnsan hakları, engelli hakları, eşitlik ve dezavantajlı grupların haklarını savunan günler.",
    longDescription: "Dünya Engelliler Günü, Dünya Down Sendromu Günü, Bilgiye Erişim Günü, Dünya Barış Günü ve toplumsal vicdan günleri.",
    iconName: "Users",
    badgeVariant: "default",
    gradient: "from-pink-500 to-rose-600",
  },
  {
    slug: "uluslararasi",
    name: "Uluslararası & BM Günleri",
    category: "Uluslararası",
    description: "Birleşmiş Milletler (BM) ve küresel kuruluşlar tarafından dünya genelinde ilan edilen günler.",
    longDescription: "Dünya Kadınlar Günü, Dünya Nüfus Günü, İnsani Yardım Günü ve dünya çapında küresel iş birliğini geliştiren günler.",
    iconName: "Globe",
    badgeVariant: "blue",
    gradient: "from-blue-600 to-indigo-700",
  },
];

export function getCategoryBySlug(slug: string): CategoryInfo | undefined {
  return CATEGORIES_METADATA.find(
    (c) => c.slug.toLowerCase() === slug.toLowerCase()
  );
}

export function getCategoryByType(type: SpecialDayCategory): CategoryInfo | undefined {
  return CATEGORIES_METADATA.find((c) => c.category === type);
}
