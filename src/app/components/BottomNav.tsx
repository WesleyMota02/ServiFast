import { Home, Search, MessageSquare, ClipboardList, User } from "lucide-react";
import { useLocation, useNavigate } from "react-router";

export function BottomNav({ role }: { role: "client" | "professional" }) {
  const navigate = useNavigate();
  const location = useLocation();

  const clientNav = [
    { icon: Home, label: "Início", path: "/client/home" },
    { icon: Search, label: "Buscar", path: "/client/search" },
    { icon: MessageSquare, label: "Chat", path: "/client/chat/1" },
    { icon: ClipboardList, label: "Pedidos", path: "/client/requests" },
    { icon: User, label: "Perfil", path: "/client/profile" },
  ];

  const profNav = [
    { icon: Home, label: "Início", path: "/professional/home" },
    { icon: ClipboardList, label: "Pedidos", path: "/professional/requests" },
    { icon: MessageSquare, label: "Chat", path: "/professional/chat/1" },
    { icon: User, label: "Perfil", path: "/professional/profile" },
  ];

  const nav = role === "client" ? clientNav : profNav;

  return (
    <div className="absolute bottom-0 left-0 right-0 bg-white border-t border-[#EEEEEE] px-4 py-3 flex justify-between items-center z-50">
      {nav.map((item) => {
        const isActive = location.pathname.startsWith(item.path.split("/1")[0]) || (location.pathname === item.path);
        return (
          <button
            key={item.label}
            onClick={() => navigate(item.path)}
            className={`flex flex-col items-center justify-center w-16 gap-1 transition-colors ${
              isActive ? "text-[#FF6B00]" : "text-[#6B6B6B]"
            }`}
          >
            <item.icon className="w-6 h-6" strokeWidth={isActive ? 2.5 : 2} />
            <span className="text-[10px] font-medium">{item.label}</span>
          </button>
        );
      })}
    </div>
  );
}
