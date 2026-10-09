"use client";

import React, { useState, useMemo, useCallback } from "react";
import Link from "next/link";
import {
  CalendarDays,
  Sparkles,
  Share2,
  Copy,
  Check,
  Download,
  Filter,
  ArrowRight,
  Lightbulb,
  Coffee,
  HeartPulse,
  GraduationCap,
  Laptop,
  ShoppingBag,
  Home,
  Calendar,
  Layers,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { INITIAL_SPECIAL_DAYS } from "@/lib/data/special-days-data";
import { SpecialDay } from "@/types/database";
import { getTurkeyToday } from "@/lib/date-engine";
import { formatDayMonthOnly, TURKISH_MONTHS } from "@/lib/utils";
import { AddToCalendarButton } from "@/components/day/AddToCalendarButton";
import { specialDayToEventPayload } from "@/lib/calendar-engine";

export default function SosyalMedyaTakvimiPage() {
  const turkeyToday = useMemo(() => getTurkeyToday(), []);
  const [selectedIndustry, setSelectedIndustry] = useState<string>("all");
  const [timeRange, setTimeRange] = useState<"7days" | "14days" | "month">("7days");
  const [copiedDayId, setCopiedDayId] = useState<string | null>(null);
  const [copiedAllPlan, setCopiedAllPlan] = useState(false);

  // Industry mapping
  const industries = [
    { id: "all", label: "Tüm Sektörler", icon: Layers },
    { id: "gastronomi", label: "Kafe & Restoran", icon: Coffee },
    { id: "saglik", label: "Sağlık & Eczane", icon: HeartPulse },
    { id: "egitim", label: "Eğitim & Okul", icon: GraduationCap },
    { id: "teknoloji", label: "Bilişim & Yazılım", icon: Laptop },
    { id: "eticaret", label: "E-Ticaret & Perakende", icon: ShoppingBag },
  ];

  // Calculate day difference from today
  const getDayDistance = useCallback((month: number, day: number) => {
    const daysInMonths = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    let todayDays = turkeyToday.day;
    for (let m = 1; m < turkeyToday.month; m++) todayDays += daysInMonths[m];

    let targetDays = day;
    for (let m = 1; m < month; m++) targetDays += daysInMonths[m];

    let diff = targetDays - todayDays;
    if (diff < 0) diff += 365;
    return diff;
  }, [turkeyToday]);

  // Filter special days by time range
  const filteredDays = useMemo(() => {
    const maxDays = timeRange === "7days" ? 7 : timeRange === "14days" ? 14 : 31;

    return INITIAL_SPECIAL_DAYS.filter((day) => {
      const distance = getDayDistance(day.month_no, day.day_no);
      if (distance > maxDays) return false;

      // Industry filtering logic
      if (selectedIndustry === "gastronomi") {
        return (
          day.category === "Eğlence" ||
          day.affiliate_keywords.some((k) =>
            k.includes("kahve") || k.includes("çay") || k.includes("çikolata") || k.includes("mutfak")
          ) ||
          day.slug.includes("kahve") ||
          day.slug.includes("pizza") ||
          day.slug.includes("ekmek")
        );
      }
      if (selectedIndustry === "saglik") {
        return (
          day.category === "Sağlık" ||
          day.slug.includes("saglik") ||
          day.slug.includes("ruh") ||
          day.slug.includes("diyabet") ||
          day.slug.includes("hemsire")
        );
      }
      if (selectedIndustry === "egitim") {
        return (
          day.slug.includes("ogretmen") ||
          day.slug.includes("cocuk") ||
          day.slug.includes("kitap") ||
          day.category === "Kültür & Sanat"
        );
      }
      if (selectedIndustry === "teknoloji") {
        return (
          day.slug.includes("yazilim") ||
          day.slug.includes("bilgi") ||
          day.slug.includes("internet") ||
          day.slug.includes("tasarim") ||
          day.category === "Mesleki"
        );
      }
      if (selectedIndustry === "eticaret") {
        return day.affiliate_keywords.length > 0 && day.day_type !== "anma";
      }

      return true;
    }).sort((a, b) => getDayDistance(a.month_no, a.day_no) - getDayDistance(b.month_no, b.day_no));
  }, [selectedIndustry, timeRange, getDayDistance]);

  // Industry-specific post concept suggestions
  const getPostIdea = (day: SpecialDay) => {
    if (day.day_type === "anma") {
      return "🇹🇷 Saygılı Görsel & Resmi Anma Mesajı: Markanızın kurumsal duruşunu sergileyen, sade ve saygılı bir anma görseli paylaşın.";
    }
    if (day.category === "Eğlence" || day.slug.includes("kahve")) {
      return "☕ Reels / Story Anketi: Takipçilerinize günün temasına uygun en sevdikleri tercihi sorun (Örn: 'Siz güne hangi kahveyle başlıyorsunuz?').";
    }
    if (day.category === "Sağlık") {
      return "💡 Bilgilendirici İpucu Karuseli: 3 maddelik pratik farkındalık veya sağlıklı yaşam önerisi paylaşarak kaydetme oranını artırın.";
    }
    return "📸 Etkileşimli Gönderi: Günün anlam ve önemine değinen bir hikaye paylaşın ve takipçilerinizden günün temasına dair yorum isteyin.";
  };

  // Copy single day caption
  const handleCopyDayCaption = (day: SpecialDay) => {
    const isMemorial = day.day_type === "anma";
    const text = isMemorial
      ? `${day.title}\n📅 ${formatDayMonthOnly(day.day_no, day.month_no)} 2026\n\nCumhuriyetimizin kurucusu Gazi Mustafa Kemal Atatürk'ü saygı, rahmet ve minnetle anıyoruz. 🇹🇷🖤\n\n${day.hashtags.join(" ")}\n\nKaynak: bugunnegunu.com`
      : `${day.title}\n📅 ${formatDayMonthOnly(day.day_no, day.month_no)} 2026\n\n${day.description}\n\n${day.title} kutlu olsun! ✨\n\n${day.hashtags.join(" ")}\n\nKaynak: bugunnegunu.com`;

    navigator.clipboard.writeText(text);
    setCopiedDayId(day.id);
    setTimeout(() => setCopiedDayId(null), 2000);
  };

  // Copy entire plan as text
  const handleCopyEntirePlan = () => {
    let fullText = `📅 HAFTALIK SOSYAL MEDYA İÇERİK PLANI (${turkeyToday.formattedShort} İtibarıyla)\nHazırlayan: bugunnegunu.com\n\n`;

    filteredDays.forEach((day, idx) => {
      fullText += `--- ${idx + 1}. GÜN: ${day.title} (${day.day_no} ${TURKISH_MONTHS[day.month_no]}) ---\n`;
      fullText += `🎯 İçerik Fikri: ${getPostIdea(day)}\n`;
      fullText += `🏷️ Etiketler: ${day.hashtags.slice(0, 4).join(" ")}\n`;
      fullText += `🔗 Detaylar: https://bugunnegunu.com/gun/${day.slug}\n\n`;
    });

    navigator.clipboard.writeText(fullText);
    setCopiedAllPlan(true);
    setTimeout(() => setCopiedAllPlan(false), 2500);
  };

  return (
    <div className="min-h-screen pb-20">
      {/* Hero */}
      <section className="border-b border-zinc-200/80 bg-gradient-to-b from-red-50/50 via-white to-zinc-50/30 py-12 sm:py-16 dark:border-zinc-800 dark:from-red-950/20 dark:via-zinc-950 dark:to-zinc-900">
        <div className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8">
          <nav aria-label="Breadcrumb" className="flex items-center gap-2 text-xs text-zinc-500 mb-6">
            <Link href="/" className="hover:text-red-600 transition-colors flex items-center gap-1">
              <Home className="h-3.5 w-3.5" />
              <span>Ana Sayfa</span>
            </Link>
            <span>/</span>
            <span className="font-semibold text-zinc-900 dark:text-zinc-100">Sosyal Medya Planlayıcısı</span>
          </nav>

          <div className="flex flex-col md:flex-row md:items-end justify-between gap-6">
            <div>
              <Badge variant="default" className="mb-3 text-xs font-bold gap-1.5">
                <Sparkles className="h-3.5 w-3.5" />
                Sosyal Medya & İçerik Üreticileri İçin
              </Badge>

              <h1 className="text-3xl sm:text-5xl font-black tracking-tight text-zinc-950 dark:text-white leading-[1.15]">
                Haftalık Sosyal Medya İçerik Takvimi
              </h1>

              <p className="mt-3 text-base sm:text-lg text-zinc-600 dark:text-zinc-300 max-w-2xl leading-relaxed">
                &quot;Önümüzdeki hafta ne paylaşmalıyım?&quot; sorusuna son! Sektörünüze özel yaklaşan günleri filtreleyin, hazır içerik fikirlerini ve Instagram altyazılarını tek tıkla kopyalayın.
              </p>
            </div>

            <Button
              onClick={handleCopyEntirePlan}
              className="gap-2 bg-zinc-900 hover:bg-zinc-800 text-white font-bold rounded-xl shadow-md shrink-0 dark:bg-zinc-100 dark:text-zinc-900"
            >
              {copiedAllPlan ? (
                <>
                  <Check className="h-4 w-4 text-emerald-500" />
                  <span>Tüm Plan Kopyalandı!</span>
                </>
              ) : (
                <>
                  <Copy className="h-4 w-4" />
                  <span>Haftalık Planı Dışa Aktar</span>
                </>
              )}
            </Button>
          </div>
        </div>
      </section>

      {/* Filter Controls Bar */}
      <section className="sticky top-16 z-30 border-b border-zinc-200/80 bg-white/95 backdrop-blur-md dark:border-zinc-800 dark:bg-zinc-950/95 py-3.5">
        <div className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
            {/* Time Range Filter */}
            <div className="flex items-center gap-1.5 rounded-xl bg-zinc-100 p-1 dark:bg-zinc-900 border border-zinc-200/60 dark:border-zinc-800">
              <button
                onClick={() => setTimeRange("7days")}
                className={`rounded-lg px-3 py-1.5 text-xs font-bold transition-all cursor-pointer ${
                  timeRange === "7days"
                    ? "bg-white text-zinc-900 shadow-sm dark:bg-zinc-800 dark:text-white"
                    : "text-zinc-500 hover:text-zinc-900 dark:hover:text-zinc-300"
                }`}
              >
                Önümüzdeki 7 Gün
              </button>
              <button
                onClick={() => setTimeRange("14days")}
                className={`rounded-lg px-3 py-1.5 text-xs font-bold transition-all cursor-pointer ${
                  timeRange === "14days"
                    ? "bg-white text-zinc-900 shadow-sm dark:bg-zinc-800 dark:text-white"
                    : "text-zinc-500 hover:text-zinc-900 dark:hover:text-zinc-300"
                }`}
              >
                14 Gün
              </button>
              <button
                onClick={() => setTimeRange("month")}
                className={`rounded-lg px-3 py-1.5 text-xs font-bold transition-all cursor-pointer ${
                  timeRange === "month"
                    ? "bg-white text-zinc-900 shadow-sm dark:bg-zinc-800 dark:text-white"
                    : "text-zinc-500 hover:text-zinc-900 dark:hover:text-zinc-300"
                }`}
              >
                Tüm Ay (30 Gün)
              </button>
            </div>

            {/* Industry Pill Selector */}
            <div className="flex items-center gap-1.5 overflow-x-auto pb-1 sm:pb-0 scrollbar-none">
              {industries.map((ind) => {
                const Icon = ind.icon;
                const isSelected = selectedIndustry === ind.id;
                return (
                  <button
                    key={ind.id}
                    onClick={() => setSelectedIndustry(ind.id)}
                    className={`inline-flex items-center gap-1.5 rounded-xl px-3 py-1.5 text-xs font-bold transition-all whitespace-nowrap cursor-pointer ${
                      isSelected
                        ? "bg-red-600 text-white shadow-sm"
                        : "bg-zinc-100 hover:bg-zinc-200/80 text-zinc-600 dark:bg-zinc-900 dark:text-zinc-400 dark:hover:bg-zinc-800"
                    }`}
                  >
                    <Icon className="h-3.5 w-3.5" />
                    <span>{ind.label}</span>
                  </button>
                );
              })}
            </div>
          </div>
        </div>
      </section>

      {/* Days Stream Grid */}
      <section className="mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 mt-10">
        <div className="flex items-center justify-between mb-6">
          <div className="flex items-center gap-2">
            <Calendar className="h-4 w-4 text-red-600" />
            <h2 className="text-xl sm:text-2xl font-black text-zinc-900 dark:text-zinc-100">
              Yaklaşan İçerik Fırsatları ({filteredDays.length})
            </h2>
          </div>
          <span className="text-xs text-zinc-500">
            Bugün: {turkeyToday.formattedShort}
          </span>
        </div>

        {filteredDays.length > 0 ? (
          <div className="space-y-6">
            {filteredDays.map((day) => {
              const distance = getDayDistance(day.month_no, day.day_no);
              const isToday = distance === 0;
              const isMemorial = day.day_type === "anma";

              return (
                <div
                  key={day.id}
                  className={`rounded-3xl border p-6 transition-all shadow-sm ${
                    isToday
                      ? "border-red-300 bg-red-50/40 dark:border-red-900/60 dark:bg-red-950/20"
                      : "border-zinc-200/90 bg-white hover:border-zinc-300 dark:border-zinc-800 dark:bg-zinc-900"
                  }`}
                >
                  <div className="flex flex-col sm:flex-row sm:items-start justify-between gap-4">
                    {/* Date Pill & Title */}
                    <div className="space-y-2">
                      <div className="flex items-center gap-2.5">
                        <span className="inline-flex items-center justify-center rounded-xl bg-zinc-100 px-3 py-1 font-mono text-xs font-black text-zinc-900 dark:bg-zinc-800 dark:text-zinc-100">
                          {formatDayMonthOnly(day.day_no, day.month_no)}
                        </span>
                        <Badge variant={isMemorial ? "secondary" : "default"} className="text-[10px]">
                          {isMemorial ? "🇹🇷 Anma Günü" : day.category}
                        </Badge>
                        <span className="text-xs font-bold text-zinc-500">
                          {distance === 0 ? "Bugün!" : `${distance} gün sonra`}
                        </span>
                      </div>

                      <h3 className="text-xl font-black text-zinc-900 dark:text-zinc-100">
                        <Link href={`/gun/${day.slug}`} className="hover:text-red-600 transition-colors">
                          {day.title}
                        </Link>
                      </h3>

                      <p className="text-xs sm:text-sm text-zinc-600 dark:text-zinc-300 leading-relaxed max-w-2xl">
                        {day.description}
                      </p>
                    </div>

                    {/* Quick CTA Actions */}
                    <div className="flex items-center gap-2 self-start shrink-0">
                      <Button
                        onClick={() => handleCopyDayCaption(day)}
                        variant="outline"
                        className="gap-1.5 text-xs font-bold rounded-xl"
                      >
                        {copiedDayId === day.id ? (
                          <>
                            <Check className="h-3.5 w-3.5 text-emerald-600" />
                            <span className="text-emerald-600">Kopyalandı</span>
                          </>
                        ) : (
                          <>
                            <Copy className="h-3.5 w-3.5" />
                            <span>Metni Kopyala</span>
                          </>
                        )}
                      </Button>

                      <AddToCalendarButton
                        event={specialDayToEventPayload(day)}
                        buttonText="Takvime Ekle"
                        variant="secondary"
                      />
                    </div>
                  </div>

                  {/* Creative Content Idea Box */}
                  <div className="mt-4 rounded-2xl bg-zinc-50 p-4 border border-zinc-200/60 dark:bg-zinc-800/40 dark:border-zinc-700/60">
                    <div className="flex items-start gap-2.5">
                      <Lightbulb className="h-4 w-4 text-amber-500 shrink-0 mt-0.5" />
                      <div className="space-y-1">
                        <span className="text-xs font-bold text-zinc-900 dark:text-zinc-100 block">
                          Önerilen İçerik Formatı:
                        </span>
                        <p className="text-xs text-zinc-600 dark:text-zinc-400 leading-relaxed">
                          {getPostIdea(day)}
                        </p>
                      </div>
                    </div>

                    {/* Hashtags */}
                    <div className="mt-3 pt-3 border-t border-zinc-200/50 dark:border-zinc-700/50 flex flex-wrap gap-1.5">
                      {day.hashtags.map((tag, idx) => (
                        <span
                          key={idx}
                          className="inline-block rounded-lg bg-white px-2 py-0.5 text-[10px] font-medium text-zinc-500 border border-zinc-200/60 dark:bg-zinc-800 dark:border-zinc-700 dark:text-zinc-400"
                        >
                          {tag}
                        </span>
                      ))}
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        ) : (
          <div className="rounded-3xl border border-dashed border-zinc-300 p-12 text-center dark:border-zinc-800">
            <p className="text-sm font-semibold text-zinc-500">
              Seçilen sektör ve tarih aralığında özel gün kaydı bulunamadı. Lütfen &quot;Tüm Sektörler&quot; filtresini seçin.
            </p>
          </div>
        )}
      </section>
    </div>
  );
}
