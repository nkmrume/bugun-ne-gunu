"use client";

import React, { useState } from "react";
import { SpecialDay } from "@/types/database";
import { Tabs, TabsList, TabsTrigger, TabsContent } from "@/components/ui/tabs";
import {
  BookOpen,
  PartyPopper,
  Share2,
  Copy,
  Check,
  Hash,
  Sparkles,
  MessageSquare,
  Lightbulb,
  Heart,
} from "lucide-react";
import { Badge } from "@/components/ui/badge";

interface DayDetailTabsProps {
  specialDay: SpecialDay;
}

export function DayDetailTabs({ specialDay }: DayDetailTabsProps) {
  const [copiedIndex, setCopiedIndex] = useState<number | null>(null);
  const [copiedTag, setCopiedTag] = useState<string | null>(null);

  const isMemorial = specialDay.day_type === "anma";
  const isAwareness = specialDay.day_type === "farkindalik";

  // Parse markdown content sections
  const rawSections = specialDay.content.split(/\n(?=##\s+)/);

  let nedirContent = "";
  let nasilContent = "";
  let sosyalContent = "";

  rawSections.forEach((sec) => {
    const lower = sec.toLowerCase();
    if (lower.includes("nedir") || lower.includes("tarihçesi") || lower.includes("önemi")) {
      nedirContent += sec + "\n";
    } else if (
      lower.includes("nasıl") ||
      lower.includes("nasil") ||
      lower.includes("kutlanır") ||
      lower.includes("anılır") ||
      lower.includes("değerlendirilir")
    ) {
      nasilContent += sec + "\n";
    } else if (lower.includes("sosyal") || lower.includes("mesaj")) {
      sosyalContent += sec + "\n";
    } else {
      if (!nedirContent) nedirContent = sec;
    }
  });

  // Respectful vs Celebratory social captions
  const sampleCaptions = isMemorial
    ? [
        `"Beni görmek demek mutlaka yüzümü görmek demek değildir. Benim fikirlerimi, benim duygularımı anlıyorsanız ve hissediyorsanız bu kafidir. Gazi Mustafa Kemal Atatürk'ü saygı, rahmet ve sonsuz minnetle anıyoruz. 🇹🇷🖤 ${specialDay.hashtags.slice(0, 3).join(" ")}"`,
        `"Fikirlerin ve emanetin olan Cumhuriyet ilelebet yaşayacak. 10 Kasım Atatürk'ü Anma Günü'nde Başkomutanımızı derin bir özlemle yad ediyoruz. 🕊️ ${specialDay.hashtags.join(" ")}"`,
        `"Cumhuriyetimizin kurucusu Gazi Mustafa Kemal Atatürk'ün aziz hatırası önünde saygıyla eğiliyoruz. Ruhun şad olsun Atam. #10Kasim #Ataturk #0905"`,
      ]
    : isAwareness
    ? [
        `"${specialDay.title} farkındalığıyla toplumda dayanışma ve bilinci büyütüyoruz. Doğal yaşamı ve sağlığı korumak hepimizin sorumluluğu. 🎗️ ${specialDay.hashtags.slice(0, 3).join(" ")}"`,
        `"Daha bilinçli ve sağlıklı bir gelecek için: ${specialDay.title} vesilesiyle farkında ol, harekete geç! 🌱 ${specialDay.hashtags.join(" ")}"`,
        `"Bugün ${specialDay.title}! Farkındalık yaratarak sevdiklerinizle bu önemli temayı paylaşın. 💫 ${specialDay.hashtags.slice(0, 2).join(" ")}"`,
      ]
    : [
        `"${specialDay.title} kutlu olsun! Bu anlamlı günde sevgi, neşe ve güzelliklerin hayatınıza dolmasını dilerim. ✨ ${specialDay.hashtags.slice(0, 3).join(" ")}"`,
        `"Hayatı güzelleştiren tüm anlar kutlanmaya değer! ${specialDay.title} günümüz neşeyle geçsin. 🎈 ${specialDay.hashtags.join(" ")}"`,
        `"Bugün ${specialDay.title}! Sevdiklerinizle paylaşmayı ve bu özel günü hatırlamayı unutmayın. 💫 ${specialDay.hashtags.slice(0, 2).join(" ")}"`,
      ];

  const handleCopyCaption = (text: string, index: number) => {
    navigator.clipboard.writeText(text);
    setCopiedIndex(index);
    setTimeout(() => setCopiedIndex(null), 2000);
  };

  const handleCopyHashtag = (tag: string) => {
    navigator.clipboard.writeText(tag);
    setCopiedTag(tag);
    setTimeout(() => setCopiedTag(null), 2000);
  };

  const renderSimpleMarkdown = (text: string) => {
    return text.split("\n").map((line, idx) => {
      const trimmed = line.trim();
      if (trimmed.startsWith("### ")) {
        return (
          <h4 key={idx} className="mt-4 mb-2 text-base font-bold text-zinc-900 dark:text-zinc-100">
            {trimmed.replace("### ", "")}
          </h4>
        );
      }
      if (trimmed.startsWith("## ")) {
        return (
          <h3 key={idx} className="mt-6 mb-3 text-xl font-black text-zinc-900 dark:text-zinc-100 border-b border-zinc-100 dark:border-zinc-800 pb-2">
            {trimmed.replace("## ", "")}
          </h3>
        );
      }
      if (trimmed.startsWith("* ") || trimmed.startsWith("- ")) {
        return (
          <li key={idx} className="ml-4 list-disc text-sm text-zinc-600 dark:text-zinc-300 my-1 leading-relaxed">
            {trimmed.replace(/^[*|-]\s+/, "").replace(/\*\*(.*?)\*\*/g, "$1")}
          </li>
        );
      }
      if (/^\d+\.\s+/.test(trimmed)) {
        return (
          <div key={idx} className="flex items-start gap-3 my-2.5 rounded-xl bg-zinc-50 dark:bg-zinc-800/40 p-3 text-sm text-zinc-700 dark:text-zinc-300">
            <span className="flex h-6 w-6 shrink-0 items-center justify-center rounded-lg bg-red-100 text-red-700 dark:bg-red-950 dark:text-red-400 font-bold text-xs">
              {trimmed.match(/^\d+/)?.[0]}
            </span>
            <span className="leading-relaxed">
              {trimmed.replace(/^\d+\.\s+/, "").replace(/\*\*(.*?)\*\*/g, "$1")}
            </span>
          </div>
        );
      }
      if (!trimmed) {
        return <div key={idx} className="h-2" />;
      }
      return (
        <p key={idx} className="text-sm sm:text-base text-zinc-600 dark:text-zinc-300 leading-relaxed my-2">
          {trimmed.replace(/\*\*(.*?)\*\*/g, "$1")}
        </p>
      );
    });
  };

  return (
    <div className="w-full">
      <Tabs defaultValue="nedir" className="w-full">
        <TabsList className="w-full justify-start p-1.5 mb-2">
          <TabsTrigger value="nedir" className="gap-2 text-xs sm:text-sm">
            <BookOpen className="h-4 w-4 text-red-600" />
            <span>Nedir?</span>
          </TabsTrigger>
          <TabsTrigger value="nasil" className="gap-2 text-xs sm:text-sm">
            {isMemorial ? (
              <>
                <Heart className="h-4 w-4 text-zinc-400" />
                <span>Nasıl Anılır?</span>
              </>
            ) : isAwareness ? (
              <>
                <Lightbulb className="h-4 w-4 text-amber-500" />
                <span>Nasıl Değerlendirilir?</span>
              </>
            ) : (
              <>
                <PartyPopper className="h-4 w-4 text-amber-500" />
                <span>Nasıl Kutlanır?</span>
              </>
            )}
          </TabsTrigger>
          <TabsTrigger value="sosyal" className="gap-2 text-xs sm:text-sm">
            <Share2 className="h-4 w-4 text-sky-500" />
            <span>{isMemorial ? "Anma Mesajları" : "Sosyal Medya & Mesajlar"}</span>
          </TabsTrigger>
        </TabsList>

        {/* Tab 1: Nedir? */}
        <TabsContent value="nedir" className="rounded-3xl border border-zinc-200/80 bg-white p-6 sm:p-8 dark:border-zinc-800 dark:bg-zinc-900/90 shadow-sm">
          <div className="prose prose-zinc dark:prose-invert max-w-none">
            {renderSimpleMarkdown(nedirContent || specialDay.content)}
          </div>
        </TabsContent>

        {/* Tab 2: Nasıl Kutlanır / Anılır? */}
        <TabsContent value="nasil" className="rounded-3xl border border-zinc-200/80 bg-white p-6 sm:p-8 dark:border-zinc-800 dark:bg-zinc-900/90 shadow-sm">
          <div className="flex items-center gap-2 mb-4">
            {isMemorial ? (
              <Heart className="h-5 w-5 text-zinc-500" />
            ) : (
              <Lightbulb className="h-5 w-5 text-amber-500" />
            )}
            <h3 className="text-lg font-bold text-zinc-900 dark:text-zinc-100">
              {isMemorial
                ? "Anma ve Saygı Rehberi"
                : isAwareness
                ? "Farkındalık ve Destek Fikirleri"
                : "Kutlama ve Etkinlik Fikirleri"}
            </h3>
          </div>
          <div className="prose prose-zinc dark:prose-invert max-w-none">
            {renderSimpleMarkdown(
              nasilContent ||
                (isMemorial
                  ? "Bu özel günde saat 09:05'te saygı duruşunda bulunabilir, Anıtkabir ve Atatürk müzelerini ziyaret edebilirsiniz."
                  : "Bu özel gün için sevdiklerinizle bir araya gelebilir, tematik etkinlikler ve kutlamalar organize edebilirsiniz.")
            )}
          </div>
        </TabsContent>

        {/* Tab 3: Sosyal Medya & Mesajlar */}
        <TabsContent value="sosyal" className="space-y-6">
          {/* Captions Box */}
          <div className="rounded-3xl border border-zinc-200/80 bg-white p-6 sm:p-8 dark:border-zinc-800 dark:bg-zinc-900/90 shadow-sm">
            <div className="flex items-center justify-between mb-4">
              <div className="flex items-center gap-2">
                <MessageSquare className="h-5 w-5 text-sky-500" />
                <h3 className="text-lg font-bold text-zinc-900 dark:text-zinc-100">
                  {isMemorial ? "Hazır Anma ve Saygı Mesajları" : "Hazır Kutlama ve Paylaşım Mesajları"}
                </h3>
              </div>
              <span className="text-xs text-zinc-400">Tek tıkla kopyala</span>
            </div>

            <div className="space-y-3">
              {sampleCaptions.map((caption, idx) => (
                <div
                  key={idx}
                  className="group relative flex flex-col sm:flex-row items-start sm:items-center justify-between gap-3 rounded-2xl border border-zinc-200/70 bg-zinc-50/70 p-4 transition-colors hover:border-sky-300 dark:border-zinc-800 dark:bg-zinc-800/40"
                >
                  <p className="text-xs sm:text-sm text-zinc-700 dark:text-zinc-300 italic leading-relaxed">
                    {caption}
                  </p>
                  <button
                    onClick={() => handleCopyCaption(caption, idx)}
                    className="inline-flex shrink-0 items-center gap-1.5 rounded-xl bg-white px-3 py-1.5 text-xs font-bold text-zinc-700 shadow-sm border border-zinc-200 hover:bg-zinc-100 dark:bg-zinc-800 dark:border-zinc-700 dark:text-zinc-200 transition-all cursor-pointer"
                  >
                    {copiedIndex === idx ? (
                      <>
                        <Check className="h-3.5 w-3.5 text-emerald-600" />
                        <span className="text-emerald-600">Kopyalandı</span>
                      </>
                    ) : (
                      <>
                        <Copy className="h-3.5 w-3.5" />
                        <span>Kopyala</span>
                      </>
                    )}
                  </button>
                </div>
              ))}
            </div>
          </div>

          {/* Hashtag Box */}
          <div className="rounded-3xl border border-zinc-200/80 bg-white p-6 sm:p-8 dark:border-zinc-800 dark:bg-zinc-900/90 shadow-sm">
            <div className="flex items-center gap-2 mb-4">
              <Hash className="h-5 w-5 text-red-500" />
              <h3 className="text-lg font-bold text-zinc-900 dark:text-zinc-100">
                Popüler Etiketler (Hashtag)
              </h3>
            </div>

            <div className="flex flex-wrap gap-2">
              {specialDay.hashtags.map((tag, idx) => (
                <button
                  key={idx}
                  onClick={() => handleCopyHashtag(tag)}
                  className="inline-flex items-center gap-1.5 rounded-xl bg-zinc-100 px-3 py-1.5 text-xs font-semibold text-zinc-700 hover:bg-red-50 hover:text-red-600 dark:bg-zinc-800 dark:text-zinc-300 dark:hover:bg-red-950/40 transition-colors cursor-pointer"
                >
                  <span>{tag}</span>
                  {copiedTag === tag ? (
                    <Check className="h-3 w-3 text-emerald-600" />
                  ) : (
                    <Copy className="h-3 w-3 text-zinc-400" />
                  )}
                </button>
              ))}
            </div>
          </div>
        </TabsContent>
      </Tabs>
    </div>
  );
}
