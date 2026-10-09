import React from "react";
import { SpecialDay } from "@/types/database";
import { formatTurkishDate, formatDayMonthOnly, TURKISH_MONTHS, NUMBER_TO_MONTH_SLUG, getBaseUrl } from "@/lib/utils";

interface SpecialDayJsonLdProps {
  specialDay: SpecialDay;
  url: string;
}

export function SpecialDayJsonLd({ specialDay, url }: SpecialDayJsonLdProps) {
  const baseUrl = getBaseUrl();
  const formattedDate = formatTurkishDate(
    specialDay.day_no,
    specialDay.month_no,
    2026
  );
  const formattedDayMonth = formatDayMonthOnly(specialDay.day_no, specialDay.month_no);
  const monthSlug = NUMBER_TO_MONTH_SLUG[specialDay.month_no] || "ekim";
  const monthName = TURKISH_MONTHS[specialDay.month_no] || "Ekim";
  const dateSlug = `${specialDay.day_no}-${monthSlug}`;

  const isMemorial = specialDay.day_type === "anma";

  // Contextual celebration or memorial text
  let howToCelebrate = isMemorial
    ? `${specialDay.title} gününde saat 09:05'te saygı duruşunda bulunabilir, Anıtkabir'i ve müzeleri ziyaret edebilir, Atatürk'ün mirasını ve eserlerini inceleyebilirsiniz.`
    : `${specialDay.title} gününde sevdiklerinizle bir araya gelebilir, temaya uygun etkinlikler ve paylaşımlar yapabilirsiniz.`;

  if (specialDay.content && specialDay.content.includes("##")) {
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
    : specialDay.hashtags && specialDay.hashtags.length > 0
    ? `"${specialDay.title} kutlu olsun! Bu özel günün getirdiği neşe ve farkındalığın hayatınıza güzellik katmasını dileriz. ${specialDay.hashtags.slice(0, 3).join(" ")}"`
    : `"${specialDay.title} kutlu olsun!"`;

  const ogImageUrl = `${baseUrl}/api/og?title=${encodeURIComponent(
    specialDay.title
  )}&date=${encodeURIComponent(formattedDate)}&cat=${encodeURIComponent(
    specialDay.category
  )}&type=${encodeURIComponent(specialDay.day_type || "kutlama")}&desc=${encodeURIComponent(
    specialDay.description || ""
  )}`;

  // 1. WebPage & Article Schema (Section 8: Structured Data)
  const articleSchema = {
    "@context": "https://schema.org",
    "@type": "Article",
    headline: `2026 ${specialDay.title} Ne Zaman, Nasıl ${isMemorial ? "Anılır" : "Kutlanır"}?`,
    description: specialDay.description,
    image: [ogImageUrl],
    datePublished: specialDay.created_at || "2026-01-01T00:00:00+03:00",
    dateModified: specialDay.updated_at || "2026-10-10T00:00:00+03:00",
    author: {
      "@type": "Organization",
      name: "Bugün Ne Günü? Editoryal Kurulu",
      url: baseUrl,
    },
    publisher: {
      "@type": "Organization",
      name: "Bugün Ne Günü?",
      url: baseUrl,
      logo: {
        "@type": "ImageObject",
        url: `${baseUrl}/favicon.ico`,
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

  // 3. BreadcrumbList Schema (Strictly mirrors visible breadcrumbs: Ana Sayfa -> Ay -> Tarih -> Detay)
  const breadcrumbSchema = {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    itemListElement: [
      {
        "@type": "ListItem",
        position: 1,
        name: "Ana Sayfa",
        item: baseUrl,
      },
      {
        "@type": "ListItem",
        position: 2,
        name: `${monthName} Ayı`,
        item: `${baseUrl}/aylar/${monthSlug}`,
      },
      {
        "@type": "ListItem",
        position: 3,
        name: formattedDayMonth,
        item: `${baseUrl}/tarih/${dateSlug}`,
      },
      {
        "@type": "ListItem",
        position: 4,
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
  const baseUrl = getBaseUrl();
  const schema = {
    "@context": "https://schema.org",
    "@type": "WebSite",
    name: "Bugün Ne Günü?",
    alternateName: ["Bugun Ne Gunu", "Ozel Gunler Takvimi"],
    url: baseUrl,
    potentialAction: {
      "@type": "SearchAction",
      target: {
        "@type": "EntryPoint",
        urlTemplate: `${baseUrl}/?q={search_term_string}`,
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
