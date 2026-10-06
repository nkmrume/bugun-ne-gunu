import { NextResponse } from "next/server";
import { supabase, isSupabaseConfigured } from "@/utils/supabase";
import { INITIAL_SPECIAL_DAYS } from "@/lib/data/special-days-data";

export async function POST() {
  if (!isSupabaseConfigured()) {
    return NextResponse.json(
      {
        error:
          "Supabase environment variables (NEXT_PUBLIC_SUPABASE_URL and NEXT_PUBLIC_SUPABASE_ANON_KEY) are not configured.",
      },
      { status: 400 }
    );
  }

  try {
    const { data, error } = await supabase
      .from("special_days")
      .upsert(INITIAL_SPECIAL_DAYS, { onConflict: "slug" });

    if (error) {
      return NextResponse.json({ error: error.message }, { status: 500 });
    }

    return NextResponse.json({
      success: true,
      message: `Successfully seeded/updated ${INITIAL_SPECIAL_DAYS.length} special days in Supabase!`,
      count: INITIAL_SPECIAL_DAYS.length,
    });
  } catch (err: unknown) {
    const message = err instanceof Error ? err.message : "Unknown error";
    return NextResponse.json({ error: message }, { status: 500 });
  }
}
