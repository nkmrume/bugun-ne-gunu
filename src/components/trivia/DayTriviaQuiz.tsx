"use client";

import React, { useState, useEffect } from "react";
import {
  Brain,
  CheckCircle2,
  XCircle,
  Sparkles,
  HelpCircle,
  Lightbulb,
  Share2,
  Flame,
  Award,
  RefreshCw,
  Copy,
  Check,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { TriviaQuestion } from "@/lib/data/trivia-data";

interface DayTriviaQuizProps {
  question: TriviaQuestion;
  layout?: "compact" | "full";
  className?: string;
}

export function DayTriviaQuiz({
  question,
  layout = "full",
  className = "",
}: DayTriviaQuizProps) {
  const [selectedOption, setSelectedOption] = useState<number | null>(null);
  const [hasAnswered, setHasAnswered] = useState<boolean>(false);
  const [streak, setStreak] = useState<number>(0);
  const [copiedShare, setCopiedShare] = useState<boolean>(false);

  // Load streak from localStorage on mount
  useEffect(() => {
    try {
      const savedStreak = localStorage.getItem("bugun_trivia_streak");
      if (savedStreak) {
        setStreak(parseInt(savedStreak, 10) || 0);
      }

      // Check if user already answered this exact question today
      const savedAnswer = localStorage.getItem(`bugun_trivia_ans_${question.id}`);
      if (savedAnswer !== null) {
        setSelectedOption(parseInt(savedAnswer, 10));
        setHasAnswered(true);
      }
    } catch {
      // localStorage fallback
    }
  }, [question.id]);

  const handleSelect = (index: number) => {
    if (hasAnswered) return;

    setSelectedOption(index);
    setHasAnswered(true);

    const isCorrect = index === question.correctIndex;

    try {
      localStorage.setItem(`bugun_trivia_ans_${question.id}`, String(index));
      if (isCorrect) {
        const newStreak = streak + 1;
        setStreak(newStreak);
        localStorage.setItem("bugun_trivia_streak", String(newStreak));
      } else {
        // Reset streak on error or keep highest
        setStreak(0);
        localStorage.setItem("bugun_trivia_streak", "0");
      }
    } catch {
      // ignore
    }
  };

  const isCorrect = selectedOption === question.correctIndex;

  const handleShare = () => {
    const text = isCorrect
      ? `🧠 Bugün Ne Günü Bilgi Yarışması'nda "${question.title}" sorusunu ilk seferde bildim! 🎉 Sen de günün sorusunu çöz: https://bugunnegunu.com`
      : `🧠 Bugün Ne Günü Bilgi Yarışması: "${question.title}" sorusunu sen bilebilecek misin? Hemen çöz: https://bugunnegunu.com`;

    navigator.clipboard.writeText(text);
    setCopiedShare(true);
    setTimeout(() => setCopiedShare(false), 3000);
  };

  const optionLetters = ["A", "B", "C", "D"];

  return (
    <div
      className={`rounded-3xl border border-zinc-200/80 bg-white p-6 sm:p-8 dark:border-zinc-800 dark:bg-zinc-900 shadow-sm transition-all ${className}`}
    >
      {/* Header bar */}
      <div className="flex items-center justify-between gap-2 border-b border-zinc-100 dark:border-zinc-800 pb-4 mb-6">
        <div className="flex items-center gap-2">
          <div className="flex h-9 w-9 items-center justify-center rounded-xl bg-purple-100 text-purple-700 dark:bg-purple-950/60 dark:text-purple-400">
            <Brain className="h-5 w-5" />
          </div>
          <div>
            <div className="flex items-center gap-2">
              <span className="text-xs font-black uppercase tracking-wider text-purple-600 dark:text-purple-400">
                Günün Bilgi Yarışması
              </span>
              <Badge variant="purple" className="text-[10px] px-2 py-0">
                {question.category}
              </Badge>
            </div>
            <h3 className="text-sm font-bold text-zinc-900 dark:text-white">
              {question.title}
            </h3>
          </div>
        </div>

        {/* Streak counter */}
        <div className="flex items-center gap-1.5 rounded-full bg-amber-50 px-3 py-1 text-xs font-black text-amber-700 dark:bg-amber-950/40 dark:text-amber-400 border border-amber-200/60 dark:border-amber-900/60 shrink-0">
          <Flame className="h-4 w-4 text-amber-500 fill-amber-500" />
          <span>{streak} Gün Seri</span>
        </div>
      </div>

      {/* Question prompt */}
      <div className="mb-6">
        <h4 className="text-base sm:text-lg font-black text-zinc-900 dark:text-zinc-50 leading-snug">
          {question.question}
        </h4>
        <span className="text-[11px] text-zinc-400 mt-1 block">
          Doğru seçeneğe tıklayarak bilginizi test edin.
        </span>
      </div>

      {/* 4 Interactive Options */}
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 mb-6">
        {question.options.map((opt, idx) => {
          const isSelected = selectedOption === idx;
          const isThisCorrect = idx === question.correctIndex;

          let btnStyles =
            "border-zinc-200 bg-zinc-50/70 text-zinc-800 hover:bg-zinc-100 hover:border-zinc-300 dark:border-zinc-800 dark:bg-zinc-800/40 dark:text-zinc-200 dark:hover:bg-zinc-800";

          if (hasAnswered) {
            if (isThisCorrect) {
              btnStyles =
                "border-emerald-500 bg-emerald-50 text-emerald-900 dark:bg-emerald-950/60 dark:text-emerald-200 dark:border-emerald-700 shadow-sm ring-1 ring-emerald-500";
            } else if (isSelected) {
              btnStyles =
                "border-red-400 bg-red-50 text-red-900 dark:bg-red-950/60 dark:text-red-200 dark:border-red-800";
            } else {
              btnStyles =
                "border-zinc-200/50 bg-zinc-50/30 text-zinc-400 dark:border-zinc-800/50 dark:bg-zinc-900/30 dark:text-zinc-600 opacity-60";
            }
          }

          return (
            <button
              key={idx}
              onClick={() => handleSelect(idx)}
              disabled={hasAnswered}
              className={`flex items-center gap-3 rounded-2xl border p-3.5 text-left text-xs sm:text-sm font-semibold transition-all ${btnStyles} ${
                !hasAnswered ? "cursor-pointer hover:scale-[1.01]" : "cursor-default"
              }`}
            >
              <div
                className={`flex h-7 w-7 shrink-0 items-center justify-center rounded-xl text-xs font-black ${
                  hasAnswered && isThisCorrect
                    ? "bg-emerald-600 text-white"
                    : hasAnswered && isSelected
                    ? "bg-red-600 text-white"
                    : "bg-white text-zinc-700 shadow-sm dark:bg-zinc-700 dark:text-zinc-200"
                }`}
              >
                {hasAnswered && isThisCorrect ? (
                  <CheckCircle2 className="h-4 w-4" />
                ) : hasAnswered && isSelected ? (
                  <XCircle className="h-4 w-4" />
                ) : (
                  optionLetters[idx]
                )}
              </div>

              <span className="flex-1 leading-snug">{opt}</span>
            </button>
          );
        })}
      </div>

      {/* Answer feedback & Didactic explanation */}
      {hasAnswered && (
        <div className="space-y-4 animate-in fade-in zoom-in-95 duration-200">
          <div
            className={`rounded-2xl border p-4 sm:p-5 text-xs sm:text-sm ${
              isCorrect
                ? "border-emerald-200 bg-emerald-50/70 text-emerald-950 dark:border-emerald-900/60 dark:bg-emerald-950/40 dark:text-emerald-100"
                : "border-amber-200 bg-amber-50/70 text-amber-950 dark:border-amber-900/60 dark:bg-amber-950/40 dark:text-amber-100"
            }`}
          >
            <div className="flex items-center gap-2 font-black text-sm mb-1.5">
              {isCorrect ? (
                <>
                  <Sparkles className="h-4 w-4 text-emerald-600" />
                  <span>Harika, bildiniz! 🎉</span>
                </>
              ) : (
                <>
                  <HelpCircle className="h-4 w-4 text-amber-600" />
                  <span>
                    Doğru Cevap: {optionLetters[question.correctIndex]}){" "}
                    {question.options[question.correctIndex]}
                  </span>
                </>
              )}
            </div>

            <p className="leading-relaxed text-zinc-700 dark:text-zinc-300">
              {question.explanation}
            </p>

            {/* Fun Fact pill */}
            {question.funFact && (
              <div className="mt-3 flex items-start gap-2 rounded-xl bg-white/70 p-3 text-xs dark:bg-zinc-900/60 border border-zinc-200/40 dark:border-zinc-800">
                <Lightbulb className="h-4 w-4 text-amber-500 shrink-0 mt-0.5" />
                <div>
                  <span className="font-bold text-zinc-900 dark:text-zinc-100 mr-1">
                    Biliyor muydunuz?
                  </span>
                  <span className="text-zinc-600 dark:text-zinc-400">
                    {question.funFact}
                  </span>
                </div>
              </div>
            )}
          </div>

          {/* Social share challenge */}
          <div className="flex flex-wrap items-center justify-between gap-3 pt-2">
            <span className="text-xs text-zinc-500 font-medium">
              Her gün yeni bir özel gün bilgi sorusu!
            </span>

            <Button
              onClick={handleShare}
              variant="outline"
              size="sm"
              className="text-xs font-bold gap-1.5 rounded-xl border-zinc-200 dark:border-zinc-700 hover:bg-zinc-100"
            >
              {copiedShare ? (
                <>
                  <Check className="h-3.5 w-3.5 text-emerald-600" />
                  <span>Kopyalandı!</span>
                </>
              ) : (
                <>
                  <Share2 className="h-3.5 w-3.5 text-purple-600" />
                  <span>Arkadaşına Meydan Oku</span>
                </>
              )}
            </Button>
          </div>
        </div>
      )}
    </div>
  );
}
