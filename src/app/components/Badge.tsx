import * as React from "react";
import { cn } from "../../lib/utils";

export interface BadgeProps extends React.HTMLAttributes<HTMLSpanElement> {
  variant?: "default" | "success" | "warning" | "error" | "info" | "outline";
}

export function Badge({ className, variant = "default", ...props }: BadgeProps) {
  return (
    <span
      className={cn(
        "inline-flex items-center rounded-full px-3 py-1 text-xs font-medium",
        {
          "bg-gray-100 text-gray-800": variant === "default",
          "bg-[#E8F8F0] text-[#27AE60]": variant === "success",
          "bg-[#FFF8E6] text-[#F39C12]": variant === "warning",
          "bg-[#FDEDED] text-[#E74C3C]": variant === "error",
          "bg-[#EBF5FF] text-[#3498DB]": variant === "info",
          "border border-gray-200 text-gray-600": variant === "outline",
        },
        className
      )}
      {...props}
    />
  );
}
