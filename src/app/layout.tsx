import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import { Navbar } from "@/components/layout/Navbar";
import { Footer } from "@/components/layout/Footer";
import { getAllSpecialDays } from "@/lib/data/special-days-service";
import { WebsiteJsonLd } from "@/components/seo/JsonLd";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  metadataBase: new URL("https://bugunnegunu.com"),
  title: {
    default: "Bugün Ne Günü? 2026 Özel Günler, Bayramlar ve Kutlamalar Takvimi",
    template: "%s | Bugün Ne Günü?",
  },
  description:
    "Bugün ne günü? Dünya genelinde ve Türkiye'de bugün kutlanan özel günler, resmi bayramlar, uluslararası haftalar, etkinlik fikirleri ve kutlama mesajları rehberi.",
  keywords: [
    "bugün ne günü",
    "özel günler takvimi 2026",
    "dünya kahve günü",
    "resmi bayramlar",
    "kutlama mesajları",
    "bugün hangi gün",
    "farkındalık günleri",
    "uluslararası günler",
  ],
  authors: [{ name: "Bugün Ne Günü Ekibi" }],
  creator: "Bugün Ne Günü?",
  publisher: "Bugün Ne Günü?",
  formatDetection: {
    email: false,
    address: false,
    telephone: false,
  },
  openGraph: {
    type: "website",
    locale: "tr_TR",
    url: "https://bugunnegunu.com",
    siteName: "Bugün Ne Günü?",
    title: "Bugün Ne Günü? 2026 Özel Günler ve Bayramlar Takvimi",
    description:
      "Tüm özel günler, dini ve resmi bayramlar, kutlama tüyoları ve hazır sosyal medya mesajları.",
    images: [
      {
        url: "/og-image.jpg",
        width: 1200,
        height: 630,
        alt: "Bugün Ne Günü? Özel Günler Rehberi",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "Bugün Ne Günü? 2026 Özel Günler Takvimi",
    description: "Bugün ne günü? Türkiye ve dünyadaki tüm kutlamalar burada.",
    creator: "@bugunnegunu",
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      "max-video-preview": -1,
      "max-image-preview": "large",
      "max-snippet": -1,
    },
  },
};

export default async function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const allDays = await getAllSpecialDays();

  return (
    <html lang="tr" className={`${geistSans.variable} ${geistMono.variable} h-full antialiased`}>
      <head>
        <WebsiteJsonLd />
      </head>
      <body className="min-h-full flex flex-col bg-white text-zinc-900 selection:bg-red-500 selection:text-white dark:bg-zinc-950 dark:text-zinc-50 font-sans">
        <Navbar allDays={allDays} />
        <main className="flex-1">{children}</main>
        <Footer />
      </body>
    </html>
  );
}
