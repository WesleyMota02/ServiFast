import { useState } from "react";
import { useNavigate } from "react-router";
import { Wrench } from "lucide-react";
import { Button } from "../components/Button";
import { Input } from "../components/Input";
import { toast } from "sonner";

export function RecoverPassword() {
  const navigate = useNavigate();
  const [email, setEmail] = useState("");

  const handleRecover = () => {
    if (!email || !email.includes("@")) {
      toast.error("Por favor, insira um e-mail válido.");
      return;
    }
    
    // Simulate sending recovery link
    toast.success("Link de recuperação enviado para o seu e-mail!");
    
    // Redirect back to login after short delay
    setTimeout(() => {
      navigate("/login");
    }, 2000);
  };

  return (
    <div className="h-full min-h-screen w-full bg-[#FFFFFF] flex flex-col pt-16 px-6 font-[Poppins]">
      {/* Logotipo/Ícone */}
      <div className="w-12 h-12 bg-[#FF6B00] rounded-xl flex items-center justify-center mb-8 shadow-sm">
        <Wrench className="w-6 h-6 text-white" />
      </div>

      {/* Título principal */}
      <h1 className="text-[28px] font-bold text-[#1A1A1A] mb-3 tracking-tight leading-tight">
        Esqueceu a senha?
      </h1>
      
      {/* Subtítulo/Instrução */}
      <p className="text-[#757575] text-[15px] mb-8 leading-relaxed">
        Não se preocupe! Digite seu e-mail abaixo e enviaremos um link para você redefinir sua senha.
      </p>

      {/* Campo de Input */}
      <div className="mb-2">
        <Input 
          label="E-mail" 
          type="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
        />
      </div>

      {/* Botão Primário */}
      <Button fullWidth onClick={handleRecover} className="mt-4 shadow-[0_4px_12px_rgba(255,107,0,0.20)]">
        Enviar link de recuperação
      </Button>

      {/* Botão Secundário / Voltar */}
      <div className="mt-auto pb-8 text-center flex-1 flex flex-col justify-end">
        <p className="text-[#757575] text-[15px]">
          Lembrou a senha?{" "}
          <button 
            onClick={() => navigate("/login")}
            className="text-[#FF6B00] font-bold hover:underline"
          >
            Voltar para o login
          </button>
        </p>
      </div>
    </div>
  );
}