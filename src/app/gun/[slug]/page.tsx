import React from "react";
import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import {
  Calendar,
  Home,
  Sparkles,
  ArrowRight,
  Clock,
  ShieldCheck,
  HelpCircle,
  ExternalLink,
} from "lucide-react";
import {
  getSpecialDayBySlug,
  getAllSpecialDays,
  getSpecialDaysByMonth,
} from "@/lib/data/special-days-service";
import { MONTHS_METADATA } from "@/lib/data/special-days-data";
import { formatTurkishDate, formatDayMonthOnly, TURKISH_MONTHS, NUMBER_TO_MONTH_SLUG } from "@/lib/utils";
import { Badge } from "@/components/ui/badge";
import { SpecialDayJsonLd } from "@/components/seo/JsonLd";
import { DayDetailTabs } from "@/components/day/DayDetailTabs";
import { AffiliateBox } from "@/components/day/AffiliateBox";
import { ShareActions } from "@/components/day/ShareActions";
import { CountdownTimer } from "@/components/day/CountdownTimer";
import { SocialShareCard } from "@/components/day/SocialShareCard";
import { AddToCalendarButton } from "@/components/day/AddToCalendarButton";
import { specialDayToEventPayload } from "@/lib/calendar-engine";
import { AdBanner } from "@/components/ads/AdBanner";
import { SpecialDayCard } from "@/components/day/SpecialDayCard";

interface DayPageProps {
  params: Promise<{ slug: string }>;
}

export async function generateStaticParams() {
  const days = await getAllSpecialDays();
  return days.map((day) => ({
    slug: day.slug,
  }));
}

export async function generateMetadata({
  params,
}: DayPageProps): Promise<Metadata> {
  const { slug } = await params;
  const day = await getSpecialDayBySlug(slug);

  if (!day) {
    return {
      title: "Özel Gün Bulunamadı",
    };
  }

  const isMemorial = day.day_type === "anma";
  const formattedDate = formatTurkishDate(day.day_no, day.month_no, 2026);
  // Title without repeating brand suffix (layout handles %s | Bugün Ne Günü?)
  const title = `2026 ${day.title} Ne Zaman, Nasıl ${isMemorial ? "Anılır" : "Kutlanır"}?`;
  const actionWord = isMemorial ? "anılmaktadır" : "kutlanıyor";
  const description = `${day.title} 2026 yılında ${formattedDate} tarihinde ${actionWord}. ${day.description} Etkinlik fikirleri, tarihçesi ve hazır ${isMemorial ? "anma" : "kutlama"} mesajları.`;
  const canonicalUrl = `https://bugunnegunu.com/gun/${day.slug}`;

  return {
    title,
    description,
    keywords: [
      day.title,
      `${day.title} ne zaman`,
      `2026 ${day.title}`,
      `${day.title} nasıl ${isMemorial ? "anılır" : "kutlanır"}`,
      `${day.title} mesajları`,
      ...day.hashtags.map((h) => h.replace("#", "")),
      ...day.affiliate_keywords,
    ],
    alternates: {
      canonical: canonicalUrl,
    },
    openGraph: {
      title,
      description,
      url: canonicalUrl,
      type: "article",
      locale: "tr_TR",
      siteName: "Bugün Ne Günü?",
      images: [
        {
          url: `https://bugunnegunu.com/og?title=${encodeURIComponent(day.title)}`,
          width: 1200,
          height: 630,
          alt: day.title,
        },
      ],
    },
    twitter: {
      card: "summary_large_image",
      title,
      description,
    },
  };
}

