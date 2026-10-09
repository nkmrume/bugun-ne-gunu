export type DayType = "kutlama" | "anma" | "farkindalik" | "resmi-tatil";

export type OfficialStatus =
  | "official" // Resmî kanun/mevzuat ile belirlenmiş (ör. 29 Ekim, 23 Nisan)
  | "international_observance" // BM, UNESCO, DSÖ gibi uluslararası resmî kurumlarca ilan edilmiş
  | "community_observance" // Kültürel veya sivil toplum geleneği (ör. Dünya Kediler Günü, Dünya Tiyatro Günü)
  | "commercial" // Ticari / sektörel kampanya kökenli günler
  | "unverified"; // Henüz birincil kaynağı teyit edilmemiş

export type EditorialStatus =
  | "draft"
  | "needs_review"
  | "verified"
  | "published"
  | "archived";

export type SourceType =
  | "primary_official" // Resmî Gazete, BM kararı, UNESCO resmi belgesi
  | "institutional" // Tanınmış kurum, sivil toplum veya üniversite
  | "secondary_reliable" // Güvenilir ikincil kaynak / ansiklopedi
  | "unverified";

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
  day_type?: DayType; // kutlama, anma, farkindalik, resmi-tatil
  is_public_holiday?: boolean;
  scope?: "turkiye" | "uluslararasi" | "bm";
  
  // Verification & Trust fields (Section 3.1)
  official_status?: OfficialStatus;
  editorial_status?: EditorialStatus;
  declaring_authority?: string | null;
  source_name?: string | null;
  source_url?: string | null;
  source_type?: SourceType;
  source_checked_at?: string | null;
  last_verified_at?: string | null;
  verified_at?: string | null; // Backwards compatible
  holiday_country?: string | null;
  holiday_year?: number | null;

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

export interface HistoryEvent {
  year: number;
  title: string;
  description: string;
  category?: "tarih" | "bilim" | "kultur" | "turkiye" | "dunya";
  source_name?: string;
  source_url?: string;
}
