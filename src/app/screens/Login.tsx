import { useState } from "react";
import { useNavigate } from "react-router";
import { Eye, EyeOff, Wrench } from "lucide-react";
import { Button } from "../components/Button";
import { Input } from "../components/Input";

export function Login() {
  const navigate = useNavigate();
  const [showPassword, setShowPassword] = useState(false);
  const [formData, setFormData] = useState({ email: "", senha: "" });

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleLogin = () => {
    // Basic mock login routing
    if (formData.email.includes("prof")) {
      navigate("/professional/home");
    } else {
      navigate("/client/home");
    }
  };

  return (
    <div className="h-full w-full bg-white flex flex-col pt-16 px-6 relative">
      <div className="w-12 h-12 bg-[#FF6B00] rounded-xl flex items-center justify-center mb-8 shadow-md">
        <Wrench className="w-6 h-6 text-white" />
      </div>

      <h1 className="text-3xl font-bold text-[#1A1A1A] mb-2 font-poppins tracking-tight">
        Bem-vindo de volta!
      </h1>
      <p className="text-[#6B6B6B] mb-8">Faça login para continuar no ServiFast.</p>

      <Input 
        label="E-mail" 
        name="email"
        type="email"
        value={formData.email}
        onChange={handleChange}
      />

      <div className="relative w-full">
        <Input 
          label="Senha" 
          name="senha"
          type={showPassword ? "text" : "password"}
          value={formData.senha}
          onChange={handleChange}
        />
        <button 
          type="button"
          onClick={() => setShowPassword(!showPassword)}
          className="absolute right-4 top-[14px] text-[#6B6B6B] z-10 p-1"
        >
          {showPassword ? <EyeOff className="w-5 h-5" /> : <Eye className="w-5 h-5" />}
        </button>
      </div>

      <div className="flex justify-end mb-8 -mt-2">
        <button 
          onClick={() => navigate("/recover-password")}
          className="text-[#FF6B00] text-sm font-semibold hover:underline"
        >
          Esqueci minha senha
        </button>
      </div>

      <Button fullWidth onClick={handleLogin} className="mb-6">
        Entrar
      </Button>

      <div className="flex items-center gap-4 mb-6">
        <div className="flex-1 h-[1px] bg-[#EEEEEE]" />
        <span className="text-[#6B6B6B] text-sm font-medium">ou</span>
        <div className="flex-1 h-[1px] bg-[#EEEEEE]" />
      </div>

      <Button 
        variant="outline" 
        fullWidth 
        className="flex gap-3 text-[#1A1A1A] border-[#EEEEEE] font-medium"
      >
        <svg viewBox="0 0 24 24" className="w-5 h-5">
          <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/>
          <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
          <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"/>
          <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/>
        </svg>
        Entrar com Google
      </Button>

      <p className="text-center text-[#6B6B6B] text-[14px] mt-auto pb-8">
        Não tem conta? <span className="text-[#FF6B00] font-bold cursor-pointer" onClick={() => navigate("/choose-profile")}>Cadastre-se</span>
      </p>
    </div>
  );
}
