import { SpecialDay } from "@/types/database";

export interface CalendarEventPayload {
  title: string;
  description: string;
  dayNo: number;
  monthNo: number;
  year?: number;
  url?: string;
  category?: string;
}

/**
 * Formats a date into YYYYMMDD string for all-day iCal events
 */
function formatIcsDate(year: number, month: number, day: number): string {
  const y = String(year);
  const m = String(month).padStart(2, "0");
  const d = String(day).padStart(2, "0");
  return `${y}${m}${d}`;
}

/**
 * Calculates next day for all-day event end date (RFC 5545 requirement)
 */
function getNextDayIcsDate(year: number, month: number, day: number): string {
  const date = new Date(year, month - 1, day);
  date.setDate(date.getDate() + 1);
  return formatIcsDate(date.getFullYear(), date.getMonth() + 1, date.getDate());
}

/**
 * Generates Google Calendar web link for instant browser-based scheduling
 */
export function generateGoogleCalendarUrl(payload: CalendarEventPayload): string {
  const year = payload.year || 2026;
  const startDateStr = formatIcsDate(year, payload.monthNo, payload.dayNo);
  const endDateStr = getNextDayIcsDate(year, payload.monthNo, payload.dayNo);

  const cleanDescription = `${payload.description}\n\nDetaylar ve Mesajlar: ${payload.url || "https://bugunnegunu.com"}\nKaynak: Bugün Ne Günü? Takvim Rehberi`;

  const params = new URLSearchParams({
    action: "TEMPLATE",
    text: payload.title,
    dates: `${startDateStr}/${endDateStr}`,
    details: cleanDescription,
    location: "Türkiye / Küresel",
    sprop: "website:bugunnegunu.com",
  });

  return `https://calendar.google.com/calendar/render?${params.toString()}`;
}

/**
 * Generates RFC 5545 compliant .ics file content for single or multiple events
 */
export function generateIcsContent(
  events: CalendarEventPayload[],
  calendarTitle: string = "Bugün Ne Günü Özel Günler Takvimi"
): string {
  const now = new Date();
  const dtStamp = now.toISOString().replace(/[-:]/g, "").split(".")[0] + "Z";

  let ics = [
    "BEGIN:VCALENDAR",
    "VERSION:2.0",
    "PRODID:-//Bugun Ne Gunu//TR",
    "CALSCALE:GREGORIAN",
    "METHOD:PUBLISH",
    `X-WR-CALNAME:${calendarTitle}`,
    "X-WR-TIMEZONE:Europe/Istanbul",
  ];

  events.forEach((event, index) => {
    const year = event.year || 2026;
    const dtStart = formatIcsDate(year, event.monthNo, event.dayNo);
    const dtEnd = getNextDayIcsDate(year, event.monthNo, event.dayNo);
    const uid = `${year}-${event.monthNo}-${event.dayNo}-${index}@bugunnegunu.com`;

    // Escape special iCal characters
    const summary = event.title.replace(/[,;\\]/g, "\\$&");
    const description = (
      `${event.description}\\n\\nDetaylar: ${event.url || "https://bugunnegunu.com"}`
    )
      .replace(/\r?\n/g, "\\n")
      .replace(/[,;]/g, "\\$&");

    ics.push(
      "BEGIN:VEVENT",
      `UID:${uid}`,
      `DTSTAMP:${dtStamp}`,
      `DTSTART;VALUE=DATE:${dtStart}`,
      `DTEND;VALUE=DATE:${dtEnd}`,
      `SUMMARY:${summary}`,
      `DESCRIPTION:${description}`,
      `URL:${event.url || "https://bugunnegunu.com"}`,
      "STATUS:CONFIRMED",
      "TRANSP:TRANSPARENT",
      "END:VEVENT"
    );
  });

  ics.push("END:VCALENDAR");

  return ics.join("\r\n");
}

/**
 * Triggers a browser download of an .ics calendar file
 */
export function triggerIcsDownload(filename: string, content: string): void {
  const blob = new Blob([content], { type: "text/calendar;charset=utf-8" });
  const url = URL.createObjectURL(blob);
  const link = document.createElement("a");
  link.href = url;
  link.setAttribute("download", filename.endsWith(".ics") ? filename : `${filename}.ics`);
  document.body.appendChild(link);
  link.click();
  document.body.removeChild(link);
  URL.revokeObjectURL(url);
}

/**
 * Convert SpecialDay object to CalendarEventPayload
 */
export function specialDayToEventPayload(day: SpecialDay, year: number = 2026): CalendarEventPayload {
  return {
    title: day.title,
    description: day.description,
    dayNo: day.day_no,
    monthNo: day.month_no,
    year,
    url: `https://bugunnegunu.com/gun/${day.slug}`,
    category: day.category,
  };
}
