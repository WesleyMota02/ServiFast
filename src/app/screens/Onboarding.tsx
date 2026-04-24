import { useState } from "react";
import { useNavigate } from "react-router";
import { motion, AnimatePresence } from "motion/react";
import { Users, ShieldCheck, Clock } from "lucide-react";
import { Button } from "../components/Button";

const slides = [
  {
    icon: Users,
    title: "Encontre quem você precisa",
    subtitle: "Pintores, eletricistas, encanadores e muito mais, perto de você.",
    color: "text-[#3498DB]"
  },
  {
    icon: ShieldCheck,
    title: "Profissionais avaliados",
    subtitle: "Veja a reputação de cada profissional antes de contratar.",
    color: "text-[#F1C40F]"
  },
  {
    icon: Clock,
    title: "Serviço combinado em minutos",
    subtitle: "Solicite, negocie e confirme tudo pelo app.",
    color: "text-[#27AE60]"
  }
];

export function Onboarding() {
  const [current, setCurrent] = useState(0);
  const navigate = useNavigate();

  const handleNext = () => {
    if (current < slides.length - 1) {
      setCurrent(current + 1);
    } else {
      navigate("/welcome");
    }
  };

  const Icon = slides[current].icon;

  return (
    <div className="h-full w-full bg-white flex flex-col justify-between">
      <div className="flex justify-end p-6">
        <button 
          onClick={() => navigate("/welcome")}
          className="text-[#6B6B6B] text-sm font-medium hover:text-[#1A1A1A]"
        >
          Pular
        </button>
      </div>

      <div className="flex-1 flex flex-col items-center justify-center p-8 text-center relative overflow-hidden">
        <AnimatePresence mode="wait">
          <motion.div
            key={current}
            initial={{ opacity: 0, x: 50 }}
            animate={{ opacity: 1, x: 0 }}
            exit={{ opacity: 0, x: -50 }}
            transition={{ duration: 0.3 }}
            className="flex flex-col items-center w-full"
          >
            <div className={`w-64 h-64 bg-[#F9F9F9] rounded-full mb-10 flex items-center justify-center ${slides[current].color}`}>
              <Icon className="w-32 h-32" strokeWidth={1.5} />
            </div>
            <h2 className="text-2xl font-bold text-[#FF6B00] mb-3 leading-tight">{slides[current].title}</h2>
            <p className="text-[#6B6B6B] text-[15px]">{slides[current].subtitle}</p>
          </motion.div>
        </AnimatePresence>
      </div>

      <div className="p-8 pb-12">
        <div className="flex justify-center gap-2 mb-8">
          {slides.map((_, i) => (
            <div 
              key={i}
              className={`h-2 rounded-full transition-all duration-300 ${i === current ? 'w-6 bg-[#FF6B00]' : 'w-2 bg-[#EEEEEE]'}`}
            />
          ))}
        </div>
        <Button fullWidth onClick={handleNext}>
          {current === slides.length - 1 ? "Começar agora" : "Próximo"}
        </Button>
      </div>
    </div>
  );
}
