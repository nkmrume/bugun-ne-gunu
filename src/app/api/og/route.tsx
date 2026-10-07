import { ImageResponse } from "next/og";
import { NextRequest } from "next/server";

export const runtime = "nodejs";

export async function GET(req: NextRequest) {
  try {
    const { searchParams } = new URL(req.url);

    const title = searchParams.get("title") || "Bugün Ne Günü?";
    const date = searchParams.get("date") || "Türkiye'nin Doğrulanmış Özel Günler Takvimi";
    const category = searchParams.get("cat") || "Özel Günler";
    const dayType = searchParams.get("type") || "kutlama";
    const description =
      searchParams.get("desc") ||
      "Türkiye ve dünyadaki özel günler, anma tarihleri, kutlama mesajları ve geri sayım rehberi.";

    // Determine badge and color theme based on dayType
    const isMemorial = dayType === "anma";
    const isHoliday = dayType === "resmi-tatil";

    const badgeText = isHoliday
      ? "🇹🇷 RESMÎ TATİL"
      : isMemorial
      ? "🕯️ ANMA GÜNÜ"
      : dayType === "farkindalik"
      ? "🌱 FARKINDALIK GÜNÜ"
      : "🎉 ÖZEL GÜN";

    const badgeBg = isHoliday
      ? "rgba(220, 38, 38, 0.25)"
      : isMemorial
      ? "rgba(113, 113, 122, 0.3)"
      : "rgba(239, 68, 68, 0.2)";

    const badgeBorder = isHoliday
      ? "#ef4444"
      : isMemorial
      ? "#a1a1aa"
      : "#f43f5e";

    const badgeColor = isHoliday ? "#fca5a5" : isMemorial ? "#e4e4e7" : "#fda4af";

    return new ImageResponse(
      (
        <div
          style={{
            height: "100%",
            width: "100%",
            display: "flex",
            flexDirection: "column",
            justifyContent: "space-between",
            backgroundColor: "#09090b",
            backgroundImage:
              "radial-gradient(circle at 90% 10%, rgba(220, 38, 38, 0.22), transparent 45%), radial-gradient(circle at 10% 90%, rgba(245, 158, 11, 0.15), transparent 40%)",
            padding: "54px 60px",
            fontFamily: "system-ui, -apple-system, sans-serif",
            color: "white",
          }}
        >
          {/* Top Brand Bar */}
          <div
            style={{
              display: "flex",
              alignItems: "center",
              justifyContent: "space-between",
              width: "100%",
            }}
          >
            {/* Brand Logo & Name */}
            <div
              style={{
                display: "flex",
                alignItems: "center",
                gap: "16px",
              }}
            >
              <div
                style={{
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "center",
                  width: "56px",
                  height: "56px",
                  borderRadius: "18px",
                  background: "linear-gradient(135deg, #dc2626 0%, #ea580c 100%)",
                  boxShadow: "0 8px 24px rgba(220, 38, 38, 0.4)",
                  fontSize: "28px",
                }}
              >
                📅
              </div>
              <div style={{ display: "flex", flexDirection: "column" }}>
                <span
                  style={{
                    fontSize: "26px",
                    fontWeight: 900,
                    letterSpacing: "-0.5px",
                    color: "#ffffff",
                  }}
                >
                  Bugün Ne Günü<span style={{ color: "#ef4444" }}>?</span>
                </span>
                <span
                  style={{
                    fontSize: "14px",
                    fontWeight: 600,
                    color: "#a1a1aa",
                    letterSpacing: "0.5px",
                  }}
                >
                  bugunnegunu.com
                </span>
              </div>
            </div>

            {/* Day Type Badge */}
            <div
              style={{
                display: "flex",
                alignItems: "center",
                gap: "8px",
                padding: "10px 22px",
                borderRadius: "9999px",
                backgroundColor: badgeBg,
                border: `1.5px solid ${badgeBorder}`,
                color: badgeColor,
                fontSize: "16px",
                fontWeight: 800,
                letterSpacing: "0.5px",
              }}
            >
              {badgeText}
            </div>
          </div>

          {/* Middle Main Content */}
          <div
            style={{
              display: "flex",
              flexDirection: "column",
              gap: "16px",
              maxWidth: "1080px",
              margin: "24px 0",
            }}
          >
            {/* Date & Category Pills */}
            <div
              style={{
                display: "flex",
                alignItems: "center",
                gap: "12px",
              }}
            >
              <div
                style={{
                  display: "flex",
                  alignItems: "center",
                  gap: "6px",
                  padding: "6px 16px",
                  borderRadius: "12px",
                  backgroundColor: "rgba(255, 255, 255, 0.08)",
                  border: "1px solid rgba(255, 255, 255, 0.15)",
                  color: "#f43f5e",
                  fontSize: "18px",
                  fontWeight: 700,
                }}
              >
                🗓️ {date}
              </div>

              <div
                style={{
                  display: "flex",
                  alignItems: "center",
                  padding: "6px 16px",
                  borderRadius: "12px",
                  backgroundColor: "rgba(255, 255, 255, 0.05)",
                  border: "1px solid rgba(255, 255, 255, 0.1)",
                  color: "#e4e4e7",
                  fontSize: "18px",
                  fontWeight: 600,
                }}
              >
                {category}
              </div>
            </div>

            {/* Title */}
            <div
              style={{
                fontSize: title.length > 40 ? "52px" : "64px",
                fontWeight: 900,
                lineHeight: 1.1,
                letterSpacing: "-1.5px",
                color: "#ffffff",
                display: "-webkit-box",
                WebkitLineClamp: 2,
                WebkitBoxOrient: "vertical",
                overflow: "hidden",
                textShadow: "0 4px 20px rgba(0, 0, 0, 0.6)",
              }}
            >
              {title}
            </div>

            {/* Description Snippet */}
            <div
              style={{
                fontSize: "22px",
                fontWeight: 500,
                lineHeight: 1.4,
                color: "#a1a1aa",
                display: "-webkit-box",
                WebkitLineClamp: 2,
                WebkitBoxOrient: "vertical",
                overflow: "hidden",
              }}
            >
              {description}
            </div>
          </div>

          {/* Bottom Footer Verification Bar */}
          <div
            style={{
              display: "flex",
              alignItems: "center",
              justifyContent: "space-between",
              borderTop: "1px solid rgba(255, 255, 255, 0.1)",
              paddingTop: "20px",
              width: "100%",
            }}
          >
            <div
              style={{
                display: "flex",
                alignItems: "center",
                gap: "8px",
                fontSize: "16px",
                fontWeight: 700,
                color: "#34d399",
              }}
            >
              <div
                style={{
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "center",
                  width: "22px",
                  height: "22px",
                  borderRadius: "50%",
                  backgroundColor: "rgba(52, 211, 153, 0.2)",
                  color: "#34d399",
                  fontSize: "14px",
                }}
              >
                ✓
              </div>
              <span>BM, UNESCO ve Resmî Gazete Teyitli Kayıt</span>
            </div>

            <div
              style={{
                display: "flex",
                alignItems: "center",
                gap: "16px",
                fontSize: "15px",
                fontWeight: 600,
                color: "#71717a",
              }}
            >
              <span>Geri Sayım</span>
              <span>•</span>
              <span>Kutlama Mesajları</span>
              <span>•</span>
              <span style={{ color: "#ef4444", fontWeight: 700 }}>bugunnegunu.com</span>
            </div>
          </div>
        </div>
      ),
      {
        width: 1200,
        height: 630,
      }
    );
  } catch (err: unknown) {
    const msg = err instanceof Error ? err.message : "Error generating OG image";
    return new Response(`Failed to generate image: ${msg}`, { status: 500 });
  }
}
