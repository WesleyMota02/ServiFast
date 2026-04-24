import React, { useState, useEffect } from "react";
import { useNavigate, Link } from "react-router";
import { 
  ArrowLeft, 
  Eye, 
  EyeOff, 
  Check, 
  Camera, 
  Search, 
  MapPin, 
  Plus, 
  X, 
  FileText,
  User,
  IdCard,
  Phone,
  Mail,
  Lock
} from "lucide-react";
import confetti from "canvas-confetti";
import { toast } from "sonner";

import { ImageWithFallback } from "../components/figma/ImageWithFallback";

export function RegisterProfessional() {
  const navigate = useNavigate();
  const [step, setStep] = useState(1);
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);

  // Form Data
  const [formData, setFormData] = useState({
    // Step 1
    nome: "",
    cpf: "",
    telefone: "",
    email: "",
    senha: "",
    confirmarSenha: "",
    // Step 2
    categoria: "",
    servicos: [] as string[],
    descricao: "",
    preco: "",
    tipoCobranca: "Diária",
    // Step 3
    cep: "",
    cidade: "",
    estado: "",
    bairro: "",
    raio: 15,
    bairrosAtendidos: [] as string[],
    // Step 4
    foto: "",
    documento: "",
    termos: false,
  });

  // Validation States
  const [errors, setErrors] = useState<Record<string, string>>({});

  const categorias = [
    "Elétrico", "Hidráulico / Encanamento", "Pintura", "Pedreiro / Alvenaria", 
    "Marcenaria / Móveis", "Jardinagem", "Limpeza", "Reformas em Geral", 
    "Ar-condicionado", "Outros"
  ];

  const servicosPorCategoria: Record<string, string[]> = {
    "Pintura": ["Pintura interna", "Pintura ext.", "Textura", "Grafiato", "Pintura metal", "Verniz"],
    "Elétrico": ["Instalação elétrica", "Manutenção", "Troca de fiação", "Quadro de luz", "Luminárias"],
    // Fallback
    "default": ["Serviço Geral 1", "Serviço Geral 2", "Serviço Geral 3"]
  };

  const getServicosList = () => {
    return servicosPorCategoria[formData.categoria] || servicosPorCategoria["default"];
  };

  const updateForm = (field: string, value: any) => {
    setFormData(prev => ({ ...prev, [field]: value }));
    // Clear error when typing
    if (errors[field]) {
      setErrors(prev => {
        const newErrs = { ...prev };
        delete newErrs[field];
        return newErrs;
      });
    }
  };

  const calcularForcaSenha = (senha: string) => {
    if (!senha) return { score: 0, label: "", color: "bg-gray-200" };
    if (senha.length < 6) return { score: 25, label: "Fraca", color: "bg-[#E74C3C]" };
    if (senha.length >= 8 && /[A-Z]/.test(senha) && /[0-9]/.test(senha)) return { score: 100, label: "Forte", color: "bg-[#27AE60]" };
    return { score: 60, label: "Média", color: "bg-[#FF6B00]" };
  };

  const forcaSenha = calcularForcaSenha(formData.senha);

  const validateStep1 = () => {
    const newErrs: Record<string, string> = {};
    if (!formData.nome || formData.nome.split(" ").length < 2) newErrs.nome = "Mínimo 2 palavras";
    if (!formData.cpf || formData.cpf.length < 11) newErrs.cpf = "CPF inválido";
    if (!formData.telefone) newErrs.telefone = "Este campo é obrigatório";
    if (!formData.email || !formData.email.includes("@")) newErrs.email = "Digite um e-mail válido";
    if (!formData.senha || formData.senha.length < 8) newErrs.senha = "Mínimo 8 caracteres";
    if (formData.senha !== formData.confirmarSenha) newErrs.confirmarSenha = "As senhas não coincidem";

    setErrors(newErrs);
    return Object.keys(newErrs).length === 0;
  };

  const validateStep2 = () => {
    const newErrs: Record<string, string> = {};
    if (!formData.categoria) newErrs.categoria = "Este campo é obrigatório";
    if (formData.servicos.length === 0) {
      toast.error("Selecione pelo menos 1 serviço", { style: { backgroundColor: "#FF6B00", color: "#fff", border: "none" }});
      return false;
    }
    if (!formData.descricao) newErrs.descricao = "Este campo é obrigatório";
    if (!formData.preco) newErrs.preco = "Este campo é obrigatório";
    
    setErrors(newErrs);
    return Object.keys(newErrs).length === 0;
  };

  const validateStep3 = () => {
    const newErrs: Record<string, string> = {};
    if (!formData.cep) newErrs.cep = "Este campo é obrigatório";
    if (!formData.bairro) newErrs.bairro = "Este campo é obrigatório";
    
    setErrors(newErrs);
    return Object.keys(newErrs).length === 0;
  };

  const handleNext = () => {
    if (step === 1 && !validateStep1()) return;
    if (step === 2 && !validateStep2()) return;
    if (step === 3 && !validateStep3()) return;
    
    window.scrollTo(0, 0);
    setStep(prev => prev + 1);
  };

  const handleBack = () => {
    if (step > 1) {
      setStep(prev => prev - 1);
      window.scrollTo(0, 0);
    } else {
      navigate(-1);
    }
  };

  const handleFinish = () => {
    if (!formData.termos) {
      toast.error("Você precisa aceitar os termos");
      return;
    }
    window.scrollTo(0, 0);
    setStep(5);
  };

  useEffect(() => {
    if (step === 5) {
      const duration = 3000;
      const end = Date.now() + duration;

      const frame = () => {
        confetti({
          particleCount: 5,
          angle: 60,
          spread: 55,
          origin: { x: 0 },
          colors: ['#FF6B00', '#FFA466', '#FFFFFF']
        });
        confetti({
          particleCount: 5,
          angle: 120,
          spread: 55,
          origin: { x: 1 },
          colors: ['#FF6B00', '#FFA466', '#FFFFFF']
        });

        if (Date.now() < end) {
          requestAnimationFrame(frame);
        }
      };
      frame();
    }
  }, [step]);

  const toggleServico = (serv: string) => {
    setFormData(prev => {
      const isSelected = prev.servicos.includes(serv);
      if (isSelected) {
        return { ...prev, servicos: prev.servicos.filter(s => s !== serv) };
      } else {
        return { ...prev, servicos: [...prev.servicos, serv] };
      }
    });
  };

  const [novoBairro, setNovoBairro] = useState("");
  const addBairro = () => {
    if (novoBairro.trim() && !formData.bairrosAtendidos.includes(novoBairro.trim())) {
      setFormData(prev => ({ ...prev, bairrosAtendidos: [...prev.bairrosAtendidos, novoBairro.trim()] }));
      setNovoBairro("");
    }
  };
  const removeBairro = (bairro: string) => {
    setFormData(prev => ({ ...prev, bairrosAtendidos: prev.bairrosAtendidos.filter(b => b !== bairro) }));
  };

  const handleCepSearch = () => {
    if (formData.cep.length >= 8) {
      updateForm("cidade", "Mauá");
      updateForm("estado", "SP");
    }
  };

  if (step === 5) {
    return (
      <div className="min-h-screen bg-white flex flex-col items-center justify-center p-6 text-center">
        <div className="w-24 h-24 bg-[#FFF3E8] rounded-full flex items-center justify-center mb-6">
          <span className="text-4xl">🎉</span>
        </div>
        <h1 className="text-2xl font-bold text-[#1A1A1A] mb-2 font-[Poppins]">Cadastro realizado!</h1>
        <p className="text-[#1A1A1A] text-lg mb-4">Bem-vindo ao ServiFast, {formData.nome.split(" ")[0] || "Profissional"}!</p>
        <p className="text-[#6B6B6B] text-[15px] mb-8">
          Seu perfil já está visível para clientes da sua região.
        </p>

        <div className="w-full max-w-sm bg-[#F9F9F9] border border-[#EEEEEE] rounded-2xl p-6 text-left mb-8 shadow-[0_2px_8px_rgba(0,0,0,0.06)]">
          <div className="space-y-4">
            <div className="flex items-center gap-3"><div className="w-6 h-6 rounded-full bg-[#27AE60] text-white flex items-center justify-center"><Check size={14} /></div> <span className="text-[#1A1A1A]">Dados pessoais</span></div>
            <div className="flex items-center gap-3"><div className="w-6 h-6 rounded-full bg-[#27AE60] text-white flex items-center justify-center"><Check size={14} /></div> <span className="text-[#1A1A1A]">Serviços cadastrados</span></div>
            <div className="flex items-center gap-3"><div className="w-6 h-6 rounded-full bg-[#27AE60] text-white flex items-center justify-center"><Check size={14} /></div> <span className="text-[#1A1A1A]">Localização definida</span></div>
            <div className="flex items-center gap-3"><div className="w-6 h-6 rounded-full bg-[#27AE60] text-white flex items-center justify-center"><Check size={14} /></div> <span className="text-[#1A1A1A]">Foto adicionada</span></div>
          </div>
        </div>

        <button 
          onClick={() => navigate("/professional/home")}
          className="w-full max-w-sm bg-[#FF6B00] text-white font-bold py-4 rounded-xl shadow-[0_4px_12px_rgba(255,107,0,0.30)] transition-transform active:scale-95 mb-4"
        >
          Ir para minha Home →
        </button>
        <button className="text-[#6B6B6B] font-medium" onClick={() => navigate("/professional/profile")}>
          Completar perfil depois
        </button>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-white pb-24 font-[Poppins]">
      {/* Header */}
      <div className="px-6 pt-12 pb-4 flex items-center justify-between bg-white sticky top-0 z-10">
        <button onClick={handleBack} className="p-2 -ml-2 text-[#1A1A1A]">
          <ArrowLeft size={24} />
        </button>
      </div>

      {/* Stepper */}
      <div className="px-6 mb-8">
        <div className="flex items-center justify-between relative">
          <div className="absolute top-4 left-0 w-full h-[2px] bg-[#EEEEEE] -z-10"></div>
          
          {/* Line fill */}
          <div 
            className="absolute top-4 left-0 h-[2px] bg-[#FF6B00] -z-10 transition-all duration-300"
            style={{ width: `${((step - 1) / 3) * 100}%` }}
          ></div>

          {[
            { id: 1, label: "Dados" },
            { id: 2, label: "Serv." },
            { id: 3, label: "Local" },
            { id: 4, label: "Foto" },
          ].map((s) => (
            <div key={s.id} className="flex flex-col items-center gap-2 bg-white px-1 cursor-pointer" onClick={() => { if(s.id < step) setStep(s.id) }}>
              <div className={`w-8 h-8 rounded-full flex items-center justify-center text-sm font-medium transition-colors ${
                step > s.id 
                  ? "bg-[#FF6B00] text-white" 
                  : step === s.id 
                    ? "bg-[#FF6B00] text-white ring-4 ring-[#FFF3E8]" 
                    : "bg-white border-2 border-[#EEEEEE] text-[#AAAAAA]"
              }`}>
                {step > s.id ? <Check size={16} /> : s.id}
              </div>
              <span className={`text-[11px] font-medium ${step >= s.id ? "text-[#FF6B00]" : "text-[#AAAAAA]"}`}>
                {s.label}
              </span>
            </div>
          ))}
        </div>
      </div>

      <div className="px-6">
        {step === 1 && (
          <div className="animate-in fade-in slide-in-from-right-4 duration-300">
            <h1 className="text-[22px] font-bold text-[#1A1A1A] mb-1">Cadastro Profissional</h1>
            <p className="text-[14px] text-[#6B6B6B] mb-8">Etapa 1: Dados pessoais</p>

            <div className="space-y-4">
              <FloatingInput 
                icon={<User size={20} />} label="Nome completo" value={formData.nome}
                onChange={(e) => updateForm("nome", e.target.value)} error={errors.nome}
              />
              <FloatingInput 
                icon={<IdCard size={20} />} label="CPF" value={formData.cpf}
                onChange={(e) => updateForm("cpf", e.target.value)} error={errors.cpf}
              />
              <FloatingInput 
                icon={<Phone size={20} />} label="Telefone / WhatsApp" value={formData.telefone} type="tel"
                onChange={(e) => updateForm("telefone", e.target.value)} error={errors.telefone}
              />
              <FloatingInput 
                icon={<Mail size={20} />} label="E-mail" value={formData.email} type="email"
                onChange={(e) => updateForm("email", e.target.value)} error={errors.email}
              />
              
              <FloatingInput 
                icon={<Lock size={20} />} label="Senha" value={formData.senha} type={showPassword ? "text" : "password"}
                onChange={(e) => updateForm("senha", e.target.value)} error={errors.senha}
                rightElement={
                  <button 
                    type="button" onClick={() => setShowPassword(!showPassword)}
                    className="ml-2 text-[#6B6B6B] z-10"
                  >
                    {showPassword ? <EyeOff size={20} /> : <Eye size={20} />}
                  </button>
                }
              />

              <FloatingInput 
                icon={<Lock size={20} />} label="Confirmar senha" value={formData.confirmarSenha} type={showConfirmPassword ? "text" : "password"}
                onChange={(e) => updateForm("confirmarSenha", e.target.value)} error={errors.confirmarSenha}
                rightElement={
                  <button 
                    type="button" onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                    className="ml-2 text-[#6B6B6B] z-10"
                  >
                    {showConfirmPassword ? <EyeOff size={20} /> : <Eye size={20} />}
                  </button>
                }
              />

              {formData.senha && (
                <div className="mt-4 pt-4 border-t border-[#EEEEEE]">
                  <p className="text-[13px] text-[#6B6B6B] mb-2 flex justify-between">
                    <span>Indicador de força da senha:</span>
                    <span className="font-bold" style={{color: forcaSenha.color === 'bg-[#E74C3C]' ? '#E74C3C' : forcaSenha.color === 'bg-[#FF6B00]' ? '#FF6B00' : '#27AE60'}}>{forcaSenha.label}</span>
                  </p>
                  <div className="h-2 w-full bg-[#EEEEEE] rounded-full overflow-hidden flex">
                    <div className={`h-full transition-all duration-300 ${forcaSenha.color}`} style={{ width: `${forcaSenha.score}%` }}></div>
                  </div>
                </div>
              )}

              <button onClick={handleNext} className="w-full bg-[#FF6B00] text-white font-bold py-4 rounded-xl shadow-[0_4px_12px_rgba(255,107,0,0.30)] mt-8 active:scale-95 transition-transform">
                Próximo →
              </button>

              <p className="text-center text-[14px] text-[#6B6B6B] mt-6">
                Já tem conta? <Link to="/login" className="text-[#FF6B00] font-bold">Entrar</Link>
              </p>
            </div>
          </div>
        )}

        {step === 2 && (
          <div className="animate-in fade-in slide-in-from-right-4 duration-300">
            <h1 className="text-[22px] font-bold text-[#1A1A1A] mb-1">Seus serviços</h1>
            <p className="text-[14px] text-[#6B6B6B] mb-8">Etapa 2: O que você oferece?</p>

            <div className="space-y-6">
              <div>
                <label className="block text-[13px] font-medium text-[#1A1A1A] mb-2">Categoria principal *</label>
                <div className="relative">
                  <select 
                    className={`w-full appearance-none border-1.5 ${errors.categoria ? 'border-[#E74C3C]' : 'border-[#EEEEEE]'} rounded-xl px-4 py-4 text-[15px] bg-white text-[#1A1A1A] focus:outline-none focus:border-[#FF6B00] transition-colors`}
                    value={formData.categoria}
                    onChange={(e) => updateForm("categoria", e.target.value)}
                  >
                    <option value="" disabled>Selecione uma categoria</option>
                    {categorias.map(c => <option key={c} value={c}>{c}</option>)}
                  </select>
                  <div className="absolute right-4 top-1/2 -translate-y-1/2 pointer-events-none text-[#6B6B6B]">▼</div>
                </div>
                {errors.categoria && <span className="text-[#E74C3C] text-[12px] mt-1 block">{errors.categoria}</span>}
              </div>

              {formData.categoria && (
                <div className="animate-in fade-in duration-300">
                  <label className="block text-[13px] font-medium text-[#1A1A1A] mb-1">Serviços específicos *</label>
                  <p className="text-[13px] text-[#6B6B6B] mb-3">Selecione todos que se aplicam:</p>
                  
                  <div className="flex flex-wrap gap-2">
                    {getServicosList().map((serv) => {
                      const isSelected = formData.servicos.includes(serv);
                      return (
                        <button
                          key={serv}
                          onClick={() => toggleServico(serv)}
                          className={`px-4 py-2 rounded-full text-[13px] font-medium transition-all active:scale-95 border ${
                            isSelected 
                              ? "bg-[#FF6B00] text-white border-[#FF6B00]" 
                              : "bg-white text-[#6B6B6B] border-[#EEEEEE]"
                          }`}
                        >
                          {isSelected && <span className="mr-1">✓</span>}
                          {!isSelected && <span className="mr-1">○</span>}
                          {serv}
                        </button>
                      );
                    })}
                  </div>
                </div>
              )}

              <div>
                <label className="block text-[13px] font-medium text-[#1A1A1A] mb-2">Descrição dos seus serviços *</label>
                <textarea 
                  className={`w-full border-1.5 ${errors.descricao ? 'border-[#E74C3C]' : 'border-[#EEEEEE]'} rounded-xl p-4 text-[15px] bg-white focus:outline-none focus:border-[#FF6B00] transition-colors resize-none`}
                  rows={4}
                  placeholder='Ex: "Sou pintor há 10 anos, especialista em acabamento fino..."'
                  value={formData.descricao}
                  onChange={(e) => updateForm("descricao", e.target.value)}
                  maxLength={300}
                />
                <div className="flex justify-between mt-1">
                  {errors.descricao ? (
                    <span className="text-[#E74C3C] text-[12px]">{errors.descricao}</span>
                  ) : <span></span>}
                  <span className="text-[12px] text-[#6B6B6B]">{formData.descricao.length}/300 car.</span>
                </div>
              </div>

              <div>
                <label className="block text-[13px] font-medium text-[#1A1A1A] mb-2">Preço médio cobrado *</label>
                <div className="flex items-center gap-3">
                  <div className="relative flex-1">
                    <span className="absolute left-4 top-1/2 -translate-y-1/2 text-[#6B6B6B] font-medium">R$</span>
                    <input 
                      type="number" 
                      className={`w-full border-1.5 ${errors.preco ? 'border-[#E74C3C]' : 'border-[#EEEEEE]'} rounded-xl pl-10 pr-4 py-3 text-[15px] bg-white focus:outline-none focus:border-[#FF6B00] transition-colors`}
                      placeholder="0,00"
                      value={formData.preco}
                      onChange={(e) => updateForm("preco", e.target.value)}
                    />
                  </div>
                </div>
                {errors.preco && <span className="text-[#E74C3C] text-[12px] mt-1 block">{errors.preco}</span>}
                
                <div className="flex items-center gap-4 mt-4">
                  <span className="text-[13px] text-[#6B6B6B]">Cobro por:</span>
                  {["Hora", "Diária", "Serv."].map(tipo => (
                    <label key={tipo} className="flex items-center gap-2 cursor-pointer">
                      <div className={`w-4 h-4 rounded-full border-2 flex items-center justify-center ${formData.tipoCobranca === tipo ? "border-[#FF6B00]" : "border-[#EEEEEE]"}`}>
                        {formData.tipoCobranca === tipo && <div className="w-2 h-2 rounded-full bg-[#FF6B00]"></div>}
                      </div>
                      <span className="text-[14px] text-[#1A1A1A]">{tipo}</span>
                      <input 
                        type="radio" className="hidden" 
                        checked={formData.tipoCobranca === tipo}
                        onChange={() => updateForm("tipoCobranca", tipo)}
                      />
                    </label>
                  ))}
                </div>
              </div>

              <button onClick={handleNext} className="w-full bg-[#FF6B00] text-white font-bold py-4 rounded-xl shadow-[0_4px_12px_rgba(255,107,0,0.30)] mt-8 active:scale-95 transition-transform">
                Próximo →
              </button>
            </div>
          </div>
        )}

        {step === 3 && (
          <div className="animate-in fade-in slide-in-from-right-4 duration-300">
            <h1 className="text-[22px] font-bold text-[#1A1A1A] mb-1">Onde você atua?</h1>
            <p className="text-[14px] text-[#6B6B6B] mb-8">Etapa 3: Localização e raio</p>

            <div className="space-y-6">
              <FloatingInput 
                icon={<MapPin size={20} />} label="CEP" value={formData.cep}
                onChange={(e) => updateForm("cep", e.target.value)} error={errors.cep}
                rightElement={
                  <button onClick={handleCepSearch} className="ml-2 text-[#FF6B00]">
                    <Search size={20} />
                  </button>
                }
              />

              {(formData.cidade || formData.estado) && (
                <div className="flex gap-4 animate-in fade-in">
                  <div className="flex-1">
                    <div className="border border-[#EEEEEE] bg-[#F9F9F9] rounded-xl px-4 py-3 relative pl-10">
                      <MapPin size={16} className="absolute left-4 top-1/2 -translate-y-1/2 text-[#9E9E9E]" />
                      <span className="text-[11px] text-[#6B6B6B] block">Cidade</span>
                      <span className="text-[14px] font-medium text-[#1A1A1A]">{formData.cidade}</span>
                    </div>
                  </div>
                  <div className="w-24">
                    <div className="border border-[#EEEEEE] bg-[#F9F9F9] rounded-xl px-4 py-3 relative">
                      <span className="text-[11px] text-[#6B6B6B] block">Estado</span>
                      <span className="text-[14px] font-medium text-[#1A1A1A]">{formData.estado}</span>
                    </div>
                  </div>
                </div>
              )}

              <FloatingInput 
                icon={<MapPin size={20} />} label="Bairro principal" value={formData.bairro}
                onChange={(e) => updateForm("bairro", e.target.value)} error={errors.bairro}
              />

              <div className="pt-4">
                <label className="block text-[13px] font-medium text-[#1A1A1A] mb-1">Raio de atendimento *</label>
                <p className="text-[13px] text-[#6B6B6B] mb-4">Até quantos km você se desloca?</p>
                
                <div className="px-2 pb-6 pt-2 relative">
                  <input 
                    type="range" min="1" max="50" 
                    className="w-full h-1 bg-[#EEEEEE] rounded-lg appearance-none cursor-pointer accent-[#FF6B00]"
                    style={{ background: `linear-gradient(to right, #FF6B00 ${(formData.raio / 50) * 100}%, #EEEEEE ${(formData.raio / 50) * 100}%)` }}
                    value={formData.raio}
                    onChange={(e) => updateForm("raio", parseInt(e.target.value))}
                  />
                  <div className="flex justify-between text-[12px] text-[#6B6B6B] mt-2">
                    <span>1 km</span>
                    <span>50 km</span>
                  </div>
                  <div className="text-center mt-2 font-bold text-[#FF6B00]">
                    Selecionado: {formData.raio} km
                  </div>
                </div>
              </div>

              <div>
                <label className="block text-[13px] font-medium text-[#1A1A1A] mb-2">Você atende em quais bairros?</label>
                <div className="flex gap-2 mb-3">
                  <input 
                    type="text" 
                    className="flex-1 border-1.5 border-[#EEEEEE] rounded-xl px-4 py-3 text-[14px] focus:outline-none focus:border-[#FF6B00]"
                    placeholder="Adicionar bairro"
                    value={novoBairro}
                    onChange={(e) => setNovoBairro(e.target.value)}
                    onKeyDown={(e) => e.key === "Enter" && addBairro()}
                  />
                  <button onClick={addBairro} className="bg-[#FFF3E8] text-[#FF6B00] px-4 rounded-xl flex items-center justify-center">
                    <Plus size={20} />
                  </button>
                </div>
                
                {formData.bairrosAtendidos.length > 0 && (
                  <div className="flex flex-wrap gap-2">
                    {formData.bairrosAtendidos.map(b => (
                      <div key={b} className="flex items-center gap-1 bg-[#F9F9F9] border border-[#EEEEEE] px-3 py-1.5 rounded-full text-[13px] text-[#1A1A1A]">
                        {b}
                        <button onClick={() => removeBairro(b)} className="text-[#6B6B6B] ml-1 hover:text-[#E74C3C]">
                          <X size={14} />
                        </button>
                      </div>
                    ))}
                  </div>
                )}
              </div>

              <button onClick={handleNext} className="w-full bg-[#FF6B00] text-white font-bold py-4 rounded-xl shadow-[0_4px_12px_rgba(255,107,0,0.30)] mt-8 active:scale-95 transition-transform">
                Próximo →
              </button>
            </div>
          </div>
        )}

        {step === 4 && (
          <div className="animate-in fade-in slide-in-from-right-4 duration-300">
            <h1 className="text-[22px] font-bold text-[#1A1A1A] mb-1">Quase lá! 🎉</h1>
            <p className="text-[14px] text-[#6B6B6B] mb-8">Etapa 4: Foto do perfil</p>

            <div className="space-y-8">
              
              <div className="flex flex-col items-center">
                <label className="self-start text-[13px] font-medium text-[#1A1A1A] mb-4">Sua foto de perfil *</label>
                <div className="w-[120px] h-[120px] rounded-full border-2 border-dashed border-[#FF6B00] bg-[#FFF3E8] flex flex-col items-center justify-center cursor-pointer mb-3 relative overflow-hidden" onClick={() => updateForm("foto", "sim")}>
                  {formData.foto ? (
                    <ImageWithFallback src="https://images.unsplash.com/photo-1540569014015-19a7be504e3a?q=80&w=250&auto=format&fit=crop" alt="Perfil" className="w-full h-full object-cover" />
                  ) : (
                    <>
                      <Camera className="text-[#FF6B00] mb-1" size={32} />
                      <span className="text-[#FF6B00] text-[12px] font-medium text-center leading-tight">Adicionar<br/>foto</span>
                    </>
                  )}
                </div>
                <p className="text-[13px] text-[#6B6B6B] text-center w-[200px]">Toque para tirar foto ou escolher da galeria</p>
              </div>

              <div className="h-px bg-[#EEEEEE] w-full"></div>

              <div className="flex flex-col items-center">
                <div className="self-start mb-4">
                  <label className="block text-[13px] font-medium text-[#1A1A1A] mb-1">Documento de verificação (opcional)</label>
                  <p className="text-[12px] text-[#6B6B6B] leading-tight pr-4">Aumenta sua credibilidade e gera o badge <span className="text-[#27AE60] font-medium inline-flex items-center gap-0.5"><Check size={12}/> Verificado</span> no seu perfil</p>
                </div>
                <div className="w-[100px] h-[100px] rounded-2xl border-2 border-dashed border-[#AAAAAA] bg-[#F9F9F9] flex flex-col items-center justify-center cursor-pointer mb-3 relative overflow-hidden" onClick={() => updateForm("documento", "sim")}>
                  {formData.documento ? (
                    <div className="w-full h-full bg-[#E5F7ED] flex items-center justify-center">
                      <Check className="text-[#27AE60]" size={32} />
                    </div>
                  ) : (
                    <>
                      <FileText className="text-[#AAAAAA] mb-1" size={24} />
                      <span className="text-[#AAAAAA] text-[11px] font-medium text-center leading-tight px-2">Enviar foto segurando doc.</span>
                    </>
                  )}
                </div>
              </div>

              <div className="h-px bg-[#EEEEEE] w-full"></div>

              <div className="flex items-start gap-3 mt-6">
                <button 
                  className={`w-6 h-6 rounded flex items-center justify-center border-2 shrink-0 transition-colors ${formData.termos ? "bg-[#FF6B00] border-[#FF6B00]" : "border-[#AAAAAA]"}`}
                  onClick={() => updateForm("termos", !formData.termos)}
                >
                  {formData.termos && <Check size={16} className="text-white" />}
                </button>
                <p className="text-[13px] text-[#6B6B6B] pt-0.5 leading-tight">
                  Aceito os <span className="text-[#FF6B00] font-medium underline">Termos de Uso</span> e a <span className="text-[#FF6B00] font-medium underline">Política de Privacidade</span>
                </p>
              </div>

              <button 
                onClick={handleFinish} 
                disabled={!formData.termos}
                className={`w-full flex items-center justify-center gap-2 font-bold py-4 rounded-xl shadow-[0_4px_12px_rgba(255,107,0,0.30)] mt-8 transition-transform ${formData.termos ? "bg-[#FF6B00] text-white active:scale-95" : "bg-[#EEEEEE] text-[#AAAAAA] opacity-70 cursor-not-allowed shadow-none"}`}
              >
                {formData.termos && <Check size={20} />}
                Criar minha conta
              </button>
            </div>
          </div>
        )}

      </div>
    </div>
  );
}

