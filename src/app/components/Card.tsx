import * as React from "react";
import { cn } from "../../lib/utils";

export const Card = React.forwardRef<HTMLDivElement, React.HTMLAttributes<HTMLDivElement>>(
  ({ className, ...props }, ref) => (
    <div
      ref={ref}
      className={cn("bg-[#F9F9F9] rounded-[16px] p-4 shadow-[0_2px_8px_rgba(0,0,0,0.06)]", className)}
      {...props}
    />
  )
);
Card.displayName = "Card";
