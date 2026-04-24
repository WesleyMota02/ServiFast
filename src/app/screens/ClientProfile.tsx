import { useNavigate } from "react-router";
import { User, Bell, Settings, Heart, ClipboardList, LogOut, ChevronRight } from "lucide-react";
import { BottomNav } from "../components/BottomNav";

export function ClientProfile() {
  const navigate = useNavigate();

  const handleLogout = () => {
    navigate("/welcome");
  };

  return (
    <div className="h-full w-full bg-[#F9F9F9] flex flex-col relative pb-20">
      <div className="px-6 pt-12 pb-16 bg-[#FF6B00] rounded-b-[32px] text-white flex flex-col items-center">
        <div className="relative mb-4">
          <div className="w-24 h-24 bg-white rounded-full flex items-center justify-center border-[4px] border-white shadow-md overflow-hidden">
            <span className="text-[#FF6B00] text-3xl font-bold">J</span>
          </div>
          <button className="absolute bottom-0 right-0 bg-white text-[#1A1A1A] p-2 rounded-full shadow-sm hover:bg-gray-50 transition-colors">
            <User className="w-4 h-4" />
          </button>
        </div>
        
        <h1 className="text-xl font-bold font-poppins text-white">João Mendes</h1>
        <p className="text-sm opacity-90 mt-1">joao.mendes@email.com</p>
        <p className="text-sm opacity-90">Mauá, SP</p>
        
        <button className="mt-4 bg-white/20 hover:bg-white/30 px-6 py-2 rounded-full text-sm font-semibold transition-colors">
          Editar perfil
        </button>
      </div>

      <div className="flex-1 px-6 -mt-6 z-10 flex flex-col gap-4 overflow-y-auto no-scrollbar">
        <div className="bg-white rounded-[16px] shadow-[0_2px_8px_rgba(0,0,0,0.06)] overflow-hidden">
          <button onClick={() => navigate("/client/requests")} className="w-full flex items-center justify-between p-4 border-b border-[#EEEEEE] hover:bg-gray-50 transition-colors text-[#1A1A1A]">
            <div className="flex items-center gap-3">
              <div className="p-2 bg-[#F9F9F9] rounded-xl text-[#FF6B00]"><ClipboardList className="w-5 h-5" /></div>
              <span className="font-semibold text-sm">Histórico de contratações</span>
            </div>
            <ChevronRight className="w-5 h-5 text-[#6B6B6B]" />
          </button>

          <button className="w-full flex items-center justify-between p-4 border-b border-[#EEEEEE] hover:bg-gray-50 transition-colors text-[#1A1A1A]">
            <div className="flex items-center gap-3">
              <div className="p-2 bg-[#F9F9F9] rounded-xl text-[#E74C3C]"><Heart className="w-5 h-5" /></div>
              <span className="font-semibold text-sm">Profissionais favoritos</span>
            </div>
            <ChevronRight className="w-5 h-5 text-[#6B6B6B]" />
          </button>

          <button onClick={() => navigate("/notifications")} className="w-full flex items-center justify-between p-4 hover:bg-gray-50 transition-colors text-[#1A1A1A]">
            <div className="flex items-center gap-3">
              <div className="p-2 bg-[#F9F9F9] rounded-xl text-[#F1C40F]"><Bell className="w-5 h-5" /></div>
              <span className="font-semibold text-sm">Notificações</span>
            </div>
            <ChevronRight className="w-5 h-5 text-[#6B6B6B]" />
          </button>
        </div>

        <div className="bg-white rounded-[16px] shadow-[0_2px_8px_rgba(0,0,0,0.06)] overflow-hidden mb-6">
          <button onClick={() => navigate("/settings")} className="w-full flex items-center justify-between p-4 border-b border-[#EEEEEE] hover:bg-gray-50 transition-colors text-[#1A1A1A]">
            <div className="flex items-center gap-3">
              <div className="p-2 bg-[#F9F9F9] rounded-xl text-[#3498DB]"><Settings className="w-5 h-5" /></div>
              <span className="font-semibold text-sm">Configurações</span>
            </div>
            <ChevronRight className="w-5 h-5 text-[#6B6B6B]" />
          </button>

          <button onClick={handleLogout} className="w-full flex items-center p-4 hover:bg-[#FDEDED] transition-colors text-[#E74C3C]">
            <div className="flex items-center gap-3">
              <div className="p-2 bg-transparent rounded-xl text-[#E74C3C]"><LogOut className="w-5 h-5" /></div>
              <span className="font-semibold text-sm">Sair da conta</span>
            </div>
          </button>
        </div>
      </div>

      <BottomNav role="client" />
    </div>
  );
}
