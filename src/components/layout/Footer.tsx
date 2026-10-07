import React from "react";
import Link from "next/link";
import { CalendarDays, Heart, Sparkles, ArrowUpRight } from "lucide-react";
import { MONTHS_METADATA } from "@/lib/data/special-days-data";

export function Footer() {
  const currentYear = 2026;

  return (
    <footer className="border-t border-zinc-200 bg-zinc-50/80 text-zinc-600 dark:border-zinc-800 dark:bg-zinc-950 dark:text-zinc-400">
      <div className="mx-auto max-w-7xl px-4 py-12 sm:px-6 lg:px-8">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-8">
          {/* Brand Info */}
          <div className="lg:col-span-2 space-y-4">
            <Link href="/" className="flex items-center gap-2.5">
              <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-gradient-to-tr from-red-600 to-amber-500 text-white shadow-md">
                <CalendarDays className="h-5 w-5" />
              </div>
              <span className="text-xl font-black tracking-tight text-zinc-900 dark:text-white">
                Bugün Ne Günü<span className="text-red-600">?</span>
              </span>
            </Link>
            <p className="text-sm text-zinc-600 dark:text-zinc-400 max-w-sm leading-relaxed">
              Bugün hangi özel gün kutlanıyor? Türkiye ve dünya genelindeki resmi bayramlar, uluslararası farkındalık günleri, mesleki haftalar ve eğlenceli kutlama takvimi.
            </p>
            <div className="flex items-center gap-2 text-xs text-zinc-500">
              <Sparkles className="h-4 w-4 text-amber-500" />
              <span>{currentYear} Yılı Özel Günler ve Kutlama Arşivi</span>
            </div>
          </div>

          {/* Month Pillar Pages */}
          <div className="lg:col-span-2">
            <h4 className="text-xs font-bold uppercase tracking-wider text-zinc-900 dark:text-zinc-100 mb-3">
              Aylık Özel Gün Takvimi
            </h4>
            <div className="grid grid-cols-3 sm:grid-cols-4 gap-2 text-xs">
              {MONTHS_METADATA.map((month) => (
                <Link
                  key={month.slug}
                  href={`/aylar/${month.slug}`}
                  className="rounded-lg p-2 hover:bg-zinc-200/60 dark:hover:bg-zinc-800 text-zinc-700 dark:text-zinc-300 font-medium transition-colors"
                >
                  {month.name} Ayı
                </Link>
              ))}
            </div>
          </div>

          {/* Categories Pillar Pages */}
          <div>
            <h4 className="text-xs font-bold uppercase tracking-wider text-zinc-900 dark:text-zinc-100 mb-3">
              Kategoriler
            </h4>
            <ul className="space-y-2 text-xs font-medium">
              <li>
                <Link href="/kategoriler/resmi" className="hover:text-red-600 transition-colors">
                  Resmi Bayramlar
                </Link>
              </li>
              <li>
                <Link href="/kategoriler/eglence" className="hover:text-red-600 transition-colors">
                  Eğlence & Yaşam
                </Link>
              </li>
              <li>
                <Link href="/kategoriler/saglik" className="hover:text-red-600 transition-colors">
                  Sağlık & Tıp
                </Link>
              </li>
              <li>
                <Link href="/kategoriler/cevre-doga" className="hover:text-red-600 transition-colors">
                  Çevre & Doğa
                </Link>
              </li>
              <li>
                <Link href="/kategoriler/kultur-sanat" className="hover:text-red-600 transition-colors">
                  Kültür & Sanat
                </Link>
              </li>
              <li>
                <Link href="/kategoriler/mesleki" className="hover:text-red-600 transition-colors">
                  Mesleki Günler
                </Link>
              </li>
            </ul>
          </div>

          {/* Popular Special Days */}
          <div>
            <h4 className="text-xs font-bold uppercase tracking-wider text-zinc-900 dark:text-zinc-100 mb-3">
              Popüler Günler
            </h4>
            <ul className="space-y-2 text-xs font-medium">
              <li>
                <Link
                  href="/gun/dunya-kahve-gunu"
                  className="hover:text-red-600 transition-colors flex items-center gap-1"
                >
                  Dünya Kahve Günü
                  <ArrowUpRight className="h-3 w-3 text-zinc-400" />
                </Link>
              </li>
              <li>
                <Link
                  href="/gun/cumhuriyet-bayrami"
                  className="hover:text-red-600 transition-colors flex items-center gap-1"
                >
                  29 Ekim Cumhuriyet Bayramı
                  <ArrowUpRight className="h-3 w-3 text-zinc-400" />
                </Link>
              </li>
              <li>
                <Link
                  href="/gun/ataturku-anma-gunu"
                  className="hover:text-red-600 transition-colors flex items-center gap-1"
                >
                  10 Kasım Atatürk'ü Anma
                  <ArrowUpRight className="h-3 w-3 text-zinc-400" />
                </Link>
              </li>
              <li>
                <Link
                  href="/gun/hayvanlari-koruma-gunu"
                  className="hover:text-red-600 transition-colors flex items-center gap-1"
                >
                  Hayvanları Koruma Günü
                  <ArrowUpRight className="h-3 w-3 text-zinc-400" />
                </Link>
              </li>
              <li>
                <Link
                  href="/gun/ogretmenler-gunu"
                  className="hover:text-red-600 transition-colors flex items-center gap-1"
                >
                  24 Kasım Öğretmenler Günü
                  <ArrowUpRight className="h-3 w-3 text-zinc-400" />
                </Link>
              </li>
            </ul>
          </div>
        </div>

        {/* Bottom Bar */}
        <div className="mt-12 border-t border-zinc-200 pt-6 dark:border-zinc-800 flex flex-col sm:flex-row items-center justify-between text-xs text-zinc-500 gap-4">
          <p>
            © {currentYear} Bugün Ne Günü? Tüm hakları saklıdır. Türkiye ve dünya özel günler, bayramlar ve kutlamalar takvimi.
          </p>
          <div className="flex items-center gap-4">
            <span className="flex items-center gap-1">
              Geliştirildi <Heart className="h-3.5 w-3.5 text-red-500 fill-red-500" /> ile Türkiye
            </span>
          </div>
        </div>
      </div>
    </footer>
  );
}
