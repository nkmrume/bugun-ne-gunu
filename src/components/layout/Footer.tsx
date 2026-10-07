import React from "react";
import Link from "next/link";
import { CalendarDays, Heart, Sparkles, ArrowUpRight, ShieldCheck } from "lucide-react";
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
              Bugün hangi özel gün kutlanıyor? Türkiye ve dünya genelindeki resmi bayramlar, uluslararası anma ve farkındalık günleri, doğrulanmış birincil kaynaklar ve içerik rehberi.
            </p>
            <div className="flex items-center gap-2 text-xs text-zinc-500">
              <ShieldCheck className="h-4 w-4 text-emerald-500" />
              <span>BM, UNESCO ve T.C. Resmî Gazete Teyitli Kayıtlar</span>
            </div>
          </div>

          {/* Month Pillar Pages */}
          <div>
            <h4 className="text-xs font-bold uppercase tracking-wider text-zinc-900 dark:text-zinc-100 mb-3">
              Aylık Takvim
            </h4>
            <div className="grid grid-cols-2 gap-1 text-xs">
              {MONTHS_METADATA.slice(0, 8).map((month) => (
                <Link
                  key={month.slug}
                  href={`/aylar/${month.slug}`}
                  className="rounded-lg p-1.5 hover:bg-zinc-200/60 dark:hover:bg-zinc-800 text-zinc-700 dark:text-zinc-300 font-medium transition-colors"
                >
                  {month.name}
                </Link>
              ))}
            </div>
            <Link
              href="/aylar/ekim"
              className="mt-2 inline-block text-xs font-bold text-red-600 hover:underline"
            >
              Tüm Aylar »
            </Link>
          </div>

          {/* Categories Pillar Pages */}
          <div>
            <h4 className="text-xs font-bold uppercase tracking-wider text-zinc-900 dark:text-zinc-100 mb-3">
              Kategoriler
            </h4>
            <ul className="space-y-2 text-xs font-medium">
              <li>
                <Link href="/kategoriler/resmi" className="hover:text-red-600 transition-colors">
                  🇹🇷 Resmi Bayramlar
                </Link>
              </li>
              <li>
                <Link href="/kategoriler/eglence" className="hover:text-red-600 transition-colors">
                  ☕ Eğlence & Yaşam
                </Link>
              </li>
              <li>
                <Link href="/kategoriler/saglik" className="hover:text-red-600 transition-colors">
                  🩺 Sağlık & Tıp
                </Link>
              </li>
              <li>
                <Link href="/kategoriler/cevre-doga" className="hover:text-red-600 transition-colors">
                  🌱 Çevre & Doğa
                </Link>
              </li>
              <li>
                <Link href="/kategoriler/kultur-sanat" className="hover:text-red-600 transition-colors">
                  🎭 Kültür & Sanat
                </Link>
              </li>
              <li>
                <Link href="/kategoriler" className="font-bold text-red-600 hover:underline">
                  Tüm Kategoriler »
                </Link>
              </li>
            </ul>
          </div>

          {/* Kurumsal & Güvenilirlik (EEAT Compliance) */}
          <div>
            <h4 className="text-xs font-bold uppercase tracking-wider text-zinc-900 dark:text-zinc-100 mb-3">
              Kurumsal & Güven
            </h4>
            <ul className="space-y-2 text-xs font-medium">
              <li>
                <Link href="/hakkimizda" className="hover:text-red-600 transition-colors">
                  Hakkımızda
                </Link>
              </li>
              <li>
                <Link href="/kunye" className="hover:text-red-600 transition-colors">
                  Künye & Editoryal İlkeler
                </Link>
              </li>
              <li>
                <Link href="/iletisim" className="hover:text-red-600 transition-colors">
                  İletişim & Hata Bildir
                </Link>
              </li>
              <li>
                <Link href="/gizlilik-politikasi" className="hover:text-red-600 transition-colors">
                  Gizlilik Politikası
                </Link>
              </li>
              <li>
                <Link href="/kullanim-kosullari" className="hover:text-red-600 transition-colors">
                  Kullanım Koşulları
                </Link>
              </li>
            </ul>
          </div>
        </div>

        {/* Bottom Bar */}
        <div className="mt-12 border-t border-zinc-200 pt-6 dark:border-zinc-800 flex flex-col sm:flex-row items-center justify-between text-xs text-zinc-500 gap-4">
          <p>
            © {currentYear} Bugün Ne Günü? Tüm hakları saklıdır. Kaynakları doğrulanmış özel günler ve kutlamalar rehberi.
          </p>
          <div className="flex items-center gap-4 text-xs">
            <Link href="/hakkimizda" className="hover:underline">Hakkımızda</Link>
            <span>•</span>
            <Link href="/kunye" className="hover:underline">Künye</Link>
            <span>•</span>
            <Link href="/gizlilik-politikasi" className="hover:underline">Gizlilik</Link>
            <span>•</span>
            <Link href="/iletisim" className="hover:underline">İletişim</Link>
          </div>
        </div>
      </div>
    </footer>
  );
}
