import { TURKISH_MONTHS, MONTH_SLUGS, NUMBER_TO_MONTH_SLUG } from "./utils";

export interface TurkeyDateInfo {
  year: number;
  month: number;
  day: number;
  dayOfWeek: string;
  dayOfWeekNo: number;
  formattedFull: string;
  formattedShort: string;
  dateSlug: string;
}

const DAYS_OF_WEEK_TR = [
  "Pazar",
  "Pazartesi",
  "Salı",
  "Çarşamba",
  "Perşembe",
  "Cuma",
  "Cumartesi",
];

/**
 * Returns current date in Europe/Istanbul timezone (UTC+3)
 */
export function getTurkeyToday(): TurkeyDateInfo {
  const now = new Date();
  
  // Format parts according to Europe/Istanbul timezone
  const formatter = new Intl.DateTimeFormat("en-US", {
    timeZone: "Europe/Istanbul",
    year: "numeric",
    month: "numeric",
    day: "numeric",
    weekday: "long",
  });
  
  const parts = formatter.formatToParts(now);
  const partMap: Record<string, string> = {};
  for (const part of parts) {
    partMap[part.type] = part.value;
  }

  const year = parseInt(partMap.year, 10) || 2026;
  const month = parseInt(partMap.month, 10) || 10;
  const day = parseInt(partMap.day, 10) || 7;

  // Exact weekday in Turkey
  const dayOfWeekIndex = new Date(Date.UTC(year, month - 1, day)).getUTCDay();
  const dayOfWeek = DAYS_OF_WEEK_TR[dayOfWeekIndex];

  const monthName = TURKISH_MONTHS[month] || "";
  const monthSlug = NUMBER_TO_MONTH_SLUG[month] || "ekim";
  const dateSlug = `${day}-${monthSlug}`;

  return {
    year,
    month,
    day,
    dayOfWeek,
    dayOfWeekNo: dayOfWeekIndex,
    formattedFull: `${day} ${monthName} ${year}, ${dayOfWeek}`,
    formattedShort: `${day} ${monthName}`,
    dateSlug,
  };
}

/**
 * Parses date slug like '7-ekim' or '29-ekim' into day and month numbers
 */
export function parseDateSlug(slug: string): {
  isValid: boolean;
  day: number;
  month: number;
  monthName: string;
  monthSlug: string;
  formattedShort: string;
} {
  const parts = slug.toLowerCase().split("-");
  if (parts.length < 2) {
    return {
      isValid: false,
      day: 1,
      month: 1,
      monthName: "Ocak",
      monthSlug: "ocak",
      formattedShort: "1 Ocak",
    };
  }

  const day = parseInt(parts[0], 10);
  const monthSlug = parts.slice(1).join("-");
  const month = MONTH_SLUGS[monthSlug];

  if (!month || isNaN(day) || day < 1 || day > 31) {
    return {
      isValid: false,
      day: 1,
      month: 1,
      monthName: "Ocak",
      monthSlug: "ocak",
      formattedShort: "1 Ocak",
    };
  }

  const monthName = TURKISH_MONTHS[month] || "";

  return {
    isValid: true,
    day,
    month,
    monthName,
    monthSlug,
    formattedShort: `${day} ${monthName}`,
  };
}

/**
 * Returns previous and next day slugs for smooth calendar navigation
 */
