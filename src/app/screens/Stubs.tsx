import { useNavigate } from "react-router";

export function EvaluateProfessional() {
  const navigate = useNavigate();
  return (
    <div className="p-6 text-center pt-20">
      <h1 className="text-2xl font-bold mb-4">Avaliar Profissional</h1>
      <button onClick={() => navigate(-1)} className="bg-[#FF6B00] text-white px-6 py-3 rounded-xl font-bold w-full">
        Voltar
      </button>
    </div>
  );
}

export function ProfRequests() {
  const navigate = useNavigate();
  return (
    <div className="p-6 text-center pt-20">
      <h1 className="text-2xl font-bold mb-4">Solicitações Recebidas</h1>
      <button onClick={() => navigate("/professional/request/1")} className="bg-[#FF6B00] text-white px-6 py-3 rounded-xl font-bold w-full mb-4">
        Ver Detalhe da Solicitação 1
      </button>
      <button onClick={() => navigate("/professional/home")} className="bg-gray-200 text-gray-800 px-6 py-3 rounded-xl font-bold w-full">
        Voltar para Home
      </button>
    </div>
  );
}

export function ProfRequestDetail() {
  const navigate = useNavigate();
  return (
    <div className="p-6 text-center pt-20">
      <h1 className="text-2xl font-bold mb-4">Detalhe da Solicitação</h1>
      <button onClick={() => navigate("/professional/chat/1")} className="bg-[#FF6B00] text-white px-6 py-3 rounded-xl font-bold w-full mb-4">
        Aceitar e Responder (Chat)
      </button>
      <button onClick={() => navigate(-1)} className="bg-gray-200 text-gray-800 px-6 py-3 rounded-xl font-bold w-full">
        Voltar
      </button>
    </div>
  );
}

export function ProfServices() {
  return <div className="p-6 text-center pt-20">Meus Serviços</div>;
}

export function ProfReviews() {
  return <div className="p-6 text-center pt-20">Minhas Avaliações</div>;
}

export function ProfProfilePublic() {
  return <div className="p-6 text-center pt-20">Meu Perfil Público</div>;
}

export function Notifications() {
  const navigate = useNavigate();
  return (
    <div className="p-6 text-center pt-20">
      <h1 className="text-2xl font-bold mb-4">Notificações</h1>
      <button onClick={() => navigate(-1)} className="bg-[#FF6B00] text-white px-6 py-3 rounded-xl font-bold w-full">
        Voltar
      </button>
    </div>
  );
}

export function Settings() {
  const navigate = useNavigate();
  return (
    <div className="p-6 text-center pt-20">
      <h1 className="text-2xl font-bold mb-4">Configurações</h1>
      <button onClick={() => navigate(-1)} className="bg-[#FF6B00] text-white px-6 py-3 rounded-xl font-bold w-full">
        Voltar
      </button>
    </div>
  );
}

export function ErrorScreen() {
  return <div className="p-6 text-center pt-20 text-red-500 font-bold">Erro / 404</div>;
}
