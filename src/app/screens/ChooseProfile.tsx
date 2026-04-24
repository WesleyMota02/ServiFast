import { useState } from "react";
import { useNavigate } from "react-router";
import { ArrowLeft, Home, HardHat } from "lucide-react";
import { Button } from "../components/Button";

export function ChooseProfile() {
  const [profile, setProfile] = useState<"client" | "professional" | null>(null);
  const navigate = useNavigate();

  return (
    <div className="h-full w-full bg-white flex flex-col p-6 pt-12">
      <div className="flex items-center mb-8">
        <button onClick={() => navigate(-1)} className="p-2 -ml-2 rounded-full hover:bg-gray-100 transition-colors">
          <ArrowLeft className="w-6 h-6 text-[#1A1A1A]" />
        </button>
        <h1 className="text-xl font-bold ml-2">Como você vai usar o app?</h1>
      </div>

      <div className="flex flex-col gap-4 flex-1 mt-4">
        <button
          onClick={() => setProfile("client")}
          className={`relative p-6 rounded-2xl border-2 transition-all flex flex-col items-start ${
            profile === "client" 
              ? "border-[#FF6B00] bg-[#FFF3E8]" 
              : "border-[#EEEEEE] bg-white hover:border-gray-300"
          }`}
        >
          <div className="w-12 h-12 rounded-full bg-[#FF6B00] flex items-center justify-center mb-4 text-white shadow-md">
            <Home className="w-6 h-6" />
          </div>
          <h2 className="text-[20px] font-bold text-[#1A1A1A] mb-1">Sou Cliente</h2>
          <p className="text-[14px] text-[#6B6B6B] font-medium text-left">
            Quero contratar serviços
          </p>
          {profile === "client" && (
            <div className="absolute top-6 right-6 w-6 h-6 bg-[#FF6B00] rounded-full flex items-center justify-center text-white text-sm">
              ✓
            </div>
          )}
        </button>

        <button
          onClick={() => setProfile("professional")}
          className={`relative p-6 rounded-2xl border-2 transition-all flex flex-col items-start ${
            profile === "professional" 
              ? "border-[#FF6B00] bg-[#FFF3E8]" 
              : "border-[#EEEEEE] bg-white hover:border-gray-300"
          }`}
        >
          <div className="w-12 h-12 rounded-full bg-[#1A1A1A] flex items-center justify-center mb-4 text-white shadow-md">
            <HardHat className="w-6 h-6" />
          </div>
          <h2 className="text-[20px] font-bold text-[#1A1A1A] mb-1">Sou Profissional</h2>
          <p className="text-[14px] text-[#6B6B6B] font-medium text-left">
            Quero oferecer meus serviços
          </p>
          {profile === "professional" && (
            <div className="absolute top-6 right-6 w-6 h-6 bg-[#FF6B00] rounded-full flex items-center justify-center text-white text-sm">
              ✓
            </div>
          )}
        </button>
      </div>

      <div className="pb-8">
        <Button 
          fullWidth 
          disabled={!profile}
          onClick={() => navigate(profile === "client" ? "/register/client" : "/register/professional")}
        >
          Continuar
        </Button>
      </div>
    </div>
  );
}
