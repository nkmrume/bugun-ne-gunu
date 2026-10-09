"use client";

import React, { useState, useEffect, useMemo } from "react";
import Link from "next/link";
import {
  CalendarDays,
  Calendar,
  Search,
  Filter,
  BarChart3,
  Database,
  Download,
  Copy,
  ExternalLink,
  Lock,
  LogOut,
  RefreshCw,
  ShieldCheck,
  Sparkles,
  Plus,
  Trash2,
  Edit,
  FileText,
  Layers,
  CheckCircle2,
  AlertCircle,
  Check,
  Eye,
  Info,
  Sliders,
  Globe,
  Share2,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { SpecialDay, SpecialDayCategory, DayType } from "@/types/database";
import { INITIAL_SPECIAL_DAYS, MONTHS_METADATA } from "@/lib/data/special-days-data";
import { CATEGORIES_METADATA } from "@/lib/data/categories-data";
import { slugifyTurkish } from "@/lib/utils";

const MASTER_PIN = "bugun2026"; // Default secure master admin PIN

export default function AdminDashboardPage() {
  // Authentication State
  const [isAuthenticated, setIsAuthenticated] = useState<boolean>(() => {
    if (typeof window !== "undefined") {
      return localStorage.getItem("bugun_admin_auth") === "true";
    }
    return false;
  });
  const [pinInput, setPinInput] = useState<string>("");
  const [pinError, setPinError] = useState<string>("");

  // Dashboard Active Tab
  const [activeTab, setActiveTab] = useState<"analytics" | "cms" | "list" | "export" | "editorial">("analytics");

  // Data State
  const [days, setDays] = useState<SpecialDay[]>(INITIAL_SPECIAL_DAYS);
  const [loading, setLoading] = useState<boolean>(false);
  const [hasSupabase, setHasSupabase] = useState<boolean>(false);
  const [notification, setNotification] = useState<{ type: "success" | "error" | "info"; message: string } | null>(null);

  // Search & Filter State in List
  const [searchTerm, setSearchTerm] = useState("");
  const [selectedMonthFilter, setSelectedMonthFilter] = useState<number | "all">("all");
  const [selectedCategoryFilter, setSelectedCategoryFilter] = useState<string>("all");
  const [selectedToneFilter, setSelectedToneFilter] = useState<string>("all");

  // Form State for CMS (Create / Edit)
  const [isEditing, setIsEditing] = useState(false);
  const [editingId, setEditingId] = useState<string | null>(null);
  const [formData, setFormData] = useState({
    title: "",
    slug: "",
    day_no: 1,
    month_no: 1,
    category: "Eğlence" as SpecialDayCategory,
    day_type: "kutlama" as DayType,
    scope: "turkiye" as "turkiye" | "uluslararasi" | "bm",
    is_public_holiday: false,
    description: "",
    content: "",
    source_name: "",
    source_url: "",
    hashtags: "",
    affiliate_keywords: "",
    messages: "",
  });

  // Export State
  const [copiedFormat, setCopiedFormat] = useState<string | null>(null);

  const handleRefresh = async () => {
    setLoading(true);
    try {
      const res = await fetch("/api/admin/day");
      const json = await res.json();
      if (json.success && json.days) {
        setDays(json.days);
        setHasSupabase(Boolean(json.hasSupabase));
      }
    } catch {
      // Fallback to local dataset
      setDays(INITIAL_SPECIAL_DAYS);
    } finally {
      setLoading(false);
    }
  };

  // Fetch Live Data from API on Auth
  useEffect(() => {
    if (!isAuthenticated) return;

    let ignore = false;
    const fetchDays = async () => {
      try {
        const res = await fetch("/api/admin/day");
        const json = await res.json();
        if (!ignore && json.success && json.days) {
          setDays(json.days);
          setHasSupabase(Boolean(json.hasSupabase));
        }
      } catch {
        if (!ignore) {
          setDays(INITIAL_SPECIAL_DAYS);
        }
      }
    };

    fetchDays();
    return () => {
      ignore = true;
    };
  }, [isAuthenticated]);

  const handleLogin = (e: React.FormEvent) => {
    e.preventDefault();
    if (pinInput.trim() === MASTER_PIN) {
      setIsAuthenticated(true);
      localStorage.setItem("bugun_admin_auth", "true");
      setPinError("");
    } else {
      setPinError("Hatalı PIN kodu! Lütfen tekrar deneyiniz.");
    }
  };

  const handleLogout = () => {
    setIsAuthenticated(false);
    localStorage.removeItem("bugun_admin_auth");
    setPinInput("");
  };

  const showNotification = (type: "success" | "error" | "info", message: string) => {
    setNotification({ type, message });
    setTimeout(() => {
      setNotification(null);
    }, 4500);
  };

  // Auto-generate slug when title changes in form
  const handleTitleChange = (newTitle: string) => {
    setFormData((prev) => ({
      ...prev,
      title: newTitle,
      slug: isEditing ? prev.slug : slugifyTurkish(newTitle),
    }));
  };

  // Reset CMS Form
  const resetForm = () => {
    setFormData({
      title: "",
      slug: "",
      day_no: 1,
      month_no: 10,
      category: "Kültür & Sanat",
      day_type: "kutlama",
      scope: "turkiye",
      is_public_holiday: false,
      description: "",
      content: "",
      source_name: "",
      source_url: "",
      hashtags: "",
      affiliate_keywords: "",
      messages: "",
    });
    setIsEditing(false);
    setEditingId(null);
  };

  // Populate form for Editing
  const startEditing = (day: SpecialDay) => {
    setIsEditing(true);
    setEditingId(day.id);
    setFormData({
      title: day.title,
      slug: day.slug,
      day_no: day.day_no,
      month_no: day.month_no,
      category: day.category,
      day_type: day.day_type || "kutlama",
      scope: day.scope || "turkiye",
      is_public_holiday: Boolean(day.is_public_holiday),
      description: day.description || "",
      content: day.content || "",
      source_name: day.source_name || "",
      source_url: day.source_url || "",
      hashtags: day.hashtags ? day.hashtags.join(", ") : "",
      affiliate_keywords: day.affiliate_keywords ? day.affiliate_keywords.join(", ") : "",
      messages: "",
    });
    setActiveTab("cms");
  };

  // Submit Form (Save or Update)
  const handleFormSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!formData.title || !formData.slug || !formData.day_no || !formData.month_no) {
      showNotification("error", "Lütfen başlık, slug, gün ve ay alanlarını doldurunuz.");
      return;
    }

    // Editorial Tone Check
    if (formData.day_type === "anma") {
      const lower = (formData.title + " " + formData.description).toLowerCase();
      if (lower.includes("kutlu olsun") || lower.includes("coşkuyla")) {
        showNotification(
          "error",
          "Editoryal Kural İhlali: Anma günlerinde kutlama ve tebrik dili kullanılamaz. Lütfen saygı/rahmet ifadeleri kullanınız."
        );
        return;
      }
    }

    const dayPayload: Partial<SpecialDay> = {
      id: isEditing && editingId ? editingId : `custom-${Date.now()}`,
      slug: formData.slug.trim().toLowerCase(),
      title: formData.title.trim(),
      description: formData.description.trim(),
      content:
        formData.content.trim() ||
        `## ${formData.title} Nedir?\n${formData.description}\n\n### Tarihçesi ve Önemi\nBu özel gün gerek Türkiye'de gerekse dünya çapında her yıl düzenli etkinliklerle ele alınmaktadır.`,
      month_no: Number(formData.month_no),
      day_no: Number(formData.day_no),
      category: formData.category,
      day_type: formData.day_type,
      scope: formData.scope,
      is_public_holiday: formData.is_public_holiday,
      source_name: formData.source_name.trim(),
      source_url: formData.source_url.trim(),
      hashtags: formData.hashtags
        ? formData.hashtags.split(",").map((t) => t.trim()).filter(Boolean)
        : [`#${formData.slug.replace(/-/g, "")}`],
      affiliate_keywords: formData.affiliate_keywords
        ? formData.affiliate_keywords.split(",").map((k) => k.trim()).filter(Boolean)
        : [],
    };

    try {
      const res = await fetch("/api/admin/day", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(dayPayload),
      });
      const data = await res.json();

      if (!res.ok) {
        showNotification("error", data.error || "Kayıt işlemi başarısız.");
        return;
      }

      // Update state locally
      setDays((prev) => {
        const index = prev.findIndex((d) => d.slug === dayPayload.slug || d.id === dayPayload.id);
        if (index >= 0) {
          const next = [...prev];
          next[index] = { ...next[index], ...(dayPayload as SpecialDay) };
          return next;
        } else {
          return [...prev, dayPayload as SpecialDay];
        }
      });

      showNotification(
        "success",
        isEditing
          ? `"${dayPayload.title}" başarıyla güncellendi!`
          : `"${dayPayload.title}" sisteme başarıyla eklendi!`
      );
      resetForm();
      setActiveTab("list");
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : "Bilinmeyen hata";
      showNotification("error", msg);
    }
  };

  // Delete Day
  const handleDeleteDay = async (slug: string, title: string) => {
    if (!confirm(`"${title}" kaydını silmek istediğinize emin misiniz?`)) {
      return;
    }

    try {
      const res = await fetch(`/api/admin/day?slug=${slug}`, { method: "DELETE" });
      const data = await res.json();
      if (!res.ok) {
        showNotification("error", data.error || "Silme başarısız.");
        return;
      }

      setDays((prev) => prev.filter((d) => d.slug !== slug));
      showNotification("success", `"${title}" başarıyla silindi.`);
    } catch {
      showNotification("error", "Silme sırasında hata oluştu.");
    }
  };

  // Filtered Days for List
  const filteredDays = useMemo(() => {
    return days.filter((d) => {
      const matchesSearch =
        d.title.toLowerCase().includes(searchTerm.toLowerCase()) ||
        d.slug.toLowerCase().includes(searchTerm.toLowerCase()) ||
        (d.source_name && d.source_name.toLowerCase().includes(searchTerm.toLowerCase()));

      const matchesMonth = selectedMonthFilter === "all" || d.month_no === selectedMonthFilter;
      const matchesCategory = selectedCategoryFilter === "all" || d.category === selectedCategoryFilter;
      const matchesTone = selectedToneFilter === "all" || (d.day_type || "kutlama") === selectedToneFilter;

      return matchesSearch && matchesMonth && matchesCategory && matchesTone;
    });
  }, [days, searchTerm, selectedMonthFilter, selectedCategoryFilter, selectedToneFilter]);

  // Analytics Calculations
  const stats = useMemo(() => {
    const total = days.length;
    const verifiedWithSource = days.filter((d) => Boolean(d.source_url || d.source_name)).length;
    const verifiedPercent = total > 0 ? Math.round((verifiedWithSource / total) * 100) : 0;

    // Unique dates covered (out of 365)
    const uniqueDates = new Set(days.map((d) => `${d.month_no}-${d.day_no}`));
    const coveragePercent = Math.round((uniqueDates.size / 365) * 100);

    // Tones breakdown
    const celebrations = days.filter((d) => !d.day_type || d.day_type === "kutlama").length;
    const memorials = days.filter((d) => d.day_type === "anma").length;
    const awareness = days.filter((d) => d.day_type === "farkindalik").length;
    const publicHolidays = days.filter((d) => d.is_public_holiday).length;

    // Category breakdown
    const categoryCounts: Record<string, number> = {};
    days.forEach((d) => {
      categoryCounts[d.category] = (categoryCounts[d.category] || 0) + 1;
    });

    // Month breakdown (how many days in each month have at least 1 record)
    const monthStats = MONTHS_METADATA.map((m) => {
      const daysInMonth = days.filter((d) => d.month_no === m.number);
      const uniqueDaysInMonth = new Set(daysInMonth.map((d) => d.day_no)).size;
      const fillRate = Math.round((uniqueDaysInMonth / m.daysCount) * 100);
      return {
        ...m,
        totalEvents: daysInMonth.length,
        filledDays: uniqueDaysInMonth,
        fillRate,
      };
    });

    // Missing dates analyzer (dates with 0 events)
    const missingDates: { day: number; month: number; monthName: string }[] = [];
    MONTHS_METADATA.forEach((m) => {
      for (let d = 1; d <= m.daysCount; d++) {
        const hasDay = days.some((item) => item.month_no === m.number && item.day_no === d);
        if (!hasDay) {
          missingDates.push({ day: d, month: m.number, monthName: m.name });
        }
      }
    });

    // Content quality alerts (missing description, missing source, long title)
    const auditAlerts = {
      missingSource: days.filter((d) => !d.source_url && !d.source_name),
      shortDescription: days.filter((d) => !d.description || d.description.length < 30),
      longTitle: days.filter((d) => d.title.length > 60),
    };

    return {
      total,
      verifiedWithSource,
      verifiedPercent,
      uniqueDaysCount: uniqueDates.size,
      coveragePercent,
      celebrations,
      memorials,
      awareness,
      publicHolidays,
      categoryCounts,
      monthStats,
      missingDates,
      auditAlerts,
    };
  }, [days]);

  // Export Generators
  const copyTypeScript = () => {
    const code = `import { SpecialDay } from "@/types/database";\n\nexport const INITIAL_SPECIAL_DAYS: SpecialDay[] = ${JSON.stringify(
      days,
      null,
      2
    )};`;
    navigator.clipboard.writeText(code);
    setCopiedFormat("typescript");
    setTimeout(() => setCopiedFormat(null), 3000);
  };

  const copySupabaseSQL = () => {
    const sqlStatements = days
      .map((d) => {
        const cleanTitle = d.title.replace(/'/g, "''");
        const cleanDesc = (d.description || "").replace(/'/g, "''");
        const cleanContent = (d.content || "").replace(/'/g, "''");
        const cleanSourceName = (d.source_name || "").replace(/'/g, "''");
        const cleanSourceUrl = (d.source_url || "").replace(/'/g, "''");
        const tags = JSON.stringify(d.hashtags || []);
        const aff = JSON.stringify(d.affiliate_keywords || []);

        return `INSERT INTO special_days (
  id, slug, title, description, content, celebration_date, month_no, day_no, category, day_type, is_public_holiday, scope, source_name, source_url, hashtags, affiliate_keywords
) VALUES (
  '${d.id}', '${d.slug}', '${cleanTitle}', '${cleanDesc}', '${cleanContent}', '${d.celebration_date}', ${d.month_no}, ${d.day_no}, '${d.category}', '${d.day_type || "kutlama"}', ${Boolean(d.is_public_holiday)}, '${d.scope || "turkiye"}', '${cleanSourceName}', '${cleanSourceUrl}', '${tags}'::jsonb, '${aff}'::jsonb
) ON CONFLICT (slug) DO UPDATE SET 
  title = EXCLUDED.title, description = EXCLUDED.description, content = EXCLUDED.content, category = EXCLUDED.category, day_type = EXCLUDED.day_type, is_public_holiday = EXCLUDED.is_public_holiday, source_name = EXCLUDED.source_name, source_url = EXCLUDED.source_url;`;
      })
      .join("\n\n");

    navigator.clipboard.writeText(sqlStatements);
    setCopiedFormat("sql");
    setTimeout(() => setCopiedFormat(null), 3000);
  };

  const downloadJSONBackup = () => {
    const dataStr = "data:text/json;charset=utf-8," + encodeURIComponent(JSON.stringify(days, null, 2));
    const downloadAnchor = document.createElement("a");
    downloadAnchor.setAttribute("href", dataStr);
    downloadAnchor.setAttribute("download", `bugun-ne-gunu-backup-${new Date().toISOString().slice(0, 10)}.json`);
    document.body.appendChild(downloadAnchor);
    downloadAnchor.click();
    downloadAnchor.remove();
  };

  // 1. Lock Screen if Not Authenticated
  if (!isAuthenticated) {
    return (
      <div className="min-h-screen bg-gradient-to-b from-zinc-50 via-white to-zinc-100 dark:from-zinc-950 dark:via-zinc-900 dark:to-zinc-950 flex items-center justify-center px-4 py-16">
        <div className="w-full max-w-md rounded-3xl border border-zinc-200/80 bg-white p-8 shadow-2xl dark:border-zinc-800 dark:bg-zinc-900 text-center">
          <div className="mx-auto flex h-14 w-14 items-center justify-center rounded-2xl bg-red-100 text-red-600 dark:bg-red-950/60 dark:text-red-400 mb-6">
            <Lock className="h-7 w-7" />
          </div>

          <h1 className="text-2xl font-black tracking-tight text-zinc-900 dark:text-white">
            Yönetim Masası Girişi
          </h1>
          <p className="mt-2 text-sm text-zinc-500 leading-relaxed">
            Bugün Ne Günü? Editoryal İçerik ve Analiz Paneline erişmek için yönetici PIN kodunu giriniz.
          </p>

          <form onSubmit={handleLogin} className="mt-8 space-y-4">
            <div>
              <Input
                type="password"
                placeholder="Yönetici PIN Kodu..."
                value={pinInput}
                onChange={(e) => setPinInput(e.target.value)}
                className="text-center font-mono text-lg tracking-widest py-3 rounded-xl border-zinc-300"
                autoFocus
              />
              {pinError && (
                <p className="mt-2 text-xs font-semibold text-red-600 dark:text-red-400">
                  {pinError}
                </p>
              )}
            </div>

            <Button type="submit" className="w-full py-3 rounded-xl font-bold bg-red-600 hover:bg-red-700 text-white shadow-md">
              Güvenli Giriş Yap
            </Button>
          </form>

          <div className="mt-6 border-t border-zinc-100 pt-4 dark:border-zinc-800">
            <span className="text-xs text-zinc-400">
              Varsayılan Sistem PIN: <code className="bg-zinc-100 dark:bg-zinc-800 px-1.5 py-0.5 rounded text-zinc-600 dark:text-zinc-300 font-mono">bugun2026</code>
            </span>
          </div>
        </div>
      </div>
    );
  }

  // 2. Authenticated Admin Dashboard
  return (
    <div className="min-h-screen bg-zinc-50/50 dark:bg-zinc-950 pb-24">
      {/* Top Admin Header */}
      <header className="sticky top-0 z-30 border-b border-zinc-200 bg-white/95 backdrop-blur dark:border-zinc-800 dark:bg-zinc-900/95">
        <div className="mx-auto flex h-16 max-w-7xl items-center justify-between px-4 sm:px-6 lg:px-8">
          <div className="flex items-center gap-3">
            <div className="flex h-9 w-9 items-center justify-center rounded-xl bg-gradient-to-tr from-red-600 to-amber-500 text-white shadow-sm">
              <Sliders className="h-4 w-4" />
            </div>
            <div>
              <span className="text-base font-black tracking-tight text-zinc-900 dark:text-white flex items-center gap-2">
                Bugün Ne Günü? <span className="text-xs px-2 py-0.5 rounded-full bg-red-100 text-red-700 dark:bg-red-950/60 dark:text-red-400 font-bold">Admin CMS</span>
              </span>
              <div className="flex items-center gap-2 text-[11px] text-zinc-500">
                <span className="flex items-center gap-1">
                  <span className={`h-2 w-2 rounded-full ${hasSupabase ? "bg-emerald-500" : "bg-amber-400"}`} />
                  {hasSupabase ? "Supabase Canlı Veri" : "Yerel Bellek / Export Modu"}
                </span>
                <span>•</span>
                <span>{days.length} Kayıtlı Gün</span>
              </div>
            </div>
          </div>

          <div className="flex items-center gap-2.5">
            <Button
              variant="outline"
              size="sm"
              onClick={handleRefresh}
              disabled={loading}
              className="text-xs gap-1.5 rounded-xl border-zinc-200"
            >
              <RefreshCw className={`h-3.5 w-3.5 ${loading ? "animate-spin" : ""}`} />
              <span className="hidden sm:inline">Yenile</span>
            </Button>

            <Link href="/" target="_blank">
              <Button variant="outline" size="sm" className="text-xs gap-1.5 rounded-xl border-zinc-200">
                <ExternalLink className="h-3.5 w-3.5" />
                <span className="hidden sm:inline">Canlı Site</span>
              </Button>
            </Link>

            <Button
              variant="outline"
              size="sm"
              onClick={handleLogout}
              className="text-xs gap-1.5 rounded-xl border-red-200 text-red-600 hover:bg-red-50 dark:border-red-900/60 dark:hover:bg-red-950/50"
            >
              <LogOut className="h-3.5 w-3.5" />
              <span>Çıkış</span>
            </Button>
          </div>
        </div>

        {/* Tab Navigation */}
        <div className="mx-auto flex max-w-7xl items-center gap-2 overflow-x-auto px-4 sm:px-6 lg:px-8 border-t border-zinc-100 dark:border-zinc-800 py-2">
          <button
            onClick={() => setActiveTab("analytics")}
            className={`flex items-center gap-2 px-3.5 py-1.5 rounded-xl text-xs font-bold transition-colors whitespace-nowrap ${
              activeTab === "analytics"
                ? "bg-red-600 text-white shadow-sm"
                : "text-zinc-600 hover:bg-zinc-100 dark:text-zinc-400 dark:hover:bg-zinc-800"
            }`}
          >
            <BarChart3 className="h-4 w-4" />
            <span>Analizler & Kapsam</span>
          </button>

          <button
            onClick={() => setActiveTab("cms")}
            className={`flex items-center gap-2 px-3.5 py-1.5 rounded-xl text-xs font-bold transition-colors whitespace-nowrap ${
              activeTab === "cms"
                ? "bg-red-600 text-white shadow-sm"
                : "text-zinc-600 hover:bg-zinc-100 dark:text-zinc-400 dark:hover:bg-zinc-800"
            }`}
          >
            <Plus className="h-4 w-4" />
            <span>{isEditing ? "Günü Düzenle" : "Yeni Gün Ekle"}</span>
          </button>

          <button
            onClick={() => setActiveTab("list")}
            className={`flex items-center gap-2 px-3.5 py-1.5 rounded-xl text-xs font-bold transition-colors whitespace-nowrap ${
              activeTab === "list"
                ? "bg-red-600 text-white shadow-sm"
                : "text-zinc-600 hover:bg-zinc-100 dark:text-zinc-400 dark:hover:bg-zinc-800"
            }`}
          >
            <Layers className="h-4 w-4" />
            <span>İçerik Arşivi ({days.length})</span>
          </button>

          <button
            onClick={() => setActiveTab("export")}
            className={`flex items-center gap-2 px-3.5 py-1.5 rounded-xl text-xs font-bold transition-colors whitespace-nowrap ${
              activeTab === "export"
                ? "bg-red-600 text-white shadow-sm"
                : "text-zinc-600 hover:bg-zinc-100 dark:text-zinc-400 dark:hover:bg-zinc-800"
            }`}
          >
            <Download className="h-4 w-4" />
            <span>Dışa Aktar & SQL</span>
          </button>

          <button
            onClick={() => setActiveTab("editorial")}
            className={`flex items-center gap-2 px-3.5 py-1.5 rounded-xl text-xs font-bold transition-colors whitespace-nowrap ${
              activeTab === "editorial"
                ? "bg-red-600 text-white shadow-sm"
                : "text-zinc-600 hover:bg-zinc-100 dark:text-zinc-400 dark:hover:bg-zinc-800"
            }`}
          >
            <ShieldCheck className="h-4 w-4" />
            <span>Editoryal Kalite & Denetim</span>
            {stats.auditAlerts.missingSource.length > 0 && (
              <span className="rounded-full bg-amber-400 text-zinc-900 text-[10px] px-1.5 py-0.2 font-black">
                {stats.auditAlerts.missingSource.length}
              </span>
            )}
          </button>
        </div>
      </header>

      {/* Toast Notification Alert */}
      {notification && (
        <div className="fixed bottom-6 right-6 z-50 animate-in slide-in-from-bottom-5 duration-200">
          <div
            className={`flex items-center gap-3 rounded-2xl px-5 py-3 text-sm font-semibold text-white shadow-2xl ${
              notification.type === "success"
                ? "bg-emerald-600"
                : notification.type === "error"
                ? "bg-red-600"
                : "bg-blue-600"
            }`}
          >
            {notification.type === "success" ? (
              <CheckCircle2 className="h-5 w-5" />
            ) : notification.type === "error" ? (
              <AlertCircle className="h-5 w-5" />
            ) : (
              <Info className="h-5 w-5" />
            )}
            <span>{notification.message}</span>
          </div>
        </div>
      )}

      {/* Main Container */}
      <main className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 mt-8">
        {/* ================= TAB 1: ANALYTICS & COVERAGE ================= */}
        {activeTab === "analytics" && (
          <div className="space-y-8 animate-in fade-in duration-150">
            {/* KPI Cards Row */}
            <div className="grid grid-cols-2 lg:grid-cols-4 gap-4 sm:gap-6">
              <div className="rounded-2xl border border-zinc-200 bg-white p-5 dark:border-zinc-800 dark:bg-zinc-900 shadow-sm">
                <span className="text-[11px] font-bold uppercase tracking-wider text-zinc-500">
                  Toplam Özel Gün
                </span>
                <div className="mt-2 flex items-baseline justify-between">
                  <span className="text-3xl font-black text-zinc-900 dark:text-white">
                    {stats.total}
                  </span>
                  <Badge variant="default" className="text-[10px]">Arşiv</Badge>
                </div>
                <p className="mt-1 text-xs text-zinc-500">
                  Doğrulanmış ve yayındaki tüm içerikler
                </p>
              </div>

              <div className="rounded-2xl border border-zinc-200 bg-white p-5 dark:border-zinc-800 dark:bg-zinc-900 shadow-sm">
                <span className="text-[11px] font-bold uppercase tracking-wider text-emerald-600 dark:text-emerald-400">
                  Resmî Kaynak Teyidi
                </span>
                <div className="mt-2 flex items-baseline justify-between">
                  <span className="text-3xl font-black text-zinc-900 dark:text-white">
                    %{stats.verifiedPercent}
                  </span>
                  <Badge variant="outline" className="text-[10px] text-emerald-600 border-emerald-300">
                    {stats.verifiedWithSource} Teyitli
                  </Badge>
                </div>
                <p className="mt-1 text-xs text-zinc-500">
                  BM, UNESCO veya Resmî Gazete bağlantılı
                </p>
              </div>

              <div className="rounded-2xl border border-zinc-200 bg-white p-5 dark:border-zinc-800 dark:bg-zinc-900 shadow-sm">
                <span className="text-[11px] font-bold uppercase tracking-wider text-blue-600 dark:text-blue-400">
                  365 Gün Kapsamı
                </span>
                <div className="mt-2 flex items-baseline justify-between">
                  <span className="text-3xl font-black text-zinc-900 dark:text-white">
                    %{stats.coveragePercent}
                  </span>
                  <Badge variant="outline" className="text-[10px] text-blue-600 border-blue-300">
                    {stats.uniqueDaysCount} / 365 Gün
                  </Badge>
                </div>
                <p className="mt-1 text-xs text-zinc-500">
                  En az 1 özel güne sahip takvim günleri
                </p>
              </div>

              <div className="rounded-2xl border border-zinc-200 bg-white p-5 dark:border-zinc-800 dark:bg-zinc-900 shadow-sm">
                <span className="text-[11px] font-bold uppercase tracking-wider text-purple-600 dark:text-purple-400">
                  Editoryal Ton
                </span>
                <div className="mt-2 flex items-center gap-2">
                  <span className="text-xs font-bold text-zinc-700 dark:text-zinc-300">
                    🎉 {stats.celebrations}
                  </span>
                  <span className="text-zinc-300">|</span>
                  <span className="text-xs font-bold text-zinc-700 dark:text-zinc-300">
                    🕯️ {stats.memorials}
                  </span>
                  <span className="text-zinc-300">|</span>
                  <span className="text-xs font-bold text-zinc-700 dark:text-zinc-300">
                    🌱 {stats.awareness}
                  </span>
                </div>
                <p className="mt-1 text-xs text-zinc-500">
                  {stats.publicHolidays} Resmi Tatil Mevcut
                </p>
              </div>
            </div>

            {/* 12 Months Fill Rate Progress Heatmap */}
            <div className="rounded-3xl border border-zinc-200 bg-white p-6 sm:p-8 dark:border-zinc-800 dark:bg-zinc-900 shadow-sm">
              <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2 mb-6">
                <div>
                  <h3 className="text-lg font-black text-zinc-900 dark:text-white flex items-center gap-2">
                    <Calendar className="h-5 w-5 text-red-600" />
                    12 Ay Doluluk & Kapsam Haritası
                  </h3>
                  <p className="text-xs text-zinc-500">
                    Her ayın toplam takvim gününün yüzde kaçında kayıtlı özel gün bulunduğunu gösterir.
                  </p>
                </div>
                <span className="text-xs font-bold text-zinc-500">
                  Hedef: Yılın 365 Gününe Ulaşmak
                </span>
              </div>

              <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-4">
                {stats.monthStats.map((m) => (
                  <div
                    key={m.slug}
                    className="rounded-2xl border border-zinc-100 bg-zinc-50/70 p-4 dark:border-zinc-800 dark:bg-zinc-800/40"
                  >
                    <div className="flex items-center justify-between">
                      <span className="text-sm font-bold text-zinc-900 dark:text-zinc-100">
                        {m.name}
                      </span>
                      <span className="text-xs font-black text-red-600 dark:text-red-400">
                        %{m.fillRate}
                      </span>
                    </div>

                    <div className="mt-2.5 h-2 w-full rounded-full bg-zinc-200 dark:bg-zinc-700 overflow-hidden">
                      <div
                        className="h-full bg-gradient-to-r from-red-500 to-amber-500 rounded-full transition-all duration-500"
                        style={{ width: `${Math.min(m.fillRate, 100)}%` }}
                      />
                    </div>

                    <div className="mt-2 flex items-center justify-between text-[11px] text-zinc-500">
                      <span>{m.totalEvents} Etkinlik</span>
                      <span>{m.filledDays} / {m.daysCount} Gün</span>
                    </div>
                  </div>
                ))}
              </div>
            </div>

            {/* Gap Analyzer: Missing Dates List & Quick Add */}
            <div className="rounded-3xl border border-zinc-200 bg-white p-6 sm:p-8 dark:border-zinc-800 dark:bg-zinc-900 shadow-sm">
              <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 mb-6">
                <div>
                  <h3 className="text-lg font-black text-zinc-900 dark:text-white flex items-center gap-2">
                    <Info className="h-5 w-5 text-amber-500" />
                    Eksik Günler & İçerik Fırsatları ({stats.missingDates.length} Boş Gün)
                  </h3>
                  <p className="text-xs text-zinc-500">
                    Takvimde henüz hiçbir özel gün atanmamış tarihler. Tıklayarak doğrudan o güne yeni içerik ekleyebilirsiniz.
                  </p>
                </div>
              </div>

              <div className="flex flex-wrap gap-2 max-h-56 overflow-y-auto p-2 border border-zinc-100 rounded-2xl dark:border-zinc-800">
                {stats.missingDates.slice(0, 48).map((missing, idx) => (
                  <button
                    key={idx}
                    onClick={() => {
                      setFormData((prev) => ({
                        ...prev,
                        day_no: missing.day,
                        month_no: missing.month,
                        title: `${missing.day} ${missing.monthName} `,
                      }));
                      setActiveTab("cms");
                    }}
                    className="flex items-center gap-1.5 rounded-xl border border-zinc-200 bg-white px-3 py-1.5 text-xs font-semibold text-zinc-700 hover:border-red-300 hover:bg-red-50 hover:text-red-700 transition-colors dark:border-zinc-800 dark:bg-zinc-900 dark:text-zinc-300"
                  >
                    <span>{missing.day} {missing.monthName}</span>
                    <Plus className="h-3 w-3 text-red-500" />
                  </button>
                ))}
                {stats.missingDates.length > 48 && (
                  <span className="text-xs text-zinc-400 self-center pl-2">
                    + {stats.missingDates.length - 48} gün daha boş
                  </span>
                )}
              </div>
            </div>
          </div>
        )}

        {/* ================= TAB 2: CMS CREATE / EDIT ================= */}
        {activeTab === "cms" && (
          <div className="max-w-4xl mx-auto rounded-3xl border border-zinc-200 bg-white p-6 sm:p-10 dark:border-zinc-800 dark:bg-zinc-900 shadow-sm animate-in fade-in duration-150">
            <div className="flex items-center justify-between pb-6 border-b border-zinc-100 dark:border-zinc-800 mb-8">
              <div>
                <h2 className="text-2xl font-black text-zinc-900 dark:text-white flex items-center gap-2">
                  {isEditing ? <Edit className="h-6 w-6 text-amber-500" /> : <Plus className="h-6 w-6 text-red-600" />}
                  {isEditing ? "Özel Günü Düzenle" : "Yeni Özel Gün Ekle"}
                </h2>
                <p className="text-xs text-zinc-500 mt-1">
                  Doğrulanmış tarih, güvenilir kaynak ve uygun editoryal dil standartlarına göre formu doldurunuz.
                </p>
              </div>

              {isEditing && (
                <Button variant="outline" size="sm" onClick={resetForm} className="text-xs">
                  Düzenlemeyi İptal Et
                </Button>
              )}
            </div>

            <form onSubmit={handleFormSubmit} className="space-y-6">
              {/* Row 1: Title & Slug */}
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-6">
                <div>
                  <label className="block text-xs font-bold text-zinc-700 dark:text-zinc-300 mb-1.5">
                    Gün Başlığı * (Örn: 7 Ekim Dünya Pamuk Günü)
                  </label>
                  <Input
                    required
                    value={formData.title}
                    onChange={(e) => handleTitleChange(e.target.value)}
                    placeholder="Örn: 24 Ekim Birleşmiş Milletler Günü"
                    className="rounded-xl"
                  />
                </div>

                <div>
                  <label className="block text-xs font-bold text-zinc-700 dark:text-zinc-300 mb-1.5">
                    URL Slug * (Otomatik Üretilir)
                  </label>
                  <Input
                    required
                    value={formData.slug}
                    onChange={(e) => setFormData({ ...formData, slug: e.target.value })}
                    placeholder="birlesmis-milletler-gunu"
                    className="font-mono text-xs rounded-xl"
                  />
                </div>
              </div>

              {/* Row 2: Date & Month Selection */}
              <div className="grid grid-cols-2 sm:grid-cols-4 gap-4">
                <div>
                  <label className="block text-xs font-bold text-zinc-700 dark:text-zinc-300 mb-1.5">
                    Ay *
                  </label>
                  <select
                    value={formData.month_no}
                    onChange={(e) => setFormData({ ...formData, month_no: Number(e.target.value) })}
                    className="w-full rounded-xl border border-zinc-200 bg-white p-2.5 text-sm dark:border-zinc-800 dark:bg-zinc-900"
                  >
                    {MONTHS_METADATA.map((m) => (
                      <option key={m.number} value={m.number}>
                        {m.name} ({m.number}. Ay)
                      </option>
                    ))}
                  </select>
                </div>

                <div>
                  <label className="block text-xs font-bold text-zinc-700 dark:text-zinc-300 mb-1.5">
                    Gün * (1 - 31)
                  </label>
                  <Input
                    type="number"
                    min={1}
                    max={31}
                    required
                    value={formData.day_no}
                    onChange={(e) => setFormData({ ...formData, day_no: Number(e.target.value) })}
                    className="rounded-xl"
                  />
                </div>

                <div>
                  <label className="block text-xs font-bold text-zinc-700 dark:text-zinc-300 mb-1.5">
                    Kategori *
                  </label>
                  <select
                    value={formData.category}
                    onChange={(e) => setFormData({ ...formData, category: e.target.value as SpecialDayCategory })}
                    className="w-full rounded-xl border border-zinc-200 bg-white p-2.5 text-sm dark:border-zinc-800 dark:bg-zinc-900"
                  >
                    {CATEGORIES_METADATA.map((cat) => (
                      <option key={cat.slug} value={cat.name}>
                        {cat.name}
                      </option>
                    ))}
                  </select>
                </div>

                <div>
                  <label className="block text-xs font-bold text-zinc-700 dark:text-zinc-300 mb-1.5">
                    Editoryal Ton *
                  </label>
                  <select
                    value={formData.day_type}
                    onChange={(e) => setFormData({ ...formData, day_type: e.target.value as DayType })}
                    className="w-full rounded-xl border border-zinc-200 bg-white p-2.5 text-sm dark:border-zinc-800 dark:bg-zinc-900"
                  >
                    <option value="kutlama">🎉 Kutlama (Neşeli)</option>
                    <option value="anma">🕯️ Anma (Saygı & Yas)</option>
                    <option value="farkindalik">🌱 Farkındalık</option>
                    <option value="resmi-tatil">🇹🇷 Resmi Tatil</option>
                  </select>
                </div>
              </div>

              {/* Tone Warning Banner */}
              {formData.day_type === "anma" && (
                <div className="rounded-2xl border border-amber-200 bg-amber-50/70 p-4 text-xs text-amber-900 dark:border-amber-900/50 dark:bg-amber-950/40 dark:text-amber-200 flex items-start gap-2.5">
                  <AlertCircle className="h-4 w-4 text-amber-600 mt-0.5 shrink-0" />
                  <div>
                    <span className="font-bold">Editoryal Kural:</span> Anma günlerinde kutlama, tebrik ve neşe ifadeleri kesinlikle kullanılmamalıdır. Sayfa şablonunda otomatik olarak saygı ve vefat anması dili kullanılacaktır.
                  </div>
                </div>
              )}

              {/* Scope & Public Holiday */}
              <div className="flex flex-wrap items-center gap-6 p-4 rounded-2xl bg-zinc-50 dark:bg-zinc-800/40 border border-zinc-100 dark:border-zinc-800">
                <div className="flex items-center gap-2">
                  <input
                    type="checkbox"
                    id="is_public_holiday"
                    checked={formData.is_public_holiday}
                    onChange={(e) => setFormData({ ...formData, is_public_holiday: e.target.checked })}
                    className="h-4 w-4 rounded text-red-600"
                  />
                  <label htmlFor="is_public_holiday" className="text-xs font-bold text-zinc-800 dark:text-zinc-200 cursor-pointer">
                    Türkiye&apos;de Resmî Tatil mi?
                  </label>
                </div>

                <div className="flex items-center gap-2 text-xs">
                  <span className="font-bold text-zinc-700 dark:text-zinc-300">Kapsam:</span>
                  <label className="flex items-center gap-1 cursor-pointer">
                    <input
                      type="radio"
                      name="scope"
                      value="turkiye"
                      checked={formData.scope === "turkiye"}
                      onChange={() => setFormData({ ...formData, scope: "turkiye" })}
                    />
                    <span>Türkiye</span>
                  </label>
                  <label className="flex items-center gap-1 cursor-pointer ml-2">
                    <input
                      type="radio"
                      name="scope"
                      value="uluslararasi"
                      checked={formData.scope === "uluslararasi"}
                      onChange={() => setFormData({ ...formData, scope: "uluslararasi" })}
                    />
                    <span>Uluslararası</span>
                  </label>
                  <label className="flex items-center gap-1 cursor-pointer ml-2">
                    <input
                      type="radio"
                      name="scope"
                      value="bm"
                      checked={formData.scope === "bm"}
                      onChange={() => setFormData({ ...formData, scope: "bm" })}
                    />
                    <span>BM / UNESCO</span>
                  </label>
                </div>
              </div>

              {/* Short Description */}
              <div>
                <label className="block text-xs font-bold text-zinc-700 dark:text-zinc-300 mb-1.5">
                  Kısa Açıklama * (SEO Meta Description & Kart Özeti - 50-160 Karakter)
                </label>
                <textarea
                  required
                  rows={2}
                  value={formData.description}
                  onChange={(e) => setFormData({ ...formData, description: e.target.value })}
                  placeholder="Günün anlamını ve amacını özetleyen net açıklama..."
                  className="w-full rounded-xl border border-zinc-200 bg-white p-3 text-sm dark:border-zinc-800 dark:bg-zinc-900"
                />
              </div>

              {/* Source & Citation (Crucial for EEAT!) */}
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-6 p-5 rounded-2xl border border-emerald-100 bg-emerald-50/40 dark:border-emerald-950 dark:bg-emerald-950/20">
                <div>
                  <label className="block text-xs font-bold text-emerald-900 dark:text-emerald-300 mb-1.5 flex items-center gap-1">
                    <ShieldCheck className="h-3.5 w-3.5" />
                    Birincil Kaynak Kurum / Karar
                  </label>
                  <Input
                    value={formData.source_name}
                    onChange={(e) => setFormData({ ...formData, source_name: e.target.value })}
                    placeholder="Örn: Birleşmiş Milletler (A/RES/73/327)"
                    className="rounded-xl text-xs bg-white dark:bg-zinc-900"
                  />
                </div>

                <div>
                  <label className="block text-xs font-bold text-emerald-900 dark:text-emerald-300 mb-1.5">
                    Kaynak URL&apos;si (Doğrulama Bağlantısı)
                  </label>
                  <Input
                    type="url"
                    value={formData.source_url}
                    onChange={(e) => setFormData({ ...formData, source_url: e.target.value })}
                    placeholder="https://press.un.org/..."
                    className="rounded-xl text-xs font-mono bg-white dark:bg-zinc-900"
                  />
                </div>
              </div>

              {/* Detailed Content */}
              <div>
                <label className="block text-xs font-bold text-zinc-700 dark:text-zinc-300 mb-1.5">
                  Detaylı İçerik & Önemi (Markdown Destekli)
                </label>
                <textarea
                  rows={5}
                  value={formData.content}
                  onChange={(e) => setFormData({ ...formData, content: e.target.value })}
                  placeholder="## Tarihçesi ve Önemi&#10;Günün nasıl ortaya çıktığı ve Türkiye'deki yansımaları..."
                  className="w-full font-mono text-xs rounded-xl border border-zinc-200 bg-white p-3 dark:border-zinc-800 dark:bg-zinc-900"
                />
              </div>

              {/* Hashtags & Keywords */}
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-6">
                <div>
                  <label className="block text-xs font-bold text-zinc-700 dark:text-zinc-300 mb-1.5">
                    Sosyal Medya Etiketleri (Virgülle ayırınız)
                  </label>
                  <Input
                    value={formData.hashtags}
                    onChange={(e) => setFormData({ ...formData, hashtags: e.target.value })}
                    placeholder="#OzelGun, #Farkindalik, #Kutlama"
                    className="text-xs rounded-xl"
                  />
                </div>

                <div>
                  <label className="block text-xs font-bold text-zinc-700 dark:text-zinc-300 mb-1.5">
                    İlgili Konu / Hediye Kelimeleri
                  </label>
                  <Input
                    value={formData.affiliate_keywords}
                    onChange={(e) => setFormData({ ...formData, affiliate_keywords: e.target.value })}
                    placeholder="kahve fincanı, kitap seti, tasarım kupa"
                    className="text-xs rounded-xl"
                  />
                </div>
              </div>

              {/* Submit Buttons */}
              <div className="pt-4 flex items-center justify-end gap-3 border-t border-zinc-100 dark:border-zinc-800">
                <Button type="button" variant="outline" onClick={resetForm} className="rounded-xl text-xs">
                  Temizle
                </Button>
                <Button type="submit" className="rounded-xl text-xs font-bold bg-red-600 hover:bg-red-700 text-white px-6">
                  {isEditing ? "Değişiklikleri Kaydet" : "Sisteme Ekle"}
                </Button>
              </div>
            </form>
          </div>
        )}

        {/* ================= TAB 3: CONTENT LIST & SEARCH ================= */}
        {activeTab === "list" && (
          <div className="space-y-6 animate-in fade-in duration-150">
            {/* Filter Controls Bar */}
            <div className="flex flex-col sm:flex-row items-center justify-between gap-4 rounded-2xl border border-zinc-200 bg-white p-4 dark:border-zinc-800 dark:bg-zinc-900 shadow-sm">
              <div className="relative w-full sm:w-80">
                <Search className="absolute left-3 top-2.5 h-4 w-4 text-zinc-400" />
                <Input
                  placeholder="Başlık, slug veya kaynak ara..."
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  className="pl-9 text-xs rounded-xl"
                />
              </div>

              <div className="flex items-center gap-2 w-full sm:w-auto overflow-x-auto pb-1 sm:pb-0">
                <select
                  value={selectedMonthFilter}
                  onChange={(e) => setSelectedMonthFilter(e.target.value === "all" ? "all" : Number(e.target.value))}
                  className="rounded-xl border border-zinc-200 bg-white px-3 py-2 text-xs dark:border-zinc-800 dark:bg-zinc-900"
                >
                  <option value="all">Tüm Aylar</option>
                  {MONTHS_METADATA.map((m) => (
                    <option key={m.number} value={m.number}>
                      {m.name}
                    </option>
                  ))}
                </select>

                <select
                  value={selectedCategoryFilter}
                  onChange={(e) => setSelectedCategoryFilter(e.target.value)}
                  className="rounded-xl border border-zinc-200 bg-white px-3 py-2 text-xs dark:border-zinc-800 dark:bg-zinc-900"
                >
                  <option value="all">Tüm Kategoriler</option>
                  {CATEGORIES_METADATA.map((cat) => (
                    <option key={cat.slug} value={cat.name}>
                      {cat.name}
                    </option>
                  ))}
                </select>

                <select
                  value={selectedToneFilter}
                  onChange={(e) => setSelectedToneFilter(e.target.value)}
                  className="rounded-xl border border-zinc-200 bg-white px-3 py-2 text-xs dark:border-zinc-800 dark:bg-zinc-900"
                >
                  <option value="all">Tüm Tonlar</option>
                  <option value="kutlama">Kutlama</option>
                  <option value="anma">Anma</option>
                  <option value="farkindalik">Farkındalık</option>
                  <option value="resmi-tatil">Resmi Tatil</option>
                </select>
              </div>
            </div>

            {/* Days Table */}
            <div className="rounded-3xl border border-zinc-200 bg-white overflow-hidden shadow-sm dark:border-zinc-800 dark:bg-zinc-900">
              <div className="overflow-x-auto">
                <table className="w-full text-left text-xs">
                  <thead className="bg-zinc-50 border-b border-zinc-100 dark:bg-zinc-800/60 dark:border-zinc-800 text-zinc-500 font-bold uppercase tracking-wider">
                    <tr>
                      <th className="py-3.5 px-4">Tarih</th>
                      <th className="py-3.5 px-4">Başlık</th>
                      <th className="py-3.5 px-4">Kategori</th>
                      <th className="py-3.5 px-4">Ton</th>
                      <th className="py-3.5 px-4">Kaynak Teyidi</th>
                      <th className="py-3.5 px-4 text-right">İşlemler</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-zinc-100 dark:divide-zinc-800">
                    {filteredDays.length === 0 ? (
                      <tr>
                        <td colSpan={6} className="py-8 text-center text-zinc-400">
                          Arama kriterlerine uygun özel gün bulunamadı.
                        </td>
                      </tr>
                    ) : (
                      filteredDays.map((d) => (
                        <tr key={d.slug} className="hover:bg-zinc-50/70 dark:hover:bg-zinc-800/40 transition-colors">
                          <td className="py-3 px-4 font-bold text-zinc-900 dark:text-zinc-100 whitespace-nowrap">
                            {d.day_no} {MONTHS_METADATA.find((m) => m.number === d.month_no)?.name}
                          </td>
                          <td className="py-3 px-4">
                            <div className="font-semibold text-zinc-900 dark:text-white">
                              {d.title}
                            </div>
                            <div className="text-[10px] text-zinc-400 font-mono">
                              /gun/{d.slug}
                            </div>
                          </td>
                          <td className="py-3 px-4">
                            <Badge variant="outline" className="text-[10px]">
                              {d.category}
                            </Badge>
                          </td>
                          <td className="py-3 px-4">
                            {d.day_type === "anma" ? (
                              <Badge variant="default" className="text-[10px] bg-zinc-800 text-white">
                                🕯️ Anma
                              </Badge>
                            ) : d.day_type === "farkindalik" ? (
                              <Badge variant="blue" className="text-[10px]">
                                🌱 Farkındalık
                              </Badge>
                            ) : d.is_public_holiday ? (
                              <Badge variant="red" className="text-[10px]">
                                🇹🇷 Resmi Tatil
                              </Badge>
                            ) : (
                              <Badge variant="default" className="text-[10px]">
                                🎉 Kutlama
                              </Badge>
                            )}
                          </td>
                          <td className="py-3 px-4">
                            {d.source_name ? (
                              <div className="flex items-center gap-1 text-emerald-600 dark:text-emerald-400 font-medium text-[11px]">
                                <ShieldCheck className="h-3.5 w-3.5" />
                                <span className="truncate max-w-[140px]">{d.source_name}</span>
                              </div>
                            ) : (
                              <span className="text-zinc-400 text-[10px]">Belirtilmemiş</span>
                            )}
                          </td>
                          <td className="py-3 px-4 text-right whitespace-nowrap">
                            <div className="flex items-center justify-end gap-1.5">
                              <Link href={`/gun/${d.slug}`} target="_blank">
                                <Button variant="ghost" size="sm" className="h-7 w-7 p-0" title="Görüntüle">
                                  <Eye className="h-3.5 w-3.5 text-zinc-500" />
                                </Button>
                              </Link>
                              <Button
                                variant="ghost"
                                size="sm"
                                onClick={() => startEditing(d)}
                                className="h-7 w-7 p-0"
                                title="Düzenle"
                              >
                                <Edit className="h-3.5 w-3.5 text-amber-600" />
                              </Button>
                              <Button
                                variant="ghost"
                                size="sm"
                                onClick={() => handleDeleteDay(d.slug, d.title)}
                                className="h-7 w-7 p-0 text-red-600 hover:text-red-700 hover:bg-red-50"
                                title="Sil"
                              >
                                <Trash2 className="h-3.5 w-3.5" />
                              </Button>
                            </div>
                          </td>
                        </tr>
                      ))
                    )}
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        )}

        {/* ================= TAB 4: EXPORT & SYNC ================= */}
        {activeTab === "export" && (
          <div className="space-y-6 max-w-4xl mx-auto animate-in fade-in duration-150">
            <div className="rounded-3xl border border-zinc-200 bg-white p-6 sm:p-8 dark:border-zinc-800 dark:bg-zinc-900 shadow-sm">
              <h3 className="text-lg font-black text-zinc-900 dark:text-white flex items-center gap-2">
                <Database className="h-5 w-5 text-red-600" />
                Veri Dışa Aktarma & Kod Senkronizasyonu
              </h3>
              <p className="text-xs text-zinc-500 mt-1">
                Panelden eklediğiniz veya düzenlediğiniz güncel verileri doğrudan TypeScript koduna, Supabase SQL betiğine veya JSON yedeğine dönüştürebilirsiniz.
              </p>

              <div className="grid grid-cols-1 sm:grid-cols-3 gap-4 mt-8">
                {/* 1. TypeScript Export */}
                <div className="rounded-2xl border border-zinc-200 bg-zinc-50/60 p-5 dark:border-zinc-800 dark:bg-zinc-800/40 flex flex-col justify-between">
                  <div>
                    <span className="text-xs font-bold text-zinc-900 dark:text-zinc-100 flex items-center gap-1.5">
                      <FileText className="h-4 w-4 text-blue-500" />
                      TypeScript Veri Seti
                    </span>
                    <p className="mt-2 text-[11px] text-zinc-500">
                      `special-days-data.ts` dosyasına doğrudan yapıştırabileceğiniz eksiksiz dizi.
                    </p>
                  </div>
                  <Button
                    onClick={copyTypeScript}
                    className="mt-4 w-full text-xs font-bold gap-1.5 rounded-xl bg-blue-600 hover:bg-blue-700 text-white"
                  >
                    {copiedFormat === "typescript" ? <Check className="h-3.5 w-3.5" /> : <Copy className="h-3.5 w-3.5" />}
                    <span>{copiedFormat === "typescript" ? "Kopyalandı!" : "TS Kodunu Kopyala"}</span>
                  </Button>
                </div>

                {/* 2. Supabase SQL Generator */}
                <div className="rounded-2xl border border-zinc-200 bg-zinc-50/60 p-5 dark:border-zinc-800 dark:bg-zinc-800/40 flex flex-col justify-between">
                  <div>
                    <span className="text-xs font-bold text-zinc-900 dark:text-zinc-100 flex items-center gap-1.5">
                      <Database className="h-4 w-4 text-emerald-500" />
                      Supabase SQL Betiği
                    </span>
                    <p className="mt-2 text-[11px] text-zinc-500">
                      `INSERT INTO special_days ... ON CONFLICT DO UPDATE` içeren hazır SQL scripti.
                    </p>
                  </div>
                  <Button
                    onClick={copySupabaseSQL}
                    className="mt-4 w-full text-xs font-bold gap-1.5 rounded-xl bg-emerald-600 hover:bg-emerald-700 text-white"
                  >
                    {copiedFormat === "sql" ? <Check className="h-3.5 w-3.5" /> : <Copy className="h-3.5 w-3.5" />}
                    <span>{copiedFormat === "sql" ? "Kopyalandı!" : "SQL Scripti Kopyala"}</span>
                  </Button>
                </div>

                {/* 3. JSON Backup */}
                <div className="rounded-2xl border border-zinc-200 bg-zinc-50/60 p-5 dark:border-zinc-800 dark:bg-zinc-800/40 flex flex-col justify-between">
                  <div>
                    <span className="text-xs font-bold text-zinc-900 dark:text-zinc-100 flex items-center gap-1.5">
                      <Download className="h-4 w-4 text-purple-500" />
                      JSON Yedek Dosyası
                    </span>
                    <p className="mt-2 text-[11px] text-zinc-500">
                      Tüm veritabanını tarih damgalı .json formatında tek tıkla cihazınıza indirin.
                    </p>
                  </div>
                  <Button
                    onClick={downloadJSONBackup}
                    className="mt-4 w-full text-xs font-bold gap-1.5 rounded-xl bg-purple-600 hover:bg-purple-700 text-white"
                  >
                    <Download className="h-3.5 w-3.5" />
                    <span>JSON İndir</span>
                  </Button>
                </div>
              </div>
            </div>
          </div>
        )}

        {/* ================= TAB 5: EDITORIAL QUALITY & AUDIT ================= */}
        {activeTab === "editorial" && (
          <div className="space-y-6 max-w-4xl mx-auto animate-in fade-in duration-150">
            <div className="rounded-3xl border border-zinc-200 bg-white p-6 sm:p-8 dark:border-zinc-800 dark:bg-zinc-900 shadow-sm">
              <h3 className="text-lg font-black text-zinc-900 dark:text-white flex items-center gap-2">
                <ShieldCheck className="h-5 w-5 text-emerald-600" />
                Editoryal Kalite & Güvenilirlik Denetimi
              </h3>
              <p className="text-xs text-zinc-500 mt-1">
                Kullanıcı raporundaki 12 maddelik güven standartlarına göre otomatik taranan iyileştirme listesi.
              </p>

              {/* Status summary */}
              <div className="grid grid-cols-1 sm:grid-cols-3 gap-4 mt-6">
                <div className="rounded-2xl border border-amber-200 bg-amber-50/60 p-4 dark:border-amber-900/50 dark:bg-amber-950/20">
                  <span className="text-xs font-bold text-amber-800 dark:text-amber-300">
                    Kaynak Eksikliği Olanlar
                  </span>
                  <div className="mt-1 text-2xl font-black text-amber-900 dark:text-amber-100">
                    {stats.auditAlerts.missingSource.length} Kayıt
                  </div>
                  <p className="text-[11px] text-amber-700/80 dark:text-amber-400 mt-1">
                    Resmi birincil kurum adı veya linki girilmemiş günler.
                  </p>
                </div>

                <div className="rounded-2xl border border-zinc-200 bg-zinc-50 p-4 dark:border-zinc-800 dark:bg-zinc-800/40">
                  <span className="text-xs font-bold text-zinc-700 dark:text-zinc-300">
                    Kısa Açıklamalı Kayıtlar
                  </span>
                  <div className="mt-1 text-2xl font-black text-zinc-900 dark:text-zinc-100">
                    {stats.auditAlerts.shortDescription.length} Kayıt
                  </div>
                  <p className="text-[11px] text-zinc-500 mt-1">
                    30 karakterden az özete sahip içerikler.
                  </p>
                </div>

                <div className="rounded-2xl border border-blue-200 bg-blue-50/60 p-4 dark:border-blue-900/50 dark:bg-blue-950/20">
                  <span className="text-xs font-bold text-blue-800 dark:text-blue-300">
                    Uzun Başlıklar (&gt;60 Karakter)
                  </span>
                  <div className="mt-1 text-2xl font-black text-blue-900 dark:text-blue-100">
                    {stats.auditAlerts.longTitle.length} Kayıt
                  </div>
                  <p className="text-[11px] text-blue-700/80 dark:text-blue-400 mt-1">
                    SEO snippet kırpılmasına uğrayabilecek uzunlukta olanlar.
                  </p>
                </div>
              </div>

              {/* Actionable Missing Source List */}
              {stats.auditAlerts.missingSource.length > 0 && (
                <div className="mt-8 border-t border-zinc-100 pt-6 dark:border-zinc-800">
                  <h4 className="text-sm font-bold text-zinc-900 dark:text-white mb-3">
                    Öncelikli Kaynak Eklenmesi Gereken Günler:
                  </h4>
                  <div className="space-y-2 max-h-64 overflow-y-auto">
                    {stats.auditAlerts.missingSource.slice(0, 10).map((day) => (
                      <div
                        key={day.slug}
                        className="flex items-center justify-between rounded-xl border border-zinc-100 bg-zinc-50/70 p-3 text-xs dark:border-zinc-800 dark:bg-zinc-800/50"
                      >
                        <div>
                          <span className="font-bold text-zinc-900 dark:text-zinc-100">
                            {day.title}
                          </span>
                          <span className="text-zinc-400 text-[11px] ml-2 font-mono">
                            ({day.day_no} {MONTHS_METADATA.find((m) => m.number === day.month_no)?.name})
                          </span>
                        </div>
                        <Button
                          size="sm"
                          variant="outline"
                          onClick={() => startEditing(day)}
                          className="text-[11px] h-7 gap-1 rounded-lg"
                        >
                          <Edit className="h-3 w-3" />
                          <span>Kaynak Ekle</span>
                        </Button>
                      </div>
                    ))}
                  </div>
                </div>
              )}
            </div>
          </div>
        )}
      </main>
    </div>
  );
}
