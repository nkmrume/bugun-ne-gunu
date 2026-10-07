import React from "react";
import type { Metadata } from "next";
import Link from "next/link";
import { ShieldCheck, Lock, Eye, Home } from "lucide-react";
import { Badge } from "@/components/ui/badge";

export const metadata: Metadata = {
  title: "Gizlilik Politikası ve Çerezler",
  description:
    "Bugün Ne Günü? gizlilik politikası, kişisel verilerin korunması (KVKK/GDPR) ve çerez politikası aydınlatma metni.",
  alternates: {
    canonical: "https://bugunnegunu.com/gizlilik-politikasi",
  },
};

export default function GizlilikPolitikasiPage() {
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
            <span className="font-semibold text-zinc-900 dark:text-zinc-100">Gizlilik Politikası</span>
          </nav>

          <Badge variant="secondary" className="mb-4 text-xs font-bold gap-1.5">
            <Lock className="h-3.5 w-3.5" />
            Yasal Aydınlatma
          </Badge>

          <h1 className="text-3xl sm:text-5xl font-black tracking-tight text-zinc-950 dark:text-white">
            Gizlilik Politikası ve Çerezler
          </h1>

          <p className="mt-4 text-xs sm:text-sm text-zinc-500">
            Son Güncelleme: 8 Ekim 2026 • 6698 sayılı KVKK ve GDPR ile Tam Uyumlu
          </p>
        </div>
      </section>

      {/* Main Content */}
      <section className="mx-auto max-w-4xl px-4 sm:px-6 lg:px-8 mt-12">
        <div className="rounded-3xl border border-zinc-200/80 bg-white p-6 sm:p-10 dark:border-zinc-800 dark:bg-zinc-900 shadow-sm prose prose-zinc dark:prose-invert max-w-none text-zinc-600 dark:text-zinc-300 text-sm sm:text-base leading-relaxed space-y-6">
          <div>
            <h2 className="text-xl font-bold text-zinc-900 dark:text-zinc-100 mb-2">
              1. Giriş ve Veri Sorumlusu
            </h2>
            <p>
              İşbu Gizlilik Politikası, <strong>bugunnegunu.com</strong> (“Platform”) alan adlı web sitesini ziyaret eden kullanıcıların kişisel verilerinin 6698 sayılı Kişisel Verilerin Korunması Kanunu (“KVKK”) ve Genel Veri Koruma Tüzüğü (“GDPR”) ilkelerine uygun olarak işlenmesi ve korunmasına ilişkin esasları belirler.
            </p>
          </div>

          <div>
            <h2 className="text-xl font-bold text-zinc-900 dark:text-zinc-100 mb-2">
              2. Toplanan Veriler ve Toplama Amaçları
            </h2>
            <p>Platformumuz üyelik veya zorunlu hesap oluşturma gerektirmeyen açık bir kamu takvimidir. Toplanan veriler yalnızca teknik gereksinimlerle sınırlıdır:</p>
            <ul className="list-disc pl-5 space-y-1">
              <li><strong>Teknik Log Verileri:</strong> Sayfa görüntüleme sayıları, tarayıcı türü, işletim sistemi ve anonimleştirilmiş IP adresi (güvenlik ve performans analitiği için).</li>
              <li><strong>İletişim Verileri:</strong> İletişim veya hata bildirme formunu kullandığınızda ilettiğiniz isim, e-posta adresi ve mesaj içeriği (yalnızca talebinize yanıt vermek amacıyla).</li>
            </ul>
          </div>

          <div>
            <h2 className="text-xl font-bold text-zinc-900 dark:text-zinc-100 mb-2">
              3. Çerez (Cookie) Kullanımı ve Reklam Ağları
            </h2>
            <p>
              Platformumuzda kullanıcı deneyimini iyileştirmek, site trafiğini ölçümlemek ve ilgili reklam içerikleri sunabilmek amacıyla birinci ve üçüncü taraf çerezler kullanılabilir:
            </p>
            <ul className="list-disc pl-5 space-y-1">
              <li><strong>Zorunlu Çerezler:</strong> Sitenin temel fonksiyonlarının (sayfa geçişleri, arama) çalışması için gereklidir.</li>
              <li><strong>Google AdSense & Reklam Çerezleri:</strong> Google dahil olmak üzere üçüncü taraf sağlayıcılar, sitemize veya diğer internet sitelerine yaptığınız önceki ziyaretlere dayalı olarak reklam yayınlamak için çerezleri (örneğin DoubleClick çerezi) kullanabilir. Kullanıcılar, Google Reklam Ayarları üzerinden kişiselleştirilmiş reklamcılığı devre dışı bırakabilirler.</li>
            </ul>
          </div>

          <div>
            <h2 className="text-xl font-bold text-zinc-900 dark:text-zinc-100 mb-2">
              4. Satış Ortaklığı (Affiliate Disclosure) Açıklaması
            </h2>
            <p>
              Sitemizdeki bazı hediye ve ürün önerisi bağlantıları satış ortaklığı (affiliate) linkleri içerebilir. Bu linklere tıklayarak harici mağazalardan (örneğin Trendyol veya Amazon) alışveriş yaptığınızda, platformumuz ürün fiyatını artırmaksızın küçük bir aracılık komisyonu kazanabilir. Bu durum editoryal tarafsızlığımızı ve ürün seçimlerimizi kesinlikle etkilemez.
            </p>
          </div>

          <div>
            <h2 className="text-xl font-bold text-zinc-900 dark:text-zinc-100 mb-2">
              5. Kullanıcı Hakları (KVKK Madde 11)
            </h2>
            <p>
              KVKK'nın 11. maddesi uyarınca her kullanıcı; kişisel verilerinin işlenip işlenmediğini öğrenme, işlenmişse bilgi talep etme, verilerin amacına uygun kullanılıp kullanılmadığını öğrenme ve silinmesini talep etme hakkına sahiptir. Taleplerinizi <strong>iletisim@bugunnegunu.com</strong> adresine yazılı olarak iletebilirsiniz.
            </p>
          </div>
        </div>
      </section>
    </div>
  );
}