export default async function SingleDayPage({ params }: DayPageProps) {
  const { slug } = await params;
  const day = await getSpecialDayBySlug(slug);

  if (!day) {
    notFound();
  }

  const isMemorial = day.day_type === "anma";
  const monthMeta = MONTHS_METADATA.find((m) => m.number === day.month_no);
  const formattedDayMonth = formatDayMonthOnly(day.day_no, day.month_no);
  const formattedFullDate = formatTurkishDate(day.day_no, day.month_no, 2026);
  const pageUrl = `https://bugunnegunu.com/gun/${day.slug}`;
  const dateSlug = `${day.day_no}-${NUMBER_TO_MONTH_SLUG[day.month_no]}`;

  // Fetch related days from same month
  const sameMonthDays = await getSpecialDaysByMonth(day.month_no);
  const relatedDays = sameMonthDays
    .filter((item) => item.slug !== day.slug)
    .slice(0, 3);

  // Extract how to celebrate / remember content
  let howToFirstParagraph = isMemorial
    ? `${day.title} gününde saat 09:05'te saygı duruşunda bulunabilir, Anıtkabir'i ve müzeleri ziyaret ederek Atatürk'ün fikirlerini inceleyebilirsiniz.`
    : `${day.title} gününde sevdiklerinizle bir araya gelebilir, günün anlamına uygun sosyal ve kültürel etkinliklere katılabilirsiniz.`;

  if (day.content.includes("##")) {
    const sections = day.content.split(/##\s+/);
    const howToSection = sections.find(
      (sec) =>
        sec.toLowerCase().includes("nasıl") ||
        sec.toLowerCase().includes("nasil") ||
        sec.toLowerCase().includes("kutlanır") ||
        sec.toLowerCase().includes("anılır")
    );
    if (howToSection) {
      const lines = howToSection
        .split("\n")
        .filter((l) => l.trim().length > 0 && !l.startsWith("##"));
      if (lines.length > 1) {
        howToFirstParagraph = lines[1].replace(/\*\*/g, "").replace(/\*/g, "");
      }
    }
  }

  return (
    <div className="min-h-screen pb-20">
      {/* 1. SEO & Schema Markup Injection */}
      <SpecialDayJsonLd specialDay={day} url={pageUrl} />

      {/* 2. Top Header & Breadcrumb */}
      <section
        className={`border-b py-10 sm:py-14 ${
          isMemorial
            ? "border-zinc-800 bg-gradient-to-b from-zinc-950 via-zinc-900 to-zinc-950 text-white"
            : "border-zinc-200/80 bg-gradient-to-b from-red-50/50 via-zinc-50/50 to-white dark:border-zinc-800 dark:from-red-950/20 dark:via-zinc-950 dark:to-zinc-900"
        }`}
      >
        <div className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8">
          {/* Breadcrumb Navigation */}
          <nav aria-label="Breadcrumb" className="flex items-center gap-2 text-xs opacity-75 mb-6 flex-wrap">
            <Link href="/" className="hover:underline flex items-center gap-1">
              <Home className="h-3.5 w-3.5" />
              <span>Ana Sayfa</span>
            </Link>
            <span>/</span>
            {monthMeta && (
              <>
                <Link href={`/aylar/${monthMeta.slug}`} className="hover:underline">
                  {monthMeta.name} Ayı
                </Link>
                <span>/</span>
              </>
            )}
            <Link href={`/tarih/${dateSlug}`} className="hover:underline">
              {formattedDayMonth}
            </Link>
            <span>/</span>
            <span className="font-semibold truncate">{day.title}</span>
          </nav>

          {/* Badges & Meta */}
          <div className="flex flex-wrap items-center gap-2.5 mb-4">
            <Badge variant="default" className="text-xs font-bold">
              {day.category}
            </Badge>

            {isMemorial ? (
              <Badge variant="secondary" className="text-xs font-bold gap-1 bg-zinc-800 text-zinc-100 border-zinc-700">
                🇹🇷 Saygı ve Anma Günü
              </Badge>
            ) : day.day_type === "farkindalik" ? (
              <Badge variant="secondary" className="text-xs font-bold gap-1">
                🎗️ Uluslararası Farkındalık
              </Badge>
            ) : (
              <Badge variant="warning" className="text-xs font-bold gap-1">
                <Sparkles className="h-3 w-3" />
                2026 Kutlaması
              </Badge>
            )}

            <span className="text-xs font-medium opacity-80 flex items-center gap-1">
              <Clock className="h-3.5 w-3.5" />
              Her Yıl {formattedDayMonth}
            </span>
          </div>

          {/* Typography Date Hero */}
          <div className="flex flex-col md:flex-row md:items-end justify-between gap-6 border-b border-white/10 pb-8">
            <div>
              <div
                className={`text-5xl sm:text-7xl md:text-8xl font-black tracking-tight select-none ${
                  isMemorial ? "text-zinc-200" : "text-red-600 dark:text-red-500"
                }`}
              >
                {formattedDayMonth}
              </div>
              <h1 className="mt-2 text-2xl sm:text-4xl md:text-5xl font-black tracking-tight">
                {day.title}
              </h1>
              <p className="mt-3 text-base sm:text-lg opacity-90 max-w-2xl leading-relaxed">
                {day.description}
              </p>
            </div>

            {/* Actions Component */}
            <div className="shrink-0 flex flex-col gap-3">
              <div>
                <span className="block text-xs font-bold uppercase tracking-wider opacity-70 mb-2">
                  Bu Günü Paylaş
                </span>
                <ShareActions specialDay={day} />
              </div>
              <div>
                <AddToCalendarButton
                  event={specialDayToEventPayload(day)}
                  buttonText="Takvime Ekle (.ics / Google)"
                  variant={isMemorial ? "secondary" : "outline"}
                />
              </div>
            </div>
          </div>

          {/* Editorial Source Verification Badge */}
          {day.source_name && (
            <div className="mt-4 flex items-center gap-2 text-xs opacity-80">
              <ShieldCheck className="h-4 w-4 text-emerald-500" />
              <span>
                Kaynak: <strong>{day.source_name}</strong>
              </span>
              {day.source_url && (
                <a
                  href={day.source_url}
                  target="_blank"
                  rel="noopener noreferrer nofollow"
                  className="inline-flex items-center gap-0.5 underline text-red-500 hover:text-red-400 ml-1"
                >
                  <span>Resmi Belge</span>
                  <ExternalLink className="h-3 w-3" />
                </a>
              )}
            </div>
          )}
        </div>
      </section>

      {/* Top Horizontal AdSense Banner */}
      <div className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 mt-6">
        <AdBanner slotId={`day-${day.slug}-top`} format="horizontal" />
      </div>

      {/* 3. Live Countdown Timer */}
      <section className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 mt-8">
        <CountdownTimer
          targetMonth={day.month_no}
          targetDay={day.day_no}
          title={day.title}
          dayType={day.day_type || "kutlama"}
        />
      </section>

      {/* 4. Main Content: Tabs Structure */}
      <section className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 mt-10">
        <DayDetailTabs specialDay={day} />
      </section>

      {/* 5. Social Media Shareable Card (Ready 1080x1080 graphic generator) */}
      <section className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 mt-12">
        <SocialShareCard
          title={day.title}
          formattedDate={formattedFullDate}
          category={day.category}
          dayType={day.day_type || "kutlama"}
          hashtags={day.hashtags}
          slug={day.slug}
        />
      </section>

      {/* 6. Affiliate Box (Only shown if NOT a memorial day) */}
      <section className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 mt-12">
        <AffiliateBox specialDay={day} />
      </section>

      {/* Mid In-Article Ad Banner */}
      <div className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 mt-12">
        <AdBanner slotId={`day-${day.slug}-middle`} format="in-article" />
      </div>

      {/* 7. Rich FAQ Section */}
      <section className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 mt-14">
        <div className="flex items-center gap-2 mb-6">
          <HelpCircle className="h-5 w-5 text-red-600" />
          <h2 className="text-xl sm:text-2xl font-black text-zinc-900 dark:text-zinc-100">
            {day.title} Hakkında Sıkça Sorulan Sorular
          </h2>
        </div>

        <div className="space-y-4">
          <div className="rounded-2xl border border-zinc-200 bg-white p-6 dark:border-zinc-800 dark:bg-zinc-900">
            <h3 className="font-bold text-base text-zinc-900 dark:text-zinc-100">
              2026 {day.title} ne zaman?
            </h3>
            <p className="mt-2 text-sm text-zinc-600 dark:text-zinc-400 leading-relaxed">
              2026 yılında {day.title}, <strong>{formattedFullDate}</strong> tarihinde {isMemorial ? "saygıyla anılmaktadır" : "kutlanmaktadır"}.
            </p>
          </div>

          <div className="rounded-2xl border border-zinc-200 bg-white p-6 dark:border-zinc-800 dark:bg-zinc-900">
            <h3 className="font-bold text-base text-zinc-900 dark:text-zinc-100">
              {day.title} nasıl {isMemorial ? "anılır" : "kutlanır"}?
            </h3>
            <p className="mt-2 text-sm text-zinc-600 dark:text-zinc-400 leading-relaxed">
              {howToFirstParagraph}
            </p>
          </div>

          <div className="rounded-2xl border border-zinc-200 bg-white p-6 dark:border-zinc-800 dark:bg-zinc-900">
            <h3 className="font-bold text-base text-zinc-900 dark:text-zinc-100">
              En iyi {day.title} {isMemorial ? "anma" : "kutlama"} mesajları nelerdir?
            </h3>
            <p className="mt-2 text-sm text-zinc-600 dark:text-zinc-400 leading-relaxed">
              {isMemorial ? (
                <span>
                  "Gazi Mustafa Kemal Atatürk'ü saygı, rahmet ve minnetle anıyoruz. Açtığın yolda, gösterdiğin hedefe durmadan yürüyeceğimize ant içeriz." gibi saygı dolu ifadeler tercih edilmelidir. Sayfamızın Sosyal Medya sekmesinden diğer mesajları tek tıkla kopyalayabilirsiniz.
                </span>
              ) : (
                <span>
                  Sayfamızın "Sosyal Medya" sekmesinde WhatsApp, Instagram ve Twitter için özel olarak hazırlanmış hazır mesaj şablonları yer almaktadır. Tek tıkla kopyalayarak paylaşabilirsiniz.
                </span>
              )}
            </p>
          </div>
        </div>
      </section>

      {/* 8. Related Days in Same Month */}
      {relatedDays.length > 0 && (
        <section className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 mt-16">
          <div className="flex items-center justify-between mb-8">
            <h3 className="text-xl sm:text-2xl font-black text-zinc-900 dark:text-zinc-100">
              {monthMeta?.name} Ayındaki Diğer Özel Günler
            </h3>
            {monthMeta && (
              <Link
                href={`/aylar/${monthMeta.slug}`}
                className="text-xs sm:text-sm font-bold text-red-600 hover:text-red-700 flex items-center gap-1 group"
              >
                <span>Tümünü Gör ({monthMeta.name})</span>
                <ArrowRight className="h-4 w-4 group-hover:translate-x-1 transition-transform" />
              </Link>
            )}
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            {relatedDays.map((relDay) => (
              <SpecialDayCard key={relDay.id} day={relDay} />
            ))}
          </div>
        </section>
      )}
    </div>
  );
}
