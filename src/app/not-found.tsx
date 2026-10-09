import React from "react";
import Link from "next/link";
import { Metadata } from "next";
import { CalendarDays, Home, Calendar, ArrowRight, Search } from "lucide-react";
import { getTurkeyToday } from "@/lib/date-engine";

export const metadata: Metadata = {
  title: "404 - Sayfa Bulunamadı",
  description: "Aradığınız özel gün veya tarih sayfası bulunamadı.",
  robots: {
    index: false,
    follow: false,
  },
};

export default function NotFound() {
  const turkeyToday = getTurkeyToday();

  return (
    <div className="min-h-[70vh] flex items-center justify-center px-4 sm:px-6 lg:px-8 py-16">
      <div className="max-w-md w-full text-center">
        <div className="mx-auto flex h-20 w-20 items-center justify-center rounded-3xl bg-red-100 dark:bg-red-950/50 text-red-600 dark:text-red-400 mb-6 shadow-inner">
          <CalendarDays className="h-10 w-10" />
        </div>

        <span className="text-xs font-black uppercase tracking-widest text-red-600">
          404 • Hata
        </span>

        <h1 className="mt-2 text-3xl sm:text-4xl font-black text-zinc-900 dark:text-zinc-50 tracking-tight">
          Sayfa Bulunamadı
        </h1>

        <p className="mt-3 text-sm text-zinc-600 dark:text-zinc-400 leading-relaxed">
          Aradığınız özel gün kaydı veya tarih sayfası mevcut değil ya da adresi değişmiş olabilir. Aşağıdaki bağlantıları kullanarak takvimimizde arama yapabilirsiniz.
        </p>

        <div className="mt-8 flex flex-col sm:flex-row items-center justify-center gap-3">
          <Link
            href="/"
            className="w-full sm:w-auto inline-flex items-center justify-center gap-2 rounded-2xl bg-red-600 px-5 py-3 text-xs sm:text-sm font-bold text-white shadow-md hover:bg-red-700 transition-colors"
          >
            <Home className="h-4 w-4" />
            <span>Ana Sayfaya Dön</span>
          </Link>

          <Link
            href={`/tarih/${turkeyToday.dateSlug}`}
            className="w-full sm:w-auto inline-flex items-center justify-center gap-2 rounded-2xl border border-zinc-200 bg-white px-5 py-3 text-xs sm:text-sm font-bold text-zinc-800 hover:bg-zinc-50 dark:border-zinc-800 dark:bg-zinc-900 dark:text-zinc-200 transition-colors"
          >
            <Calendar className="h-4 w-4 text-red-600" />
            <span>Bugün: {turkeyToday.formattedShort}</span>
          </Link>
        </div>

        <div className="mt-10 pt-6 border-t border-zinc-200 dark:border-zinc-800">
          <span className="text-xs text-zinc-500 block mb-3 font-medium">
            Popüler Takvim Bölümleri
          </span>
          <div className="flex flex-wrap items-center justify-center gap-2 text-xs">
            <Link
              href="/aylar/ekim"
              className="px-3 py-1.5 rounded-xl bg-zinc-100 dark:bg-zinc-800 hover:bg-zinc-200 dark:hover:bg-zinc-700 transition-colors font-semibold"
            >
              Ekim Ayı Takvimi
            </Link>
            <Link
              href="/kategoriler/resmi"
              className="px-3 py-1.5 rounded-xl bg-zinc-100 dark:bg-zinc-800 hover:bg-zinc-200 dark:hover:bg-zinc-700 transition-colors font-semibold"
            >
              Resmi Bayramlar
            </Link>
            <Link
              href="/sosyal-medya-takvimi"
              className="px-3 py-1.5 rounded-xl bg-zinc-100 dark:bg-zinc-800 hover:bg-zinc-200 dark:hover:bg-zinc-700 transition-colors font-semibold"
            >
              Sosyal Medya Planlayıcı
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
}