export function getAdjacentDateSlugs(day: number, month: number): {
  prev: { day: number; month: number; slug: string; formatted: string };
  next: { day: number; month: number; slug: string; formatted: string };
} {
  const daysInMonths = [0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  // Previous day
  let prevDay = day - 1;
  let prevMonth = month;
  if (prevDay < 1) {
    prevMonth = month - 1;
    if (prevMonth < 1) prevMonth = 12;
    prevDay = daysInMonths[prevMonth];
  }

  // Next day
  let nextDay = day + 1;
  let nextMonth = month;
  if (nextDay > daysInMonths[month]) {
    nextDay = 1;
    nextMonth = month + 1;
    if (nextMonth > 12) nextMonth = 1;
  }

  const prevMonthSlug = NUMBER_TO_MONTH_SLUG[prevMonth];
  const nextMonthSlug = NUMBER_TO_MONTH_SLUG[nextMonth];

  return {
    prev: {
      day: prevDay,
      month: prevMonth,
      slug: `${prevDay}-${prevMonthSlug}`,
      formatted: `${prevDay} ${TURKISH_MONTHS[prevMonth]}`,
    },
    next: {
      day: nextDay,
      month: nextMonth,
      slug: `${nextDay}-${nextMonthSlug}`,
      formatted: `${nextDay} ${TURKISH_MONTHS[nextMonth]}`,
    },
  };
}

/**
 * Official Public Holidays in Turkey (2026)
 */
export interface PublicHolidayInfo {
  isHoliday: boolean;
  name: string;
  type: "resmi_tatil" | "dini_bayram" | "yarim_gun" | "is_gunu";
  details: string;
}

export function getPublicHolidayStatus(day: number, month: number): PublicHolidayInfo {
  // Official Fixed Holidays
  if (day === 1 && month === 1) {
    return {
      isHoliday: true,
      name: "Yılbaşı",
      type: "resmi_tatil",
      details: "1 Ocak Yılbaşı tüm kamu ve özel sektörde 1 tam gün resmî tatildir.",
    };
  }

  if (day === 23 && month === 4) {
    return {
      isHoliday: true,
      name: "Ulusal Egemenlik ve Çocuk Bayramı",
      type: "resmi_tatil",
      details: "23 Nisan Türkiye genelinde tam gün resmî tatildir. Okullar ve resmî daireler kapalıdır.",
    };
  }

  if (day === 1 && month === 5) {
    return {
      isHoliday: true,
      name: "Emek ve Dayanışma Günü",
      type: "resmi_tatil",
      details: "1 Mayıs Emek ve Dayanışma Günü tam gün resmî tatildir.",
    };
  }

  if (day === 19 && month === 5) {
    return {
      isHoliday: true,
      name: "Atatürk'ü Anma, Gençlik ve Spor Bayramı",
      type: "resmi_tatil",
      details: "19 Mayıs Türkiye genelinde tam gün resmî tatildir.",
    };
  }

  if (day === 15 && month === 7) {
    return {
      isHoliday: true,
      name: "15 Temmuz Demokrasi ve Milli Birlik Günü",
      type: "resmi_tatil",
      details: "15 Temmuz tam gün resmî tatildir.",
    };
  }

  if (day === 30 && month === 8) {
    return {
      isHoliday: true,
      name: "Zafer Bayramı",
      type: "resmi_tatil",
      details: "30 Ağustos Zafer Bayramı Türkiye genelinde tam gün resmî tatildir.",
    };
  }

  if (day === 28 && month === 10) {
    return {
      isHoliday: true,
      name: "Cumhuriyet Bayramı Arifesi",
      type: "yarim_gun",
      details: "28 Ekim öğleden sonra (saat 13:00 itibarıyla) yarım gün resmî tatildir.",
    };
  }

  if (day === 29 && month === 10) {
    return {
      isHoliday: true,
      name: "Cumhuriyet Bayramı",
      type: "resmi_tatil",
      details: "29 Ekim Cumhuriyet Bayramı Türkiye genelinde 1.5 günlük tatilin ana günü olup tam gün resmî tatildir.",
    };
  }

  // 2026 Ramazan Bayramı (Tahmini: 20-22 Mart 2026, 19 Mart Arife)
  if (month === 3 && day >= 19 && day <= 22) {
    return {
      isHoliday: true,
      name: day === 19 ? "Ramazan Bayramı Arifesi" : "Ramazan Bayramı",
      type: "dini_bayram",
      details: day === 19 ? "Ramazan Bayramı arifesi yarım gün tatildir." : "Ramazan Bayramı resmî tatildir.",
    };
  }

  // 2026 Kurban Bayramı (Tahmini: 27-30 Mayıs 2026, 26 Mayıs Arife)
  if (month === 5 && day >= 26 && day <= 30) {
    return {
      isHoliday: true,
      name: day === 26 ? "Kurban Bayramı Arifesi" : "Kurban Bayramı",
      type: "dini_bayram",
      details: day === 26 ? "Kurban Bayramı arifesi yarım gün tatildir." : "Kurban Bayramı resmî tatildir.",
    };
  }

  return {
    isHoliday: false,
    name: "Normal İş Günü",
    type: "is_gunu",
    details: `${day} ${TURKISH_MONTHS[month]} tarihinde Türkiye'de resmî tatil bulunmamaktadır. Tüm kamu ve özel kurumlar normal mesai düzenindedir.`,
  };
}

/**
 * Returns date slugs for all 365 days of the year (useful for sitemap and SSG)
 */
export function getAllYearDateSlugs(): string[] {
  const daysInMonths = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  const slugs: string[] = [];

  for (let m = 1; m <= 12; m++) {
    const monthSlug = NUMBER_TO_MONTH_SLUG[m];
    const days = daysInMonths[m];
    for (let d = 1; d <= days; d++) {
      slugs.push(`${d}-${monthSlug}`);
    }
  }

  return slugs;
}
