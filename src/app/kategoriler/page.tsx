import React from "react";
import type { Metadata } from "next";
import Link from "next/link";
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
} from "lucide-react";
import { CATEGORIES_METADATA } from "@/lib/data/categories-data";
import { getCategoryDayCounts, getAllSpecialDays } from "@/lib/data/special-days-service";
import { Badge } from "@/components/ui/badge";
import { AdBanner } from "@/components/ads/AdBanner";

export const metadata: Metadata = {
  title: "Özel Gün Kategorileri 2026",
  description:
    "Resmi bayramlar, eğlence günleri, sağlık ve farkındalık haftaları, çevre ve kültür-sanat günleri. Tüm özel gün kategorilerini keşfedin.",
  alternates: {
    canonical: "https://bugunnegunu.com/kategoriler",
  },
  openGraph: {
    title: "Özel Gün Kategorileri 2026 | Bugün Ne Günü?",
    description: "Tüm kategorilere göre sınıflandırılmış özel günler ve bayramlar takvimi.",
    url: "https://bugunnegunu.com/kategoriler",
  },
};

export default async function CategoriesHubPage() {
  const counts = await getCategoryDayCounts();
  const allDays = await getAllSpecialDays();

  const getIcon = (iconName: string) => {
    switch (iconName) {
      case "Landmark":
        return <Landmark className="h-6 w-6" />;
      case "PartyPopper":
        return <PartyPopper className="h-6 w-6" />;
      case "HeartPulse":
        return <HeartPulse className="h-6 w-6" />;
      case "Leaf":
        return <Leaf className="h-6 w-6" />;
      case "Palette":
        return <Palette className="h-6 w-6" />;
      case "Briefcase":
        return <Briefcase className="h-6 w-6" />;
      case "Users":
        return <Users className="h-6 w-6" />;
      default:
        return <Globe className="h-6 w-6" />;
    }
  };

  return (
    <div className="min-h-screen pb-20">
      {/* Header & Breadcrumb Hero */}
      <section className="border-b border-zinc-200 bg-gradient-to-b from-zinc-50 to-white py-12 dark:border-zinc-800 dark:from-zinc-950 dark:to-zinc-900">
        <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
          <nav aria-label="Breadcrumb" className="flex items-center gap-2 text-xs text-zinc-500 mb-6">
            <Link href="/" className="hover:text-red-600 transition-colors flex items-center gap-1">
              <Home className="h-3.5 w-3.5" />
              <span>Ana Sayfa</span>
            </Link>
            <span>/</span>
            <span className="font-semibold text-zinc-900 dark:text-zinc-100">
              Kategoriler
            </span>
          </nav>

          <div className="max-w-3xl">
            <div className="flex items-center gap-2 mb-3">
              <Badge variant="default" className="text-xs">
                Kategori Rehberi
              </Badge>
              <span className="text-xs font-semibold text-zinc-500">
                {CATEGORIES_METADATA.length} Farklı Tema • {allDays.length} Özel Gün
              </span>
            </div>
            <h1 className="text-3xl sm:text-5xl font-black tracking-tight text-zinc-950 dark:text-white">
              Özel Gün Kategorileri
            </h1>
            <p className="mt-3 text-base text-zinc-600 dark:text-zinc-400 leading-relaxed">
              İlgi alanınıza göre özel günleri, resmi bayramları, meslek günlerini ve sosyal farkındalık takvimini kategorilere ayrılmış olarak inceleyin.
            </p>
          </div>
        </div>
      </section>

      {/* Top Banner Ad */}
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 mt-6">
        <AdBanner slotId="categories-top-leaderboard" format="horizontal" />
      </div>

      {/* Categories Grid */}
      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 mt-12">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {CATEGORIES_METADATA.map((cat) => {
            const count = counts[cat.category] || 0;
            const topDays = allDays
              .filter((d) => d.category === cat.category)
              .slice(0, 3);

            return (
              <div
                key={cat.slug}
                className="group relative flex flex-col justify-between rounded-3xl border border-zinc-200/80 bg-white p-6 shadow-sm transition-all duration-200 hover:-translate-y-1.5 hover:shadow-xl hover:border-red-200 dark:border-zinc-800 dark:bg-zinc-900"
              >
                <div>
                  <div className="flex items-center justify-between mb-4">
                    <div className={`flex h-12 w-12 items-center justify-center rounded-2xl bg-gradient-to-tr ${cat.gradient} text-white shadow-md`}>
                      {getIcon(cat.iconName)}
                    </div>
                    <Badge variant={cat.badgeVariant} className="text-xs font-bold">
                      {count} Özel Gün
                    </Badge>
                  </div>

                  <h2 className="text-xl font-bold text-zinc-900 group-hover:text-red-600 transition-colors dark:text-zinc-100">
                    <Link href={`/kategoriler/${cat.slug}`} className="hover:underline">
                      {cat.name}
                    </Link>
                  </h2>
                  <p className="mt-2 text-xs sm:text-sm text-zinc-600 dark:text-zinc-400 leading-relaxed">
                    {cat.description}
                  </p>

                  {/* Top Days Preview in this category */}
                  <div className="mt-4 pt-3 border-t border-zinc-100 dark:border-zinc-800 space-y-1.5">
                    <span className="text-[10px] font-bold uppercase tracking-wider text-zinc-400 block mb-1">
                      Öne Çıkan Günler:
                    </span>
                    {topDays.map((td) => (
                      <Link
                        key={td.id}
                        href={`/gun/${td.slug}`}
                        className="flex items-center justify-between text-xs text-zinc-700 hover:text-red-600 dark:text-zinc-300 dark:hover:text-red-400 transition-colors"
                      >
                        <span className="truncate max-w-[200px]">{td.title}</span>
                        <span className="text-[10px] text-zinc-400 shrink-0">
                          {td.day_no}/{td.month_no}
                        </span>
                      </Link>
                    ))}
                  </div>
                </div>

                <div className="mt-6 pt-3 border-t border-zinc-100 dark:border-zinc-800">
                  <Link
                    href={`/kategoriler/${cat.slug}`}
                    className="inline-flex items-center gap-1.5 text-xs font-bold text-red-600 group-hover:translate-x-1 transition-transform"
                  >
                    <span>Tüm {cat.name} Günlerini Gör ({count})</span>
                    <ArrowRight className="h-3.5 w-3.5" />
                  </Link>
                </div>
              </div>
            );
          })}
        </div>
      </section>

      {/* Footer Banner Ad */}
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 mt-12">
        <AdBanner slotId="categories-bottom-responsive" format="in-article" />
      </div>
    </div>
  );
}
