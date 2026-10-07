import React from "react";
import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import {
  Calendar,
  Home,
  ChevronLeft,
  ChevronRight,
  ShieldAlert,
  ShieldCheck,
  Info,
  CalendarDays,
  Sparkles,
  ArrowRight,
  HelpCircle,
} from "lucide-react";
import {
  parseDateSlug,
  getAdjacentDateSlugs,
  getPublicHolidayStatus,
  getAllYearDateSlugs,
} from "@/lib/date-engine";
import { getSpecialDaysByDate, getAllSpecialDays } from "@/lib/data/special-days-service";
import { getHistoryEventsForDate } from "@/lib/data/history-data";
import { MONTHS_METADATA } from "@/lib/data/special-days-data";
import { SpecialDayCard } from "@/components/day/SpecialDayCard";
import { CountdownTimer } from "@/components/day/CountdownTimer";
import { SocialShareCard } from "@/components/day/SocialShareCard";
import { HistoryOnThisDay } from "@/components/day/HistoryOnThisDay";
import { AddToCalendarButton } from "@/components/day/AddToCalendarButton";
import { specialDayToEventPayload } from "@/lib/calendar-engine";
import { Badge } from "@/components/ui/badge";
import { AdBanner } from "@/components/ads/AdBanner";
import { DayTriviaQuiz } from "@/components/trivia/DayTriviaQuiz";
import { getTriviaForDay } from "@/lib/data/trivia-data";

interface DatePageProps {
  params: Promise<{ daySlug: string }>;
}

export const dynamicParams = true;

// Pre-render prominent days of the year (or all 365)
export async function generateStaticParams() {
  const allSlugs = getAllYearDateSlugs();
  // Pre-render all days for ultra-fast static loading
  return allSlugs.map((daySlug) => ({
    daySlug,
  }));
}

export async function generateMetadata({
  params,
}: DatePageProps): Promise<Metadata> {
  const { daySlug } = await params;
  const parsed = parseDateSlug(daySlug);

  if (!parsed.isValid) {
    return {
      title: "Tarih Bulunamadı",
    };
  }

  const specialDays = await getSpecialDaysByDate(parsed.day, parsed.month);
  const holidayInfo = getPublicHolidayStatus(parsed.day, parsed.month);

  const specialDayNames = specialDays.map((d) => d.title).join(", ");
  const daySummary =
    specialDays.length > 0
      ? `${specialDayNames} ve tüm kutlama detayları.`
      : `Bugüne ait resmi tatil durumu ve tarihte bugün yaşanan olaylar.`;

  const title = `${parsed.formattedShort} Ne Günü? 2026 Özel Günler ve Tarihte Bugün`;
  const description = `${parsed.formattedShort} ne günü? ${parsed.formattedShort} 2026 resmi tatil mi? ${daySummary} Hazır kutlama mesajları ve tarihsel kronoloji.`;
  const canonicalUrl = `https://bugunnegunu.com/tarih/${daySlug}`;

  const primaryDay = specialDays[0];
  const ogTitle = primaryDay ? primaryDay.title : `${parsed.formattedShort} Ne Günü?`;
  const ogCat = primaryDay ? primaryDay.category : "Tarihte Bugün";
  const ogType = holidayInfo.isHoliday
    ? "resmi-tatil"
    : primaryDay?.day_type || "kutlama";

  const ogImageUrl = `https://bugunnegunu.com/api/og?title=${encodeURIComponent(
    ogTitle
  )}&date=${encodeURIComponent(`${parsed.formattedShort} 2026`)}&cat=${encodeURIComponent(
    ogCat
  )}&type=${encodeURIComponent(ogType)}&desc=${encodeURIComponent(
    daySummary
  )}`;

    return {
      title,
      description,
      keywords: [
        `${parsed.formattedShort} ne günü`,
        `${parsed.formattedShort} resmi tatil mi`,
        `${parsed.formattedShort} 2026`,
        `${parsed.formattedShort} tarihte bugün`,
        ...specialDays.map((d) => d.title),
      ],
      alternates: {
        canonical: canonicalUrl,
      },
      openGraph: {
        title,
        description,
        url: canonicalUrl,
        type: "website",
        locale: "tr_TR",
        siteName: "Bugün Ne Günü?",
        images: [
          {
            url: ogImageUrl,
            width: 1200,
            height: 630,
            alt: title,
          },
        ],
      },
      twitter: {
        card: "summary_large_image",
        title,
        description,
        images: [ogImageUrl],
      },
    };
  }

