import React from "react";
import type { Metadata } from "next";
import Link from "next/link";
import { FileCheck, Home } from "lucide-react";
import { Badge } from "@/components/ui/badge";

export const metadata: Metadata = {
  title: "Kullanım Koşulları",
  description:
    "Bugün Ne Günü? kullanım koşulları, içerik telif hakları, veri alıntılama standartları ve yasal sorumluluk reddi.",
  alternates: {
    canonical: "https://bugunnegunu.com/kullanim-kosullari",
  },
};

export default function KullanimKosullariPage() {
  return (
    <div className="min-h-screen pb-20">
      {/* Hero */}
      <section className="border-b border-zinc-200/80 bg-gradient-to-b from-zinc-50/80 via-white to-zinc-50/30 py-12 sm:py-16 dark:border-zinc-800 dark:from-zinc-900/60 dark:via-zinc-950 dark:to-zinc-900">
        <div className="mx-auto max-w-4xl px-4 sm:px-6 lg:px-8">
          <nav aria-label="Breadcrumb" className="flex items-center gap-2 text-xs text-zinc-500 mb-6">
            <Link href="/" className="hover:text-red-600 transition-colors flex items-center gap-1">
              <Home className="h-3.5 w-3.5" />
              <span>Ana Sayfa</span>
            </Link>
            <span>/</span>
            <span className="font-semibold text-zinc-900 dark:text-zinc-100">Kullanım Koşulları</span>
          </nav>

          <Badge variant="secondary" className="mb-4 text-xs font-bold gap-1.5">
            <FileCheck className="h-3.5 w-3.5" />
            Yasal Şartlar
          </Badge>

          <h1 className="text-3xl sm:text-5xl font-black tracking-tight text-zinc-950 dark:text-white">
            Kullanım Koşulları
          </h1>

          <p className="mt-4 text-xs sm:text-sm text-zinc-500">
            Son Güncelleme: 8 Ekim 2026
          </p>
        </div>
      </section>

      {/* Main Content */}
      <section className="mx-auto max-w-4xl px-4 sm:px-6 lg:px-8 mt-12">
        <div className="rounded-3xl border border-zinc-200/80 bg-white p-6 sm:p-10 dark:border-zinc-800 dark:bg-zinc-900 shadow-sm prose prose-zinc dark:prose-invert max-w-none text-zinc-600 dark:text-zinc-300 text-sm sm:text-base leading-relaxed space-y-6">
          <div>
            <h2 className="text-xl font-bold text-zinc-900 dark:text-zinc-100 mb-2">
              1. Genel Hükümler
            </h2>
            <p>
              Bu web sitesini (<strong>bugunnegunu.com</strong>) ziyaret ederek ve kullanarak aşağıdaki koşulları kabul etmiş sayılırsınız. Şartları kabul etmiyorsanız lütfen siteyi kullanmayınız.
            </p>
          </div>

          <div>
            <h2 className="text-xl font-bold text-zinc-900 dark:text-zinc-100 mb-2">
              2. Fikri Mülkiyet ve İçerik Paylaşım İzni
            </h2>
            <p>
              Platformumuzda üretilen metinler, grafik kartlar, geri sayım tasarımları ve veritabanı yapısı telif hakları ile korunmaktadır.
            </p>
            <ul className="list-disc pl-5 space-y-1">
              <li><strong>Sosyal Medya ve Bireysel Kullanım:</strong> Sitemiz üzerinden üretilen hazır sosyal medya kartları, görseller ve kutlama mesajları; bireysel kullanıcılar, öğretmenler ve küçük işletmeler tarafından sosyal medya hesaplarında ve iletişim kanallarında serbestçe paylaşılabilir.</li>
              <li><strong>Alıntı ve Kaynak Gösterme:</strong> İçeriklerimizden internet sitelerinde alıntı yapılırken, alıntılanan sayfamıza doğrudan ve tıklanabilir bir bağlantı (link) verilmesi zorunludur. Tüm veritabanının toplu olarak kopyalanması veya botlarla çekilmesi (scraping) yasaktır.</li>
            </ul>
          </div>

          <div>
            <h2 className="text-xl font-bold text-zinc-900 dark:text-zinc-100 mb-2">
              3. Sorumluluk Reddi (Disclaimer)
            </h2>
            <p>
              Bugün Ne Günü? ekibi, takvim bilgilerini ve resmî tatil statülerini en güncel ve güvenilir resmî kaynaklardan temin etmek için azami özeni göstermektedir. Ancak idari makamlarca sonradan yapılan tatil uzatmaları, köprü tatil kararları veya uluslararası kurumların takvim değişikliklerinden doğabilecek olası aksaklıklardan platformumuz doğrudan sorumlu tutulamaz. Kritik resmî işlemleriniz öncesinde Resmî Gazete duyurularını teyit etmeniz tavsiye edilir.
            </p>
          </div>

          <div>
            <h2 className="text-xl font-bold text-zinc-900 dark:text-zinc-100 mb-2">
              4. İletişim
            </h2>
            <p>
              Kullanım koşullarına ilişkin her türlü soru ve bildirimleriniz için <strong>iletisim@bugunnegunu.com</strong> üzerinden bize ulaşabilirsiniz.
            </p>
          </div>
        </div>
      </section>
    </div>
  );
}
