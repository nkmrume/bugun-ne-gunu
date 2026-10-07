import React from "react";
import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import {
  Calendar,
  ChevronLeft,
  ChevronRight,
  ArrowRight,
  Sparkles,
  Home,
  CheckCircle2,
} from "lucide-react";
import { MONTHS_METADATA } from "@/lib/data/special-days-data";
import { getSpecialDaysByMonth } from "@/lib/data/special-days-service";
import { SpecialDayCard } from "@/components/day/SpecialDayCard";
import { AddToCalendarButton } from "@/components/day/AddToCalendarButton";
import { specialDayToEventPayload } from "@/lib/calendar-engine";
import { AdBanner } from "@/components/ads/AdBanner";
import { Badge } from "@/components/ui/badge";
import { MONTH_SLUGS, NUMBER_TO_MONTH_SLUG } from "@/lib/utils";

interface MonthPageProps {
  params: Promise<{ monthSlug: string }>;
}

export async function generateStaticParams() {
  return MONTHS_METADATA.map((month) => ({
    monthSlug: month.slug,
  }));
}

export async function generateMetadata({
  params,
}: MonthPageProps): Promise<Metadata> {
  const { monthSlug } = await params;
  const monthNo = MONTH_SLUGS[monthSlug.toLowerCase()];
  const monthMeta = MONTHS_METADATA.find((m) => m.number === monthNo);

  if (!monthMeta) {
    return {
      title: "Ay Bulunamadı",
    };
  }

  const title = `${monthMeta.name} Ayı Özel Günleri ve Haftaları 2026`;
  const description = `${monthMeta.name} ayında hangi özel günler ve resmi tatiller var? 2026 ${monthMeta.name} ayı önemli günler takvimi, etkinlik fikirleri ve kutlama mesajları.`;

  const ogImageUrl = `https://bugunnegunu.com/api/og?title=${encodeURIComponent(
    `${monthMeta.name} Ayı Özel Günleri 2026`
  )}&date=${encodeURIComponent(`${monthMeta.name} 2026`)}&cat=${encodeURIComponent(
    `${monthMeta.season} Mevsimi`
  )}&type=kutlama&desc=${encodeURIComponent(description)}`;

  return {
    title,
    description,
    alternates: {
      canonical: `https://bugunnegunu.com/aylar/${monthMeta.slug}`,
    },
    openGraph: {
      title,
      description,
      url: `https://bugunnegunu.com/aylar/${monthMeta.slug}`,
      type: "website",
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

export default async function MonthPillarPage({ params }: MonthPageProps) {
  const { monthSlug } = await params;
  const monthNo = MONTH_SLUGS[monthSlug.toLowerCase()];
  const monthMeta = MONTHS_METADATA.find((m) => m.number === monthNo);

  if (!monthMeta || !monthNo) {
    notFound();
  }

  const specialDays = await getSpecialDaysByMonth(monthNo);

  // Prev / Next month calculation
  const prevMonthNo = monthNo === 1 ? 12 : monthNo - 1;
  const nextMonthNo = monthNo === 12 ? 1 : monthNo + 1;
  const prevMonthMeta = MONTHS_METADATA.find((m) => m.number === prevMonthNo)!;
  const nextMonthMeta = MONTHS_METADATA.find((m) => m.number === nextMonthNo)!;

  // Collection JSON-LD Schema
  const collectionSchema = {
    "@context": "https://schema.org",
    "@type": "CollectionPage",
    name: `${monthMeta.name} Ayı Özel Günleri 2026`,
    description: monthMeta.description,
    url: `https://bugunnegunu.com/aylar/${monthMeta.slug}`,
    hasPart: specialDays.map((day) => ({
      "@type": "Event",
      name: day.title,
      startDate: day.celebration_date,
      url: `https://bugunnegunu.com/gun/${day.slug}`,
    })),
  };

  const breadcrumbSchema = {
    "@context": "https://schema.org",
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
        name: "Aylar",
        item: "https://bugunnegunu.com/#aylar",
      },
      {
        "@type": "ListItem",
        position: 3,
        name: `${monthMeta.name} Ayı`,
        item: `https://bugunnegunu.com/aylar/${monthMeta.slug}`,
      },
    ],
  };

  return (
    <div className="min-h-screen pb-20">
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(collectionSchema) }}
      />
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(breadcrumbSchema) }}
      />

      {/* Header & Breadcrumb Hero */}
      <section className="border-b border-zinc-200 bg-gradient-to-b from-zinc-50 to-white py-10 dark:border-zinc-800 dark:from-zinc-950 dark:to-zinc-900">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          {/* Breadcrumb Navigation */}
          <nav aria-label="Breadcrumb" className="flex items-center gap-2 text-xs text-zinc-500 mb-6">
            <Link href="/" className="hover:text-red-600 transition-colors flex items-center gap-1">
              <Home className="h-3.5 w-3.5" />
              <span>Ana Sayfa</span>
            </Link>
            <span>/</span>
            <span className="text-zinc-400">Aylar</span>
            <span>/</span>
            <span className="font-semibold text-zinc-900 dark:text-zinc-100">
              {monthMeta.name} Ayı
            </span>
          </nav>

          {/* Month Header Banner */}
          <div className="flex flex-col md:flex-row md:items-end justify-between gap-6">
            <div>
              <div className="flex items-center gap-2.5">
                <Badge variant="default" className="text-xs">
                  {monthMeta.season} Mevsimi
                </Badge>
                <Badge variant="secondary" className="text-xs">
                  {monthMeta.daysCount} Gün
                </Badge>
                <span className="text-xs font-semibold text-zinc-500">
                  {specialDays.length} Kayıtlı Özel Gün
                </span>
              </div>

              <h1 className="mt-3 text-3xl sm:text-5xl font-black tracking-tight text-zinc-950 dark:text-white">
                {monthMeta.name} Ayı Özel Günleri ve Haftaları (2026)
              </h1>
              <p className="mt-2 text-sm sm:text-base text-zinc-600 dark:text-zinc-400 max-w-3xl leading-relaxed">
                {monthMeta.description} Bu sayfada {monthMeta.name} ayı boyunca kutlanan tüm milli bayramlar, uluslararası günler ve etkinlikler listelenmiştir.
              </p>

              <div className="mt-5 flex flex-wrap items-center gap-3">
                <AddToCalendarButton
                  events={specialDays.map((d) => specialDayToEventPayload(d))}
                  buttonText={`${monthMeta.name} Ayı Günlerini Takvime Ekle (.ics)`}
                  calendarTitle={`${monthMeta.name} 2026 Özel Günleri`}
                  variant="default"
                />
              </div>
            </div>

            {/* Prev / Next Month Links */}
            <div className="flex items-center gap-2 self-start md:self-auto shrink-0">
              <Link
                href={`/aylar/${prevMonthMeta.slug}`}
                className="inline-flex items-center gap-1 rounded-xl border border-zinc-200 bg-white px-3.5 py-2 text-xs font-bold text-zinc-700 hover:bg-zinc-100 hover:text-red-600 dark:border-zinc-800 dark:bg-zinc-900 dark:text-zinc-300 dark:hover:bg-zinc-800 transition-colors"
                title={`${prevMonthMeta.name} Ayı`}
              >
                <ChevronLeft className="h-4 w-4" />
                <span>{prevMonthMeta.name}</span>
              </Link>
              <Link
                href={`/aylar/${nextMonthMeta.slug}`}
                className="inline-flex items-center gap-1 rounded-xl border border-zinc-200 bg-white px-3.5 py-2 text-xs font-bold text-zinc-700 hover:bg-zinc-100 hover:text-red-600 dark:border-zinc-800 dark:bg-zinc-900 dark:text-zinc-300 dark:hover:bg-zinc-800 transition-colors"
                title={`${nextMonthMeta.name} Ayı`}
              >
                <span>{nextMonthMeta.name}</span>
                <ChevronRight className="h-4 w-4" />
              </Link>
            </div>
          </div>
        </div>
      </section>

      {/* Top Banner Ad */}
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 mt-6">
        <AdBanner slotId={`month-${monthMeta.slug}-leaderboard`} format="horizontal" />
      </div>

      {/* Month Days Grid */}
      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 mt-10">
        <div className="flex items-center justify-between mb-8">
          <div className="flex items-center gap-2">
            <Calendar className="h-5 w-5 text-red-600" />
            <h2 className="text-xl sm:text-2xl font-black text-zinc-900 dark:text-zinc-100">
              {monthMeta.name} Ayında Kutlanan Günler Listesi
            </h2>
          </div>
        </div>

        {specialDays.length > 0 ? (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            {specialDays.map((day) => (
              <SpecialDayCard key={day.id} day={day} />
            ))}
          </div>
        ) : (
          <div className="rounded-3xl border border-dashed border-zinc-300 bg-zinc-50 p-12 text-center dark:border-zinc-800 dark:bg-zinc-900/40">
            <Calendar className="mx-auto h-12 w-12 text-zinc-400" />
            <h3 className="mt-4 text-base font-bold text-zinc-800 dark:text-zinc-200">
              Bu aya ait kayıtlı gün bulunamadı
            </h3>
            <p className="mt-1 text-xs text-zinc-500">
              Diğer aylara göz atmak için yukarıdaki takvim butonlarını kullanabilirsiniz.
            </p>
          </div>
        )}
      </section>

      {/* Month Content & SEO Text Box */}
      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 mt-16">
        <div className="rounded-3xl border border-zinc-200/80 bg-zinc-50/60 p-6 sm:p-10 dark:border-zinc-800 dark:bg-zinc-900/40">
          <h3 className="text-lg font-bold text-zinc-900 dark:text-zinc-100 mb-4">
            {monthMeta.name} Ayı Özel Günleri Hakkında Rehber
          </h3>
          <p className="text-sm text-zinc-600 dark:text-zinc-400 leading-relaxed mb-4">
            {monthMeta.name} ayı, gerek Türkiye'de gerekse küresel çapta çok sayıda anlamlı etkinliğe ve kutlamaya ev sahipliği yapar. Bu ay içinde yer alan özel günler sayesinde sevdiklerinizi mutlu edebilir, sosyal sorumluluk projelerine destek verebilir ve farkındalık yaratabilirsiniz.
          </p>
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-4 pt-4 border-t border-zinc-200/60 dark:border-zinc-800">
            <div className="flex items-center gap-2 text-xs font-semibold text-zinc-700 dark:text-zinc-300">
              <CheckCircle2 className="h-4 w-4 text-emerald-500" />
              <span>Güncel 2026 Tarihleri</span>
            </div>
            <div className="flex items-center gap-2 text-xs font-semibold text-zinc-700 dark:text-zinc-300">
              <CheckCircle2 className="h-4 w-4 text-emerald-500" />
              <span>Hazır Tebrik Mesajları</span>
            </div>
            <div className="flex items-center gap-2 text-xs font-semibold text-zinc-700 dark:text-zinc-300">
              <CheckCircle2 className="h-4 w-4 text-emerald-500" />
              <span>Popüler Hediye Seçenekleri</span>
            </div>
          </div>
        </div>
      </section>

      {/* In-Article Ad Banner */}
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 mt-12">
        <AdBanner slotId={`month-${monthMeta.slug}-footer`} format="in-article" />
      </div>

      {/* Month Fast Switcher Carousel / Row */}
      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 mt-16">
        <h4 className="text-xs font-bold uppercase tracking-wider text-zinc-400 mb-4">
          Tüm Aylara Hızlı Geçiş Yapın
        </h4>
        <div className="grid grid-cols-3 sm:grid-cols-4 md:grid-cols-6 lg:grid-cols-12 gap-2">
          {MONTHS_METADATA.map((m) => (
            <Link
              key={m.slug}
              href={`/aylar/${m.slug}`}
              className={`rounded-xl py-2 px-1 text-center text-xs font-bold transition-all ${
                m.number === monthNo
                  ? "bg-red-600 text-white shadow-sm"
                  : "bg-white text-zinc-700 border border-zinc-200 hover:bg-zinc-100 hover:text-zinc-900 dark:bg-zinc-900 dark:border-zinc-800 dark:text-zinc-300 dark:hover:bg-zinc-800"
              }`}
            >
              {m.name}
            </Link>
          ))}
        </div>
      </section>
    </div>
  );
}
