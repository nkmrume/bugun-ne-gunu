"use client";

import React, { useState, useRef, useEffect } from "react";
import {
  CalendarPlus,
  ExternalLink,
  Download,
  Check,
  ChevronDown,
  Calendar,
} from "lucide-react";
import {
  CalendarEventPayload,
  generateGoogleCalendarUrl,
  generateIcsContent,
  triggerIcsDownload,
} from "@/lib/calendar-engine";
import { Button } from "@/components/ui/button";

interface AddToCalendarButtonProps {
  event?: CalendarEventPayload;
  events?: CalendarEventPayload[];
  buttonText?: string;
  variant?: "default" | "outline" | "secondary";
  className?: string;
  calendarTitle?: string;
}

export function AddToCalendarButton({
  event,
  events,
  buttonText = "Takvime Ekle",
  variant = "outline",
  className = "",
  calendarTitle,
}: AddToCalendarButtonProps) {
  const [isOpen, setIsOpen] = useState(false);
  const [downloaded, setDownloaded] = useState(false);
  const dropdownRef = useRef<HTMLDivElement>(null);

  // Close dropdown on outside click
  useEffect(() => {
    function handleClickOutside(e: MouseEvent) {
      if (dropdownRef.current && !dropdownRef.current.contains(e.target as Node)) {
        setIsOpen(false);
      }
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  const eventList = events || (event ? [event] : []);
  if (eventList.length === 0) return null;

  const isSingle = eventList.length === 1;
  const primaryEvent = eventList[0];

  // 1. Google Calendar click handler
  const handleGoogleCalendar = () => {
    if (isSingle) {
      const url = generateGoogleCalendarUrl(primaryEvent);
      window.open(url, "_blank", "noopener,noreferrer");
    } else {
      // For bulk, download .ics and guide user to import into Google Calendar
      handleDownloadIcs();
    }
    setIsOpen(false);
  };

  // 2. Apple / Outlook / iCal download handler
  const handleDownloadIcs = () => {
    const title = calendarTitle || (isSingle ? primaryEvent.title : "Ozel-Gunler-Takvimi");
    const icsContent = generateIcsContent(eventList, title);
    const fileName = `${title.toLowerCase().replace(/[^a-z0-9]/g, "-")}.ics`;

    triggerIcsDownload(fileName, icsContent);
    setDownloaded(true);
    setIsOpen(false);
    setTimeout(() => setDownloaded(false), 3000);
  };

  return (
    <div className={`relative inline-block text-left ${className}`} ref={dropdownRef}>
      <Button
        type="button"
        variant={variant}
        onClick={() => setIsOpen(!isOpen)}
        className="gap-2 font-bold rounded-xl shadow-sm text-xs sm:text-sm cursor-pointer"
      >
        {downloaded ? (
          <>
            <Check className="h-4 w-4 text-emerald-600" />
            <span className="text-emerald-600">Takvim İndirildi!</span>
          </>
        ) : (
          <>
            <CalendarPlus className="h-4 w-4 text-red-600 dark:text-red-400" />
            <span>{buttonText}</span>
            <ChevronDown className="h-3.5 w-3.5 opacity-60 ml-0.5" />
          </>
        )}
      </Button>

      {/* Dropdown Menu */}
      {isOpen && (
        <div className="absolute right-0 sm:left-0 z-50 mt-2 w-64 origin-top-left rounded-2xl border border-zinc-200 bg-white p-2 shadow-xl dark:border-zinc-800 dark:bg-zinc-900 animate-in fade-in-50 zoom-in-95 duration-150">
          <div className="px-3 py-2 text-[11px] font-bold uppercase tracking-wider text-zinc-400 dark:text-zinc-500 border-b border-zinc-100 dark:border-zinc-800 mb-1">
            {isSingle ? "Hatırlatıcı Oluştur" : `${eventList.length} Özel Günü Aktar`}
          </div>

          {/* Option 1: Google Calendar (Single event direct link) */}
          {isSingle && (
            <button
              onClick={handleGoogleCalendar}
              className="flex w-full items-center justify-between rounded-xl px-3 py-2.5 text-xs font-semibold text-zinc-800 hover:bg-zinc-100 dark:text-zinc-200 dark:hover:bg-zinc-800 transition-colors cursor-pointer text-left"
            >
              <div className="flex items-center gap-2.5">
                <div className="flex h-6 w-6 items-center justify-center rounded-lg bg-blue-100 text-blue-700 dark:bg-blue-950 dark:text-blue-300">
                  <Calendar className="h-3.5 w-3.5" />
                </div>
                <span>Google Takvim</span>
              </div>
              <ExternalLink className="h-3 w-3 text-zinc-400" />
            </button>
          )}

          {/* Option 2: Apple Calendar / Outlook / .ics Download */}
          <button
            onClick={handleDownloadIcs}
            className="flex w-full items-center justify-between rounded-xl px-3 py-2.5 text-xs font-semibold text-zinc-800 hover:bg-zinc-100 dark:text-zinc-200 dark:hover:bg-zinc-800 transition-colors cursor-pointer text-left"
          >
            <div className="flex items-center gap-2.5">
              <div className="flex h-6 w-6 items-center justify-center rounded-lg bg-amber-100 text-amber-800 dark:bg-amber-950 dark:text-amber-300">
                <Download className="h-3.5 w-3.5" />
              </div>
              <div className="flex flex-col">
                <span>Apple / Outlook (.ics)</span>
                <span className="text-[10px] text-zinc-400">iOS, Mac & Android Takvim</span>
              </div>
            </div>
            <Download className="h-3 w-3 text-zinc-400" />
          </button>

          {!isSingle && (
            <div className="mt-2 pt-2 border-t border-zinc-100 dark:border-zinc-800 px-3 py-1">
              <p className="text-[10px] text-zinc-500 leading-tight">
                İndirilen .ics dosyasını açarak tüm günleri tek seferde telefonunuzun veya bilgisayarınızın takvimine ekleyebilirsiniz.
              </p>
            </div>
          )}
        </div>
      )}
    </div>
  );
}
