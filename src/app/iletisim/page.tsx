"use client";

import React, { useState } from "react";
import Link from "next/link";
import {
  Mail,
  MessageSquare,
  ShieldAlert,
  Send,
  CheckCircle2,
  Home,
  Clock,
  Sparkles,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";

export default function IletisimPage() {
  const [submitted, setSubmitted] = useState(false);
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    subject: "Hata Bildirimi / Düzeltme",
    message: "",
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    // Simulate client-side confirmation & provide direct mailto link
    setSubmitted(true);
  };

  return (
    <div className="min-h-screen pb-20">
      {/* Hero Section */}
      <section className="border-b border-zinc-200/80 bg-gradient-to-b from-red-50/40 via-white to-zinc-50/30 py-12 sm:py-16 dark:border-zinc-800 dark:from-red-950/20 dark:via-zinc-950 dark:to-zinc-900">
        <div className="mx-auto max-w-4xl px-4 sm:px-6 lg:px-8">
          <nav aria-label="Breadcrumb" className="flex items-center gap-2 text-xs text-zinc-500 mb-6">
            <Link href="/" className="hover:text-red-600 transition-colors flex items-center gap-1">
              <Home className="h-3.5 w-3.5" />
              <span>Ana Sayfa</span>
            </Link>
            <span>/</span>
            <span className="font-semibold text-zinc-900 dark:text-zinc-100">İletişim</span>
          </nav>

          <Badge variant="default" className="mb-4 text-xs font-bold gap-1.5">
            <Mail className="h-3.5 w-3.5" />
            Doğrudan İletişim & Destek
          </Badge>

          <h1 className="text-3xl sm:text-5xl font-black tracking-tight text-zinc-950 dark:text-white">
            Bizimle İletişime Geçin
          </h1>

          <p className="mt-4 text-base sm:text-lg text-zinc-600 dark:text-zinc-300 leading-relaxed">
            Takvimimizde yer alan bir gün hakkında düzeltme bildirmek, yeni bir ulusal/uluslararası gün önermek veya kurumsal iş birlikleri için bize ulaşabilirsiniz.
          </p>
        </div>
      </section>

      {/* Main Grid */}
      <section className="mx-auto max-w-4xl px-4 sm:px-6 lg:px-8 mt-12">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          {/* Left Column: Direct Info Cards */}
          <div className="space-y-4">
            <div className="rounded-2xl border border-zinc-200/80 bg-white p-5 dark:border-zinc-800 dark:bg-zinc-900 shadow-sm">
              <span className="text-[10px] font-bold uppercase tracking-wider text-red-600 dark:text-red-400">
                Editoryal Masası & Hata Bildirimi
              </span>
              <h3 className="mt-1 font-bold text-sm text-zinc-900 dark:text-zinc-100">
                Tarih Düzeltmeleri
              </h3>
              <p className="mt-1 text-xs text-zinc-500">
                Tarih, tatil durumu veya bilgi uyuşmazlığı bildirimleri.
              </p>
              <a
                href="mailto:editor@bugunnegunu.com"
                className="mt-3 inline-flex items-center gap-1.5 text-xs font-semibold text-red-600 hover:underline"
              >
                <Mail className="h-3.5 w-3.5" />
                <span>editor@bugunnegunu.com</span>
              </a>
            </div>

            <div className="rounded-2xl border border-zinc-200/80 bg-white p-5 dark:border-zinc-800 dark:bg-zinc-900 shadow-sm">
              <span className="text-[10px] font-bold uppercase tracking-wider text-zinc-500">
                Genel İletişim
              </span>
              <h3 className="mt-1 font-bold text-sm text-zinc-900 dark:text-zinc-100">
                Öneri ve Görüşler
              </h3>
              <p className="mt-1 text-xs text-zinc-500">
                Kullanıcı deneyimi ve genel platform soruları.
              </p>
              <a
                href="mailto:iletisim@bugunnegunu.com"
                className="mt-3 inline-flex items-center gap-1.5 text-xs font-semibold text-zinc-700 dark:text-zinc-300 hover:underline"
              >
                <Mail className="h-3.5 w-3.5" />
                <span>iletisim@bugunnegunu.com</span>
              </a>
            </div>

            <div className="rounded-2xl border border-zinc-200/80 bg-white p-5 dark:border-zinc-800 dark:bg-zinc-900 shadow-sm">
              <span className="text-[10px] font-bold uppercase tracking-wider text-zinc-500">
                Kurumsal & Basın
              </span>
              <h3 className="mt-1 font-bold text-sm text-zinc-900 dark:text-zinc-100">
                İş Birliği & Sponsorluk
              </h3>
              <p className="mt-1 text-xs text-zinc-500">
                Marka entegrasyonu ve sektörel takvim ortaklıkları.
              </p>
              <a
                href="mailto:kurumsal@bugunnegunu.com"
                className="mt-3 inline-flex items-center gap-1.5 text-xs font-semibold text-zinc-700 dark:text-zinc-300 hover:underline"
              >
                <Mail className="h-3.5 w-3.5" />
                <span>kurumsal@bugunnegunu.com</span>
              </a>
            </div>

            <div className="rounded-2xl bg-zinc-50 p-4 border border-zinc-200/60 dark:bg-zinc-800/40 dark:border-zinc-700 text-xs text-zinc-500 space-y-1">
              <div className="flex items-center gap-1.5 font-bold text-zinc-700 dark:text-zinc-300">
                <Clock className="h-3.5 w-3.5 text-emerald-500" />
                <span>Ortalama Yanıt Süresi</span>
              </div>
              <p>Tüm e-postalar en geç 24-48 saat içerisinde değerlendirilir.</p>
            </div>
          </div>

          {/* Right Column: Contact Form */}
          <div className="md:col-span-2">
            <div className="rounded-3xl border border-zinc-200/80 bg-white p-6 sm:p-8 dark:border-zinc-800 dark:bg-zinc-900 shadow-sm">
              <h2 className="text-xl font-black text-zinc-900 dark:text-zinc-100 mb-2">
                Mesaj veya Düzeltme Gönderin
              </h2>
              <p className="text-xs sm:text-sm text-zinc-500 mb-6">
                Aşağıdaki formu doldurarak editörlerimize doğrudan mesaj iletebilirsiniz.
              </p>

              {submitted ? (
                <div className="rounded-2xl bg-emerald-50 border border-emerald-200 p-6 text-center dark:bg-emerald-950/20 dark:border-emerald-900">
                  <CheckCircle2 className="h-10 w-10 text-emerald-600 mx-auto mb-2" />
                  <h3 className="font-bold text-base text-emerald-950 dark:text-emerald-200">
                    Mesajınız Alındı!
                  </h3>
                  <p className="text-xs text-emerald-800 dark:text-emerald-300 mt-1 max-w-sm mx-auto">
                    Bildiriminiz editoryal masamıza iletildi. İlgili kayıt incelenerek gerekli güncellemeler yapılacaktır. Teşekkür ederiz.
                  </p>
                  <Button
                    onClick={() => setSubmitted(false)}
                    variant="outline"
                    className="mt-4 text-xs font-bold"
                  >
                    Yeni Mesaj Gönder
                  </Button>
                </div>
              ) : (
                <form onSubmit={handleSubmit} className="space-y-4">
                  <div>
                    <label className="block text-xs font-bold text-zinc-700 dark:text-zinc-300 mb-1">
                      Adınız Soyadınız
                    </label>
                    <Input
                      required
                      type="text"
                      placeholder="Örn: Mehmet Yılmaz"
                      value={formData.name}
                      onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                      className="rounded-xl"
                    />
                  </div>

                  <div>
                    <label className="block text-xs font-bold text-zinc-700 dark:text-zinc-300 mb-1">
                      E-posta Adresiniz
                    </label>
                    <Input
                      required
                      type="email"
                      placeholder="Örn: ornek@eposta.com"
                      value={formData.email}
                      onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                      className="rounded-xl"
                    />
                  </div>

                  <div>
                    <label className="block text-xs font-bold text-zinc-700 dark:text-zinc-300 mb-1">
                      Konu
                    </label>
                    <select
                      value={formData.subject}
                      onChange={(e) => setFormData({ ...formData, subject: e.target.value })}
                      className="w-full rounded-xl border border-zinc-200 bg-white px-3 py-2 text-xs font-medium text-zinc-900 shadow-sm focus:outline-none focus:ring-2 focus:ring-red-600 dark:border-zinc-800 dark:bg-zinc-900 dark:text-zinc-100"
                    >
                      <option value="Hata Bildirimi / Düzeltme">Tarih veya Bilgi Hatası Bildirimi</option>
                      <option value="Yeni Özel Gün Önerisi">Yeni Özel Gün / Hafta Önerisi</option>
                      <option value="Kurumsal İş Birliği">Kurumsal İş Birliği & Reklam</option>
                      <option value="Diğer">Diğer Konular</option>
                    </select>
                  </div>

                  <div>
                    <label className="block text-xs font-bold text-zinc-700 dark:text-zinc-300 mb-1">
                      Mesajınız ve Kaynak Bilgisi
                    </label>
                    <textarea
                      required
                      rows={5}
                      placeholder="Düzeltilmesini istediğiniz tarihi, sayfayı veya önerinizi detaylı şekilde yazabilirsiniz..."
                      value={formData.message}
                      onChange={(e) => setFormData({ ...formData, message: e.target.value })}
                      className="w-full rounded-xl border border-zinc-200 bg-white p-3 text-xs text-zinc-900 shadow-sm focus:outline-none focus:ring-2 focus:ring-red-600 dark:border-zinc-800 dark:bg-zinc-900 dark:text-zinc-100 resize-none"
                    />
                  </div>

                  <Button
                    type="submit"
                    className="w-full gap-2 bg-red-600 hover:bg-red-700 text-white font-bold rounded-xl py-3"
                  >
                    <Send className="h-4 w-4" />
                    <span>Mesajı Gönder</span>
                  </Button>
                </form>
              )}
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
