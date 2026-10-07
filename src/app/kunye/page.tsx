import React from "react";
import type { Metadata } from "next";
import Link from "next/link";
import {
  FileText,
  ShieldCheck,
  CheckCircle2,
  Mail,
  AlertCircle,
  Home,
  Users,
  Search,
  Scale,
  Sparkles,
} from "lucide-react";
import { Badge } from "@/components/ui/badge";

export const metadata: Metadata = {
  title: "Künye ve Editoryal İlkeler",
  description:
    "Bugün Ne Günü? editoryal kurulu, sorumlu editör bilgileri, içerik doğrulama standartları ve hata düzeltme politikası.",
  alternates: {
    canonical: "https://bugunnegunu.com/kunye",
  },
};

export default function KunyePage() {
  return (
    <div className="min-h-screen pb-20">
      {/* Hero Section */}
      <section className="border-b border-zinc-200/80 bg-gradient-to-b from-zinc-50/80 via-white to-zinc-50/30 py-12 sm:py-16 dark:border-zinc-800 dark:from-zinc-900/60 dark:via-zinc-950 dark:to-zinc-900">
        <div className="mx-auto max-w-4xl px-4 sm:px-6 lg:px-8">
          <nav aria-label="Breadcrumb" className="flex items-center gap-2 text-xs text-zinc-500 mb-6">
            <Link href="/" className="hover:text-red-600 transition-colors flex items-center gap-1">
              <Home className="h-3.5 w-3.5" />
              <span>Ana Sayfa</span>
            </Link>
            <span>/</span>
            <span className="font-semibold text-zinc-900 dark:text-zinc-100">Künye</span>
          </nav>

          <Badge variant="secondary" className="mb-4 text-xs font-bold gap-1.5">
            <FileText className="h-3.5 w-3.5" />
            Editoryal Şeffaflık
          </Badge>

          <h1 className="text-3xl sm:text-5xl font-black tracking-tight text-zinc-950 dark:text-white">
            Künye & Doğrulama Standartları
          </h1>

          <p className="mt-4 text-base sm:text-lg text-zinc-600 dark:text-zinc-300 leading-relaxed">
            Bugün Ne Günü? platformunda yayınlanan tüm içerikler bağımsız editoryal ilkeler, birincil kaynak araştırmaları ve sıkı doğrulama prosedürleri çerçevesinde hazırlanmaktadır.
          </p>
        </div>
      </section>

      {/* Main Content */}
      <section className="mx-auto max-w-4xl px-4 sm:px-6 lg:px-8 mt-12 space-y-10">
        {/* Editoryal Kurul */}
        <div className="rounded-3xl border border-zinc-200/80 bg-white p-6 sm:p-10 dark:border-zinc-800 dark:bg-zinc-900 shadow-sm">
          <div className="flex items-center gap-2 mb-6">
            <Users className="h-5 w-5 text-red-600" />
            <h2 className="text-xl sm:text-2xl font-black text-zinc-900 dark:text-zinc-100">
              Yayın Kurulu ve Sorumlular
            </h2>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-6">
            <div className="rounded-2xl bg-zinc-50 p-5 dark:bg-zinc-800/50 border border-zinc-200/60 dark:border-zinc-700/60">
              <span className="text-[11px] font-bold uppercase tracking-wider text-red-600 dark:text-red-400">
                Genel Yayın Yönetmeni
              </span>
              <h3 className="mt-1 font-bold text-base text-zinc-900 dark:text-zinc-100">
                Bugün Ne Günü Editoryal Masası
              </h3>
              <p className="mt-1 text-xs text-zinc-500 leading-relaxed">
                Platformun genel yayın politikası, takvim bütünlüğü ve içerik doğruluğundan sorumludur.
              </p>
              <div className="mt-3 text-xs text-zinc-600 dark:text-zinc-400 font-medium flex items-center gap-1.5">
                <Mail className="h-3.5 w-3.5 text-zinc-400" />
                <span>editor@bugunnegunu.com</span>
              </div>
            </div>

            <div className="rounded-2xl bg-zinc-50 p-5 dark:bg-zinc-800/50 border border-zinc-200/60 dark:border-zinc-700/60">
              <span className="text-[11px] font-bold uppercase tracking-wider text-red-600 dark:text-red-400">
                Tarih & Veri Doğrulama Uzmanı
              </span>
              <h3 className="mt-1 font-bold text-base text-zinc-900 dark:text-zinc-100">
                Araştırma ve Arşiv Ekibi
              </h3>
              <p className="mt-1 text-xs text-zinc-500 leading-relaxed">
                Birleşmiş Milletler kararları, T.C. Resmî Gazete arşivleri ve uluslararası konvansiyonları inceler.
              </p>
              <div className="mt-3 text-xs text-zinc-600 dark:text-zinc-400 font-medium flex items-center gap-1.5">
                <Mail className="h-3.5 w-3.5 text-zinc-400" />
                <span>arastirma@bugunnegunu.com</span>
              </div>
            </div>
          </div>
        </div>

        {/* Doğrulama Hiyerarşisi */}
        <div className="rounded-3xl border border-zinc-200/80 bg-white p-6 sm:p-10 dark:border-zinc-800 dark:bg-zinc-900 shadow-sm">
          <div className="flex items-center gap-2 mb-6">
            <Search className="h-5 w-5 text-amber-600" />
            <h2 className="text-xl sm:text-2xl font-black text-zinc-900 dark:text-zinc-100">
              Kaynak Doğrulama Hiyerarşisi (Fact-Checking)
            </h2>
          </div>

          <p className="text-sm text-zinc-600 dark:text-zinc-400 leading-relaxed mb-6">
            Platformumuza bir özel gün veya anma tarihi eklenirken aşağıdaki kaynak piramidi uygulanır:
          </p>

          <div className="space-y-4">
            <div className="flex items-start gap-3.5 p-4 rounded-2xl bg-emerald-50/70 border border-emerald-200/70 dark:bg-emerald-950/20 dark:border-emerald-900/40">
              <ShieldCheck className="h-5 w-5 text-emerald-600 dark:text-emerald-400 shrink-0 mt-0.5" />
              <div>
                <h4 className="font-bold text-sm text-emerald-950 dark:text-emerald-200">
                  1. Kademe: Resmî ve Hukuki Birincil Kaynaklar
                </h4>
                <p className="mt-1 text-xs text-emerald-800 dark:text-emerald-300 leading-relaxed">
                  T.C. Resmî Gazete (2429 sayılı Ulusal Bayram ve Genel Tatiller Hakkında Kanun), Birleşmiş Milletler Genel Kurul Kararları (UN Resolutions), UNESCO, DSÖ (WHO) ve ILO resmî ilanları.
                </p>
              </div>
            </div>

            <div className="flex items-start gap-3.5 p-4 rounded-2xl bg-blue-50/70 border border-blue-200/70 dark:bg-blue-950/20 dark:border-blue-900/40">
              <CheckCircle2 className="h-5 w-5 text-blue-600 dark:text-blue-400 shrink-0 mt-0.5" />
              <div>
                <h4 className="font-bold text-sm text-blue-950 dark:text-blue-200">
                  2. Kademe: Kurucu Meslek Birlikleri ve Küresel Federasyonlar
                </h4>
                <p className="mt-1 text-xs text-blue-800 dark:text-blue-300 leading-relaxed">
                  İlgili günü başlatan uluslararası örgütler (Örn: Uluslararası Kahve Örgütü - ICO, Dünya Ruh Sağlığı Federasyonu, TMMOB, Türk Tabipleri Birliği).
                </p>
              </div>
            </div>

            <div className="flex items-start gap-3.5 p-4 rounded-2xl bg-zinc-50 border border-zinc-200 dark:bg-zinc-800/40 dark:border-zinc-700">
              <AlertCircle className="h-5 w-5 text-zinc-500 shrink-0 mt-0.5" />
              <div>
                <h4 className="font-bold text-sm text-zinc-900 dark:text-zinc-100">
                  Kabul Edilmeyen Kaynaklar
                </h4>
                <p className="mt-1 text-xs text-zinc-600 dark:text-zinc-400 leading-relaxed">
                  Anonim internet blogları, kaynağı gösterilmemiş sosyal medya iddiaları ve doğrulanmamış ticari kampanya bültenleri kesinlikle kaynak olarak kullanılmaz.
                </p>
              </div>
            </div>
          </div>
        </div>

        {/* Hata Düzeltme Politikası */}
        <div className="rounded-3xl border border-zinc-200/80 bg-white p-6 sm:p-10 dark:border-zinc-800 dark:bg-zinc-900 shadow-sm">
          <div className="flex items-center gap-2 mb-4">
            <Scale className="h-5 w-5 text-sky-600" />
            <h2 className="text-xl sm:text-2xl font-black text-zinc-900 dark:text-zinc-100">
              Hata Düzeltme Politikası (Corrections Policy)
            </h2>
          </div>

          <p className="text-sm text-zinc-600 dark:text-zinc-400 leading-relaxed">
            Takvimimizde yer alan herhangi bir tarihte, resmî tatil statüsünde veya açıklama metninde bir hata tespit edilmesi durumunda; okuyucularımızın ve resmî kurumların bildirimleri <strong>en geç 24 saat içerisinde</strong> incelenir. Hata tespit edildiğinde ilgili sayfa derhal güncellenir ve şeffaflık ilkemiz gereği sayfanın altındaki doğrulama tarihi yenilenir.
          </p>

          <div className="mt-6 p-4 rounded-2xl bg-zinc-50 border border-zinc-200 dark:bg-zinc-800/40 dark:border-zinc-700 flex flex-col sm:flex-row sm:items-center justify-between gap-3">
            <div>
              <span className="font-bold text-xs text-zinc-900 dark:text-zinc-100 block">
                Bir hata veya eksiklik mi fark ettiniz?
              </span>
              <span className="text-xs text-zinc-500">
                Düzeltme bildirimlerinizi öncelikli olarak işleme alıyoruz.
              </span>
            </div>
            <Link
              href="/iletisim"
              className="inline-flex items-center gap-1.5 rounded-xl bg-red-600 hover:bg-red-700 text-white px-4 py-2 text-xs font-bold transition-colors shrink-0"
            >
              <Mail className="h-3.5 w-3.5" />
              <span>Hata Bildir</span>
            </Link>
          </div>
        </div>
      </section>
    </div>
  );
}
