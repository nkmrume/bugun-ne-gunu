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
        url: "https://bugunnegunu.com/api/og?title=Bug%C3%BCn%20Ne%20G%C3%BCn%C3%BC%3F&date=T%C3%BCrkiye%27nin%20Do%C4%9Frulanm%C4%B1%C5%9F%20%C3%96zel%20G%C3%BCnler%20Rehberi&cat=%C3%96zel%20G%C3%BCnler&type=kutlama&desc=T%C3%BCm%20%C3%B6zel%20g%C3%BCnler%2C%20resmi%20bayramlar%2C%20anma%20tarihleri%20ve%20haz%C4%B1r%20mesajlar.",
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
    images: [
      "https://bugunnegunu.com/api/og?title=Bug%C3%BCn%20Ne%20G%C3%BCn%C3%BC%3F&date=T%C3%BCrkiye%27nin%20Do%C4%9Frulanm%C4%B1%C5%9F%20%C3%96zel%20G%C3%BCnler%20Rehberi&cat=%C3%96zel%20G%C3%BCnler&type=kutlama&desc=T%C3%BCm%20%C3%B6zel%20g%C3%BCnler%2C%20resmi%20bayramlar%2C%20anma%20tarihleri%20ve%20haz%C4%B1r%20mesajlar.",
    ],
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
