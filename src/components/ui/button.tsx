import * as React from "react";
import { cn } from "@/lib/utils";

export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: "default" | "secondary" | "outline" | "ghost" | "link" | "amber";
  size?: "default" | "sm" | "lg" | "icon";
}

const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant = "default", size = "default", ...props }, ref) => {
    const baseStyles =
      "inline-flex items-center justify-center rounded-xl text-sm font-medium transition-all focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 cursor-pointer active:scale-[0.98]";

    const variantStyles = {
      default:
        "bg-red-600 text-white shadow-sm hover:bg-red-700 focus-visible:ring-red-500",
      secondary:
        "bg-zinc-100 text-zinc-900 shadow-sm hover:bg-zinc-200 dark:bg-zinc-800 dark:text-zinc-100 dark:hover:bg-zinc-700 focus-visible:ring-zinc-500",
      outline:
        "border border-zinc-200 bg-white text-zinc-800 hover:bg-zinc-50 dark:border-zinc-800 dark:bg-zinc-900 dark:text-zinc-200 dark:hover:bg-zinc-800",
      ghost:
        "text-zinc-700 hover:bg-zinc-100 hover:text-zinc-900 dark:text-zinc-300 dark:hover:bg-zinc-800 dark:hover:text-zinc-100",
      link: "text-red-600 underline-offset-4 hover:underline dark:text-red-400 p-0 h-auto",
      amber:
        "bg-amber-500 text-zinc-950 font-semibold shadow-sm hover:bg-amber-400 focus-visible:ring-amber-500",
    };

    const sizeStyles = {
      default: "h-11 px-5 py-2.5",
      sm: "h-9 rounded-lg px-3.5 text-xs",
      lg: "h-12 rounded-xl px-7 text-base font-semibold",
      icon: "h-10 w-10",
    };

    return (
      <button
        className={cn(
          baseStyles,
          variantStyles[variant],
          sizeStyles[size],
          className
        )}
        ref={ref}
        {...props}
      />
    );
  }
);
Button.displayName = "Button";

export { Button };
