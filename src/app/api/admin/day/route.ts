import { NextResponse } from "next/server";
import { supabase, isSupabaseConfigured } from "@/utils/supabase";
import { getAllSpecialDays } from "@/lib/data/special-days-service";
import { SpecialDay } from "@/types/database";

export async function GET() {
  try {
    const days = await getAllSpecialDays();
    const hasSupabase = isSupabaseConfigured();

    return NextResponse.json({
      success: true,
      hasSupabase,
      totalCount: days.length,
      days,
    });
  } catch (err: unknown) {
    const message = err instanceof Error ? err.message : "Unknown error";
    return NextResponse.json({ success: false, error: message }, { status: 500 });
  }
}

export async function POST(req: Request) {
  try {
    const body = (await req.json()) as Partial<SpecialDay>;

    if (!body.title || !body.slug || !body.month_no || !body.day_no || !body.category) {
      return NextResponse.json(
        { error: "Başlık, slug, gün, ay ve kategori zorunludur." },
        { status: 400 }
      );
    }

    // Editorial tone safety check
    if (body.day_type === "anma") {
      const lowerTitle = body.title.toLowerCase();
      const lowerDesc = (body.description || "").toLowerCase();
      if (lowerTitle.includes("kutlu olsun") || lowerDesc.includes("kutlu olsun") || lowerDesc.includes("coşkuyla")) {
        return NextResponse.json(
          { error: "Editoryal Kural İhlali: Anma günlerinde kutlama ve coşku ifadeleri kullanılamaz. 'Saygıyla anıyoruz' veya 'rahmetle yad ediyoruz' ifadelerini tercih ediniz." },
          { status: 422 }
        );
      }
    }

    // Auto-generate date string
    const paddedMonth = String(body.month_no).padStart(2, "0");
    const paddedDay = String(body.day_no).padStart(2, "0");
    const celebration_date = `2026-${paddedMonth}-${paddedDay}`;

    const newDay: Partial<SpecialDay> = {
      id: body.id || `custom-${Date.now()}`,
      slug: body.slug.trim().toLowerCase(),
      title: body.title.trim(),
      description: body.description?.trim() || "",
      content: body.content?.trim() || "",
      celebration_date,
      month_no: Number(body.month_no),
      day_no: Number(body.day_no),
      category: body.category,
      day_type: body.day_type || "kutlama",
      is_public_holiday: Boolean(body.is_public_holiday),
      scope: body.scope || "turkiye",
      source_name: body.source_name?.trim() || "",
      source_url: body.source_url?.trim() || "",
      verified_at: body.verified_at || new Date().toISOString(),
      hashtags: Array.isArray(body.hashtags) ? body.hashtags : [],
      affiliate_keywords: Array.isArray(body.affiliate_keywords) ? body.affiliate_keywords : [],
      updated_at: new Date().toISOString(),
    };

    if (isSupabaseConfigured()) {
      const { data, error } = await supabase
        .from("special_days")
        .upsert(newDay, { onConflict: "slug" })
        .select()
        .single();

      if (error) {
        return NextResponse.json({ error: error.message }, { status: 500 });
      }

      return NextResponse.json({
        success: true,
        persistedToSupabase: true,
        data,
      });
    }

    // If Supabase is not active, return success with local preview item
    return NextResponse.json({
      success: true,
      persistedToSupabase: false,
      message: "Supabase bağlı olmadığı için veri yerel belleğe ve export kuyruğuna eklendi.",
      data: newDay,
    });
  } catch (err: unknown) {
    const message = err instanceof Error ? err.message : "Internal Server Error";
    return NextResponse.json({ error: message }, { status: 500 });
  }
}

export async function DELETE(req: Request) {
  try {
    const { searchParams } = new URL(req.url);
    const slug = searchParams.get("slug");

    if (!slug) {
      return NextResponse.json({ error: "Slug parametresi zorunludur." }, { status: 400 });
    }

    if (isSupabaseConfigured()) {
      const { error } = await supabase.from("special_days").delete().eq("slug", slug);
      if (error) {
        return NextResponse.json({ error: error.message }, { status: 500 });
      }
    }

    return NextResponse.json({ success: true, message: `${slug} kaydı silindi.` });
  } catch (err: unknown) {
    const message = err instanceof Error ? err.message : "Internal Server Error";
    return NextResponse.json({ error: message }, { status: 500 });
  }
}
