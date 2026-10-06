import React from "react";
import { cn } from "@/lib/utils";

interface AdBannerProps {
  slotId?: string;
  format?: "horizontal" | "in-article" | "rectangle";
  className?: string;
}

export function AdBanner({
  slotId = "default-slot",
  format = "horizontal",
  className,
}: AdBannerProps) {
  const formatClasses = {
    horizontal: "min-h-[100px] w-full max-w-4xl mx-auto",
    "in-article": "min-h-[180px] w-full my-8",
    rectangle: "min-h-[250px] w-full max-w-[336px] mx-auto",
  };

  return (
    <div
      className={cn(
        "relative my-6 flex flex-col items-center justify-center rounded-2xl border border-dashed border-zinc-300 bg-zinc-50/70 p-4 text-center dark:border-zinc-800 dark:bg-zinc-900/50",
        formatClasses[format],
        className
      )}
      data-ad-slot={slotId}
      aria-label="Sponsorlu Reklam Alanı"
    >
      {/* Google AdSense Placement Code Comment
          <ins class="adsbygoogle"
               style="display:block"
               data-ad-client="ca-pub-XXXXXXXXXXXXXXXX"
               data-ad-slot={slotId}
               data-ad-format="auto"
               data-full-width-responsive="true"></ins>
          <script>(adsbygoogle = window.adsbygoogle || []).push({});</script>
      */}
      <div className="flex flex-col items-center space-y-1">
        <span className="text-[11px] font-semibold uppercase tracking-widest text-zinc-400 dark:text-zinc-500">
          Sponsorlu Alan / Reklam
        </span>
        <p className="text-xs text-zinc-400 dark:text-zinc-500">
          Google AdSense {format === "horizontal" ? "728x90 Leaderboard" : format === "in-article" ? "In-Article Reklamı" : "300x250 Kutu"}
        </p>
      </div>
    </div>
  );
}
