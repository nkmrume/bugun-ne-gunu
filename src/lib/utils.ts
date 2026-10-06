import { clsx, type ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

export const TURKISH_MONTHS: { [key: number]: string } = {
  1: "Ocak",
  2: "Şubat",
  3: "Mart",
  4: "Nisan",
  5: "Mayıs",
  6: "Haziran",
  7: "Temmuz",
  8: "Ağustos",
  9: "Eylül",
  10: "Ekim",
  11: "Kasım",
  12: "Aralık",
};

export const MONTH_SLUGS: { [key: string]: number } = {
  ocak: 1,
  subat: 2,
  mart: 3,
  nisan: 4,
  mayis: 5,
  haziran: 6,
  temmuz: 7,
  agustos: 8,
  eylul: 9,
  ekim: 10,
  kasim: 11,
  aralik: 12,
};

export const NUMBER_TO_MONTH_SLUG: { [key: number]: string } = {
  1: "ocak",
  2: "subat",
  3: "mart",
  4: "nisan",
  5: "mayis",
  6: "haziran",
  7: "temmuz",
  8: "agustos",
  9: "eylul",
  10: "ekim",
  11: "kasim",
  12: "aralik",
};

export function formatTurkishDate(day: number, month: number, year: number = 2026): string {
  const monthName = TURKISH_MONTHS[month] || "";
  return `${day} ${monthName} ${year}`;
}

export function formatDayMonthOnly(day: number, month: number): string {
  const monthName = TURKISH_MONTHS[month] || "";
  return `${day} ${monthName}`;
}

export function slugifyTurkish(text: string): string {
  return text
    .toLowerCase()
    .replace(/ğ/g, "g")
    .replace(/ü/g, "u")
    .replace(/ş/g, "s")
    .replace(/ı/g, "i")
    .replace(/ö/g, "o")
    .replace(/ç/g, "c")
    .replace(/[^a-z0-9\s-]/g, "")
    .trim()
    .replace(/\s+/g, "-")
    .replace(/-+/g, "-");
}
