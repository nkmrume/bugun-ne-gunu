export interface SpecialDay {
  id: string;
  slug: string;
  title: string;
  description: string;
  content: string; // Markdown or structured content
  celebration_date: string; // ISO Date YYYY-MM-DD
  month_no: number; // 1 - 12
  day_no: number; // 1 - 31
  category: SpecialDayCategory;
  hashtags: string[];
  affiliate_keywords: string[];
  created_at?: string;
  updated_at?: string;
}

export type SpecialDayCategory =
  | "Eğlence"
  | "Resmi"
  | "Dini"
  | "Farkındalık"
  | "Kültür & Sanat"
  | "Mesleki"
  | "Çevre & Doğa"
  | "Sağlık"
  | "Uluslararası";

export interface MonthInfo {
  number: number;
  slug: string;
  name: string;
  shortName: string;
  season: "Kış" | "İlkbahar" | "Yaz" | "Sonbahar";
  daysCount: number;
  description: string;
}

export interface FAQItem {
  question: string;
  answer: string;
}
