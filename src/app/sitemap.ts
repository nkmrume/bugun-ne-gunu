import { MetadataRoute } from "next";
import { getAllSpecialDays } from "@/lib/data/special-days-service";
import { MONTHS_METADATA } from "@/lib/data/special-days-data";
import { CATEGORIES_METADATA } from "@/lib/data/categories-data";

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const baseUrl = "https://bugunnegunu.com";
  const days = await getAllSpecialDays();

  // 1. Homepage
  const routes: MetadataRoute.Sitemap = [
    {
      url: baseUrl,
      lastModified: new Date(),
      changeFrequency: "daily",
      priority: 1.0,
    },
    {
      url: `${baseUrl}/kategoriler`,
      lastModified: new Date(),
      changeFrequency: "weekly",
      priority: 0.8,
    },
  ];

  // 2. 12 Monthly Pillar Pages
  MONTHS_METADATA.forEach((month) => {
    routes.push({
      url: `${baseUrl}/aylar/${month.slug}`,
      lastModified: new Date(),
      changeFrequency: "weekly",
      priority: 0.85,
    });
  });

  // 3. Category Pillar Pages
  CATEGORIES_METADATA.forEach((cat) => {
    routes.push({
      url: `${baseUrl}/kategoriler/${cat.slug}`,
      lastModified: new Date(),
      changeFrequency: "weekly",
      priority: 0.85,
    });
  });

  // 4. Special Day Pages
  days.forEach((day) => {
    routes.push({
      url: `${baseUrl}/gun/${day.slug}`,
      lastModified: day.updated_at ? new Date(day.updated_at) : new Date(),
      changeFrequency: "monthly",
      priority: 0.9,
    });
  });

  return routes;
}
