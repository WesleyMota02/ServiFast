import * as React from "react";
import { cn } from "../../lib/utils";

export interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: "primary" | "secondary" | "outline" | "ghost";
  fullWidth?: boolean;
}

export const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant = "primary", fullWidth, ...props }, ref) => {
    return (
      <button
        ref={ref}
        className={cn(
          "inline-flex items-center justify-center rounded-xl px-4 py-4 text-base font-bold transition-all disabled:opacity-50 disabled:pointer-events-none cursor-pointer",
          fullWidth && "w-full",
          variant === "primary" && "bg-[#FF6B00] text-white hover:bg-[#E65C00] shadow-[0_4px_12px_rgba(255,107,0,0.3)]",
          variant === "secondary" && "bg-transparent border-2 border-[#FF6B00] text-[#FF6B00] hover:bg-[#FFF3E8]",
          variant === "outline" && "bg-transparent border-2 border-[#EEEEEE] text-[#1A1A1A] hover:border-[#FF6B00] hover:text-[#FF6B00]",
          variant === "ghost" && "bg-transparent text-[#6B6B6B] hover:bg-gray-100",
          className
        )}
        {...props}
      />
    );
  }
);
Button.displayName = "Button";