export default async function DateDetailPage({ params }: DatePageProps) {
  const { daySlug } = await params;
  const parsed = parseDateSlug(daySlug);

  if (!parsed.isValid) {
    notFound();
  }

  const { day, month, formattedShort, monthSlug, monthName } = parsed;

  // Adjacent days navigation
  const adjacent = getAdjacentDateSlugs(day, month);

  // Fetch special days for this exact date
  const specialDays = await getSpecialDaysByDate(day, month);

  // Holiday status
  const holidayInfo = getPublicHolidayStatus(day, month);

  // History events on this day
  const historyEvents = getHistoryEventsForDate(day, month);

  const monthMeta = MONTHS_METADATA.find((m) => m.number === month);

  // Primary day for social card & countdown
  const primaryDay = specialDays.length > 0 ? specialDays[0] : null;

  // Curated or rotating trivia for this date
  const dateTrivia = getTriviaForDay({
    slug: primaryDay?.slug,
    month,
    day,
  });

  // JSON-LD structured data
  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "CollectionPage",
    name: `${formattedShort} Ne Günü? 2026 Takvimi`,
    description: `${formattedShort} özel günleri, resmi tatil bilgisi ve tarihte bugün yaşananlar.`,
    url: `https://bugunnegunu.com/tarih/${daySlug}`,
    breadcrumb: {
      "@type": "BreadcrumbList",
      itemListElement: [
        {
          "@type": "ListItem",
          position: 1,
          name: "Ana Sayfa",
          item: "https://bugunnegunu.com",
        },
        {
          "@type": "ListItem",
          position: 2,
          name: `${monthName} Ayı`,
          item: `https://bugunnegunu.com/aylar/${monthSlug}`,
        },
        {
          "@type": "ListItem",
          position: 3,
          name: formattedShort,
          item: `https://bugunnegunu.com/tarih/${daySlug}`,
        },
      ],
    },
  };

  return (
    <div className="min-h-screen pb-20">
      {/* JSON-LD Schema */}
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
      />

      {/* 1. Header & Navigation */}
      <section className="border-b border-zinc-200/80 bg-gradient-to-b from-red-50/40 via-white to-zinc-50/30 py-8 sm:py-12 dark:border-zinc-800 dark:from-red-950/20 dark:via-zinc-950 dark:to-zinc-900">
        <div className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8">
          {/* Breadcrumb Navigation */}
          <nav aria-label="Breadcrumb" className="flex items-center gap-2 text-xs text-zinc-500 mb-6 flex-wrap">
            <Link href="/" className="hover:text-red-600 transition-colors flex items-center gap-1">
              <Home className="h-3.5 w-3.5" />
              <span>Ana Sayfa</span>
            </Link>
            <span>/</span>
            <Link href={`/aylar/${monthSlug}`} className="hover:text-red-600 transition-colors">
              {monthName} Ayı
            </Link>
            <span>/</span>
            <span className="font-semibold text-zinc-900 dark:text-zinc-100">
              {formattedShort}
            </span>
          </nav>

          {/* Prev/Next Day Quick Controls */}
          <div className="flex items-center justify-between border-b border-zinc-100 pb-4 dark:border-zinc-800 mb-6 text-xs font-semibold text-zinc-600 dark:text-zinc-400">
            <Link
              href={`/tarih/${adjacent.prev.slug}`}
              className="inline-flex items-center gap-1 rounded-xl px-3 py-1.5 hover:bg-zinc-100 hover:text-zinc-900 dark:hover:bg-zinc-800 dark:hover:text-white transition-colors"
            >
              <ChevronLeft className="h-4 w-4" />
              <span>Önceki Gün: {adjacent.prev.formatted}</span>
            </Link>

            <Link
              href={`/tarih/${adjacent.next.slug}`}
              className="inline-flex items-center gap-1 rounded-xl px-3 py-1.5 hover:bg-zinc-100 hover:text-zinc-900 dark:hover:bg-zinc-800 dark:hover:text-white transition-colors"
            >
              <span>Sonraki Gün: {adjacent.next.formatted}</span>
              <ChevronRight className="h-4 w-4" />
            </Link>
          </div>

          {/* Hero Content */}
          <div className="flex flex-col md:flex-row md:items-end justify-between gap-6">
            <div>
              <div className="inline-flex items-center gap-2 rounded-full bg-red-50 px-3.5 py-1 text-xs font-bold text-red-600 dark:bg-red-950/40 dark:text-red-400 border border-red-200/60 dark:border-red-900/60 mb-3">
                <Calendar className="h-3.5 w-3.5" />
                <span>2026 Takvimi • {day} {monthName}</span>
              </div>

              <h1 className="text-3xl sm:text-5xl font-black tracking-tight text-zinc-950 dark:text-white">
                {formattedShort} Ne Günü<span className="text-red-600">?</span>
              </h1>

              <p className="mt-3 text-base sm:text-lg text-zinc-600 dark:text-zinc-300 max-w-2xl leading-relaxed">
                {specialDays.length > 0
                  ? `${formattedShort} tarihinde ${specialDays.map((d) => d.title).join(" ve ")} idrak edilmektedir.`
                  : `${formattedShort} tarihine ait resmi tatil bilgisi, tarihte bugün yaşanan olaylar ve takvim detayları.`}
              </p>

              <div className="mt-5 flex flex-wrap items-center gap-3">
                <AddToCalendarButton
                  events={
                    specialDays.length > 0
                      ? specialDays.map((d) => specialDayToEventPayload(d))
                      : [
                          {
                            title: `${formattedShort} Takvimi`,
                            description: holidayInfo.details,
                            dayNo: day,
                            monthNo: month,
                            url: `https://bugunnegunu.com/tarih/${daySlug}`,
                          },
                        ]
                  }
                  buttonText={
                    specialDays.length > 0
                      ? `${formattedShort} Gününü Takvime Ekle`
                      : "Bu Tarihi Takvime Ekle"
                  }
                  calendarTitle={`${formattedShort} Takvimi`}
                  variant="default"
                />
              </div>
            </div>
          </div>

          {/* 2. Official Holiday Status Banner */}
          <div className="mt-8">
            {holidayInfo.isHoliday ? (
              <div className="rounded-2xl border border-emerald-200 bg-emerald-50/70 p-5 dark:border-emerald-900/60 dark:bg-emerald-950/30 flex items-start gap-3.5">
                <ShieldCheck className="h-6 w-6 text-emerald-600 dark:text-emerald-400 shrink-0 mt-0.5" />
                <div>
                  <h3 className="font-bold text-emerald-950 dark:text-emerald-200 text-base">
                    ✅ {formattedShort} Resmî Tatil mi? — EVET ({holidayInfo.name})
                  </h3>
                  <p className="mt-1 text-xs sm:text-sm text-emerald-800 dark:text-emerald-300/90 leading-relaxed">
                    {holidayInfo.details}
                  </p>
                </div>
              </div>
            ) : (
              <div className="rounded-2xl border border-zinc-200 bg-zinc-50 p-5 dark:border-zinc-800 dark:bg-zinc-900/50 flex items-start gap-3.5">
                <Info className="h-5 w-5 text-zinc-500 shrink-0 mt-0.5" />
                <div>
                  <h3 className="font-bold text-zinc-900 dark:text-zinc-100 text-sm sm:text-base">
                    ℹ️ {formattedShort} Resmî Tatil mi? — Hayır (Normal Mesai Günü)
                  </h3>
                  <p className="mt-1 text-xs sm:text-sm text-zinc-600 dark:text-zinc-400 leading-relaxed">
                    {holidayInfo.details}
                  </p>
                </div>
              </div>
            )}
          </div>
        </div>
      </section>

      {/* Top AdSense Banner */}
      <div className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 mt-6">
        <AdBanner slotId={`tarih-${daySlug}-top`} format="horizontal" />
      </div>

      {/* 3. Live Countdown Timer Section */}
      <section className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 mt-8">
        <CountdownTimer
          targetMonth={month}
          targetDay={day}
          title={primaryDay ? primaryDay.title : `${formattedShort} Günü`}
          dayType={primaryDay?.day_type || "kutlama"}
        />
      </section>

      {/* 4. Special Days on This Date */}
      <section className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 mt-12">
        <div className="flex items-center justify-between mb-6">
          <div className="flex items-center gap-2">
            <span className="flex h-3 w-3 rounded-full bg-red-600" />
            <h2 className="text-xl sm:text-2xl font-black text-zinc-900 dark:text-zinc-100">
              {formattedShort} Özel Günleri ({specialDays.length})
            </h2>
          </div>

          <Link
            href={`/aylar/${monthSlug}`}
            className="text-xs font-bold text-red-600 hover:underline flex items-center gap-1"
          >
            <span>{monthName} Ayı Takvimi</span>
            <ArrowRight className="h-3 w-3" />
          </Link>
        </div>

        {specialDays.length > 0 ? (
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {specialDays.map((dayItem) => (
              <SpecialDayCard key={dayItem.id} day={dayItem} />
            ))}
          </div>
        ) : (
          <div className="rounded-3xl border border-dashed border-zinc-300 bg-zinc-50/70 p-8 text-center dark:border-zinc-800 dark:bg-zinc-900/30">
            <CalendarDays className="mx-auto h-10 w-10 text-zinc-400 mb-3" />
            <h3 className="text-base font-bold text-zinc-800 dark:text-zinc-200">
              Bu tarihe kayıtlı özel bir bayram veya uluslararası gün bulunmamaktadır.
            </h3>
            <p className="mt-1 text-xs text-zinc-500 max-w-md mx-auto">
              {monthName} ayındaki diğer tüm özel günleri ve kutlamaları incelemek için ay rehberimize göz atabilirsiniz.
            </p>
            <div className="mt-4">
              <Link
                href={`/aylar/${monthSlug}`}
                className="inline-flex items-center gap-1.5 rounded-xl bg-red-600 px-4 py-2 text-xs font-bold text-white hover:bg-red-700 transition-colors"
              >
                <span>{monthName} Ayı Özel Günleri</span>
                <ArrowRight className="h-3.5 w-3.5" />
              </Link>
            </div>
          </div>
        )}
      </section>

      {/* 5. History on This Day Section */}
      <section className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 mt-14">
        <HistoryOnThisDay events={historyEvents} formattedDate={formattedShort} />
      </section>

      {/* 5.5. Günün Bilgi Yarışması (Interactive Trivia / Quiz) */}
      <section className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 mt-14">
        <DayTriviaQuiz question={dateTrivia} />
      </section>

      {/* 6. Social Media Shareable Card */}
      <section className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 mt-14">
        <SocialShareCard
          title={primaryDay ? primaryDay.title : `${formattedShort} Günü`}
          formattedDate={`${formattedShort} 2026`}
          category={primaryDay ? primaryDay.category : "Günün Anlamı"}
          dayType={primaryDay?.day_type || "kutlama"}
          hashtags={primaryDay?.hashtags || [`#${formattedShort.replace(/\s+/g, "")}`, "#BugunNeGunu"]}
          slug={daySlug}
        />
      </section>

      {/* Middle In-Article Ad Banner */}
      <div className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 mt-12">
        <AdBanner slotId={`tarih-${daySlug}-middle`} format="in-article" />
      </div>

      {/* 7. FAQ Section */}
      <section className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 mt-14">
        <div className="flex items-center gap-2 mb-6">
          <HelpCircle className="h-5 w-5 text-red-600" />
          <h2 className="text-xl sm:text-2xl font-black text-zinc-900 dark:text-zinc-100">
            {formattedShort} Hakkında Sıkça Sorulan Sorular
          </h2>
        </div>

        <div className="space-y-4">
          <div className="rounded-2xl border border-zinc-200 bg-white p-6 dark:border-zinc-800 dark:bg-zinc-900">
            <h3 className="font-bold text-base text-zinc-900 dark:text-zinc-100">
              {formattedShort} 2026 resmî tatil mi?
            </h3>
            <p className="mt-2 text-sm text-zinc-600 dark:text-zinc-400 leading-relaxed">
              {holidayInfo.details}
            </p>
          </div>

          <div className="rounded-2xl border border-zinc-200 bg-white p-6 dark:border-zinc-800 dark:bg-zinc-900">
            <h3 className="font-bold text-base text-zinc-900 dark:text-zinc-100">
              {formattedShort} hangi güne denk geliyor?
            </h3>
            <p className="mt-2 text-sm text-zinc-600 dark:text-zinc-400 leading-relaxed">
              2026 takviminde {formattedShort} günü için haftanın gününü ve yaklaşan etkinlikleri yukarıdaki geri sayım sayacından canlı olarak takip edebilirsiniz.
            </p>
          </div>
        </div>
      </section>
    </div>
  );
}
