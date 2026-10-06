import { SpecialDay, MonthInfo } from "@/types/database";
import { supabase, isSupabaseConfigured } from "@/utils/supabase";
import { INITIAL_SPECIAL_DAYS, MONTHS_METADATA } from "./special-days-data";

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

export async function getTodaySpecialDays(dateOverride?: Date): Promise<SpecialDay[]> {
  // Use Turkish local time or provided date
  const now = dateOverride || new Date();
  const currentMonth = now.getMonth() + 1; // 1-12
  const currentDay = now.getDate(); // 1-31

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
  const todayDays = INITIAL_SPECIAL_DAYS.filter(
    (item) => item.month_no === currentMonth && item.day_no === currentDay
  );

  return todayDays;
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

export async function getUpcomingSpecialDays(limit: number = 4): Promise<SpecialDay[]> {
  const all = await getAllSpecialDays();
  const now = new Date();
  const currentMonth = now.getMonth() + 1;
  const currentDay = now.getDate();

  // Sort by closest day after today in current year
  const sorted = [...all].sort((a, b) => {
    const aVal = a.month_no * 100 + a.day_no;
    const bVal = b.month_no * 100 + b.day_no;
    const currentVal = currentMonth * 100 + currentDay;

    const aDiff = aVal >= currentVal ? aVal - currentVal : aVal + 1200 - currentVal;
    const bDiff = bVal >= currentVal ? bVal - currentVal : bVal + 1200 - currentVal;

    return aDiff - bDiff;
  });

  // Filter out today
  const upcoming = sorted.filter(
    (item) => !(item.month_no === currentMonth && item.day_no === currentDay)
  );

  return upcoming.slice(0, limit);
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

export function getMonthMetadata(monthNoOrSlug: number | string): MonthInfo | undefined {
  if (typeof monthNoOrSlug === "number") {
    return MONTHS_METADATA.find((m) => m.number === monthNoOrSlug);
  }
  return MONTHS_METADATA.find((m) => m.slug.toLowerCase() === monthNoOrSlug.toLowerCase());
}
