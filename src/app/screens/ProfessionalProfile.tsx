import { useNavigate, useParams } from "react-router";
import { ArrowLeft, Star, MapPin, CheckCircle, MessageSquare, ClipboardEdit, StarHalf, Wrench } from "lucide-react";
import { Button } from "../components/Button";
import { Badge } from "../components/Badge";

export function ProfessionalProfile() {
  const navigate = useNavigate();
  const { id } = useParams();

  const handleRequestService = () => {
    navigate(`/client/request/${id}`);
  };

  const handleMessage = () => {
    navigate(`/client/chat/${id}`);
  };

  return (
    <div className="h-full w-full bg-white flex flex-col relative pb-20 overflow-y-auto no-scrollbar">
      <div className="relative h-64 bg-gray-200">
        <img 
          src="https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=600&h=400&auto=format&fit=crop" 
          alt="Carlos Silva" 
          className="w-full h-full object-cover"
        />
        <div className="absolute top-12 left-6">
          <button onClick={() => navigate(-1)} className="p-2 bg-white/80 backdrop-blur-sm rounded-full shadow-sm hover:bg-white transition-colors">
            <ArrowLeft className="w-6 h-6 text-[#1A1A1A]" />
          </button>
        </div>
      </div>

      <div className="px-6 -mt-8 relative z-10 bg-white rounded-t-[32px] pt-8 pb-6 flex-1 shadow-[0_-8px_20px_rgba(0,0,0,0.05)]">
        <div className="flex justify-between items-start mb-2">
          <h1 className="text-2xl font-bold font-poppins text-[#1A1A1A]">Carlos Silva</h1>
          <Badge variant="success" className="gap-1 px-2.5 py-1">
            <CheckCircle className="w-3.5 h-3.5" /> Disponível
          </Badge>
        </div>

        <div className="flex items-center gap-4 text-sm mb-4">
          <div className="flex items-center gap-1 font-bold text-[#1A1A1A]">
            <Star className="w-4 h-4 text-[#F1C40F] fill-[#F1C40F]" />
            4.9 <span className="text-[#6B6B6B] font-normal">(47 avaliações)</span>
          </div>
          <div className="w-1 h-1 bg-[#D9D9D9] rounded-full" />
          <div className="flex items-center gap-1 text-[#6B6B6B]">
            <MapPin className="w-4 h-4" />
            Jd. Miranda, Mauá
          </div>
        </div>

        <div className="flex flex-col gap-3 mt-6">
          <Button fullWidth onClick={handleRequestService} className="gap-2">
            <ClipboardEdit className="w-5 h-5" /> Solicitar Serviço
          </Button>
          <Button variant="outline" fullWidth onClick={handleMessage} className="gap-2">
            <MessageSquare className="w-5 h-5" /> Enviar mensagem
          </Button>
        </div>

        <div className="mt-8">
          <h2 className="text-[18px] font-bold text-[#1A1A1A] mb-3">Sobre</h2>
          <p className="text-[#6B6B6B] text-[14px] leading-relaxed">
            "Sou pintor há 10 anos, trabalho com tinta acrílica e esmalte. Faço serviços em residências e pequenos comércios. Trago todo o material necessário para proteger seus móveis."
          </p>
        </div>

        <div className="mt-8">
          <h2 className="text-[18px] font-bold text-[#1A1A1A] mb-3">Serviços</h2>
          <div className="flex flex-col gap-2">
            {["Pintura interna", "Pintura externa", "Textura e grafiato"].map((srv, i) => (
              <div key={i} className="flex items-center gap-3 text-[#1A1A1A] text-sm">
                <div className="w-8 h-8 rounded-full bg-[#FFF3E8] text-[#FF6B00] flex items-center justify-center">
                  <Wrench className="w-4 h-4" />
                </div>
                {srv}
              </div>
            ))}
          </div>
        </div>

        <div className="mt-8 border-t border-[#EEEEEE] pt-6">
          <div className="flex justify-between items-center mb-4">
            <h2 className="text-[18px] font-bold text-[#1A1A1A]">Avaliações</h2>
            <button className="text-[#FF6B00] text-sm font-semibold hover:underline">
              Ver todas
            </button>
          </div>
          
          <div className="bg-[#F9F9F9] rounded-[16px] p-4">
            <div className="flex items-center gap-3 mb-2">
              <img src="https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=100&h=100&auto=format&fit=crop" className="w-10 h-10 rounded-full object-cover" />
              <div>
                <h4 className="text-[14px] font-bold text-[#1A1A1A]">Maria D.</h4>
                <div className="flex items-center">
                  {[...Array(5)].map((_, i) => (
                    <Star key={i} className="w-3 h-3 text-[#F1C40F] fill-[#F1C40F]" />
                  ))}
                </div>
              </div>
              <span className="ml-auto text-[#6B6B6B] text-[12px]">Há 2 dias</span>
            </div>
            <p className="text-[#6B6B6B] text-[13px] italic">
              "Ótimo serviço! Muito pontual, fez um trabalho impecável na sala. Recomendo muito!"
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}
