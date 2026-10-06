"use client";

import React from "react";
import { SpecialDay } from "@/types/database";
import { ShoppingBag, ExternalLink, Sparkles, Tag, ShieldCheck, ArrowRight } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";

interface AffiliateBoxProps {
  specialDay: SpecialDay;
}

export function AffiliateBox({ specialDay }: AffiliateBoxProps) {
  const keywords = specialDay.affiliate_keywords.length > 0
    ? specialDay.affiliate_keywords
    : ["özel gün hediyesi", "kutlama seti", "anı hediyesi"];

  return (
    <div className="relative overflow-hidden rounded-3xl border border-amber-200 bg-gradient-to-br from-amber-50/80 via-white to-orange-50/50 p-6 md:p-8 shadow-sm dark:border-amber-900/40 dark:from-amber-950/20 dark:via-zinc-900 dark:to-orange-950/10">
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
              Doğrulanmış Fırsatlar
            </span>
          </div>
          <h3 className="mt-2 text-xl md:text-2xl font-black text-zinc-900 dark:text-zinc-100">
            {specialDay.title} İçin En Çok Tercih Edilen Hediyeler
          </h3>
          <p className="mt-1 text-sm text-zinc-600 dark:text-zinc-400">
            Kutlamanızı unutulmaz kılacak popüler hediye seçenekleri ve özel indirimli ürün koleksiyonları.
          </p>
        </div>

        <div className="hidden sm:flex items-center gap-2 rounded-2xl bg-white px-4 py-2.5 shadow-sm border border-amber-100 dark:bg-zinc-800 dark:border-zinc-700">
          <Tag className="h-4 w-4 text-amber-500" />
          <span className="text-xs font-semibold text-zinc-800 dark:text-zinc-200">
            Özel Kampanyalar Aktif
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
                  <span className="text-[11px] font-bold text-amber-600 bg-amber-50 px-2.5 py-0.5 rounded-full dark:bg-amber-950/40 dark:text-amber-400">
                    %{15 + (index * 7) % 35} İndirim Fırsatı
                  </span>
                </div>

                <h4 className="mt-4 font-bold text-zinc-900 capitalize dark:text-zinc-100 group-hover:text-amber-600 transition-colors">
                  {keyword}
                </h4>
                <p className="mt-1 text-xs text-zinc-500 line-clamp-2">
                  {specialDay.title} konseptine uygun en çok satan ve yüksek puanlı modelleri keşfedin.
                </p>
              </div>

              <div className="mt-5 pt-3 border-t border-zinc-100 dark:border-zinc-800 flex items-center justify-between gap-2">
                <a
                  href={trendyolUrl}
                  target="_blank"
                  rel="noopener noreferrer nofollow"
                  className="flex-1 inline-flex items-center justify-center gap-1.5 rounded-xl bg-orange-500 hover:bg-orange-600 text-white px-3 py-2 text-xs font-bold transition-colors shadow-sm"
                >
                  <span>Trendyol</span>
                  <ExternalLink className="h-3 w-3" />
                </a>
                <a
                  href={amazonUrl}
                  target="_blank"
                  rel="noopener noreferrer nofollow"
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

      {/* Conversion Banner Footer */}
      <div className="mt-6 flex flex-col sm:flex-row items-center justify-between rounded-2xl bg-amber-500/10 p-4 border border-amber-300/40 dark:bg-amber-950/30 dark:border-amber-900/40 gap-3">
        <div className="flex items-center gap-3">
          <div className="hidden sm:flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-amber-500 text-zinc-950 font-black">
            %
          </div>
          <div className="text-center sm:text-left">
            <p className="text-sm font-bold text-zinc-900 dark:text-zinc-100">
              Kupon Kodu: <span className="font-mono text-red-600 dark:text-red-400">BUGUNNEKUTLU</span>
            </p>
            <p className="text-xs text-zinc-500">
              Seçili mağazalarda geçerli sürpriz hediye çeki ve indirimler için mağazaya göz atın.
            </p>
          </div>
        </div>

        <a
          href={`https://www.trendyol.com/sr?q=${encodeURIComponent(specialDay.title)}`}
          target="_blank"
          rel="noopener noreferrer nofollow"
          className="inline-flex items-center gap-1.5 text-xs font-bold text-amber-700 hover:text-amber-800 hover:underline dark:text-amber-400"
        >
          Tüm Fırsatları Görüntüle
          <ArrowRight className="h-3.5 w-3.5" />
        </a>
      </div>

      <p className="mt-4 text-center text-[10px] text-zinc-400 dark:text-zinc-500">
        * Sitemiz üzerinden gerçekleştirilen alışverişlerden iş ortaklarımız (Trendyol & Amazon) aracılığıyla komisyon elde edilebilir. Fiyat ve stok bilgisi ilgili sitelerde anlık değişebilir.
      </p>
    </div>
  );
}
