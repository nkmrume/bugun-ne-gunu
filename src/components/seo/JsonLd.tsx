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

  // Extract how to celebrate content
  let howToCelebrate = `${specialDay.title} gününde sevdiklerinizle bir araya gelebilir, temaya uygun etkinlikler ve paylaşımlar yapabilirsiniz.`;
  if (specialDay.content.includes("##")) {
    const sections = specialDay.content.split(/##\s+/);
    const howToSection = sections.find(
      (sec) =>
        sec.toLowerCase().includes("nasıl") ||
        sec.toLowerCase().includes("nasil") ||
        sec.toLowerCase().includes("kutlanır")
    );
    if (howToSection) {
      const lines = howToSection.split("\n").filter((l) => l.trim().length > 0 && !l.startsWith("##"));
      if (lines.length > 1) {
        howToCelebrate = lines.slice(1, 4).join(" ").replace(/\*\*/g, "").replace(/\*/g, "");
      }
    }
  }

  // Sample greeting message
  const bestMessage =
    specialDay.hashtags.length > 0
      ? `"${specialDay.title} kutlu olsun! Bu özel günün getirdiği neşe ve farkındalığın hayatınıza güzellik katmasını dileriz. ${specialDay.hashtags.slice(0, 3).join(" ")}"`
      : `"${specialDay.title} kutlu olsun!"`;

  // 1. Event Schema
  const eventSchema = {
    "@context": "https://schema.org",
    "@type": "Event",
    name: specialDay.title,
    startDate: specialDay.celebration_date,
    endDate: specialDay.celebration_date,
    eventAttendanceMode: "https://schema.org/OnlineEventAttendanceMode",
    eventStatus: "https://schema.org/EventScheduled",
    location: {
      "@type": "VirtualLocation",
      url: url,
      name: "Bugün Ne Günü? Çevrim İçi Etkinlik ve Kutlama Platformu",
    },
    image: [
      `https://bugunnegunu.com/og?title=${encodeURIComponent(specialDay.title)}`,
    ],
    description: specialDay.description,
    organizer: {
      "@type": "Organization",
      name: "Bugün Ne Günü?",
      url: "https://bugunnegunu.com",
    },
    offers: {
      "@type": "Offer",
      price: "0",
      priceCurrency: "TRY",
      availability: "https://schema.org/InStock",
      url: url,
      validFrom: "2026-01-01",
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
          text: `2026 yılında ${specialDay.title}, ${formattedDate} tarihinde kutlanmaktadır.`,
        },
      },
      {
        "@type": "Question",
        name: `${specialDay.title} nasıl kutlanır?`,
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
        name: `${TURKISH_MONTHS[specialDay.month_no] || specialDay.month_no} Ayı Özel Günleri`,
        item: `https://bugunnegunu.com/aylar/${NUMBER_TO_MONTH_SLUG[specialDay.month_no] || specialDay.month_no}`,
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
        dangerouslySetInnerHTML={{ __html: JSON.stringify(eventSchema) }}
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
  const websiteSchema = {
    "@context": "https://schema.org",
    "@type": "WebSite",
    name: "Bugün Ne Günü?",
    url: "https://bugunnegunu.com",
    potentialAction: {
      "@type": "SearchAction",
      target: {
        "@type": "EntryPoint",
        urlTemplate: "https://bugunnegunu.com/?q={search_term_string}",
      },
      "query-input": "required name=search_term_string",
    },
    inLanguage: "tr-TR",
    description: "Bugün hangi özel gün kutlanıyor? Türkiye ve dünyadaki tüm özel günler, haftalar ve bayramlar rehberi.",
  };

  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(websiteSchema) }}
    />
  );
}
