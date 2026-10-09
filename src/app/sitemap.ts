import { MetadataRoute } from "next";
import { getAllSpecialDays } from "@/lib/data/special-days-service";
import { MONTHS_METADATA } from "@/lib/data/special-days-data";
import { CATEGORIES_METADATA } from "@/lib/data/categories-data";
import { getAllYearDateSlugs } from "@/lib/date-engine";
import { getBaseUrl } from "@/lib/utils";

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const baseUrl = getBaseUrl();
  const days = await getAllSpecialDays();
  const dateSlugs = getAllYearDateSlugs();
  const baseContentDate = new Date("2026-10-10T00:00:00.000Z");

  // 1. Homepage & Hubs
  const routes: MetadataRoute.Sitemap = [
    {
      url: baseUrl,
      lastModified: baseContentDate,
      changeFrequency: "daily",
      priority: 1.0,
    },
    {
      url: `${baseUrl}/kategoriler`,
      lastModified: baseContentDate,
      changeFrequency: "weekly",
      priority: 0.8,
    },
    {
      url: `${baseUrl}/sosyal-medya-takvimi`,
      lastModified: baseContentDate,
      changeFrequency: "daily",
      priority: 0.9,
    },
    {
      url: `${baseUrl}/hakkimizda`,
      lastModified: baseContentDate,
      changeFrequency: "monthly",
      priority: 0.8,
    },
    {
      url: `${baseUrl}/kunye`,
      lastModified: baseContentDate,
      changeFrequency: "monthly",
      priority: 0.8,
    },
    {
      url: `${baseUrl}/iletisim`,
      lastModified: baseContentDate,
      changeFrequency: "monthly",
      priority: 0.7,
    },
    {
      url: `${baseUrl}/gizlilik-politikasi`,
      lastModified: baseContentDate,
      changeFrequency: "monthly",
      priority: 0.5,
    },
    {
      url: `${baseUrl}/kullanim-kosullari`,
      lastModified: baseContentDate,
      changeFrequency: "monthly",
      priority: 0.5,
    },
  ];

  // 2. 12 Monthly Pillar Pages
  MONTHS_METADATA.forEach((month) => {
    routes.push({
      url: `${baseUrl}/aylar/${month.slug}`,
      lastModified: baseContentDate,
      changeFrequency: "weekly",
      priority: 0.85,
    });
  });

  // 3. Category Pillar Pages
  CATEGORIES_METADATA.forEach((cat) => {
    routes.push({
      url: `${baseUrl}/kategoriler/${cat.slug}`,
      lastModified: baseContentDate,
      changeFrequency: "weekly",
      priority: 0.85,
    });
  });

  // 4. Special Day Pages
  days.forEach((day) => {
    routes.push({
      url: `${baseUrl}/gun/${day.slug}`,
      lastModified: day.updated_at ? new Date(day.updated_at) : baseContentDate,
      changeFrequency: "monthly",
      priority: 0.9,
    });
  });

  // 5. 365 Daily Date Pages (/tarih/7-ekim etc.)
  dateSlugs.forEach((dateSlug) => {
    routes.push({
      url: `${baseUrl}/tarih/${dateSlug}`,
      lastModified: baseContentDate,
      changeFrequency: "weekly",
      priority: 0.75,
    });
  });

  return routes;
}
