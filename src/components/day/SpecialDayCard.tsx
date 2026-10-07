import React from "react";
import Link from "next/link";
import { SpecialDay } from "@/types/database";
import { Card, CardHeader, CardTitle, CardDescription, CardContent, CardFooter } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Calendar, ArrowRight, Sparkles, Tag, ShieldAlert } from "lucide-react";
import { formatDayMonthOnly } from "@/lib/utils";

interface SpecialDayCardProps {
  day: SpecialDay;
  isToday?: boolean;
}

export function SpecialDayCard({ day, isToday = false }: SpecialDayCardProps) {
  const isMemorial = day.day_type === "anma";

  const categoryVariant = (): "default" | "secondary" | "success" | "warning" | "red" | "purple" | "blue" => {
    if (isMemorial) return "secondary";
    switch (day.category) {
      case "Resmi":
        return "red";
      case "Eğlence":
        return "warning";
      case "Sağlık":
        return "blue";
      case "Çevre & Doğa":
        return "success";
      case "Kültür & Sanat":
        return "purple";
      default:
        return "secondary";
    }
  };

  return (
    <Card className="group relative flex flex-col justify-between overflow-hidden rounded-3xl border border-zinc-200/80 bg-white shadow-sm transition-all duration-300 hover:-translate-y-1.5 hover:shadow-xl hover:border-red-200 dark:border-zinc-800 dark:bg-zinc-900/90 dark:hover:border-red-900/60">
      {/* Top Banner if Today */}
      {isToday && (
        <div
          className={`px-4 py-1.5 text-center text-xs font-black uppercase tracking-widest text-white shadow-inner flex items-center justify-center gap-1.5 ${
            isMemorial
              ? "bg-zinc-900 border-b border-zinc-800 text-zinc-100"
              : "bg-gradient-to-r from-red-600 via-rose-600 to-amber-500"
          }`}
        >
          {isMemorial ? (
            <span>🇹🇷 Bugün Saygıyla Anılıyor</span>
          ) : (
            <>
              <Sparkles className="h-3.5 w-3.5 animate-pulse" />
              <span>Bugün Kutlanıyor!</span>
            </>
          )}
        </div>
      )}

      <CardHeader className="pb-3">
        <div className="flex items-start justify-between gap-3">
          <div className="flex items-center gap-2">
            <Badge variant={categoryVariant()}>{day.category}</Badge>
            {isMemorial && (
              <Badge variant="secondary" className="text-[10px] font-bold">
                Anma Günü
              </Badge>
            )}
            <span className="text-xs font-semibold text-zinc-400 dark:text-zinc-500 flex items-center gap-1">
              <Calendar className="h-3 w-3" />
              {formatDayMonthOnly(day.day_no, day.month_no)}
            </span>
          </div>

          <div className="flex h-12 w-12 shrink-0 flex-col items-center justify-center rounded-2xl bg-zinc-100 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700/60 group-hover:bg-red-50 group-hover:border-red-200 dark:group-hover:bg-red-950/40 transition-colors">
            <span className="text-sm font-black text-zinc-900 dark:text-zinc-100 group-hover:text-red-600 transition-colors">
              {day.day_no}
            </span>
            <span className="text-[10px] font-bold uppercase text-zinc-500 dark:text-zinc-400 group-hover:text-red-600">
              {formatDayMonthOnly(day.day_no, day.month_no).split(" ")[1]}
            </span>
          </div>
        </div>

        <CardTitle className="mt-3 text-xl font-black group-hover:text-red-600 transition-colors">
          <Link href={`/gun/${day.slug}`} className="hover:underline focus:outline-none">
            {day.title}
          </Link>
        </CardTitle>

        <CardDescription className="line-clamp-2 mt-1.5 text-xs sm:text-sm">
          {day.description}
        </CardDescription>
      </CardHeader>

      <CardContent className="pb-4">
        {/* Hashtag Pills */}
        <div className="flex flex-wrap gap-1.5">
          {day.hashtags.slice(0, 3).map((tag, idx) => (
            <span
              key={idx}
              className="inline-flex items-center text-[11px] font-medium text-zinc-500 bg-zinc-100 dark:bg-zinc-800/60 px-2 py-0.5 rounded-lg dark:text-zinc-400"
            >
              {tag}
            </span>
          ))}
        </div>
      </CardContent>

      <CardFooter className="pt-3 border-t border-zinc-100 dark:border-zinc-800/80 flex items-center justify-between">
        <Link
          href={`/gun/${day.slug}`}
          className="inline-flex items-center gap-1.5 text-xs font-bold text-red-600 hover:text-red-700 dark:text-red-400 transition-colors group-hover:translate-x-1 duration-200"
        >
          <span>{isMemorial ? "Detaylar ve Anma Mesajları" : "Tüm Detaylar ve Mesajlar"}</span>
          <ArrowRight className="h-3.5 w-3.5" />
        </Link>

        {!isMemorial && day.affiliate_keywords && day.affiliate_keywords.length > 0 && (
          <span className="flex items-center gap-1 text-[11px] text-amber-700 bg-amber-50 dark:bg-amber-950/40 dark:text-amber-400 px-2 py-0.5 rounded-md font-medium">
            <Tag className="h-3 w-3" />
            Hediye Fikirleri
          </span>
        )}
      </CardFooter>
    </Card>
  );
}
