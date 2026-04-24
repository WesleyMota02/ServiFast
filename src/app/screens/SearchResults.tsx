import { useNavigate, useSearchParams } from "react-router";
import { ArrowLeft, Filter, Star, MapPin, Wrench } from "lucide-react";
import { Card } from "../components/Card";
import { Badge } from "../components/Badge";

const PROFS = [
  { id: "1", name: "Carlos Silva", service: "Pintura · Reforma", rating: 4.8, reviews: 32, location: "Centro, Mauá", price: "R$80", img: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200&h=200&auto=format&fit=crop", available: true },
  { id: "2", name: "José Alves", service: "Eletricista", rating: 4.9, reviews: 45, location: "Vila Assis, Mauá", price: "R$100", img: "https://images.unsplash.com/photo-1540569014015-19a7be504e3a?q=80&w=200&h=200&auto=format&fit=crop", available: false },
  { id: "3", name: "Maria Santos", service: "Pintura", rating: 5.0, reviews: 120, location: "Jardim Zaíra, Mauá", price: "R$70", img: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&h=200&auto=format&fit=crop", available: true },
];

export function SearchResults() {
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const query = searchParams.get("q") || "Pintor";

  return (
    <div className="h-full w-full bg-white flex flex-col pt-12">
      <div className="px-6 flex items-center mb-4">
        <button onClick={() => navigate(-1)} className="p-2 -ml-2 rounded-full hover:bg-gray-100 transition-colors">
          <ArrowLeft className="w-6 h-6 text-[#1A1A1A]" />
        </button>
        <h1 className="text-xl font-bold ml-2 truncate">Resultados para "{query}"</h1>
      </div>

      <div className="px-6 pb-4 border-b border-[#EEEEEE] flex gap-2 overflow-x-auto no-scrollbar">
        <Badge variant="outline" className="border-[#FF6B00] text-[#FF6B00] bg-[#FFF3E8] py-1.5 px-3 flex items-center gap-1 cursor-pointer">
          Mauá <span className="text-[10px]">×</span>
        </Badge>
        <Badge variant="outline" className="border-[#EEEEEE] text-[#6B6B6B] py-1.5 px-3 flex items-center gap-1 cursor-pointer hover:bg-gray-50">
          <Star className="w-3 h-3 fill-current" /> 4+ <span className="text-[10px]">×</span>
        </Badge>
        <button className="flex items-center gap-1 text-sm font-medium text-[#1A1A1A] ml-2 px-2 py-1 rounded-md hover:bg-gray-100">
          <Filter className="w-4 h-4" /> Filtros
        </button>
      </div>

      <div className="flex-1 overflow-y-auto px-6 py-6 no-scrollbar flex flex-col gap-4">
        <p className="text-sm font-medium text-[#6B6B6B] mb-2">{PROFS.length} profissionais encontrados</p>
        
        {PROFS.map(prof => (
          <Card key={prof.id} className="p-0 overflow-hidden cursor-pointer" onClick={() => navigate(`/client/professional/${prof.id}`)}>
            <div className="flex p-4 gap-4">
              <div className="relative">
                <img src={prof.img} alt={prof.name} className="w-[72px] h-[72px] rounded-[16px] object-cover" />
                {prof.available && (
                  <div className="absolute -bottom-1 -right-1 w-4 h-4 bg-[#27AE60] border-2 border-white rounded-full"></div>
                )}
              </div>
              <div className="flex-1">
                <div className="flex justify-between items-start">
                  <h3 className="font-bold text-[#1A1A1A] leading-tight">{prof.name}</h3>
                  <div className="flex flex-col items-end">
                    <div className="flex items-center gap-1">
                      <Star className="w-3 h-3 text-[#F1C40F] fill-[#F1C40F]" />
                      <span className="text-[12px] font-bold text-[#1A1A1A]">{prof.rating}</span>
                    </div>
                    <span className="text-[10px] text-[#6B6B6B]">({prof.reviews})</span>
                  </div>
                </div>
                
                <div className="flex items-center text-[12px] text-[#6B6B6B] mt-1 gap-1">
                  <MapPin className="w-3 h-3" />
                  {prof.location}
                </div>
                
                <div className="flex items-center text-[12px] text-[#6B6B6B] mt-1 gap-1">
                  <Wrench className="w-3 h-3" />
                  {prof.service}
                </div>
              </div>
            </div>
            
            <div className="border-t border-[#EEEEEE] px-4 py-3 flex justify-between items-center bg-[#FAFAFA]">
              <div className="text-[12px] font-medium">
                <span className="text-[#6B6B6B]">A partir de </span>
                <span className="text-[#1A1A1A] font-bold">{prof.price}</span>
              </div>
              <span className="text-[#FF6B00] text-[12px] font-bold flex items-center gap-1">
                Ver perfil <ArrowLeft className="w-3 h-3 rotate-180" />
              </span>
            </div>
          </Card>
        ))}
      </div>
    </div>
  );
}
