import { useEffect } from "react";
import { useNavigate } from "react-router";
import { Wrench, Zap } from "lucide-react";
import { motion } from "motion/react";

export function Splash() {
  const navigate = useNavigate();

  useEffect(() => {
    const timer = setTimeout(() => {
      navigate("/onboarding");
    }, 2500);
    return () => clearTimeout(timer);
  }, [navigate]);

  return (
    <div className="h-full w-full bg-[#FF6B00] flex flex-col items-center justify-center text-white">
      <motion.div
        initial={{ opacity: 0, scale: 0.8 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{ duration: 0.8, ease: "easeOut" }}
        className="flex flex-col items-center"
      >
        <div className="relative mb-4">
          <Wrench className="w-16 h-16 text-white" />
          <Zap className="w-8 h-8 text-white absolute -right-2 -bottom-2 fill-white" />
        </div>
        <h1 className="text-4xl font-bold font-poppins tracking-tight mb-2">ServiFast</h1>
        <p className="text-sm font-light text-center opacity-90 leading-tight">
          "O serviço certo,<br />perto de você."
        </p>
      </motion.div>
    </div>
  );
}
