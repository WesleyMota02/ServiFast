import { useState } from "react";
import { useNavigate, useParams } from "react-router";
import { ArrowLeft, Image as ImageIcon, MapPin, Calendar, Clock, Wrench } from "lucide-react";
import { Button } from "../components/Button";
import { Input } from "../components/Input";

export function RequestService() {
  const navigate = useNavigate();
  const { id } = useParams();

  const [formData, setFormData] = useState({
    servico: "Pintura interna",
    descricao: "",
    endereco: "",
    data: "",
    horario: "manhã"
  });

  const handleSubmit = () => {
    navigate("/client/confirmation");
  };

  return (
    <div className="h-full w-full bg-white flex flex-col pt-12">
      <div className="px-6 flex items-center mb-6">
        <button onClick={() => navigate(-1)} className="p-2 -ml-2 rounded-full hover:bg-gray-100 transition-colors">
          <ArrowLeft className="w-6 h-6 text-[#1A1A1A]" />
        </button>
        <h1 className="text-xl font-bold ml-2 truncate">Solicitar serviço para Carlos</h1>
      </div>

      <div className="flex-1 overflow-y-auto px-6 pb-24 no-scrollbar">
        <div className="mb-6">
          <label className="block text-sm font-medium text-[#1A1A1A] mb-2">Tipo de serviço</label>
          <div className="relative">
            <select 
              value={formData.servico}
              onChange={e => setFormData({...formData, servico: e.target.value})}
              className="w-full appearance-none bg-white border-[1.5px] border-[#EEEEEE] rounded-[10px] pl-4 pr-10 py-[14px] text-sm focus:border-[#FF6B00] outline-none"
            >
              <option value="Pintura interna">Pintura interna</option>
              <option value="Pintura externa">Pintura externa</option>
              <option value="Textura e grafiato">Textura e grafiato</option>
            </select>
            <Wrench className="absolute right-4 top-1/2 -translate-y-1/2 w-5 h-5 text-[#6B6B6B] pointer-events-none" />
          </div>
        </div>

        <div className="mb-6">
          <div className="flex justify-between items-center mb-2">
            <label className="block text-sm font-medium text-[#1A1A1A]">Descrição do que precisa</label>
            <span className="text-[10px] text-[#6B6B6B]">{formData.descricao.length}/300</span>
          </div>
          <textarea 
            value={formData.descricao}
            onChange={e => setFormData({...formData, descricao: e.target.value.substring(0, 300)})}
            placeholder="Ex: Preciso pintar minha sala, são 4 paredes..."
            className="w-full bg-white border-[1.5px] border-[#EEEEEE] rounded-[10px] p-4 text-sm focus:border-[#FF6B00] outline-none min-h-[120px] resize-none"
          />
        </div>

        <div className="mb-6">
          <Input 
            label="Endereço de atendimento" 
            value={formData.endereco}
            onChange={e => setFormData({...formData, endereco: e.target.value})}
            icon={<MapPin className="w-5 h-5" />}
          />
        </div>

        <div className="flex gap-4 mb-6">
          <div className="flex-1 relative">
            <label className="block text-[12px] font-medium text-[#6B6B6B] mb-2">Data preferida</label>
            <div className="relative">
              <input 
                type="date"
                value={formData.data}
                onChange={e => setFormData({...formData, data: e.target.value})}
                className="w-full bg-white border-[1.5px] border-[#EEEEEE] rounded-[10px] px-4 py-[14px] text-sm focus:border-[#FF6B00] outline-none appearance-none"
              />
              <Calendar className="absolute right-4 top-1/2 -translate-y-1/2 w-5 h-5 text-[#6B6B6B] pointer-events-none" />
            </div>
          </div>
          
          <div className="flex-1">
            <label className="block text-[12px] font-medium text-[#6B6B6B] mb-2">Horário</label>
            <div className="relative">
              <select 
                value={formData.horario}
                onChange={e => setFormData({...formData, horario: e.target.value})}
                className="w-full appearance-none bg-white border-[1.5px] border-[#EEEEEE] rounded-[10px] pl-4 pr-10 py-[14px] text-sm focus:border-[#FF6B00] outline-none"
              >
                <option value="manhã">Manhã</option>
                <option value="tarde">Tarde</option>
                <option value="noite">Noite</option>
              </select>
              <Clock className="absolute right-4 top-1/2 -translate-y-1/2 w-5 h-5 text-[#6B6B6B] pointer-events-none" />
            </div>
          </div>
        </div>

        <div className="mb-8">
          <label className="block text-sm font-medium text-[#1A1A1A] mb-2">Foto do local/problema (opcional)</label>
          <button className="w-full border-2 border-dashed border-[#EEEEEE] rounded-[10px] py-8 flex flex-col items-center justify-center text-[#6B6B6B] hover:border-[#FF6B00] hover:bg-[#FFF3E8] transition-colors">
            <ImageIcon className="w-8 h-8 mb-2 text-[#FF6B00]" />
            <span className="text-sm font-medium">Toque para enviar foto</span>
            <span className="text-[10px]">JPG, PNG até 5MB</span>
          </button>
        </div>

        <Button fullWidth onClick={handleSubmit}>
          Enviar solicitação
        </Button>
      </div>
    </div>
  );
}
