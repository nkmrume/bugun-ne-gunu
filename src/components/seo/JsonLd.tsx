import React from "react";
import { SpecialDay } from "@/types/database";
import { formatTurkishDate, TURKISH_MONTHS, NUMBER_TO_MONTH_SLUG } from "@/lib/utils";

interface SpecialDayJsonLdProps {
  specialDay: SpecialDay;
  url: string;
}

export function SpecialDayJsonLd({ specialDay, url }: SpecialDayJsonLdProps) {
  const formattedDate = formatTurkishDate(
    specialDay.day_no,
    specialDay.month_no,
    2026
  );

  const isMemorial = specialDay.day_type === "anma";

  // Contextual celebration or memorial text
  let howToCelebrate = isMemorial
    ? `${specialDay.title} gününde saat 09:05'te saygı duruşunda bulunabilir, Anıtkabir'i ve müzeleri ziyaret edebilir, Atatürk'ün mirasını ve eserlerini inceleyebilirsiniz.`
    : `${specialDay.title} gününde sevdiklerinizle bir araya gelebilir, temaya uygun etkinlikler ve paylaşımlar yapabilirsiniz.`;

  if (specialDay.content.includes("##")) {
    const sections = specialDay.content.split(/##\s+/);
    const howToSection = sections.find(
      (sec) =>
        sec.toLowerCase().includes("nasıl") ||
        sec.toLowerCase().includes("nasil") ||
        sec.toLowerCase().includes("kutlanır") ||
        sec.toLowerCase().includes("anılır")
    );
    if (howToSection) {
      const lines = howToSection.split("\n").filter((l) => l.trim().length > 0 && !l.startsWith("##"));
      if (lines.length > 1) {
        howToCelebrate = lines.slice(1, 4).join(" ").replace(/\*\*/g, "").replace(/\*/g, "");
      }
    }
  }

  // Sample greeting message
  const bestMessage = isMemorial
    ? `"Cumhuriyetimizin kurucusu Gazi Mustafa Kemal Atatürk'ü saygı, rahmet ve minnetle anıyoruz. 🇹🇷🖤"`
    : specialDay.hashtags.length > 0
    ? `"${specialDay.title} kutlu olsun! Bu özel günün getirdiği neşe ve farkındalığın hayatınıza güzellik katmasını dileriz. ${specialDay.hashtags.slice(0, 3).join(" ")}"`
    : `"${specialDay.title} kutlu olsun!"`;

  // 1. WebPage & Article Schema (Compliant with Google guidelines for informational editorial guides)
  const articleSchema = {
    "@context": "https://schema.org",
    "@type": "Article",
    headline: `2026 ${specialDay.title} Ne Zaman, Nasıl ${isMemorial ? "Anılır" : "Kutlanır"}?`,
    description: specialDay.description,
    image: [
      `https://bugunnegunu.com/og?title=${encodeURIComponent(specialDay.title)}`,
    ],
    datePublished: "2026-01-01T00:00:00+03:00",
    dateModified: specialDay.updated_at || "2026-10-07T00:00:00+03:00",
    author: {
      "@type": "Organization",
      name: "Bugün Ne Günü? Editoryal Kurulu",
      url: "https://bugunnegunu.com",
    },
    publisher: {
      "@type": "Organization",
      name: "Bugün Ne Günü?",
      url: "https://bugunnegunu.com",
      logo: {
        "@type": "ImageObject",
        url: "https://bugunnegunu.com/logo.png",
      },
    },
    mainEntityOfPage: {
      "@type": "WebPage",
      "@id": url,
    },
  };

  // 2. FAQPage Schema
  const faqSchema = {
    "@context": "https://schema.org",
    "@type": "FAQPage",
    mainEntity: [
      {
        "@type": "Question",
        name: `2026 ${specialDay.title} ne zaman?`,
        acceptedAnswer: {
          "@type": "Answer",
          text: `2026 yılında ${specialDay.title}, ${formattedDate} tarihinde ${isMemorial ? "anılmaktadır" : "kutlanmaktadır"}.`,
        },
      },
      {
        "@type": "Question",
        name: `${specialDay.title} nasıl ${isMemorial ? "anılır" : "kutlanır"}?`,
        acceptedAnswer: {
          "@type": "Answer",
          text: howToCelebrate,
        },
      },
      {
        "@type": "Question",
        name: `En iyi ${specialDay.title} mesajları nelerdir?`,
        acceptedAnswer: {
          "@type": "Answer",
          text: bestMessage,
        },
      },
    ],
  };

  // 3. BreadcrumbList Schema
  const monthSlug = NUMBER_TO_MONTH_SLUG[specialDay.month_no] || "ekim";
  const monthName = TURKISH_MONTHS[specialDay.month_no] || "Ekim";

  const breadcrumbSchema = {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    itemListElement: [
      {
        "@type": "ListItem",
        position: 1,
        name: "Ana Sayfa",
        item: "https://bugunnegunu.com",
      },
      {
        "@type": "ListItem",
        position: 2,
        name: `${monthName} Ayı`,
        item: `https://bugunnegunu.com/aylar/${monthSlug}`,
      },
      {
        "@type": "ListItem",
        position: 3,
        name: specialDay.title,
        item: url,
      },
    ],
  };

  return (
    <>
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(articleSchema) }}
      />
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(faqSchema) }}
      />
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(breadcrumbSchema) }}
      />
    </>
  );
}

export function WebsiteJsonLd() {
  const schema = {
    "@context": "https://schema.org",
    "@type": "WebSite",
    name: "Bugün Ne Günü?",
    alternateName: ["Bugun Ne Gunu", "Ozel Gunler Takvimi"],
    url: "https://bugunnegunu.com",
    potentialAction: {
      "@type": "SearchAction",
      target: {
        "@type": "EntryPoint",
        urlTemplate: "https://bugunnegunu.com/ara?q={search_term_string}",
      },
      "query-input": "required name=search_term_string",
    },
  };

  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(schema) }}
    />
  );
}
