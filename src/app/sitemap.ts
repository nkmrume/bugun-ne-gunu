import { MetadataRoute } from "next";
import { getAllSpecialDays } from "@/lib/data/special-days-service";
import { MONTHS_METADATA } from "@/lib/data/special-days-data";

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

  // 3. Special Day Pages
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