// Reusable Input Component
function FloatingInput({ 
  icon, 
  label, 
  value, 
  onChange, 
  type = "text",
  error,
  rightElement 
}: { 
  icon?: React.ReactNode, 
  label: string, 
  value: string, 
  onChange: (e: any) => void,
  type?: string,
  error?: string,
  rightElement?: React.ReactNode
}) {
  const [isFocused, setIsFocused] = useState(false);
  const isActive = isFocused || value.length > 0;
  const isValid = !error && value.length > 0;

  const getIconColor = () => {
    if (error) return "text-[#E74C3C]";
    if (isValid) return "text-[#27AE60]";
    if (isFocused) return "text-[#FF6B00]";
    return "text-[#9E9E9E]";
  };

  return (
    <div className="w-full">
      <div 
        className={`relative w-full rounded-xl border-[1.5px] transition-colors flex items-center px-4 h-14 bg-white ${
          error ? "border-[#E74C3C]" : isFocused ? "border-[#FF6B00]" : "border-[#EEEEEE]"
        } ${isValid ? "border-[#27AE60]" : ""}`}
      >
        {icon && <span className={`mr-3 transition-colors ${getIconColor()} flex items-center justify-center`}>{icon}</span>}
        
        <div className="relative flex-1 h-full flex flex-col justify-center">
          <label 
            className={`absolute left-0 transition-all duration-200 pointer-events-none ${
              isActive 
                ? "-top-4 text-[11px] text-[#FF6B00] bg-white px-1 font-medium" 
                : "top-1/2 -translate-y-1/2 text-[15px] text-[#6B6B6B]"
            } ${isValid ? "!text-[#27AE60]" : ""} ${error ? "!text-[#E74C3C]" : ""}`}
          >
            {label}
          </label>
          <input 
            type={type}
            value={value}
            onChange={onChange}
            onFocus={() => setIsFocused(true)}
            onBlur={() => setIsFocused(false)}
            className="w-full text-[15px] text-[#1A1A1A] outline-none bg-transparent h-full pt-2 pr-2"
          />
        </div>

        {rightElement}

        {error && !rightElement && (
          <span className="text-[#E74C3C] ml-2 shrink-0"><X size={18} strokeWidth={3} /></span>
        )}
        {isValid && !rightElement && (
          <span className="text-[#27AE60] ml-2 shrink-0"><Check size={18} strokeWidth={3} /></span>
        )}
      </div>
      {error && <span className="text-[#E74C3C] text-[12px] mt-1 ml-1 block font-medium">{error}</span>}
    </div>
  );
}