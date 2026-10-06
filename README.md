# 📅 Bugün Ne Günü? (What Day is it Today?)

Yüksek performanslı, teknik SEO odaklı, tarih bazlı yerel arama sorgularını (ör. *"Dünya Kahve Günü ne zaman?"*, *"29 Ekim resmi tatil mi?"*) hedefleyen modern rehber platformu.

---

## 🚀 Öne Çıkan Özellikler

- **⚡ Next.js 16 (App Router) & Edge / ISR:** `revalidate: 3600` ile dinamik güncellemeler ve statik sayfa hızında (SSG) anında açılan sayfalar.
- **🔍 İleri Düzey Teknik SEO & JSON-LD:**
  - `Event` Şeması: Başlık, `celebration_date`, `VirtualLocation` ve katılım modu.
  - `FAQPage` Şeması: Otomatik üretilen 3 kritik soru (*"2026 [Gün] ne zaman?"*, *"[Gün] nasıl kutlanır?"*, *"En iyi mesajlar nelerdir?"*).
  - `BreadcrumbList` & `WebSite` Arama Şeması.
  - Dinamik OpenGraph ve Twitter Cards meta etiketleri.
  - Otomatik `sitemap.xml` ve `robots.txt`.
  - **Yıl içermeyen kalıcı slug yapısı** (ör. `/gun/dunya-kahve-gunu`).
- **📱 Modern & Erişilebilir UI (Tailwind CSS + shadcn/ui):**
  - Dev tipografi tarih gösterimi (ör. "1 Ekim").
  - Çoklu sekme yapısı (**"Nedir?"**, **"Nasıl Kutlanır?"**, **"Sosyal Medya & Mesajlar"**).
  - Tek tıkla kopyalanabilir hashtag ve altyazı şablonları.
  - Hızlı arama modalı (`Ctrl + K`).
- **🛍️ Dönüşüm Odaklı Affiliate Box:**
  - `affiliate_keywords` dizisi ile dinamik Trendyol ve Amazon derin bağlantıları.
  - Kampanya ve hediye öneri kartları.
- **💰 Google AdSense Entegrasyonu:**
  - Standart 728x90 Leaderboard, In-Article ve 300x250 kutu reklam slotları hazır.
- **🗄️ Supabase PostgreSQL:**
  - Tam `special_days` SQL şeması, indeksler, RLS politikaları.
  - Supabase henüz bağlanmadığında bile kesintisiz çalışan akıllı veri katmanı (graceful fallback).

---

## 📂 Sayfa Mimarisi ve Rotalar

| Rota | Açıklama | Render Modeli |
| :--- | :--- | :--- |
| `app/page.tsx` | Bugünün tarihine göre özel günleri listeleyen dinamik ana sayfa | ISR (`revalidate: 3600`) |
| `app/aylar/[monthSlug]/page.tsx` | 12 ay için pillar (kategori takvimi) sayfaları (ör. `/aylar/ekim`) | SSG (`generateStaticParams`) |
| `app/gun/[slug]/page.tsx` | Özel gün detay sayfası, sekmeler, JSON-LD ve affiliate kutusu | SSG (`generateStaticParams`) |
| `app/sitemap.ts` | Tüm sayfaları kapsayan dinamik XML site haritası | Dynamic / Static |
| `app/robots.ts` | Arama motoru robot direktifleri | Static |
| `app/api/seed/route.ts` | Supabase veritabanını tek tıkla dolduran API uç noktası | API Route (POST) |

---

## 🗄️ Veritabanı Şeması (`special_days`)

`supabase/schema.sql` dosyasında aşağıdaki alanlar ve indeksler yer alır:

- `id`: UUID (Primary Key)
- `slug`: TEXT UNIQUE (ör. `dunya-kahve-gunu`)
- `title`: TEXT (ör. `Dünya Kahve Günü`)
- `description`: TEXT (Özet açıklama)
- `content`: TEXT (Markdown formatında detaylı içerik)
- `celebration_date`: DATE (2026-10-01)
- `month_no`: INTEGER (1 - 12)
- `day_no`: INTEGER (1 - 31)
- `category`: TEXT (Eğlence, Resmi, Sağlık, Çevre & Doğa, Kültür & Sanat vb.)
- `hashtags`: TEXT[] (`['#DunyaKahveGunu', '#Kahve']`)
- `affiliate_keywords`: TEXT[] (`['filtre kahve makinesi', 'termos kupa']`)
- `created_at` & `updated_at`: TIMESTAMP WITH TIME ZONE

---

## 🛠️ Kurulum ve Çalıştırma

### 1. Proje Dizinine Geçiş
```bash
cd C:\Users\PC\.gemini\antigravity\scratch\bugun-ne-gunu
```

### 2. Bağımlılıkları Yükleme
```bash
npm install
```

### 3. Ortam Değişkenleri (.env.local)
`.env.example` dosyasını `.env.local` olarak kopyalayın:
```env
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
NEXT_PUBLIC_ADSENSE_CLIENT_ID=ca-pub-XXXXXXXXXXXXXXXX
```
*(Not: Supabase anahtarları girilmemiş olsa dahi, uygulama yerleşik zengin veri setiyle hatasız ve tam işlevli çalışır).*

### 4. Supabase Veritabanını Kurma & Doldurma
1. Supabase Dashboard'unuzda **SQL Editor** sekmesine gidin.
2. `supabase/schema.sql` dosyasının içeriğini yapıştırıp çalıştırın.
3. Veya `.env.local` ayarlandıktan sonra `POST /api/seed` isteği atarak hazır günleri yükleyin.

### 5. Geliştirme Sunucusunu Başlatma
```bash
npm run dev
```
Tarayıcınızda [http://localhost:3000](http://localhost:3000) adresini açın.

### 6. Üretim Derlemesi (Production Build)
```bash
npm run build
npm run start
```
