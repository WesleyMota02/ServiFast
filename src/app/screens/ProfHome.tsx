import { useNavigate } from "react-router";
import { Star, MessageSquare, ClipboardList, MapPin, Power } from "lucide-react";
import { BottomNav } from "../components/BottomNav";
import { useState } from "react";
import { Button } from "../components/Button";

export function ProfHome() {
  const navigate = useNavigate();
  const [available, setAvailable] = useState(true);

  return (
    <div className="h-full w-full bg-[#FFFFFF] flex flex-col relative pb-20 overflow-y-auto no-scrollbar">
      <div className="px-6 pt-12 pb-8 bg-[#FF6B00] rounded-b-[32px] shadow-sm text-white flex justify-between items-start">
        <div>
          <h1 className="text-2xl font-bold font-poppins">Olá, Carlos! 👷</h1>
          <div className="flex items-center text-sm mt-1 opacity-90 font-medium">
            <MapPin className="w-4 h-4 mr-1" />
            Mauá, SP
          </div>
        </div>
        
        <button 
          onClick={() => setAvailable(!available)}
          className={`flex flex-col items-center gap-1 p-2 rounded-xl border-2 transition-colors ${
            available ? "bg-white/20 border-white text-white" : "bg-black/20 border-transparent text-white/70"
          }`}
        >
          <Power className="w-5 h-5" />
          <span className="text-[10px] font-bold">{available ? "ON" : "OFF"}</span>
        </button>
      </div>

      <div className="mt-8 px-6">
        <h2 className="text-[18px] font-bold text-[#1A1A1A] mb-4">Resumo do dia</h2>
        <div className="grid grid-cols-2 gap-4">
          <div className="bg-[#FFF3E8] p-4 rounded-2xl flex flex-col gap-2">
            <div className="w-8 h-8 rounded-full bg-[#FF6B00] flex items-center justify-center text-white">
              <ClipboardList className="w-4 h-4" />
            </div>
            <h3 className="text-2xl font-bold text-[#1A1A1A]">2</h3>
            <p className="text-xs text-[#6B6B6B]">Solicitações novas</p>
          </div>
          
          <div className="bg-[#F9F9F9] p-4 rounded-2xl flex flex-col gap-2">
            <div className="w-8 h-8 rounded-full bg-white flex items-center justify-center text-[#FF6B00] shadow-sm">
              <MessageSquare className="w-4 h-4" />
            </div>
            <h3 className="text-2xl font-bold text-[#1A1A1A]">1</h3>
            <p className="text-xs text-[#6B6B6B]">Mensagem não lida</p>
          </div>
          
          <div className="col-span-2 bg-[#F9F9F9] p-4 rounded-2xl flex flex-col gap-2 items-center justify-center text-center">
            <div className="flex items-center justify-center gap-1">
              <Star className="w-6 h-6 text-[#F1C40F] fill-[#F1C40F]" />
              <h3 className="text-3xl font-bold text-[#1A1A1A] ml-2">4.9</h3>
            </div>
            <p className="text-sm text-[#6B6B6B]">Sua nota (47 avaliações)</p>
          </div>
        </div>
      </div>

      <div className="mt-8 px-6 pb-6">
        <div className="flex justify-between items-center mb-4">
          <h2 className="text-[18px] font-bold text-[#1A1A1A]">Novas solicitações</h2>
          <span className="w-6 h-6 rounded-full bg-[#FF6B00] text-white flex items-center justify-center text-xs font-bold">
            2
          </span>
        </div>
        
        <div className="flex flex-col gap-4">
          <div className="bg-white border border-[#EEEEEE] rounded-2xl p-4 shadow-[0_2px_8px_rgba(0,0,0,0.06)]">
            <div className="flex justify-between items-start mb-3">
              <div>
                <h3 className="font-bold text-[#1A1A1A]">Pintura de quarto</h3>
                <p className="text-sm text-[#6B6B6B]">João Mendes</p>
              </div>
              <span className="text-xs font-medium text-[#FF6B00] bg-[#FFF3E8] px-2 py-1 rounded-md">Hoje, 14h</span>
            </div>
            
            <div className="flex gap-2 mt-4">
              <Button variant="outline" className="flex-1 py-3 text-sm">Recusar</Button>
              <Button className="flex-1 py-3 text-sm" onClick={() => navigate("/professional/requests")}>Aceitar</Button>
            </div>
          </div>
        </div>
      </div>

      <BottomNav role="professional" />
    </div>
  );
}
