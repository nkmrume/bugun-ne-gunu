"use client";

import React, { useState, useEffect, useRef } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { Search, Calendar, Sparkles, X, ArrowRight, Tag } from "lucide-react";
import { SpecialDay } from "@/types/database";
import { formatDayMonthOnly } from "@/lib/utils";
import { Badge } from "@/components/ui/badge";

interface SearchModalProps {
  isOpen: boolean;
  onClose: () => void;
  allDays: SpecialDay[];
}

export function SearchModal({ isOpen, onClose, allDays }: SearchModalProps) {
  const [query, setQuery] = useState("");
  const inputRef = useRef<HTMLInputElement>(null);
  const router = useRouter();

  useEffect(() => {
    if (isOpen) {
      setTimeout(() => {
        inputRef.current?.focus();
      }, 50);
    } else {
      setQuery("");
    }
  }, [isOpen]);

  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === "Escape") {
        onClose();
      }
      if ((e.metaKey || e.ctrlKey) && e.key === "k") {
        e.preventDefault();
        if (isOpen) {
          onClose();
        } else {
          // Trigger open via custom event or caller
        }
      }
    };
    window.addEventListener("keydown", handleKeyDown);
    return () => window.removeEventListener("keydown", handleKeyDown);
  }, [isOpen, onClose]);

  if (!isOpen) return null;

  const filteredDays = query.trim()
    ? allDays.filter((day) => {
        const q = query.toLowerCase();
        return (
          day.title.toLowerCase().includes(q) ||
          day.description.toLowerCase().includes(q) ||
          day.category.toLowerCase().includes(q) ||
          day.hashtags.some((h) => h.toLowerCase().includes(q))
        );
      })
    : allDays.slice(0, 5);

  const handleSelectDay = (slug: string) => {
    onClose();
    router.push(`/gun/${slug}`);
  };

  return (
    <div className="fixed inset-0 z-50 flex items-start justify-center pt-16 sm:pt-24 px-4 bg-zinc-950/60 backdrop-blur-sm animate-in fade-in-0 duration-200">
      <div
        className="w-full max-w-xl overflow-hidden rounded-3xl border border-zinc-200 bg-white shadow-2xl dark:border-zinc-800 dark:bg-zinc-900"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Search Input Bar */}
        <div className="relative flex items-center border-b border-zinc-200 px-4 py-3.5 dark:border-zinc-800">
          <Search className="h-5 w-5 text-zinc-400" />
          <input
            ref={inputRef}
            type="text"
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="Özel gün, bayram veya kategori ara (örn: Kahve, 29 Ekim)..."
            className="w-full bg-transparent px-3 text-base text-zinc-900 placeholder:text-zinc-400 focus:outline-none dark:text-zinc-100 dark:placeholder:text-zinc-500"
          />
          {query ? (
            <button
              onClick={() => setQuery("")}
              className="p-1 rounded-lg text-zinc-400 hover:text-zinc-600 dark:hover:text-zinc-200"
            >
              <X className="h-4 w-4" />
            </button>
          ) : (
            <kbd className="hidden sm:inline-flex items-center gap-1 rounded bg-zinc-100 px-2 py-0.5 text-[10px] font-mono text-zinc-500 dark:bg-zinc-800 dark:text-zinc-400 border border-zinc-200 dark:border-zinc-700">
              ESC
            </kbd>
          )}
        </div>

        {/* Results */}
        <div className="max-h-[60vh] overflow-y-auto p-3">
          <div className="px-3 py-2 text-[11px] font-bold uppercase tracking-wider text-zinc-400 dark:text-zinc-500 flex items-center justify-between">
            <span>{query ? "Arama Sonuçları" : "Popüler & Öne Çıkan Günler"}</span>
            <span>{filteredDays.length} gün bulundu</span>
          </div>

          {filteredDays.length === 0 ? (
            <div className="py-12 text-center">
              <Calendar className="mx-auto h-10 w-10 text-zinc-300 dark:text-zinc-700" />
              <p className="mt-3 text-sm font-medium text-zinc-600 dark:text-zinc-400">
                &ldquo;{query}&rdquo; ile eşleşen bir gün bulunamadı.
              </p>
              <p className="mt-1 text-xs text-zinc-400">
                Farklı bir kelime aramayı deneyebilir veya aylık takvimimize göz atabilirsiniz.
              </p>
            </div>
          ) : (
            <div className="space-y-1 mt-1">
              {filteredDays.map((day) => (
                <button
                  key={day.id}
                  onClick={() => handleSelectDay(day.slug)}
                  className="group flex w-full items-center justify-between rounded-2xl p-3 text-left transition-colors hover:bg-zinc-100 dark:hover:bg-zinc-800/80 cursor-pointer"
                >
                  <div className="flex items-center gap-3">
                    <div className="flex h-11 w-11 shrink-0 flex-col items-center justify-center rounded-xl bg-red-50 text-red-600 dark:bg-red-950/60 dark:text-red-400 border border-red-100 dark:border-red-900/60">
                      <span className="text-xs font-bold leading-none">{day.day_no}</span>
                      <span className="text-[9px] font-semibold uppercase leading-tight">
                        {formatDayMonthOnly(day.day_no, day.month_no).split(" ")[1]}
                      </span>
                    </div>

                    <div>
                      <div className="flex items-center gap-2">
                        <span className="font-bold text-sm text-zinc-900 dark:text-zinc-100 group-hover:text-red-600 transition-colors">
                          {day.title}
                        </span>
                        <Badge variant="secondary" className="text-[10px] py-0 px-2">
                          {day.category}
                        </Badge>
                      </div>
                      <p className="text-xs text-zinc-500 line-clamp-1 mt-0.5">
                        {day.description}
                      </p>
                    </div>
                  </div>

                  <ArrowRight className="h-4 w-4 text-zinc-300 opacity-0 group-hover:opacity-100 group-hover:text-zinc-700 transition-all dark:text-zinc-600 dark:group-hover:text-zinc-300" />
                </button>
              ))}
            </div>
          )}
        </div>

        {/* Modal Footer */}
        <div className="border-t border-zinc-100 bg-zinc-50/70 px-4 py-3 text-xs text-zinc-500 dark:border-zinc-800 dark:bg-zinc-900/80 flex items-center justify-between">
          <div className="flex items-center gap-2">
            <Sparkles className="h-3.5 w-3.5 text-amber-500" />
            <span>Hızlı arama için <kbd className="font-mono bg-zinc-200/60 dark:bg-zinc-800 px-1.5 py-0.5 rounded">Ctrl + K</kbd> tuşlarını kullanabilirsiniz.</span>
          </div>
          <button
            onClick={onClose}
            className="text-xs font-medium text-zinc-600 hover:text-zinc-900 dark:text-zinc-400 dark:hover:text-zinc-100"
          >
            Kapat
          </button>
        </div>
      </div>
    </div>
  );
}
