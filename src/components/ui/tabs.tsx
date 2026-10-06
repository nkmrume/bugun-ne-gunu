"use client";

import * as React from "react";
import { cn } from "@/lib/utils";

interface TabsContextValue {
  activeTab: string;
  setActiveTab: (val: string) => void;
}

const TabsContext = React.createContext<TabsContextValue | undefined>(undefined);

export interface TabsProps extends React.HTMLAttributes<HTMLDivElement> {
  defaultValue: string;
  value?: string;
  onValueChange?: (value: string) => void;
  children: React.ReactNode;
}

export function Tabs({
  defaultValue,
  value,
  onValueChange,
  children,
  className,
  ...props
}: TabsProps) {
  const [selectedTab, setSelectedTab] = React.useState<string>(defaultValue);

  const activeTab = value !== undefined ? value : selectedTab;
  const handleTabChange = (val: string) => {
    setSelectedTab(val);
    if (onValueChange) {
      onValueChange(val);
    }
  };

  return (
    <TabsContext.Provider value={{ activeTab, setActiveTab: handleTabChange }}>
      <div className={cn("w-full", className)} {...props}>
        {children}
      </div>
    </TabsContext.Provider>
  );
}

export interface TabsListProps extends React.HTMLAttributes<HTMLDivElement> {
  children: React.ReactNode;
}

export function TabsList({ className, children, ...props }: TabsListProps) {
  return (
    <div
      role="tablist"
      className={cn(
        "inline-flex h-12 items-center justify-start rounded-2xl bg-zinc-100 p-1.5 text-zinc-600 dark:bg-zinc-800/80 dark:text-zinc-400 w-full sm:w-auto overflow-x-auto gap-1 border border-zinc-200/60 dark:border-zinc-700/60 shadow-inner",
        className
      )}
      {...props}
    >
      {children}
    </div>
  );
}

export interface TabsTriggerProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  value: string;
}

export function TabsTrigger({
  value,
  className,
  children,
  ...props
}: TabsTriggerProps) {
  const context = React.useContext(TabsContext);
  if (!context) {
    throw new Error("TabsTrigger must be used within a Tabs component");
  }

  const isSelected = context.activeTab === value;

  return (
    <button
      role="tab"
      type="button"
      aria-selected={isSelected}
      onClick={() => context.setActiveTab(value)}
      className={cn(
        "inline-flex items-center justify-center whitespace-nowrap rounded-xl px-4 py-2 text-sm font-semibold transition-all duration-200 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-red-500 cursor-pointer select-none",
        isSelected
          ? "bg-white text-zinc-950 shadow-sm dark:bg-zinc-900 dark:text-white"
          : "text-zinc-600 hover:text-zinc-900 hover:bg-zinc-200/50 dark:text-zinc-400 dark:hover:text-zinc-100 dark:hover:bg-zinc-700/40",
        className
      )}
      {...props}
    >
      {children}
    </button>
  );
}

export interface TabsContentProps extends React.HTMLAttributes<HTMLDivElement> {
  value: string;
}

export function TabsContent({
  value,
  className,
  children,
  ...props
}: TabsContentProps) {
  const context = React.useContext(TabsContext);
  if (!context) {
    throw new Error("TabsContent must be used within a Tabs component");
  }

  if (context.activeTab !== value) {
    return null;
  }

  return (
    <div
      role="tabpanel"
      className={cn(
        "mt-6 ring-offset-background focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-red-500 animate-in fade-in-50 duration-300",
        className
      )}
      {...props}
    >
      {children}
    </div>
  );
}
