import React from "react";
import Link from "next/link";
import {
  CalendarDays,
  Sparkles,
  Calendar,
  ArrowRight,
  TrendingUp,
  Search,
  CheckCircle2,
  Gift,
  Flame,
  Clock,
} from "lucide-react";
import {
  getTodaySpecialDays,
  getUpcomingSpecialDays,
  getAllSpecialDays,
} from "@/lib/data/special-days-service";
import { MONTHS_METADATA } from "@/lib/data/special-days-data";
import { SpecialDayCard } from "@/components/day/SpecialDayCard";
import { CountdownTimer } from "@/components/day/CountdownTimer";
import { AdBanner } from "@/components/ads/AdBanner";
import { Badge } from "@/components/ui/badge";
import { TURKISH_MONTHS } from "@/lib/utils";
import { getTurkeyToday, getPublicHolidayStatus } from "@/lib/date-engine";

// Edge/ISR revalidation interval (1 hour)
export const revalidate = 3600;

export default async function HomePage() {
  const turkeyToday = getTurkeyToday();
  const currentMonthNo = turkeyToday.month;
  const currentDayNo = turkeyToday.day;
  const formattedToday = turkeyToday.formattedFull;

  // Fetch data from unified engine
  const todayDays = await getTodaySpecialDays();
  const upcomingDays = await getUpcomingSpecialDays(6);
  const allDays = await getAllSpecialDays();

  // Flagship upcoming highlight (closest major upcoming day)
  const nextMajorDay = upcomingDays.length > 0 ? upcomingDays[0] : null;

  // Holiday status for today
  const todayHolidayInfo = getPublicHolidayStatus(currentDayNo, currentMonthNo);

  return (
    <div className="min-h-screen pb-16">
      {/* 1. Hero Section */}
      <section className="relative overflow-hidden bg-gradient-to-b from-red-50/70 via-white to-zinc-50/50 py-14 sm:py-20 border-b border-zinc-200/60 dark:from-red-950/20 dark:via-zinc-950 dark:to-zinc-900/40 dark:border-zinc-800">
        {/* Ambient glow */}
        <div className="pointer-events-none absolute left-1/2 top-0 -translate-x-1/2 h-96 w-full max-w-7xl -z-10">
          <div className="absolute top-8 left-1/4 h-72 w-72 rounded-full bg-red-400/10 blur-3xl dark:bg-red-600/10" />
          <div className="absolute top-12 right-1/4 h-80 w-80 rounded-full bg-amber-400/10 blur-3xl dark:bg-amber-600/10" />
        </div>

        <div className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 text-center">
          {/* Today Date Badge with link to date page */}
          <Link
            href={`/tarih/${turkeyToday.dateSlug}`}
            className="inline-flex items-center gap-2 rounded-full bg-white px-4 py-2 text-xs sm:text-sm font-bold text-zinc-800 shadow-sm border border-zinc-200/80 hover:border-red-300 dark:bg-zinc-900 dark:border-zinc-800 dark:text-zinc-200 mb-6 transition-all group"
          >
            <span className="flex h-2.5 w-2.5 rounded-full bg-red-600 animate-pulse" />
            <Calendar className="h-4 w-4 text-red-600" />
            <span>
              Bugün: <span className="text-red-600 font-black">{formattedToday}</span>
            </span>
            <ArrowRight className="h-3.5 w-3.5 text-zinc-400 group-hover:translate-x-0.5 group-hover:text-red-600 transition-all ml-1" />
          </Link>

          <h1 className="text-4xl sm:text-6xl md:text-7xl font-black tracking-tight text-zinc-950 dark:text-white leading-[1.08]">
            Bugün Ne Günü<span className="text-red-600">?</span>
          </h1>

          <p className="mt-4 sm:mt-6 text-base sm:text-xl text-zinc-600 dark:text-zinc-400 max-w-2xl mx-auto leading-relaxed">
            Türkiye ve dünyada bugün kutlanan resmi bayramlar, uluslararası farkındalık günleri, kutlama mesajları ve takvim rehberi.
          </p>

          {/* Quick CTA & Stats */}
          <div className="mt-8 flex flex-wrap items-center justify-center gap-3 text-xs sm:text-sm font-medium text-zinc-600 dark:text-zinc-400">
            <span className="inline-flex items-center gap-1.5 rounded-xl bg-zinc-100 dark:bg-zinc-800/60 px-3.5 py-1.5 border border-zinc-200/60 dark:border-zinc-700/60">
              <CheckCircle2 className="h-4 w-4 text-emerald-500" />
              Bugün {todayDays.length} Özel Gün
            </span>
            <span className="inline-flex items-center gap-1.5 rounded-xl bg-zinc-100 dark:bg-zinc-800/60 px-3.5 py-1.5 border border-zinc-200/60 dark:border-zinc-700/60">
              <Flame className="h-4 w-4 text-amber-500" />
              {allDays.length}+ Doğrulanmış Kayıt
            </span>
            <span className="inline-flex items-center gap-1.5 rounded-xl bg-zinc-100 dark:bg-zinc-800/60 px-3.5 py-1.5 border border-zinc-200/60 dark:border-zinc-700/60">
              <Gift className="h-4 w-4 text-rose-500" />
              Sosyal Medya Kartları
            </span>
          </div>
        </div>
      </section>

      {/* Leaderboard Ad Placeholder */}
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 mt-6">
        <AdBanner slotId="home-top-leaderboard" format="horizontal" />
      </div>

      {/* 2. Today's Special Days Section */}
      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 mt-10">
        <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-4 mb-8">
          <div>
            <div className="flex items-center gap-2">
              <span className="flex h-3 w-3 rounded-full bg-red-600" />
              <span className="text-xs font-bold uppercase tracking-widest text-red-600">
                Günün Anlam ve Önemi
              </span>
            </div>
            <h2 className="mt-1 text-2xl sm:text-3xl font-black text-zinc-900 dark:text-zinc-50">
              Bugün Kutlanan Özel Günler ({turkeyToday.formattedShort})
            </h2>
          </div>

          <div className="flex items-center gap-3">
            <Link
              href={`/tarih/${turkeyToday.dateSlug}`}
              className="inline-flex items-center gap-1.5 text-xs sm:text-sm font-bold text-zinc-700 hover:text-zinc-900 dark:text-zinc-300 group bg-zinc-100 dark:bg-zinc-800 px-3 py-1.5 rounded-xl"
            >
              <span>{turkeyToday.formattedShort} Tarih Sayfası</span>
              <ArrowRight className="h-3.5 w-3.5 group-hover:translate-x-0.5 transition-transform" />
            </Link>

            <Link
              href={`/aylar/${MONTHS_METADATA.find((m) => m.number === currentMonthNo)?.slug || "ekim"}`}
              className="inline-flex items-center gap-1.5 text-xs sm:text-sm font-bold text-red-600 hover:text-red-700 dark:text-red-400 group"
            >
              <span>{TURKISH_MONTHS[currentMonthNo]} Ayı Tüm Günleri</span>
              <ArrowRight className="h-4 w-4 group-hover:translate-x-1 transition-transform" />
            </Link>
          </div>
        </div>

        {todayDays.length > 0 ? (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-2 gap-6">
            {todayDays.map((day) => (
              <SpecialDayCard key={day.id} day={day} isToday={true} />
            ))}
          </div>
        ) : (
          <div className="rounded-3xl border border-zinc-200 bg-zinc-50/60 p-10 text-center dark:border-zinc-800 dark:bg-zinc-900/40">
            <CalendarDays className="mx-auto h-12 w-12 text-zinc-400" />
            <h3 className="mt-4 text-lg font-bold text-zinc-900 dark:text-zinc-100">
              Bugüne kayıtlı özel bir resmi bayram bulunmuyor
            </h3>
            <p className="mt-2 text-sm text-zinc-500 max-w-md mx-auto">
              Bugün {todayHolidayInfo.details} Yaklaşan özel günlere göz atabilir veya bu ayın takvimini inceleyebilirsiniz.
            </p>
          </div>
        )}
      </section>

      {/* 3. Dynamic Next Major Day Highlight & Countdown */}
      {nextMajorDay && (
        <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 mt-16">
          <div className="relative overflow-hidden rounded-3xl bg-gradient-to-r from-red-600 via-rose-600 to-amber-600 p-8 md:p-12 text-white shadow-xl">
            <div className="relative z-10 max-w-2xl">
              <Badge variant="secondary" className="bg-white/20 text-white border-white/30 text-xs backdrop-blur-sm">
                <Sparkles className="h-3 w-3 mr-1" />
                Gündemdeki Yaklaşan Gün
              </Badge>
              <h3 className="mt-4 text-3xl sm:text-4xl font-black leading-tight">
                {nextMajorDay.title} Yaklaşıyor!
              </h3>
              <p className="mt-3 text-white/90 text-sm sm:text-base leading-relaxed">
                {nextMajorDay.description}
              </p>
              <div className="mt-6 flex flex-wrap items-center gap-4">
                <Link
                  href={`/gun/${nextMajorDay.slug}`}
                  className="inline-flex items-center gap-2 rounded-xl bg-white px-6 py-3 text-sm font-bold text-zinc-900 shadow-md hover:bg-zinc-100 transition-all hover:scale-105"
                >
                  <span>Rehberi ve Mesajları İncele</span>
                  <ArrowRight className="h-4 w-4" />
                </Link>
                <Link
                  href={`/tarih/${nextMajorDay.day_no}-${MONTHS_METADATA.find((m) => m.number === nextMajorDay.month_no)?.slug}`}
                  className="inline-flex items-center gap-2 rounded-xl bg-black/20 px-5 py-3 text-sm font-bold text-white border border-white/20 hover:bg-black/30 transition-all backdrop-blur-sm"
                >
                  <span>{nextMajorDay.day_no} {TURKISH_MONTHS[nextMajorDay.month_no]} Tarih Sayfası</span>
                </Link>
              </div>
            </div>
          </div>
        </section>
      )}

      {/* 4. Upcoming Days Section (Strictly Future Chronological) */}
      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 mt-16">
        <div className="flex items-center justify-between mb-8">
          <div>
            <div className="flex items-center gap-2">
              <TrendingUp className="h-4 w-4 text-amber-500" />
              <span className="text-xs font-bold uppercase tracking-widest text-zinc-500">
                Takviminizi Planlayın
              </span>
            </div>
            <h2 className="mt-1 text-2xl sm:text-3xl font-black text-zinc-900 dark:text-zinc-50">
              Yaklaşan Özel Günler ve Kutlamalar
            </h2>
          </div>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          {upcomingDays.map((day) => (
            <SpecialDayCard key={day.id} day={day} />
          ))}
        </div>
      </section>

      {/* In-Article Ad Banner */}
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 mt-12">
        <AdBanner slotId="home-middle-responsive" format="in-article" />
      </div>

      {/* 5. Month Pillar Hubs Navigation */}
      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 mt-16">
        <div className="text-center max-w-2xl mx-auto mb-10">
          <Badge variant="secondary" className="mb-2">12 Ayın Rehberi</Badge>
          <h2 className="text-2xl sm:text-3xl font-black text-zinc-900 dark:text-zinc-50">
            Aylara Göre Özel Günler Takvimi
          </h2>
          <p className="mt-2 text-sm text-zinc-500">
            İstediğiniz aya tıklayarak o ayda yer alan tüm ulusal, uluslararası ve tematik özel günleri listeleyin.
          </p>
        </div>

        <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-6 gap-3 sm:gap-4">
          {MONTHS_METADATA.map((month) => {
            const isCurrentMonth = month.number === currentMonthNo;
            return (
              <Link
                key={month.slug}
                href={`/aylar/${month.slug}`}
                className={`group relative flex flex-col justify-between rounded-2xl border p-4 text-center transition-all duration-200 hover:-translate-y-1 hover:shadow-md ${
                  isCurrentMonth
                    ? "border-red-400 bg-red-50/50 shadow-sm dark:border-red-800 dark:bg-red-950/20"
                    : "border-zinc-200/80 bg-white hover:border-zinc-300 dark:border-zinc-800 dark:bg-zinc-900"
                }`}
              >
                <div>
                  <span className="text-[10px] font-bold uppercase tracking-wider text-zinc-400">
                    {month.number}. Ay • {month.season}
                  </span>
                  <h3 className="mt-1 font-black text-base sm:text-lg text-zinc-900 group-hover:text-red-600 transition-colors dark:text-zinc-100">
                    {month.name}
                  </h3>
                </div>

                <div className="mt-4 pt-2 border-t border-zinc-100 dark:border-zinc-800 flex items-center justify-between text-[11px] text-zinc-500">
                  <span>{month.daysCount} Gün</span>
                  <ArrowRight className="h-3 w-3 opacity-0 group-hover:opacity-100 transition-opacity text-red-600" />
                </div>
              </Link>
            );
          })}
        </div>
      </section>

      {/* 6. FAQ Section for SEO */}
      <section className="mx-auto max-w-4xl px-4 sm:px-6 lg:px-8 mt-20">
        <div className="text-center mb-10">
          <Badge variant="secondary">Sıkça Sorulan Sorular</Badge>
          <h2 className="mt-2 text-2xl sm:text-3xl font-black text-zinc-900 dark:text-zinc-100">
            Özel Günler ve Bayramlar Hakkında Merak Edilenler
          </h2>
          <p className="mt-2 text-sm text-zinc-500">
            2026 yılı takvimi, bayram tatilleri ve özel günler hakkında en çok aratılan soruların yanıtları.
          </p>
        </div>

        <div className="space-y-4">
          <div className="rounded-2xl border border-zinc-200 bg-white p-6 dark:border-zinc-800 dark:bg-zinc-900">
            <h3 className="font-bold text-base text-zinc-900 dark:text-zinc-100">
              Bugün hangi özel gün kutlanıyor?
            </h3>
            <p className="mt-2 text-sm text-zinc-600 dark:text-zinc-400 leading-relaxed">
              Bugün ({turkeyToday.formattedShort}) tarihinde{" "}
              {todayDays.length > 0 ? (
                <span>
                  <strong>{todayDays.map((d) => d.title).join(", ")}</strong> yer almaktadır. Sayfamızın üst bölümünden günün detaylarına ve hazır paylaşım kartlarına ulaşabilirsiniz.
                </span>
              ) : (
                <span>
                  Türkiye'de resmî bir tatil bulunmamaktadır. Yaklaşan ilk önemli gün ise <strong>{nextMajorDay?.title}</strong> olacaktır.
                </span>
              )}
            </p>
          </div>

          <div className="rounded-2xl border border-zinc-200 bg-white p-6 dark:border-zinc-800 dark:bg-zinc-900">
            <h3 className="font-bold text-base text-zinc-900 dark:text-zinc-100">
              Bugün resmî tatil mi?
            </h3>
            <p className="mt-2 text-sm text-zinc-600 dark:text-zinc-400 leading-relaxed">
              {todayHolidayInfo.details}
            </p>
          </div>

          <div className="rounded-2xl border border-zinc-200 bg-white p-6 dark:border-zinc-800 dark:bg-zinc-900">
            <h3 className="font-bold text-base text-zinc-900 dark:text-zinc-100">
              2026 yılında 29 Ekim Cumhuriyet Bayramı hangi güne denk geliyor?
            </h3>
            <p className="mt-2 text-sm text-zinc-600 dark:text-zinc-400 leading-relaxed">
              2026 yılında 29 Ekim Cumhuriyet Bayramı Perşembe gününe denk gelmektedir. Türkiye genelinde resmi tatil olarak coşkuyla kutlanacaktır.
            </p>
          </div>
        </div>
      </section>
    </div>
  );
}
