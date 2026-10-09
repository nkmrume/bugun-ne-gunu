import React from "react";
import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import {
  Layers,
  ArrowRight,
  Home,
  Sparkles,
  CalendarDays,
  Landmark,
  PartyPopper,
  HeartPulse,
  Leaf,
  Palette,
  Briefcase,
  Users,
  Globe,
  Calendar,
} from "lucide-react";
import { CATEGORIES_METADATA, getCategoryBySlug } from "@/lib/data/categories-data";
import { getSpecialDaysByCategory } from "@/lib/data/special-days-service";
import { SpecialDayCard } from "@/components/day/SpecialDayCard";
import { Badge } from "@/components/ui/badge";
import { AdBanner } from "@/components/ads/AdBanner";
import { getBaseUrl } from "@/lib/utils";

interface CategoryPageProps {
  params: Promise<{ categorySlug: string }>;
}

export async function generateStaticParams() {
  return CATEGORIES_METADATA.map((cat) => ({
    categorySlug: cat.slug,
  }));
}

export async function generateMetadata({
  params,
}: CategoryPageProps): Promise<Metadata> {
  const { categorySlug } = await params;
  const categoryMeta = getCategoryBySlug(categorySlug);

  if (!categoryMeta) {
    return {
      title: "Kategori Bulunamadı",
    };
  }

  const title = `${categoryMeta.name} Özel Günleri Takvimi 2026`;
  const description = `${categoryMeta.name} kategorisindeki tüm özel günler, haftalar ve bayramlar. ${categoryMeta.description} 2026 takvimi ve kutlama mesajları.`;

  const baseUrl = getBaseUrl();

  return {
    title,
    description,
    alternates: {
      canonical: `${baseUrl}/kategoriler/${categoryMeta.slug}`,
    },
    openGraph: {
      title,
      description,
      url: `${baseUrl}/kategoriler/${categoryMeta.slug}`,
      type: "website",
    },
    twitter: {
      card: "summary_large_image",
      title,
      description,
    },
  };
}

export default async function SingleCategoryPage({ params }: CategoryPageProps) {
  const { categorySlug } = await params;
  const categoryMeta = getCategoryBySlug(categorySlug);

  if (!categoryMeta) {
    notFound();
  }

  const baseUrl = getBaseUrl();
  const days = await getSpecialDaysByCategory(categoryMeta.category);

  const collectionSchema = {
    "@context": "https://schema.org",
    "@type": "CollectionPage",
    name: `${categoryMeta.name} Özel Günleri 2026`,
    description: categoryMeta.description,
    url: `${baseUrl}/kategoriler/${categoryMeta.slug}`,
    mainEntity: {
      "@type": "ItemList",
      itemListElement: days.map((day, index) => ({
        "@type": "ListItem",
        position: index + 1,
        name: day.title,
        url: `${baseUrl}/gun/${day.slug}`,
      })),
    },
  };

  const breadcrumbSchema = {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    itemListElement: [
      {
        "@type": "ListItem",
        position: 1,
        name: "Ana Sayfa",
        item: baseUrl,
      },
      {
        "@type": "ListItem",
        position: 2,
        name: "Kategoriler",
        item: `${baseUrl}/kategoriler`,
      },
      {
        "@type": "ListItem",
        position: 3,
        name: categoryMeta.name,
        item: `${baseUrl}/kategoriler/${categoryMeta.slug}`,
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

      {/* Hero Header */}
      <section className="border-b border-zinc-200 bg-gradient-to-b from-zinc-50 to-white py-12 dark:border-zinc-800 dark:from-zinc-950 dark:to-zinc-900">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <nav aria-label="Breadcrumb" className="flex items-center gap-2 text-xs text-zinc-500 mb-6">
            <Link href="/" className="hover:text-red-600 transition-colors flex items-center gap-1">
              <Home className="h-3.5 w-3.5" />
              <span>Ana Sayfa</span>
            </Link>
            <span>/</span>
            <Link href="/kategoriler" className="hover:text-red-600 transition-colors">
              Kategoriler
            </Link>
            <span>/</span>
            <span className="font-semibold text-zinc-900 dark:text-zinc-100">
              {categoryMeta.name}
            </span>
          </nav>

          <div className="flex flex-col md:flex-row md:items-end justify-between gap-6">
            <div className="max-w-3xl">
              <div className="flex items-center gap-2.5 mb-3">
                <Badge variant={categoryMeta.badgeVariant} className="text-xs font-bold">
                  {categoryMeta.category}
                </Badge>
                <span className="text-xs font-semibold text-zinc-500">
                  {days.length} Kayıtlı Özel Gün
                </span>
              </div>

              <h1 className="text-3xl sm:text-5xl font-black tracking-tight text-zinc-950 dark:text-white">
                {categoryMeta.name}
              </h1>
              <p className="mt-3 text-base text-zinc-600 dark:text-zinc-400 leading-relaxed">
                {categoryMeta.longDescription}
              </p>
            </div>

            <Link
              href="/kategoriler"
              className="inline-flex items-center gap-1 text-xs font-bold text-red-600 hover:underline shrink-0"
            >
              <span>Tüm Kategorileri Gör</span>
              <ArrowRight className="h-3.5 w-3.5" />
            </Link>
          </div>
        </div>
      </section>

      {/* Top Banner Ad */}
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 mt-6">
        <AdBanner slotId={`category-${categoryMeta.slug}-leaderboard`} format="horizontal" />
      </div>

      {/* Special Days Grid */}
      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 mt-12">
        <div className="flex items-center justify-between mb-8">
          <div className="flex items-center gap-2">
            <Calendar className="h-5 w-5 text-red-600" />
            <h2 className="text-xl sm:text-2xl font-black text-zinc-900 dark:text-zinc-100">
              {categoryMeta.name} Listesi ({days.length} Gün)
            </h2>
          </div>
        </div>

        {days.length > 0 ? (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            {days.map((day) => (
              <SpecialDayCard key={day.id} day={day} />
            ))}
          </div>
        ) : (
          <div className="rounded-3xl border border-dashed border-zinc-300 bg-zinc-50 p-12 text-center dark:border-zinc-800 dark:bg-zinc-900/40">
            <CalendarDays className="mx-auto h-12 w-12 text-zinc-400" />
            <h3 className="mt-4 text-base font-bold text-zinc-800 dark:text-zinc-200">
              Bu kategoriye ait gün bulunamadı
            </h3>
          </div>
        )}
      </section>

      {/* Mid In-Article Ad */}
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 mt-12">
        <AdBanner slotId={`category-${categoryMeta.slug}-middle`} format="in-article" />
      </div>

      {/* Fast Category Switcher Footer */}
      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 mt-16">
        <h4 className="text-xs font-bold uppercase tracking-wider text-zinc-400 mb-4">
          Diğer Kategorilere Göz Atın
        </h4>
        <div className="grid grid-cols-2 sm:grid-cols-4 lg:grid-cols-8 gap-2">
          {CATEGORIES_METADATA.map((c) => (
            <Link
              key={c.slug}
              href={`/kategoriler/${c.slug}`}
              className={`rounded-xl py-2.5 px-2 text-center text-xs font-bold transition-all ${
                c.slug === categorySlug
                  ? "bg-red-600 text-white shadow-sm"
                  : "bg-white text-zinc-700 border border-zinc-200 hover:bg-zinc-100 hover:text-zinc-900 dark:bg-zinc-900 dark:border-zinc-800 dark:text-zinc-300 dark:hover:bg-zinc-800"
              }`}
            >
              {c.category}
            </Link>
          ))}
        </div>
      </section>
    </div>
  );
}
