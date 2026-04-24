import { useNavigate } from "react-router";
import { CheckCircle2, Calendar, MapPin, Wrench } from "lucide-react";
import { Button } from "../components/Button";
import { motion } from "motion/react";

export function RequestConfirmation() {
  const navigate = useNavigate();

  return (
    <div className="h-full w-full bg-white flex flex-col p-6 items-center justify-center text-center">
      <motion.div 
        initial={{ scale: 0.5, opacity: 0 }}
        animate={{ scale: 1, opacity: 1 }}
        transition={{ type: "spring", bounce: 0.5 }}
        className="w-24 h-24 bg-[#E8F8F0] rounded-full flex items-center justify-center mb-6"
      >
        <CheckCircle2 className="w-12 h-12 text-[#27AE60]" />
      </motion.div>

      <h1 className="text-2xl font-bold text-[#1A1A1A] mb-2 font-poppins">Solicitação enviada!</h1>
      <p className="text-[#6B6B6B] mb-8 text-sm max-w-[260px]">
        Carlos Silva foi notificado e em breve entrará em contato com você.
      </p>

      <div className="w-full bg-[#F9F9F9] rounded-[16px] p-5 mb-8 border border-[#EEEEEE] text-left">
        <div className="flex items-center gap-3 mb-4 pb-4 border-b border-[#EEEEEE]">
          <img src="https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=100&h=100&auto=format&fit=crop" className="w-12 h-12 rounded-full object-cover" />
          <div>
            <h3 className="font-bold text-[#1A1A1A]">Carlos Silva</h3>
            <span className="text-xs text-[#6B6B6B]">Pintor</span>
          </div>
        </div>

        <div className="flex flex-col gap-3">
          <div className="flex items-center gap-3 text-sm text-[#1A1A1A]">
            <Wrench className="w-4 h-4 text-[#FF6B00]" /> Pintura interna
          </div>
          <div className="flex items-center gap-3 text-sm text-[#1A1A1A]">
            <Calendar className="w-4 h-4 text-[#FF6B00]" /> 15/07 - Manhã
          </div>
          <div className="flex items-center gap-3 text-sm text-[#1A1A1A]">
            <MapPin className="w-4 h-4 text-[#FF6B00]" /> Rua Exemplo, 123
          </div>
        </div>
      </div>

      <div className="w-full flex flex-col gap-3 mt-auto">
        <Button fullWidth onClick={() => navigate("/client/requests")}>
          Ver minhas solicitações
        </Button>
        <Button variant="outline" fullWidth onClick={() => navigate("/client/home")}>
          Voltar ao início
        </Button>
      </div>
    </div>
  );
}
