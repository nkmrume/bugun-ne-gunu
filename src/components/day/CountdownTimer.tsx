"use client";

import React, { useState, useEffect } from "react";
import { Clock, Sparkles, CheckCircle2 } from "lucide-react";
import { DayType } from "@/types/database";

interface CountdownTimerProps {
  targetMonth: number;
  targetDay: number;
  targetYear?: number;
  title: string;
  dayType?: DayType;
}

interface TimeRemaining {
  isToday: boolean;
  days: number;
  hours: number;
  minutes: number;
  seconds: number;
}

export function CountdownTimer({
  targetMonth,
  targetDay,
  title,
  dayType = "kutlama",
}: CountdownTimerProps) {
  const [timeLeft, setTimeLeft] = useState<TimeRemaining | null>(null);

  useEffect(() => {
    function calculateTime() {
      const now = new Date();
      const currentYear = now.getFullYear();

      // Create target date for this year
      let targetDate = new Date(currentYear, targetMonth - 1, targetDay, 0, 0, 0);

      // Check if today is the day (same year, month, day)
      const isToday =
        now.getFullYear() === targetDate.getFullYear() &&
        now.getMonth() === targetDate.getMonth() &&
        now.getDate() === targetDate.getDate();

      if (isToday) {
        setTimeLeft({
          isToday: true,
          days: 0,
          hours: 0,
          minutes: 0,
          seconds: 0,
        });
        return;
      }

      // If target date already passed this year, point to next year
      if (now.getTime() > targetDate.getTime()) {
        targetDate = new Date(currentYear + 1, targetMonth - 1, targetDay, 0, 0, 0);
      }

      const diff = targetDate.getTime() - now.getTime();
      const days = Math.floor(diff / (1000 * 60 * 60 * 24));
      const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
      const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
      const seconds = Math.floor((diff % (1000 * 60)) / 1000);

      setTimeLeft({
        isToday: false,
        days,
        hours,
        minutes,
        seconds,
      });
    }

    calculateTime();
    const interval = setInterval(calculateTime, 1000);
    return () => clearInterval(interval);
  }, [targetMonth, targetDay]);

  if (!timeLeft) {
    return (
      <div className="rounded-2xl border border-zinc-200 bg-zinc-50 p-6 animate-pulse dark:border-zinc-800 dark:bg-zinc-900/50">
        <div className="h-6 w-48 bg-zinc-200 dark:bg-zinc-700 rounded mx-auto mb-4" />
        <div className="grid grid-cols-4 gap-2 max-w-sm mx-auto">
          {[1, 2, 3, 4].map((i) => (
            <div key={i} className="h-14 bg-zinc-200 dark:bg-zinc-700 rounded-xl" />
          ))}
        </div>
      </div>
    );
  }

  // If today is the active day
  if (timeLeft.isToday) {
    const isMemorial = dayType === "anma";
    return (
      <div
        className={`rounded-2xl border p-6 text-center shadow-sm ${
          isMemorial
            ? "border-zinc-800 bg-zinc-900 text-white"
            : "border-red-200 bg-gradient-to-r from-red-500 via-rose-500 to-amber-500 text-white"
        }`}
      >
        <div className="inline-flex items-center gap-2 rounded-full bg-white/20 px-3.5 py-1 text-xs font-black uppercase tracking-wider backdrop-blur-sm mb-2">
          {isMemorial ? "🇹🇷 Milli Anma Günü" : "🎉 Bugün Kutlanıyor!"}
        </div>
        <h4 className="text-xl sm:text-2xl font-black">
          {isMemorial ? `${title} — Saygı ve Rahmetle Anıyoruz` : `${title} Kutlu Olsun!`}
        </h4>
        <p className="mt-1 text-xs sm:text-sm text-white/90">
          Günün anlam ve önemine dair detayları aşağıdan inceleyebilir, özel mesajları paylaşabilirsiniz.
        </p>
      </div>
    );
  }

  return (
    <div className="rounded-2xl border border-zinc-200/90 bg-white p-5 sm:p-6 shadow-sm dark:border-zinc-800 dark:bg-zinc-900">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2 border-b border-zinc-100 pb-4 dark:border-zinc-800/80 mb-4">
        <div className="flex items-center gap-2">
          <Clock className="h-4 w-4 text-red-600 dark:text-red-400" />
          <span className="text-xs font-bold uppercase tracking-wider text-zinc-500 dark:text-zinc-400">
            Canlı Geri Sayım
          </span>
        </div>
        <span className="text-xs font-semibold text-zinc-700 dark:text-zinc-300 truncate">
          {title} İçin Kalan Süre
        </span>
      </div>

      <div className="grid grid-cols-4 gap-2 sm:gap-3 max-w-md mx-auto text-center">
        {/* Days */}
        <div className="flex flex-col items-center justify-center rounded-xl bg-zinc-50 border border-zinc-200/80 p-2.5 sm:p-3 dark:bg-zinc-800/50 dark:border-zinc-700/60">
          <span className="font-mono text-xl sm:text-2xl md:text-3xl font-black text-zinc-900 dark:text-white">
            {timeLeft.days}
          </span>
          <span className="text-[10px] sm:text-xs font-bold uppercase tracking-wider text-zinc-400 mt-0.5">
            Gün
          </span>
        </div>

        {/* Hours */}
        <div className="flex flex-col items-center justify-center rounded-xl bg-zinc-50 border border-zinc-200/80 p-2.5 sm:p-3 dark:bg-zinc-800/50 dark:border-zinc-700/60">
          <span className="font-mono text-xl sm:text-2xl md:text-3xl font-black text-zinc-900 dark:text-white">
            {String(timeLeft.hours).padStart(2, "0")}
          </span>
          <span className="text-[10px] sm:text-xs font-bold uppercase tracking-wider text-zinc-400 mt-0.5">
            Saat
          </span>
        </div>

        {/* Minutes */}
        <div className="flex flex-col items-center justify-center rounded-xl bg-zinc-50 border border-zinc-200/80 p-2.5 sm:p-3 dark:bg-zinc-800/50 dark:border-zinc-700/60">
          <span className="font-mono text-xl sm:text-2xl md:text-3xl font-black text-zinc-900 dark:text-white">
            {String(timeLeft.minutes).padStart(2, "0")}
          </span>
          <span className="text-[10px] sm:text-xs font-bold uppercase tracking-wider text-zinc-400 mt-0.5">
            Dakika
          </span>
        </div>

        {/* Seconds */}
        <div className="flex flex-col items-center justify-center rounded-xl bg-red-50/60 border border-red-200/80 p-2.5 sm:p-3 dark:bg-red-950/20 dark:border-red-900/60">
          <span className="font-mono text-xl sm:text-2xl md:text-3xl font-black text-red-600 dark:text-red-400">
            {String(timeLeft.seconds).padStart(2, "0")}
          </span>
          <span className="text-[10px] sm:text-xs font-bold uppercase tracking-wider text-red-500/80 mt-0.5">
            Saniye
          </span>
        </div>
      </div>
    </div>
  );
}
