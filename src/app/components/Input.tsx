import * as React from "react";
import { cn } from "../../lib/utils";

export interface InputProps extends React.InputHTMLAttributes<HTMLInputElement> {
  label: string;
  error?: string;
  icon?: React.ReactNode;
}

export const Input = React.forwardRef<HTMLInputElement, InputProps>(
  ({ className, type, label, error, icon, ...props }, ref) => {
    const [focused, setFocused] = React.useState(false);
    
    return (
      <div className="w-full mb-4">
        <div 
          className={cn(
            "relative flex items-center border-[1.5px] rounded-[10px] transition-colors bg-white",
            focused ? "border-[#FF6B00]" : error ? "border-[#E74C3C]" : "border-[#EEEEEE]"
          )}
        >
          <div className="relative flex-1 px-4 py-[14px]">
            <label 
              className={cn(
                "absolute left-4 transition-all duration-200 pointer-events-none",
                (focused || props.value || props.defaultValue) 
                  ? "top-1 text-[10px] text-[#FF6B00]" 
                  : "top-1/2 -translate-y-1/2 text-sm text-[#6B6B6B]"
              )}
            >
              {label}
            </label>
            <input
              type={type}
              className={cn(
                "w-full bg-transparent outline-none text-[#1A1A1A] text-sm",
                (focused || props.value || props.defaultValue) ? "pt-3" : "pt-0"
              )}
              ref={ref}
              onFocus={(e) => {
                setFocused(true);
                props.onFocus?.(e);
              }}
              onBlur={(e) => {
                setFocused(false);
                props.onBlur?.(e);
              }}
              {...props}
            />
          </div>
          {icon && <div className="pr-4 text-[#6B6B6B]">{icon}</div>}
        </div>
        {error && <span className="text-[12px] text-[#E74C3C] mt-1 ml-1 block">{error}</span>}
      </div>
    );
  }
);
Input.displayName = "Input";
