import React from "react";
import { History, Milestone, Compass } from "lucide-react";
import { HistoryEvent } from "@/types/database";
import { Badge } from "@/components/ui/badge";

interface HistoryOnThisDayProps {
  events: HistoryEvent[];
  formattedDate: string;
}

export function HistoryOnThisDay({ events, formattedDate }: HistoryOnThisDayProps) {
  if (!events || events.length === 0) {
    return null;
  }

  const categoryLabels: Record<string, { label: string; variant: "default" | "secondary" | "warning" }> = {
    turkiye: { label: "🇹🇷 Türkiye Tarihi", variant: "default" },
    tarih: { label: "📜 Tarihi Olay", variant: "secondary" },
    bilim: { label: "🔬 Bilim & Keşif", variant: "warning" },
    dunya: { label: "🌍 Dünya Tarihi", variant: "secondary" },
    kultur: { label: "🎭 Kültür & Sanat", variant: "secondary" },
  };

  return (
    <div className="rounded-3xl border border-zinc-200/90 bg-white p-6 sm:p-8 shadow-sm dark:border-zinc-800 dark:bg-zinc-900">
      <div className="flex items-center justify-between border-b border-zinc-100 pb-5 dark:border-zinc-800 mb-6">
        <div>
          <div className="flex items-center gap-2">
            <History className="h-4 w-4 text-amber-600 dark:text-amber-400" />
            <span className="text-xs font-bold uppercase tracking-wider text-zinc-500">
              Tarihsel Kronoloji
            </span>
          </div>
          <h3 className="mt-1 text-xl sm:text-2xl font-black text-zinc-900 dark:text-zinc-100">
            Tarihte Bugün: {formattedDate}
          </h3>
        </div>

        <Badge variant="secondary" className="hidden sm:inline-flex text-xs">
          {events.length} Önemli Olay
        </Badge>
      </div>

      <div className="relative border-l-2 border-zinc-200/80 dark:border-zinc-800 ml-3 sm:ml-4 space-y-6">
        {events.map((event, idx) => {
          const catInfo = event.category ? categoryLabels[event.category] : null;

          return (
            <div key={idx} className="relative pl-6 sm:pl-8 group">
              {/* Timeline Dot */}
              <div className="absolute -left-[9px] top-1.5 h-4 w-4 rounded-full border-2 border-white bg-amber-500 shadow-sm transition-transform group-hover:scale-125 dark:border-zinc-900" />

              <div className="flex flex-wrap items-center gap-2 mb-1.5">
                <span className="font-mono text-base font-black text-red-600 dark:text-red-400">
                  {event.year}
                </span>
                {catInfo && (
                  <Badge variant={catInfo.variant} className="text-[10px] py-0 px-2 font-semibold">
                    {catInfo.label}
                  </Badge>
                )}
              </div>

              <h4 className="text-base font-bold text-zinc-900 dark:text-zinc-100">
                {event.title}
              </h4>
              <p className="mt-1 text-xs sm:text-sm text-zinc-600 dark:text-zinc-400 leading-relaxed">
                {event.description}
              </p>
            </div>
          );
        })}
      </div>
    </div>
  );
}
