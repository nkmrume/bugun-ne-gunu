import React from "react";
import type { Metadata } from "next";
import Link from "next/link";
import {
  CalendarDays,
  ShieldCheck,
  CheckCircle2,
  Award,
  Globe,
  HeartHandshake,
  Users,
  Home,
  ArrowRight,
  BookOpen,
} from "lucide-react";
import { Badge } from "@/components/ui/badge";

export const metadata: Metadata = {
  title: "Hakkımızda",
  description:
    "Bugün Ne Günü? platformunun kuruluş hikayesi, misyonu, kaynak doğrulama ilkeleri ve editoryal vizyonu. Türkiye'nin güvenilir özel günler arşivi.",
  alternates: {
    canonical: "https://bugunnegunu.com/hakkimizda",
  },
};

export default function HakkimizdaPage() {
  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "AboutPage",
    name: "Hakkımızda | Bugün Ne Günü?",
    description: "Bugün Ne Günü? platformunun editoryal yapısı ve doğrulama misyonu.",
    url: "https://bugunnegunu.com/hakkimizda",
    publisher: {
      "@type": "Organization",
      name: "Bugün Ne Günü?",
      url: "https://bugunnegunu.com",
    },
  };

  return (
    <div className="min-h-screen pb-20">
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
      />

      {/* Hero Section */}
      <section className="border-b border-zinc-200/80 bg-gradient-to-b from-red-50/50 via-white to-zinc-50/30 py-12 sm:py-16 dark:border-zinc-800 dark:from-red-950/20 dark:via-zinc-950 dark:to-zinc-900">
        <div className="mx-auto max-w-4xl px-4 sm:px-6 lg:px-8">
          {/* Breadcrumb */}
          <nav aria-label="Breadcrumb" className="flex items-center gap-2 text-xs text-zinc-500 mb-6">
            <Link href="/" className="hover:text-red-600 transition-colors flex items-center gap-1">
              <Home className="h-3.5 w-3.5" />
              <span>Ana Sayfa</span>
            </Link>
            <span>/</span>
            <span className="font-semibold text-zinc-900 dark:text-zinc-100">Hakkımızda</span>
          </nav>

          <Badge variant="default" className="mb-4 text-xs font-bold gap-1.5">
            <ShieldCheck className="h-3.5 w-3.5" />
            Doğrulanmış Bilgi & Şeffaf Yayıncılık
          </Badge>

          <h1 className="text-3xl sm:text-5xl font-black tracking-tight text-zinc-950 dark:text-white leading-[1.15]">
            Türkiye ve Dünyanın Kaynakları Doğrulanmış Özel Günler Takvimi
          </h1>

          <p className="mt-4 text-base sm:text-lg text-zinc-600 dark:text-zinc-300 leading-relaxed">
            <strong>Bugün Ne Günü?</strong>, internetteki bilgi kirliliğini ve tarih çelişkilerini ortadan kaldırmak amacıyla kurulmuş; resmî tatilleri, uluslararası anma ve farkındalık günlerini birincil kaynaklardan teyit ederek sunan bağımsız bir dijital takvim ve içerik rehberidir.
          </p>
        </div>
      </section>

      {/* Main Content */}
      <section className="mx-auto max-w-4xl px-4 sm:px-6 lg:px-8 mt-12 space-y-12">
        {/* Neden Kurulduk? */}
        <div className="rounded-3xl border border-zinc-200/80 bg-white p-6 sm:p-10 dark:border-zinc-800 dark:bg-zinc-900 shadow-sm">
          <h2 className="text-2xl font-black text-zinc-900 dark:text-zinc-100 mb-4">
            Neden Kurulduk?
          </h2>
          <div className="prose prose-zinc dark:prose-invert max-w-none text-zinc-600 dark:text-zinc-300 text-sm sm:text-base leading-relaxed space-y-4">
            <p>
              "Bugün ne günü?" sorusu, Türkiye'de her gün yüz binlerce kullanıcı, öğrenci, öğretmen, sosyal medya yöneticisi ve küçük işletme tarafından aratılmaktadır. Ancak geleneksel arama sonuçlarında karşılaşılan en büyük problem; kaynağı belirsiz tarihler, yanlış resmî tatil iddiaları, anma günlerine uygulanan uygunsuz ticari reklamlar ve güncelliğini yitirmiş içeriklerdir.
            </p>
            <p>
              Biz, her özel günün bir arka planı, yasal veya uluslararası bir dayanağı olduğuna inanıyoruz. Birleşmiş Milletler (BM), UNESCO, Dünya Sağlık Örgütü (DSÖ) ve T.C. Resmî Gazete gibi birincil mercileri referans alarak; yalnızca doğru tarihi değil, o günün gerçek toplumsal anlamını da titizlikle araştırıp sunuyoruz.
            </p>
          </div>
        </div>

        {/* 3 Temel Yayın İlkemiz */}
        <div>
          <h2 className="text-2xl font-black text-zinc-900 dark:text-zinc-100 mb-6 text-center">
            Yayıncılık İlkelerimiz
          </h2>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div className="rounded-2xl border border-zinc-200/80 bg-white p-6 dark:border-zinc-800 dark:bg-zinc-900 shadow-sm">
              <div className="h-10 w-10 rounded-xl bg-red-100 text-red-600 dark:bg-red-950 dark:text-red-400 flex items-center justify-center mb-4">
                <Award className="h-5 w-5" />
              </div>
              <h3 className="font-bold text-base text-zinc-900 dark:text-zinc-100 mb-2">
                1. Birincil Kaynak Doğrulaması
              </h3>
              <p className="text-xs sm:text-sm text-zinc-600 dark:text-zinc-400 leading-relaxed">
                Platformumuzda yer alan hiçbir özel gün kulaktan dolma bilgilerle eklenmez. Her kayıt, uluslararası konvansiyonlar, kanun metinleri veya kurucu kuruluşların resmî belgeleriyle doğrulanır.
              </p>
            </div>

            <div className="rounded-2xl border border-zinc-200/80 bg-white p-6 dark:border-zinc-800 dark:bg-zinc-900 shadow-sm">
              <div className="h-10 w-10 rounded-xl bg-amber-100 text-amber-700 dark:bg-amber-950 dark:text-amber-400 flex items-center justify-center mb-4">
                <HeartHandshake className="h-5 w-5" />
              </div>
              <h3 className="font-bold text-base text-zinc-900 dark:text-zinc-100 mb-2">
                2. Kültürel & Editoryal Hassasiyet
              </h3>
              <p className="text-xs sm:text-sm text-zinc-600 dark:text-zinc-400 leading-relaxed">
                Kutlama günleri ile milli anma ve yas günleri (örn. 10 Kasım Atatürk'ü Anma Günü) kesin çizgilerle ayrılır. Anma günlerinde kutlama dili ve ticari fırsat modülleri asla kullanılmaz.
              </p>
            </div>

            <div className="rounded-2xl border border-zinc-200/80 bg-white p-6 dark:border-zinc-800 dark:bg-zinc-900 shadow-sm">
              <div className="h-10 w-10 rounded-xl bg-sky-100 text-sky-600 dark:bg-sky-950 dark:text-sky-400 flex items-center justify-center mb-4">
                <Globe className="h-5 w-5" />
              </div>
              <h3 className="font-bold text-base text-zinc-900 dark:text-zinc-100 mb-2">
                3. Kullanıcıya Değer Üreten Araçlar
              </h3>
              <p className="text-xs sm:text-sm text-zinc-600 dark:text-zinc-400 leading-relaxed">
                Yalnızca metin sunmakla kalmıyoruz; canlı geri sayım sayaçları, indirilebilir sosyal medya görsel kartları ve özgün kutlama mesajlarıyla kullanıcılarımızın hayatını kolaylaştırıyoruz.
              </p>
            </div>
          </div>
        </div>

        {/* Rakamlarla Platform */}
        <div className="rounded-3xl border border-red-200/80 bg-gradient-to-r from-red-50/60 via-rose-50/40 to-amber-50/50 p-8 dark:border-red-950/60 dark:from-red-950/20 dark:via-zinc-900 dark:to-zinc-950">
          <div className="grid grid-cols-2 md:grid-cols-4 gap-6 text-center">
            <div>
              <div className="text-3xl sm:text-4xl font-black text-red-600 dark:text-red-400 font-mono">
                365
              </div>
              <div className="mt-1 text-xs font-semibold text-zinc-600 dark:text-zinc-400">
                Günlük Tarih Sayfası
              </div>
            </div>
            <div>
              <div className="text-3xl sm:text-4xl font-black text-red-600 dark:text-red-400 font-mono">
                115+
              </div>
              <div className="mt-1 text-xs font-semibold text-zinc-600 dark:text-zinc-400">
                Teyitli Özel Gün
              </div>
            </div>
            <div>
              <div className="text-3xl sm:text-4xl font-black text-red-600 dark:text-red-400 font-mono">
                8
              </div>
              <div className="mt-1 text-xs font-semibold text-zinc-600 dark:text-zinc-400">
                Tematik Kategori
              </div>
            </div>
            <div>
              <div className="text-3xl sm:text-4xl font-black text-emerald-600 dark:text-emerald-400 font-mono">
                %100
              </div>
              <div className="mt-1 text-xs font-semibold text-zinc-600 dark:text-zinc-400">
                Kaynak Doğrulama
              </div>
            </div>
          </div>
        </div>

        {/* CTA Banner */}
        <div className="flex flex-col sm:flex-row items-center justify-between gap-4 rounded-2xl border border-zinc-200 bg-zinc-50 p-6 dark:border-zinc-800 dark:bg-zinc-900/50">
          <div>
            <h4 className="font-bold text-base text-zinc-900 dark:text-zinc-100">
              Editoryal ekibimiz ve doğrulama süreçlerimiz hakkında bilgi alın
            </h4>
            <p className="text-xs text-zinc-500 mt-1">
              Künye sayfamızda sorumlu editörlerimizi ve içerik doğrulama yönergelerimizi inceleyebilirsiniz.
            </p>
          </div>
          <Link
            href="/kunye"
            className="inline-flex items-center gap-1.5 rounded-xl bg-zinc-900 text-white px-4 py-2.5 text-xs font-bold hover:bg-zinc-800 transition-colors shrink-0 dark:bg-zinc-100 dark:text-zinc-900 dark:hover:bg-zinc-200"
          >
            <span>Künye ve İlkeler</span>
            <ArrowRight className="h-3.5 w-3.5" />
          </Link>
        </div>
      </section>
    </div>
  );
}
