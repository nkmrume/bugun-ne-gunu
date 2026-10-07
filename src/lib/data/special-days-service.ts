import { SpecialDay, MonthInfo } from "@/types/database";
import { supabase, isSupabaseConfigured } from "@/utils/supabase";
import { INITIAL_SPECIAL_DAYS, MONTHS_METADATA } from "./special-days-data";
import { getTurkeyToday } from "@/lib/date-engine";

export async function getAllSpecialDays(): Promise<SpecialDay[]> {
  if (isSupabaseConfigured()) {
    try {
      const { data, error } = await supabase
        .from("special_days")
        .select("*")
        .order("month_no", { ascending: true })
        .order("day_no", { ascending: true });

      if (!error && data && data.length > 0) {
        return data as SpecialDay[];
      }
    } catch (err) {
      console.warn("Supabase query error, falling back to local dataset:", err);
    }
  }
  return INITIAL_SPECIAL_DAYS;
}

export async function getSpecialDayBySlug(slug: string): Promise<SpecialDay | null> {
  if (isSupabaseConfigured()) {
    try {
      const { data, error } = await supabase
        .from("special_days")
        .select("*")
        .eq("slug", slug)
        .single();

      if (!error && data) {
        return data as SpecialDay;
      }
    } catch (err) {
      console.warn(`Supabase getSpecialDayBySlug error for slug ${slug}:`, err);
    }
  }

  const found = INITIAL_SPECIAL_DAYS.find((item) => item.slug === slug);
  return found || null;
}

export async function getTodaySpecialDays(dateOverride?: { day: number; month: number }): Promise<SpecialDay[]> {
  const turkeyToday = getTurkeyToday();
  const currentMonth = dateOverride ? dateOverride.month : turkeyToday.month;
  const currentDay = dateOverride ? dateOverride.day : turkeyToday.day;

  if (isSupabaseConfigured()) {
    try {
      const { data, error } = await supabase
        .from("special_days")
        .select("*")
        .eq("month_no", currentMonth)
        .eq("day_no", currentDay);

      if (!error && data && data.length > 0) {
        return data as SpecialDay[];
      }
    } catch (err) {
      console.warn("Supabase getTodaySpecialDays error:", err);
    }
  }

  // Filter local dataset
  return INITIAL_SPECIAL_DAYS.filter(
    (item) => item.month_no === currentMonth && item.day_no === currentDay
  );
}

export async function getSpecialDaysByDate(day: number, month: number): Promise<SpecialDay[]> {
  const all = await getAllSpecialDays();
  return all.filter((item) => item.month_no === month && item.day_no === day);
}

export async function getSpecialDaysByMonth(monthNo: number): Promise<SpecialDay[]> {
  if (isSupabaseConfigured()) {
    try {
      const { data, error } = await supabase
        .from("special_days")
        .select("*")
        .eq("month_no", monthNo)
        .order("day_no", { ascending: true });

      if (!error && data && data.length > 0) {
        return data as SpecialDay[];
      }
    } catch (err) {
      console.warn(`Supabase getSpecialDaysByMonth error for month ${monthNo}:`, err);
    }
  }

  return INITIAL_SPECIAL_DAYS.filter((item) => item.month_no === monthNo).sort(
    (a, b) => a.day_no - b.day_no
  );
}

/**
 * Returns strictly upcoming days chronologically starting tomorrow in Turkey timezone.
 * Wraps cleanly into next year without showing past days.
 */
export async function getUpcomingSpecialDays(limit: number = 6): Promise<SpecialDay[]> {
  const all = await getAllSpecialDays();
  const turkeyToday = getTurkeyToday();
  const currentMonth = turkeyToday.month;
  const currentDay = turkeyToday.day;

  const currentDayOfYear = getDayOfYear(currentMonth, currentDay);

  // Compute days until next occurrence for each special day
  const withDistance = all
    .map((day) => {
      const targetDayOfYear = getDayOfYear(day.month_no, day.day_no);
      let diffDays = targetDayOfYear - currentDayOfYear;
      if (diffDays <= 0) {
        diffDays += 365; // Next year occurrence
      }
      return {
        day,
        diffDays,
      };
    })
    .filter((item) => item.diffDays > 0);

  // Sort strictly by closest upcoming date
  withDistance.sort((a, b) => a.diffDays - b.diffDays);

  return withDistance.slice(0, limit).map((item) => item.day);
}

function getDayOfYear(month: number, day: number): number {
  const daysInMonths = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  let total = day;
  for (let m = 1; m < month; m++) {
    total += daysInMonths[m];
  }
  return total;
}

export async function searchSpecialDays(query: string): Promise<SpecialDay[]> {
  if (!query || query.trim() === "") return [];

  const lowerQuery = query.toLowerCase().trim();
  const all = await getAllSpecialDays();

  return all.filter((day) => {
    return (
      day.title.toLowerCase().includes(lowerQuery) ||
      day.description.toLowerCase().includes(lowerQuery) ||
      day.category.toLowerCase().includes(lowerQuery) ||
      day.hashtags.some((tag) => tag.toLowerCase().includes(lowerQuery)) ||
      day.affiliate_keywords.some((kw) => kw.toLowerCase().includes(lowerQuery))
    );
  });
}

export async function getSpecialDaysByCategory(categoryOrType: string): Promise<SpecialDay[]> {
  const all = await getAllSpecialDays();
  return all
    .filter((day) => day.category.toLowerCase() === categoryOrType.toLowerCase())
    .sort((a, b) => a.month_no * 100 + a.day_no - (b.month_no * 100 + b.day_no));
}

export async function getCategoryDayCounts(): Promise<Record<string, number>> {
  const all = await getAllSpecialDays();
  const counts: Record<string, number> = {};
  all.forEach((day) => {
    counts[day.category] = (counts[day.category] || 0) + 1;
  });
  return counts;
}

export function getMonthMetadata(monthNoOrSlug: number | string): MonthInfo | undefined {
  if (typeof monthNoOrSlug === "number") {
    return MONTHS_METADATA.find((m) => m.number === monthNoOrSlug);
  }
  return MONTHS_METADATA.find((m) => m.slug.toLowerCase() === monthNoOrSlug.toLowerCase());
}
