import { useState, useRef, useEffect } from "react";
import { useNavigate, useParams } from "react-router";
import { ArrowLeft, Paperclip, Send, MoreVertical, Phone } from "lucide-react";

export function Chat() {
  const navigate = useNavigate();
  const { id } = useParams();
  const messagesEndRef = useRef<HTMLDivElement>(null);

  const [messages, setMessages] = useState([
    { id: 1, text: "Olá Carlos! Tudo bem?", sender: "me", time: "10:30" },
    { id: 2, text: "Tudo ótimo, João! Como posso ajudar?", sender: "other", time: "10:32" },
    { id: 3, text: "Vi que você faz pintura. Qual o valor médio para pintar 2 quartos?", sender: "me", time: "10:35" },
    { id: 4, text: "O valor varia, mas em média fica R$400 os dois quartos, considerando o preparo. Quando precisa?", sender: "other", time: "10:40" },
  ]);

  const [input, setInput] = useState("");

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  useEffect(() => {
    scrollToBottom();
  }, [messages]);

  const handleSend = () => {
    if (!input.trim()) return;
    
    const newMessage = {
      id: Date.now(),
      text: input,
      sender: "me",
      time: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
    };
    
    setMessages([...messages, newMessage]);
    setInput("");
  };

  return (
    <div className="h-full w-full bg-[#F9F9F9] flex flex-col">
      <div className="px-4 py-4 pt-12 bg-white flex items-center justify-between shadow-sm z-10">
        <div className="flex items-center gap-3">
          <button onClick={() => navigate(-1)} className="p-2 -ml-2 rounded-full hover:bg-gray-100 transition-colors">
            <ArrowLeft className="w-6 h-6 text-[#1A1A1A]" />
          </button>
          
          <div className="flex items-center gap-3 cursor-pointer" onClick={() => navigate(`/client/professional/${id}`)}>
            <div className="relative">
              <img src="https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=100&h=100&auto=format&fit=crop" className="w-10 h-10 rounded-full object-cover" />
              <div className="absolute -bottom-0.5 -right-0.5 w-3 h-3 bg-[#27AE60] border-[1.5px] border-white rounded-full"></div>
            </div>
            <div>
              <h2 className="font-bold text-[#1A1A1A] text-[15px] leading-tight">Carlos Silva</h2>
              <span className="text-[12px] text-[#6B6B6B] flex items-center gap-1">
                Online
              </span>
            </div>
          </div>
        </div>

        <div className="flex items-center gap-1">
          <button className="p-2 rounded-full hover:bg-gray-100 text-[#1A1A1A]">
            <Phone className="w-5 h-5" />
          </button>
          <button className="p-2 rounded-full hover:bg-gray-100 text-[#1A1A1A]">
            <MoreVertical className="w-5 h-5" />
          </button>
        </div>
      </div>

      <div className="flex-1 overflow-y-auto px-4 py-6 no-scrollbar flex flex-col gap-4">
        {messages.map((msg) => (
          <div key={msg.id} className={`flex flex-col max-w-[80%] ${msg.sender === 'me' ? 'self-end items-end' : 'self-start items-start'}`}>
            <div 
              className={`p-3 px-4 rounded-[18px] text-[14px] leading-snug ${
                msg.sender === 'me' 
                  ? 'bg-[#FF6B00] text-white rounded-br-[4px]' 
                  : 'bg-white border border-[#EEEEEE] text-[#1A1A1A] rounded-bl-[4px]'
              }`}
            >
              {msg.text}
            </div>
            <span className="text-[10px] text-[#6B6B6B] mt-1 px-1">
              {msg.time} {msg.sender === 'me' && <span className="text-[#3498DB] ml-1">✓✓</span>}
            </span>
          </div>
        ))}
        <div ref={messagesEndRef} />
      </div>

      <div className="px-4 py-3 pb-8 bg-white border-t border-[#EEEEEE] flex items-center gap-3">
        <button className="p-2 text-[#6B6B6B] hover:text-[#FF6B00] transition-colors rounded-full hover:bg-[#FFF3E8]">
          <Paperclip className="w-5 h-5" />
        </button>
        
        <input 
          type="text"
          value={input}
          onChange={(e) => setInput(e.target.value)}
          onKeyDown={(e) => e.key === 'Enter' && handleSend()}
          placeholder="Mensagem..."
          className="flex-1 bg-[#F9F9F9] border border-[#EEEEEE] text-[#1A1A1A] text-sm rounded-full px-4 py-[10px] outline-none focus:border-[#FF6B00] transition-colors"
        />
        
        <button 
          onClick={handleSend}
          disabled={!input.trim()}
          className={`p-[10px] rounded-full flex items-center justify-center transition-colors ${
            input.trim() 
              ? "bg-[#FF6B00] text-white shadow-sm" 
              : "bg-[#F9F9F9] text-[#6B6B6B]"
          }`}
        >
          <Send className="w-5 h-5" />
        </button>
      </div>
    </div>
  );
}
