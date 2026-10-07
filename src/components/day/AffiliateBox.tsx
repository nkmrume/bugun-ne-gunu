"use client";

import React from "react";
import { SpecialDay } from "@/types/database";
import { ShoppingBag, ExternalLink, Sparkles, Tag, ShieldCheck } from "lucide-react";
import { Badge } from "@/components/ui/badge";

interface AffiliateBoxProps {
  specialDay: SpecialDay;
}

export function AffiliateBox({ specialDay }: AffiliateBoxProps) {
  // Never display commercial affiliate boxes on memorial days or if keywords are explicitly empty
  if (
    specialDay.day_type === "anma" ||
    !specialDay.affiliate_keywords ||
    specialDay.affiliate_keywords.length === 0
  ) {
    return null;
  }

  const keywords = specialDay.affiliate_keywords;

  return (
    <div className="relative overflow-hidden rounded-3xl border border-amber-200/90 bg-gradient-to-br from-amber-50/60 via-white to-orange-50/40 p-6 md:p-8 shadow-sm dark:border-amber-900/40 dark:from-amber-950/20 dark:via-zinc-900 dark:to-orange-950/10">
      {/* Background ambient decorative glow */}
      <div className="pointer-events-none absolute -right-12 -top-12 h-40 w-40 rounded-full bg-amber-400/10 blur-3xl" />
      <div className="pointer-events-none absolute -left-12 -bottom-12 h-40 w-40 rounded-full bg-orange-400/10 blur-3xl" />

      {/* Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 border-b border-amber-200/60 pb-6 dark:border-amber-900/40">
        <div>
          <div className="flex items-center gap-2">
            <Badge variant="warning" className="gap-1.5 font-bold uppercase tracking-wider text-[11px]">
              <Sparkles className="h-3.5 w-3.5 text-amber-600 dark:text-amber-400" />
              Günün Hediye & Ürün Rehberi
            </Badge>
            <span className="flex items-center gap-1 text-xs text-zinc-500">
              <ShieldCheck className="h-3.5 w-3.5 text-emerald-500" />
              Editoryal Öneri
            </span>
          </div>
          <h3 className="mt-2 text-xl md:text-2xl font-black text-zinc-900 dark:text-zinc-100">
            {specialDay.title} İçin Hediye ve Ekipman Seçenekleri
          </h3>
          <p className="mt-1 text-sm text-zinc-600 dark:text-zinc-400">
            Günün anlamına uygun hediye alternatiflerini ve popüler modelleri güvenilir pazaryerlerinde inceleyin.
          </p>
        </div>

        <div className="hidden sm:flex items-center gap-2 rounded-2xl bg-white px-4 py-2 shadow-sm border border-amber-100 dark:bg-zinc-800 dark:border-zinc-700">
          <Tag className="h-4 w-4 text-amber-500" />
          <span className="text-xs font-semibold text-zinc-800 dark:text-zinc-200">
            Fiyatları Mağazada İncele
          </span>
        </div>
      </div>

      {/* Keyword Offer Cards */}
      <div className="mt-6 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
        {keywords.map((keyword, index) => {
          const trendyolUrl = `https://www.trendyol.com/sr?q=${encodeURIComponent(keyword)}`;
          const amazonUrl = `https://www.amazon.com.tr/s?k=${encodeURIComponent(keyword)}`;

          return (
            <div
              key={index}
              className="group relative flex flex-col justify-between rounded-2xl border border-zinc-200/80 bg-white p-5 shadow-sm transition-all duration-200 hover:-translate-y-1 hover:border-amber-300 hover:shadow-md dark:border-zinc-800 dark:bg-zinc-900/90 dark:hover:border-amber-800/80"
            >
              <div>
                <div className="flex items-center justify-between">
                  <span className="inline-flex h-8 w-8 items-center justify-center rounded-xl bg-amber-100 text-amber-800 dark:bg-amber-950/60 dark:text-amber-300">
                    <ShoppingBag className="h-4 w-4" />
                  </span>
                  <span className="text-[11px] font-bold text-zinc-600 bg-zinc-100 px-2.5 py-0.5 rounded-full dark:bg-zinc-800 dark:text-zinc-300">
                    Kategori Rehberi
                  </span>
                </div>

                <h4 className="mt-4 font-bold text-zinc-900 capitalize dark:text-zinc-100 group-hover:text-amber-600 transition-colors">
                  {keyword}
                </h4>
                <p className="mt-1 text-xs text-zinc-500 line-clamp-2">
                  {specialDay.title} konseptine uygun en çok tercih edilen modeller ve kullanıcı yorumları.
                </p>
              </div>

              <div className="mt-5 pt-3 border-t border-zinc-100 dark:border-zinc-800 flex items-center justify-between gap-2">
                <a
                  href={trendyolUrl}
                  target="_blank"
                  rel="sponsored nofollow noopener noreferrer"
                  className="flex-1 inline-flex items-center justify-center gap-1.5 rounded-xl bg-orange-500 hover:bg-orange-600 text-white px-3 py-2 text-xs font-bold transition-colors shadow-sm"
                >
                  <span>Trendyol</span>
                  <ExternalLink className="h-3 w-3" />
                </a>
                <a
                  href={amazonUrl}
                  target="_blank"
                  rel="sponsored nofollow noopener noreferrer"
                  className="flex-1 inline-flex items-center justify-center gap-1.5 rounded-xl bg-zinc-800 hover:bg-zinc-900 text-white px-3 py-2 text-xs font-bold transition-colors shadow-sm dark:bg-zinc-700 dark:hover:bg-zinc-600"
                >
                  <span>Amazon</span>
                  <ExternalLink className="h-3 w-3" />
                </a>
              </div>
            </div>
          );
        })}
      </div>

      {/* Commercial Affiliate Disclaimer */}
      <div className="mt-6 pt-4 border-t border-amber-200/40 text-center">
        <p className="text-[11px] text-zinc-500 dark:text-zinc-400">
          * Bu sayfada yer alan ürün bağlantıları bağımsız editoryal önerilerimizdir. Bağlantılar üzerinden yapılan alışverişlerde satış ortaklığı kapsamında küçük bir komisyon elde edilebilir; bu durum sizin ödediğiniz fiyatı etkilemez.
        </p>
      </div>
    </div>
  );
}
