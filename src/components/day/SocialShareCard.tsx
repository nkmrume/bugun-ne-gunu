"use client";

import React, { useRef, useState } from "react";
import { Download, Copy, Check, Share2, Sparkles, Image as ImageIcon } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { DayType } from "@/types/database";

interface SocialShareCardProps {
  title: string;
  formattedDate: string;
  category: string;
  dayType?: DayType;
  quoteOrMessage?: string;
  hashtags?: string[];
  slug?: string;
}

export function SocialShareCard({
  title,
  formattedDate,
  category,
  dayType = "kutlama",
  quoteOrMessage,
  hashtags = [],
  slug,
}: SocialShareCardProps) {
  const [copiedText, setCopiedText] = useState(false);
  const [downloading, setDownloading] = useState(false);
  const cardRef = useRef<HTMLDivElement>(null);

  const isMemorial = dayType === "anma";

  // Default respectful or celebratory message
  const defaultMessage = isMemorial
    ? `Cumhuriyetimizin kurucusu Gazi Mustafa Kemal Atatürk'ü saygı, rahmet ve minnetle anıyoruz. 🇹🇷🖤`
    : `${title} kutlu olsun! Sevdiklerinizle birlikte neşe ve güzellik dolu bir gün dileriz. ✨`;

  const message = quoteOrMessage || defaultMessage;
  const tagString = hashtags.length > 0 ? hashtags.join(" ") : `#${category.replace(/\s+/g, "")} #BugunNeGunu`;

  // Handle caption copy
  const handleCopyCaption = async () => {
    const fullText = `${title}\n📅 ${formattedDate}\n\n"${message}"\n\n${tagString}\n\nKaynak: bugunnegunu.com`;
    try {
      await navigator.clipboard.writeText(fullText);
      setCopiedText(true);
      setTimeout(() => setCopiedText(false), 2500);
    } catch (err) {
      console.error("Metin kopyalanamadı:", err);
    }
  };

  // Generate and download high-res PNG using Canvas
  const handleDownloadImage = () => {
    setDownloading(true);

    try {
      const canvas = document.createElement("canvas");
      const ctx = canvas.getContext("2d");
      if (!ctx) return;

      const size = 1080;
      canvas.width = size;
      canvas.height = size;

      // 1. Background
      if (isMemorial) {
        // Solemn Dark Gradient
        const grad = ctx.createLinearGradient(0, 0, 0, size);
        grad.addColorStop(0, "#09090b");
        grad.addColorStop(0.5, "#18181b");
        grad.addColorStop(1, "#09090b");
        ctx.fillStyle = grad;
        ctx.fillRect(0, 0, size, size);

        // Elegant border
        ctx.strokeStyle = "rgba(255, 255, 255, 0.12)";
        ctx.lineWidth = 12;
        ctx.strokeRect(36, 36, size - 72, size - 72);
      } else {
        // Vibrant Celebratory Gradient
        const grad = ctx.createLinearGradient(0, 0, size, size);
        grad.addColorStop(0, "#be123c"); // Rose-700
        grad.addColorStop(0.4, "#dc2626"); // Red-600
        grad.addColorStop(1, "#d97706"); // Amber-600
        ctx.fillStyle = grad;
        ctx.fillRect(0, 0, size, size);

        // Ambient radial light
        const radial = ctx.createRadialGradient(size / 2, size * 0.35, 50, size / 2, size * 0.35, 500);
        radial.addColorStop(0, "rgba(255, 255, 255, 0.18)");
        radial.addColorStop(1, "rgba(255, 255, 255, 0)");
        ctx.fillStyle = radial;
        ctx.fillRect(0, 0, size, size);

        // Elegant border
        ctx.strokeStyle = "rgba(255, 255, 255, 0.25)";
        ctx.lineWidth = 12;
        ctx.strokeRect(36, 36, size - 72, size - 72);
      }

      // 2. Top Badge
      ctx.textAlign = "center";
      ctx.fillStyle = "rgba(255, 255, 255, 0.9)";
      ctx.font = "bold 32px sans-serif";
      const topBadgeText = isMemorial ? "🇹🇷 MİLLİ ANMA GÜNÜ" : `✨ ${category.toUpperCase()}`;
      ctx.fillText(topBadgeText, size / 2, 130);

      // 3. Date Pill
      ctx.fillStyle = isMemorial ? "rgba(255, 255, 255, 0.1)" : "rgba(0, 0, 0, 0.2)";
      roundRect(ctx, size / 2 - 200, 160, 400, 60, 30);
      ctx.fill();

      ctx.fillStyle = "#ffffff";
      ctx.font = "bold 34px sans-serif";
      ctx.fillText(formattedDate.toUpperCase(), size / 2, 202);

      // 4. Main Title (with wrapping)
      ctx.fillStyle = "#ffffff";
      ctx.font = "900 64px sans-serif";
      wrapText(ctx, title, size / 2, 340, 900, 78);

      // 5. Divider Line
      ctx.strokeStyle = isMemorial ? "rgba(255, 255, 255, 0.2)" : "rgba(255, 255, 255, 0.4)";
      ctx.lineWidth = 4;
      ctx.beginPath();
      ctx.moveTo(size / 2 - 140, 520);
      ctx.lineTo(size / 2 + 140, 520);
      ctx.stroke();

      // 6. Message Box / Quote
      ctx.fillStyle = isMemorial ? "#e4e4e7" : "#fffbeb";
      ctx.font = "500 36px serif";
      wrapText(ctx, `"${message}"`, size / 2, 600, 860, 52);

      // 7. Hashtags
      if (hashtags.length > 0) {
        ctx.fillStyle = isMemorial ? "#a1a1aa" : "rgba(255, 255, 255, 0.85)";
        ctx.font = "600 28px sans-serif";
        ctx.fillText(hashtags.slice(0, 4).join("  "), size / 2, 850);
      }

      // 8. Footer Brand
      ctx.fillStyle = "rgba(255, 255, 255, 0.7)";
      ctx.font = "bold 26px sans-serif";
      ctx.fillText("BUGUNNEGUNU.COM  •  ÖZEL GÜNLER REHBERİ", size / 2, 980);

      // Trigger download
      const dataUrl = canvas.toDataURL("image/png");
      const a = document.createElement("a");
      a.href = dataUrl;
      const fileSafeSlug = (slug || title).toLowerCase().replace(/[^a-z0-9]/g, "-");
      a.download = `${fileSafeSlug}-sosyal-medya.png`;
      a.click();
    } catch (err) {
      console.error("Görsel oluşturulamadı:", err);
    } finally {
      setDownloading(false);
    }
  };

  return (
    <div className="rounded-3xl border border-zinc-200/90 bg-white p-6 shadow-sm dark:border-zinc-800 dark:bg-zinc-900">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 border-b border-zinc-100 pb-4 dark:border-zinc-800">
        <div>
          <div className="flex items-center gap-2">
            <ImageIcon className="h-4 w-4 text-rose-600 dark:text-rose-400" />
            <span className="text-xs font-bold uppercase tracking-wider text-zinc-500">
              Sosyal Medya Paylaşım Kartı
            </span>
          </div>
          <h3 className="mt-1 text-lg font-black text-zinc-900 dark:text-zinc-100">
            Instagram, WhatsApp ve X İçin Hazır Görsel
          </h3>
        </div>

        <Badge variant={isMemorial ? "secondary" : "default"} className="self-start sm:self-auto text-xs">
          1080x1080 Kare Format
        </Badge>
      </div>

      {/* Visual Live Card Preview */}
      <div
        ref={cardRef}
        className={`mt-6 relative aspect-square max-w-sm mx-auto overflow-hidden rounded-3xl p-6 sm:p-8 flex flex-col justify-between text-center shadow-lg transition-transform hover:scale-[1.01] ${
          isMemorial
            ? "bg-gradient-to-b from-zinc-950 via-zinc-900 to-zinc-950 border-2 border-zinc-800 text-white"
            : "bg-gradient-to-br from-rose-600 via-red-600 to-amber-600 text-white border-2 border-white/20"
        }`}
      >
        <div className="space-y-2">
          <span className="inline-block rounded-full bg-white/20 px-3 py-1 text-[11px] font-black uppercase tracking-wider backdrop-blur-sm">
            {isMemorial ? "🇹🇷 Milli Anma Günü" : `✨ ${category}`}
          </span>
          <div className="text-xs font-bold tracking-widest uppercase opacity-90">
            {formattedDate}
          </div>
        </div>

        <div className="my-auto py-4">
          <h4 className="text-2xl sm:text-3xl font-black leading-tight tracking-tight drop-shadow-sm">
            {title}
          </h4>
          <div className="mx-auto my-3 h-0.5 w-16 bg-white/40" />
          <p className="text-xs sm:text-sm font-medium leading-relaxed opacity-95 line-clamp-4 italic">
            "{message}"
          </p>
        </div>

        <div className="pt-2 border-t border-white/20 flex flex-col items-center gap-1">
          {hashtags.length > 0 && (
            <span className="text-[10px] font-semibold text-white/80 truncate max-w-full">
              {hashtags.slice(0, 3).join(" ")}
            </span>
          )}
          <span className="text-[10px] font-bold tracking-wider uppercase text-white/60">
            bugunnegunu.com
          </span>
        </div>
      </div>

      {/* Action Buttons */}
      <div className="mt-6 flex flex-col sm:flex-row items-center justify-center gap-3">
        <Button
          onClick={handleDownloadImage}
          disabled={downloading}
          className="w-full sm:w-auto gap-2 bg-red-600 hover:bg-red-700 text-white font-bold rounded-xl shadow-md"
        >
          <Download className="h-4 w-4" />
          <span>{downloading ? "Hazırlanıyor..." : "Görsel Olarak İndir (PNG)"}</span>
        </Button>

        <Button
          onClick={handleCopyCaption}
          variant="outline"
          className="w-full sm:w-auto gap-2 font-bold rounded-xl"
        >
          {copiedText ? (
            <>
              <Check className="h-4 w-4 text-emerald-600" />
              <span className="text-emerald-600">Metin Kopyalandı!</span>
            </>
          ) : (
            <>
              <Copy className="h-4 w-4" />
              <span>Hazır Metni Kopyala</span>
            </>
          )}
        </Button>
      </div>

      <p className="mt-3 text-center text-[11px] text-zinc-500">
        Instagram gönderisi, hikayesi, durum ve WhatsApp paylaşımlarınızda doğrudan kullanabilirsiniz.
      </p>
    </div>
  );
}

// Helper: Wrap text on HTML5 Canvas
function wrapText(
  ctx: CanvasRenderingContext2D,
  text: string,
  x: number,
  y: number,
  maxWidth: number,
  lineHeight: number
) {
  const words = text.split(" ");
  let line = "";
  let currentY = y;

  for (let n = 0; n < words.length; n++) {
    const testLine = line + words[n] + " ";
    const metrics = ctx.measureText(testLine);
    const testWidth = metrics.width;
    if (testWidth > maxWidth && n > 0) {
      ctx.fillText(line, x, currentY);
      line = words[n] + " ";
      currentY += lineHeight;
    } else {
      line = testLine;
    }
  }
  ctx.fillText(line, x, currentY);
}

// Helper: Rounded rectangle on Canvas
function roundRect(
  ctx: CanvasRenderingContext2D,
  x: number,
  y: number,
  w: number,
  h: number,
  r: number
) {
  ctx.beginPath();
  ctx.moveTo(x + r, y);
  ctx.arcTo(x + w, y, x + w, y + h, r);
  ctx.arcTo(x + w, y + h, x, y + h, r);
  ctx.arcTo(x, y + h, x, y, r);
  ctx.arcTo(x, y, x + w, y, r);
  ctx.closePath();
}
