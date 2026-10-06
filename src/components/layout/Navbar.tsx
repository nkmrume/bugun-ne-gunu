"use client";

import React, { useState } from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import {
  CalendarDays,
  Search,
  Menu,
  X,
  ChevronDown,
  Sparkles,
  Calendar,
  Layers,
  HeartHandshake,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { SearchModal } from "./SearchModal";
import { SpecialDay } from "@/types/database";
import { MONTHS_METADATA } from "@/lib/data/special-days-data";

interface NavbarProps {
  allDays: SpecialDay[];
}

export function Navbar({ allDays }: NavbarProps) {
  const [isSearchOpen, setIsSearchOpen] = useState(false);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const [isMonthsDropdownOpen, setIsMonthsDropdownOpen] = useState(false);
  const pathname = usePathname();

  // Current Turkish date indicator
  const today = new Date();
  const currentMonthNo = today.getMonth() + 1;
  const currentMonthMeta = MONTHS_METADATA.find((m) => m.number === currentMonthNo);

  return (
    <>
      <header className="sticky top-0 z-40 w-full border-b border-zinc-200/80 bg-white/90 backdrop-blur-md dark:border-zinc-800/80 dark:bg-zinc-950/90">
        <div className="mx-auto flex h-16 max-w-7xl items-center justify-between px-4 sm:px-6 lg:px-8">
          {/* Logo & Brand */}
          <div className="flex items-center gap-6">
            <Link
              href="/"
              className="flex items-center gap-2.5 transition-transform hover:scale-[1.01]"
            >
              <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-gradient-to-tr from-red-600 via-rose-600 to-amber-500 text-white shadow-md shadow-red-500/20">
                <CalendarDays className="h-5 w-5" />
              </div>
              <div className="flex flex-col">
                <span className="text-lg font-black tracking-tight text-zinc-900 dark:text-white">
                  Bugün Ne Günü<span className="text-red-600">?</span>
                </span>
                <span className="text-[10px] font-semibold text-zinc-500 tracking-wider uppercase -mt-1">
                  Özel Günler Rehberi
                </span>
              </div>
            </Link>

            {/* Desktop Navigation Links */}
            <nav className="hidden md:flex items-center gap-1 text-sm font-medium">
              <Link
                href="/"
                className={`rounded-xl px-3 py-2 transition-colors ${
                  pathname === "/"
                    ? "bg-zinc-100 text-red-600 font-bold dark:bg-zinc-800 dark:text-red-400"
                    : "text-zinc-600 hover:bg-zinc-100 hover:text-zinc-900 dark:text-zinc-300 dark:hover:bg-zinc-800 dark:hover:text-white"
                }`}
              >
                Bugün
              </Link>

              {/* Month Pillar Link Dropdown */}
              <div
                className="relative"
                onMouseEnter={() => setIsMonthsDropdownOpen(true)}
                onMouseLeave={() => setIsMonthsDropdownOpen(false)}
              >
                <button
                  onClick={() => setIsMonthsDropdownOpen(!isMonthsDropdownOpen)}
                  className={`inline-flex items-center gap-1 rounded-xl px-3 py-2 transition-colors ${
                    pathname.startsWith("/aylar")
                      ? "bg-zinc-100 text-red-600 font-bold dark:bg-zinc-800 dark:text-red-400"
                      : "text-zinc-600 hover:bg-zinc-100 hover:text-zinc-900 dark:text-zinc-300 dark:hover:bg-zinc-800 dark:hover:text-white"
                  }`}
                >
                  <span>Aylar</span>
                  <ChevronDown className="h-4 w-4 text-zinc-400" />
                </button>

                {isMonthsDropdownOpen && (
                  <div className="absolute left-0 top-full pt-1 w-64 animate-in fade-in-50 zoom-in-95 duration-150 z-50">
                    <div className="grid grid-cols-2 gap-1 rounded-2xl border border-zinc-200 bg-white p-2 shadow-xl dark:border-zinc-800 dark:bg-zinc-900">
                      {MONTHS_METADATA.map((month) => (
                        <Link
                          key={month.slug}
                          href={`/aylar/${month.slug}`}
                          onClick={() => setIsMonthsDropdownOpen(false)}
                          className="flex items-center justify-between rounded-xl px-3 py-2 text-xs font-semibold text-zinc-700 hover:bg-red-50 hover:text-red-600 dark:text-zinc-300 dark:hover:bg-zinc-800 dark:hover:text-red-400 transition-colors"
                        >
                          <span>{month.name}</span>
                          <span className="text-[10px] text-zinc-400">
                            {month.daysCount} gün
                          </span>
                        </Link>
                      ))}
                    </div>
                  </div>
                )}
              </div>

              {/* Quick links to today's month & flagship day */}
              {currentMonthMeta && (
                <Link
                  href={`/aylar/${currentMonthMeta.slug}`}
                  className="rounded-xl px-3 py-2 text-zinc-600 hover:bg-zinc-100 hover:text-zinc-900 dark:text-zinc-300 dark:hover:bg-zinc-800"
                >
                  {currentMonthMeta.name} Ayı
                </Link>
              )}

              <Link
                href="/gun/dunya-kahve-gunu"
                className="rounded-xl px-3 py-2 text-amber-700 hover:bg-amber-50 dark:text-amber-400 dark:hover:bg-amber-950/40 font-semibold flex items-center gap-1.5"
              >
                <Sparkles className="h-3.5 w-3.5" />
                Dünya Kahve Günü
              </Link>
            </nav>
          </div>

          {/* Right Action Icons & Search Trigger */}
          <div className="flex items-center gap-3">
            {/* Search Trigger Button */}
            <button
              onClick={() => setIsSearchOpen(true)}
              className="flex items-center gap-2 rounded-xl border border-zinc-200 bg-zinc-50 px-3.5 py-2 text-xs text-zinc-500 shadow-inner hover:border-zinc-300 hover:bg-white dark:border-zinc-800 dark:bg-zinc-900 dark:text-zinc-400 dark:hover:border-zinc-700 cursor-pointer transition-all"
            >
              <Search className="h-3.5 w-3.5" />
              <span className="hidden sm:inline">Hızlı Ara...</span>
              <kbd className="hidden lg:inline-flex items-center rounded bg-white px-1.5 py-0.5 text-[10px] font-mono text-zinc-400 dark:bg-zinc-800 dark:text-zinc-500 border border-zinc-200 dark:border-zinc-700">
                Ctrl K
              </kbd>
            </button>

            {/* Today Pill */}
            <Link
              href="/"
              className="hidden sm:flex items-center gap-1.5 rounded-full bg-red-50 px-3.5 py-1.5 text-xs font-bold text-red-600 dark:bg-red-950/40 dark:text-red-400 border border-red-200/60 dark:border-red-900/60"
            >
              <span className="relative flex h-2 w-2">
                <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-red-400 opacity-75"></span>
                <span className="relative inline-flex rounded-full h-2 w-2 bg-red-500"></span>
              </span>
              <span>28 Eylül</span>
            </Link>

            {/* Mobile Menu Hamburger */}
            <button
              onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
              className="md:hidden p-2 rounded-xl text-zinc-600 hover:bg-zinc-100 dark:text-zinc-300 dark:hover:bg-zinc-800"
              aria-label="Menüyü aç"
            >
              {isMobileMenuOpen ? <X className="h-6 w-6" /> : <Menu className="h-6 w-6" />}
            </button>
          </div>
        </div>

        {/* Mobile Navigation Drawer */}
        {isMobileMenuOpen && (
          <div className="md:hidden border-t border-zinc-200 bg-white px-4 pt-3 pb-6 dark:border-zinc-800 dark:bg-zinc-950 animate-in slide-in-from-top-4 duration-200">
            <div className="flex flex-col space-y-2">
              <Link
                href="/"
                onClick={() => setIsMobileMenuOpen(false)}
                className="flex items-center gap-2 rounded-xl px-4 py-3 text-sm font-bold text-zinc-900 hover:bg-zinc-100 dark:text-zinc-100 dark:hover:bg-zinc-800"
              >
                <CalendarDays className="h-4 w-4 text-red-600" />
                Bugün Ne Günü?
              </Link>

              <div className="pt-2 pb-1">
                <span className="px-4 text-xs font-bold uppercase tracking-wider text-zinc-400 dark:text-zinc-500">
                  Aylara Göre Keşfet
                </span>
                <div className="grid grid-cols-3 gap-1.5 mt-2 px-2">
                  {MONTHS_METADATA.map((month) => (
                    <Link
                      key={month.slug}
                      href={`/aylar/${month.slug}`}
                      onClick={() => setIsMobileMenuOpen(false)}
                      className="rounded-lg bg-zinc-50 p-2 text-center text-xs font-semibold text-zinc-700 hover:bg-red-50 hover:text-red-600 dark:bg-zinc-900 dark:text-zinc-300 dark:hover:bg-zinc-800"
                    >
                      {month.name}
                    </Link>
                  ))}
                </div>
              </div>

              <div className="pt-2">
                <span className="px-4 text-xs font-bold uppercase tracking-wider text-zinc-400 dark:text-zinc-500">
                  Öne Çıkan Günler
                </span>
                <div className="mt-2 space-y-1">
                  <Link
                    href="/gun/dunya-kahve-gunu"
                    onClick={() => setIsMobileMenuOpen(false)}
                    className="flex items-center justify-between rounded-xl px-4 py-2.5 text-xs font-bold text-amber-700 bg-amber-50/80 dark:bg-amber-950/40 dark:text-amber-400"
                  >
                    <span>☕ 1 Ekim Dünya Kahve Günü</span>
                    <Badge variant="warning" className="text-[10px]">Popüler</Badge>
                  </Link>
                  <Link
                    href="/gun/cumhuriyet-bayrami"
                    onClick={() => setIsMobileMenuOpen(false)}
                    className="flex items-center justify-between rounded-xl px-4 py-2.5 text-xs font-bold text-red-700 bg-red-50/80 dark:bg-red-950/40 dark:text-red-400"
                  >
                    <span>🇹🇷 29 Ekim Cumhuriyet Bayramı</span>
                    <Badge variant="red" className="text-[10px]">Milli Bayram</Badge>
                  </Link>
                </div>
              </div>
            </div>
          </div>
        )}
      </header>

      {/* Global Search Modal */}
      <SearchModal
        isOpen={isSearchOpen}
        onClose={() => setIsSearchOpen(false)}
        allDays={allDays}
      />
    </>
  );
}
