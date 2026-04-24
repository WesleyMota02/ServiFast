import { useNavigate } from "react-router";
import { Wrench, Zap } from "lucide-react";
import { Button } from "../components/Button";

export function Welcome() {
  const navigate = useNavigate();

  return (
    <div className="h-full w-full flex flex-col relative overflow-hidden bg-white">
      {/* Top Half */}
      <div className="h-[55%] bg-[#FF6B00] flex flex-col items-center justify-center text-white relative z-0 pb-10">
        <div className="relative mb-4">
          <Wrench className="w-20 h-20 text-white" />
          <Zap className="w-10 h-10 text-white absolute -right-3 -bottom-3 fill-white" />
        </div>
        <h1 className="text-[40px] font-bold font-poppins tracking-tight">ServiFast</h1>
      </div>

      {/* Bottom Half */}
      <div className="h-[45%] bg-white rounded-t-[32px] absolute bottom-0 left-0 right-0 z-10 px-6 py-10 flex flex-col justify-between shadow-[0_-8px_30px_rgba(0,0,0,0.1)]">
        <div className="flex flex-col gap-4 mt-4">
          <Button 
            variant="secondary" 
            fullWidth 
            onClick={() => navigate("/login")}
          >
            Entrar na conta
          </Button>
          <Button 
            variant="primary" 
            fullWidth 
            onClick={() => navigate("/choose-profile")}
          >
            Criar conta
          </Button>
        </div>

        <p className="text-center text-[#6B6B6B] text-[12px] font-medium mt-auto">
          Ao continuar, você concorda com nossos{" "}
          <span className="text-[#FF6B00] font-bold cursor-pointer">Termos de uso</span> e{" "}
          <span className="text-[#FF6B00] font-bold cursor-pointer">Política de Privacidade</span>.
        </p>
      </div>
    </div>
  );
}
