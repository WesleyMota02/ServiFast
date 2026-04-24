import { useState } from "react";
import { useNavigate } from "react-router";
import { Search, MapPin, Calendar, Wrench, MessageSquare, ChevronRight } from "lucide-react";
import { BottomNav } from "../components/BottomNav";
import { Badge } from "../components/Badge";

const REQUESTS = [
  { id: "1", prof: "Carlos Silva", service: "Pintura interna", date: "15/07 às 09h", location: "Rua X, nº 50", status: "Aguardando resposta", statusColor: "warning" },
  { id: "2", prof: "José Alves", service: "Instalação elétrica", date: "10/07 às 14h", location: "Rua X, nº 50", status: "Concluída", statusColor: "success" },
  { id: "3", prof: "Maria Santos", service: "Faxina completa", date: "05/07 às 08h", location: "Rua X, nº 50", status: "Cancelada", statusColor: "error" },
];

export function ClientRequests() {
  const navigate = useNavigate();
  const [activeTab, setActiveTab] = useState("Todas");

  const tabs = ["Todas", "Em andamento", "Aguardando", "Concluídas"];

  return (
    <div className="h-full w-full bg-white flex flex-col relative pb-20">
      <div className="px-6 pt-12 pb-4 bg-[#FF6B00] text-white">
        <h1 className="text-2xl font-bold font-poppins">Minhas Solicitações</h1>
      </div>

      <div className="flex overflow-x-auto no-scrollbar gap-6 px-6 pt-4 pb-2 border-b border-[#EEEEEE]">
        {tabs.map(tab => (
          <button 
            key={tab}
            onClick={() => setActiveTab(tab)}
            className={`whitespace-nowrap text-sm font-bold pb-2 border-b-2 transition-colors ${
              activeTab === tab 
                ? "border-[#FF6B00] text-[#FF6B00]" 
                : "border-transparent text-[#6B6B6B] hover:text-[#1A1A1A]"
            }`}
          >
            {tab}
          </button>
        ))}
      </div>

      <div className="flex-1 overflow-y-auto px-6 py-6 no-scrollbar flex flex-col gap-4">
        {REQUESTS.map((req, i) => (
          <div key={i} className="bg-[#F9F9F9] rounded-[16px] p-4 border border-[#EEEEEE]">
            <div className="flex justify-between items-start mb-3">
              <h3 className="font-bold text-[#1A1A1A]">{req.service}</h3>
              <Badge variant={req.statusColor as any} className="text-[10px] px-2 py-0.5">{req.status}</Badge>
            </div>
            
            <div className="flex items-center gap-2 mb-4">
              <img src={`https://images.unsplash.com/photo-${1500000000000 + i}?q=80&w=100&h=100&auto=format&fit=crop`} className="w-6 h-6 rounded-full object-cover" />
              <span className="text-sm font-medium text-[#6B6B6B]">{req.prof}</span>
            </div>

            <div className="flex flex-col gap-2 mb-4">
              <div className="flex items-center gap-2 text-[12px] text-[#6B6B6B]">
                <Calendar className="w-3.5 h-3.5" /> {req.date}
              </div>
              <div className="flex items-center gap-2 text-[12px] text-[#6B6B6B]">
                <MapPin className="w-3.5 h-3.5" /> {req.location}
              </div>
            </div>

            <div className="flex gap-2">
              <button 
                onClick={() => navigate(`/client/request/${req.id}`)}
                className="flex-1 bg-white border border-[#EEEEEE] text-[#1A1A1A] text-sm font-bold py-2 rounded-[10px] hover:bg-gray-50 transition-colors"
              >
                Ver detalhes
              </button>
              <button 
                onClick={() => navigate(`/client/chat/${req.id}`)}
                className="flex-1 bg-[#FFF3E8] border border-[#FFF3E8] text-[#FF6B00] text-sm font-bold py-2 rounded-[10px] hover:bg-[#FFE8D6] transition-colors flex items-center justify-center gap-2"
              >
                <MessageSquare className="w-4 h-4" /> Chat
              </button>
            </div>
          </div>
        ))}
      </div>

      <BottomNav role="client" />
    </div>
  );
}
