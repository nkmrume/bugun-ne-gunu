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
  Tag,
  ShieldCheck,
  HelpCircle,
} from "lucide-react";
import {
  getSpecialDayBySlug,
  getAllSpecialDays,
  getSpecialDaysByMonth,
} from "@/lib/data/special-days-service";
import { MONTHS_METADATA } from "@/lib/data/special-days-data";
import { formatTurkishDate, formatDayMonthOnly, TURKISH_MONTHS } from "@/lib/utils";
import { Badge } from "@/components/ui/badge";
import { SpecialDayJsonLd } from "@/components/seo/JsonLd";
import { DayDetailTabs } from "@/components/day/DayDetailTabs";
import { AffiliateBox } from "@/components/day/AffiliateBox";
import { ShareActions } from "@/components/day/ShareActions";
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
      title: "Özel Gün Bulunamadı | Bugün Ne Günü?",
    };
  }

  const formattedDate = formatTurkishDate(day.day_no, day.month_no, 2026);
  const title = `2026 ${day.title} Ne Zaman, Nasıl Kutlanır? | Bugün Ne Günü?`;
  const description = `${day.title} 2026 yılında ${formattedDate} tarihinde kutlanıyor. ${day.description} Etkinlik fikirleri, hazır kutlama mesajları ve hediyeler.`;
  const canonicalUrl = `https://bugunnegunu.com/gun/${day.slug}`;

  return {
    title,
    description,
    keywords: [
      day.title,
      `${day.title} ne zaman`,
      `2026 ${day.title}`,
      `${day.title} nasıl kutlanır`,
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

  const monthMeta = MONTHS_METADATA.find((m) => m.number === day.month_no);
  const formattedDayMonth = formatDayMonthOnly(day.day_no, day.month_no);
  const formattedFullDate = formatTurkishDate(day.day_no, day.month_no, 2026);
  const pageUrl = `https://bugunnegunu.com/gun/${day.slug}`;

  // Fetch related days from same month or category
  const sameMonthDays = await getSpecialDaysByMonth(day.month_no);
  const relatedDays = sameMonthDays
    .filter((item) => item.slug !== day.slug)
    .slice(0, 3);

  // Extract first paragraph for FAQ answer
  let howToFirstParagraph = `${day.title} gününde sevdiklerinizle bir araya gelebilir, günün anlamına uygun sosyal ve kültürel etkinliklere katılabilirsiniz.`;
  if (day.content.includes("##")) {
    const sections = day.content.split(/##\s+/);
    const howToSection = sections.find(
      (sec) =>
        sec.toLowerCase().includes("nasıl") ||
        sec.toLowerCase().includes("nasil") ||
        sec.toLowerCase().includes("kutlanır")
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
      <section className="border-b border-zinc-200/80 bg-gradient-to-b from-red-50/50 via-zinc-50/50 to-white py-10 sm:py-14 dark:border-zinc-800 dark:from-red-950/20 dark:via-zinc-950 dark:to-zinc-900">
        <div className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8">
          {/* Breadcrumb Navigation */}
          <nav aria-label="Breadcrumb" className="flex items-center gap-2 text-xs text-zinc-500 mb-6 flex-wrap">
            <Link href="/" className="hover:text-red-600 transition-colors flex items-center gap-1">
              <Home className="h-3.5 w-3.5" />
              <span>Ana Sayfa</span>
            </Link>
            <span>/</span>
            {monthMeta && (
              <>
                <Link
                  href={`/aylar/${monthMeta.slug}`}
                  className="hover:text-red-600 transition-colors"
                >
                  {monthMeta.name} Ayı
                </Link>
                <span>/</span>
              </>
            )}
            <span className="font-semibold text-zinc-900 dark:text-zinc-100 truncate">
              {day.title}
            </span>
          </nav>

          {/* Badges & Meta */}
          <div className="flex flex-wrap items-center gap-2.5 mb-4">
            <Badge variant="default" className="text-xs font-bold">
              {day.category}
            </Badge>
            <Badge variant="warning" className="text-xs font-bold gap-1">
              <Sparkles className="h-3 w-3" />
              2026 Kutlaması
            </Badge>
            <span className="text-xs font-medium text-zinc-500 flex items-center gap-1">
              <Clock className="h-3.5 w-3.5" />
              Her Yıl {formattedDayMonth}
            </span>
          </div>

          {/* Huge Typography Date Hero */}
          <div className="flex flex-col md:flex-row md:items-end justify-between gap-6 border-b border-zinc-200/60 pb-8 dark:border-zinc-800">
            <div>
              <div className="text-5xl sm:text-7xl md:text-8xl font-black tracking-tight text-red-600 dark:text-red-500 select-none">
                {formattedDayMonth}
              </div>
              <h1 className="mt-2 text-2xl sm:text-4xl md:text-5xl font-black text-zinc-950 dark:text-white tracking-tight">
                {day.title}
              </h1>
              <p className="mt-3 text-base sm:text-lg text-zinc-600 dark:text-zinc-300 max-w-2xl leading-relaxed">
                {day.description}
              </p>
            </div>

            {/* Social Share Component */}
            <div className="shrink-0">
              <span className="block text-xs font-bold uppercase tracking-wider text-zinc-400 mb-2">
                Bu Günü Paylaş
              </span>
              <ShareActions specialDay={day} />
            </div>
          </div>
        </div>
      </section>

      {/* Top Horizontal AdSense Banner */}
      <div className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 mt-6">
        <AdBanner slotId={`day-${day.slug}-top`} format="horizontal" />
      </div>

      {/* 3. Main Content: Tabs Structure */}
      <section className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 mt-10">
        <DayDetailTabs specialDay={day} />
      </section>

      {/* 4. Conversion-Optimized Affiliate Box */}
      <section className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 mt-14">
        <AffiliateBox specialDay={day} />
      </section>

      {/* Mid In-Article Ad Banner */}
      <div className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 mt-12">
        <AdBanner slotId={`day-${day.slug}-middle`} format="in-article" />
      </div>

      {/* 5. Rich FAQ Section (Auto-generated 3 questions matching FAQ Schema) */}
      <section className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 mt-14">
        <div className="flex items-center gap-2 mb-6">
          <HelpCircle className="h-5 w-5 text-red-600" />
          <h2 className="text-xl sm:text-2xl font-black text-zinc-900 dark:text-zinc-100">
            {day.title} Hakkında Sıkça Sorulan Sorular
          </h2>
        </div>

        <div className="space-y-4">
          {/* Question 1 */}
          <div className="rounded-2xl border border-zinc-200 bg-white p-6 dark:border-zinc-800 dark:bg-zinc-900">
            <h3 className="font-bold text-base text-zinc-900 dark:text-zinc-100">
              2026 {day.title} ne zaman?
            </h3>
            <p className="mt-2 text-sm text-zinc-600 dark:text-zinc-400 leading-relaxed">
              2026 yılında {day.title}, <strong>{formattedFullDate}</strong> tarihinde kutlanmaktadır.
            </p>
          </div>

          {/* Question 2 */}
          <div className="rounded-2xl border border-zinc-200 bg-white p-6 dark:border-zinc-800 dark:bg-zinc-900">
            <h3 className="font-bold text-base text-zinc-900 dark:text-zinc-100">
              {day.title} nasıl kutlanır?
            </h3>
            <p className="mt-2 text-sm text-zinc-600 dark:text-zinc-400 leading-relaxed">
              {howToFirstParagraph}
            </p>
          </div>

          {/* Question 3 */}
          <div className="rounded-2xl border border-zinc-200 bg-white p-6 dark:border-zinc-800 dark:bg-zinc-900">
            <h3 className="font-bold text-base text-zinc-900 dark:text-zinc-100">
              En iyi {day.title} mesajları nelerdir?
            </h3>
            <p className="mt-2 text-sm text-zinc-600 dark:text-zinc-400 leading-relaxed">
              &ldquo;{day.title} kutlu olsun! Bu özel günün getirdiği neşe ve farkındalığın hayatınıza güzellik katmasını dileriz.&rdquo; Sayfamızdaki Sosyal Medya sekmesinden hazır şablonları kopyalayabilirsiniz.
            </p>
          </div>
        </div>
      </section>

      {/* 6. Related Special Days */}
      {relatedDays.length > 0 && (
        <section className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 mt-16 border-t border-zinc-200 pt-12 dark:border-zinc-800">
          <div className="flex items-center justify-between mb-8">
            <div>
              <span className="text-xs font-bold uppercase tracking-wider text-zinc-400">
                Aynı Ay İçerisindeki
              </span>
              <h2 className="text-xl sm:text-2xl font-black text-zinc-900 dark:text-zinc-100">
                Diğer {monthMeta?.name} Ayı Özel Günleri
              </h2>
            </div>
            {monthMeta && (
              <Link
                href={`/aylar/${monthMeta.slug}`}
                className="inline-flex items-center gap-1 text-xs font-bold text-red-600 hover:underline"
              >
                <span>Tümünü Gör</span>
                <ArrowRight className="h-3.5 w-3.5" />
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
