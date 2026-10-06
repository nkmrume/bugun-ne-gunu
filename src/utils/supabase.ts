import { createClient } from "@supabase/supabase-js";
import { SpecialDay } from "@/types/database";

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || "";
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || "";

export const isSupabaseConfigured = (): boolean => {
  return Boolean(
    supabaseUrl &&
    supabaseAnonKey &&
    supabaseUrl.startsWith("http") &&
    !supabaseUrl.includes("your-supabase-url")
  );
};

// Safe client instance (will only attempt real calls if configured)
export const supabase = createClient(
  supabaseUrl || "https://placeholder-domain.supabase.co",
  supabaseAnonKey || "placeholder-anon-key",
  {
    auth: {
      persistSession: false,
    },
  }
);

export type { SpecialDay };
