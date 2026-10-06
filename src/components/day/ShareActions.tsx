"use client";

import React, { useState } from "react";
import { Share2, Check, Copy, MessageCircle, Send } from "lucide-react";
import { SpecialDay } from "@/types/database";

interface ShareActionsProps {
  specialDay: SpecialDay;
}

export function ShareActions({ specialDay }: ShareActionsProps) {
  const [copied, setCopied] = useState(false);

  const currentUrl = typeof window !== "undefined" ? window.location.href : `https://bugunnegunu.com/gun/${specialDay.slug}`;
  const shareText = `${specialDay.title} ne zaman, nasıl kutlanır? Detaylar ve hazır kutlama mesajları: ${currentUrl}`;

  const handleCopy = () => {
    navigator.clipboard.writeText(currentUrl);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  };

  const handleWhatsApp = () => {
    window.open(`https://api.whatsapp.com/send?text=${encodeURIComponent(shareText)}`, "_blank");
  };

  const handleTwitter = () => {
    window.open(`https://twitter.com/intent/tweet?text=${encodeURIComponent(shareText)}`, "_blank");
  };

  return (
    <div className="flex flex-wrap items-center gap-2">
      <button
        onClick={handleWhatsApp}
        className="inline-flex items-center gap-1.5 rounded-xl bg-emerald-600 hover:bg-emerald-700 text-white px-3.5 py-2 text-xs font-bold transition-all shadow-sm cursor-pointer"
        title="WhatsApp'ta Paylaş"
      >
        <MessageCircle className="h-3.5 w-3.5" />
        <span>WhatsApp</span>
      </button>

      <button
        onClick={handleTwitter}
        className="inline-flex items-center gap-1.5 rounded-xl bg-zinc-900 hover:bg-black text-white px-3.5 py-2 text-xs font-bold transition-all shadow-sm cursor-pointer dark:bg-zinc-800 dark:hover:bg-zinc-700"
        title="X (Twitter)'da Paylaş"
      >
        <Send className="h-3.5 w-3.5" />
        <span>X / Twitter</span>
      </button>

      <button
        onClick={handleCopy}
        className="inline-flex items-center gap-1.5 rounded-xl border border-zinc-200 bg-white hover:bg-zinc-50 text-zinc-700 px-3.5 py-2 text-xs font-bold transition-all shadow-sm cursor-pointer dark:border-zinc-800 dark:bg-zinc-900 dark:text-zinc-200"
        title="Bağlantıyı Kopyala"
      >
        {copied ? (
          <>
            <Check className="h-3.5 w-3.5 text-emerald-500" />
            <span className="text-emerald-600 dark:text-emerald-400">Kopyalandı!</span>
          </>
        ) : (
          <>
            <Copy className="h-3.5 w-3.5 text-zinc-400" />
            <span>Linki Kopyala</span>
          </>
        )}
      </button>
    </div>
  );
}
