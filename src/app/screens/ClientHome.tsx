import { useNavigate } from "react-router";
import { Search, MapPin, Zap, Wrench, Droplet, Paintbrush, Scissors, Shovel, Monitor, ChevronRight, Star } from "lucide-react";
import { BottomNav } from "../components/BottomNav";
import { Card } from "../components/Card";
import { Badge } from "../components/Badge";
import { useState } from "react";

const CATEGORIES = [
  { id: 1, name: "Elétrico", icon: Zap },
  { id: 2, name: "Hidráulico", icon: Droplet },
  { id: 3, name: "Pintura", icon: Paintbrush },
  { id: 4, name: "Jardinagem", icon: Shovel },
  { id: 5, name: "Reforma", icon: Wrench },
  { id: 6, name: "Limpeza", icon: Scissors },
];

const PROFS = [
  { id: "1", name: "Carlos Silva", service: "Pintor", rating: 4.8, location: "Centro, Mauá", img: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200&h=200&auto=format&fit=crop" },
  { id: "2", name: "José Alves", service: "Eletricista", rating: 4.9, location: "Vila Assis, Mauá", img: "https://images.unsplash.com/photo-1540569014015-19a7be504e3a?q=80&w=200&h=200&auto=format&fit=crop" },
  { id: "3", name: "Maria Santos", service: "Faxina", rating: 5.0, location: "Jardim Zaíra, Mauá", img: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&h=200&auto=format&fit=crop" },
];

export function ClientHome() {
  const navigate = useNavigate();
  const [activeCategory, setActiveCategory] = useState<number | null>(null);

  return (
    <div className="h-full w-full bg-[#FFFFFF] flex flex-col relative pb-20 overflow-y-auto no-scrollbar">
      <div className="px-6 pt-12 pb-6 bg-[#FF6B00] rounded-b-[32px] shadow-sm text-white">
        <h1 className="text-2xl font-bold font-poppins">Olá, João! 👋</h1>
        <div className="flex items-center text-sm mt-1 opacity-90 font-medium">
          <MapPin className="w-4 h-4 mr-1" />
          Mauá, SP
        </div>

        <div className="mt-6 relative">
          <input 
            type="text" 
            placeholder="Buscar serviço..."
            onClick={() => navigate("/client/search")}
            readOnly
            className="w-full bg-white text-[#1A1A1A] rounded-xl pl-12 pr-4 py-3 text-sm shadow-[0_4px_12px_rgba(0,0,0,0.1)] outline-none"
          />
          <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-[#6B6B6B]" />
        </div>
      </div>

      <div className="mt-6 px-6">
        <div className="flex justify-between items-center mb-4">
          <h2 className="text-[18px] font-bold text-[#1A1A1A]">Categorias</h2>
          <button className="text-[#FF6B00] text-sm font-semibold flex items-center">
            Ver todas <ChevronRight className="w-4 h-4" />
          </button>
        </div>
        
        <div className="flex gap-4 overflow-x-auto no-scrollbar pb-2 -mx-6 px-6">
          {CATEGORIES.map(cat => {
            const Icon = cat.icon;
            const isActive = activeCategory === cat.id;
            return (
              <button 
                key={cat.id} 
                onClick={() => setActiveCategory(cat.id)}
                className={`flex flex-col items-center gap-2 min-w-[72px] transition-all`}
              >
                <div className={`w-14 h-14 rounded-full flex items-center justify-center shadow-sm transition-colors ${
                  isActive ? "bg-[#FF6B00] text-white" : "bg-[#F9F9F9] text-[#1A1A1A] hover:bg-[#FFF3E8]"
                }`}>
                  <Icon className="w-6 h-6" strokeWidth={isActive ? 2.5 : 2} />
                </div>
                <span className={`text-[12px] font-medium ${isActive ? "text-[#FF6B00]" : "text-[#6B6B6B]"}`}>{cat.name}</span>
              </button>
            )
          })}
        </div>
      </div>

      <div className="mt-8 px-6">
        <div className="flex justify-between items-center mb-4">
          <h2 className="text-[18px] font-bold text-[#1A1A1A]">Profissionais perto</h2>
        </div>
        
        <div className="flex gap-4 overflow-x-auto no-scrollbar pb-4 -mx-6 px-6">
          {PROFS.map(prof => (
            <Card 
              key={prof.id} 
              className="min-w-[160px] cursor-pointer hover:shadow-md transition-shadow"
              onClick={() => navigate(`/client/professional/${prof.id}`)}
            >
              <img src={prof.img} alt={prof.name} className="w-16 h-16 rounded-full mx-auto object-cover mb-3 shadow-sm" />
              <h3 className="text-[14px] font-bold text-center text-[#1A1A1A] leading-tight truncate">{prof.name}</h3>
              <p className="text-[12px] text-[#6B6B6B] text-center mb-2">{prof.service}</p>
              
              <div className="flex items-center justify-center gap-1 mb-1">
                <Star className="w-3 h-3 text-[#F1C40F] fill-[#F1C40F]" />
                <span className="text-[12px] font-bold text-[#1A1A1A]">{prof.rating}</span>
              </div>
              
              <div className="flex items-center justify-center text-[10px] text-[#6B6B6B]">
                <MapPin className="w-3 h-3 mr-1" />
                <span className="truncate">{prof.location}</span>
              </div>
            </Card>
          ))}
        </div>
      </div>

      <div className="mt-8 px-6 pb-6">
        <h2 className="text-[18px] font-bold text-[#1A1A1A] mb-4">Mais solicitados</h2>
        <div className="flex flex-col gap-4">
          {[1, 2, 3].map((_, i) => (
            <div 
              key={i} 
              onClick={() => navigate(`/client/professional/${i+1}`)}
              className="bg-[#F9F9F9] rounded-2xl p-4 flex gap-4 cursor-pointer hover:shadow-md transition-shadow items-center"
            >
              <img src={PROFS[i % 3].img} className="w-16 h-16 rounded-xl object-cover" />
              <div className="flex-1">
                <div className="flex justify-between items-start mb-1">
                  <h3 className="font-bold text-[#1A1A1A]">{PROFS[i % 3].name}</h3>
                  <div className="flex items-center gap-1">
                    <Star className="w-3 h-3 text-[#F1C40F] fill-[#F1C40F]" />
                    <span className="text-[12px] font-bold text-[#1A1A1A]">{PROFS[i % 3].rating}</span>
                  </div>
                </div>
                <p className="text-[#6B6B6B] text-sm mb-1">{PROFS[i % 3].service}</p>
                <div className="flex items-center gap-2">
                  <Badge variant="success" className="text-[10px] px-2 py-0.5">Disponível agora</Badge>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>

      <BottomNav role="client" />
    </div>
  );
}
