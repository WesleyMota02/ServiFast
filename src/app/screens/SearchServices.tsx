import { useState, useEffect, useRef } from "react";
import { useNavigate } from "react-router";
import { Search, ArrowLeft, SlidersHorizontal, X, Clock } from "lucide-react";
import { Badge } from "../components/Badge";

const RECENT = ["Pintor", "Eletricista", "Limpeza pesada"];
const SUGGESTIONS = ["Pintura residencial", "Pintor automotivo", "Eletricista 24h", "Manutenção elétrica"];

export function SearchServices() {
  const navigate = useNavigate();
  const [query, setQuery] = useState("");
  const inputRef = useRef<HTMLInputElement>(null);

  useEffect(() => {
    inputRef.current?.focus();
  }, []);

  const handleSearch = (q: string) => {
    navigate(`/client/search-results?q=${encodeURIComponent(q)}`);
  };

  return (
    <div className="h-full w-full bg-white flex flex-col pt-12">
      <div className="px-6 flex items-center gap-3 mb-6">
        <button onClick={() => navigate(-1)} className="p-2 -ml-2 rounded-full hover:bg-gray-100 transition-colors">
          <ArrowLeft className="w-6 h-6 text-[#1A1A1A]" />
        </button>
        <div className="flex-1 relative">
          <input
            ref={inputRef}
            type="text"
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            onKeyDown={(e) => e.key === "Enter" && handleSearch(query)}
            placeholder="Buscar serviço ou profissional"
            className="w-full bg-[#F9F9F9] text-[#1A1A1A] rounded-xl pl-10 pr-10 py-3 text-sm outline-none border border-[#EEEEEE] focus:border-[#FF6B00]"
          />
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-[#6B6B6B]" />
          {query && (
            <button onClick={() => setQuery("")} className="absolute right-3 top-1/2 -translate-y-1/2">
              <X className="w-4 h-4 text-[#6B6B6B]" />
            </button>
          )}
        </div>
        <button className="p-2 rounded-xl bg-[#F9F9F9] border border-[#EEEEEE] hover:bg-[#FFF3E8] hover:border-[#FF6B00] transition-colors">
          <SlidersHorizontal className="w-5 h-5 text-[#1A1A1A]" />
        </button>
      </div>

      <div className="flex-1 px-6">
        {!query ? (
          <>
            <h2 className="text-[16px] font-bold text-[#1A1A1A] mb-4">Buscas recentes</h2>
            <div className="flex flex-wrap gap-2 mb-8">
              {RECENT.map((item, i) => (
                <button
                  key={i}
                  onClick={() => handleSearch(item)}
                  className="flex items-center gap-2 bg-[#F9F9F9] text-[#6B6B6B] text-sm font-medium px-4 py-2 rounded-full border border-[#EEEEEE] hover:border-[#FF6B00] hover:text-[#FF6B00] transition-colors"
                >
                  <Clock className="w-3.5 h-3.5" />
                  {item}
                </button>
              ))}
            </div>

            <h2 className="text-[16px] font-bold text-[#1A1A1A] mb-4">Categorias populares</h2>
            <div className="flex flex-wrap gap-2">
              {["Hidráulica", "Gás", "Montagem de móveis", "Frete"].map((cat, i) => (
                <Badge key={i} variant="outline" className="px-3 py-1.5 text-sm cursor-pointer hover:bg-[#FFF3E8] hover:text-[#FF6B00] hover:border-[#FF6B00]" onClick={() => handleSearch(cat)}>
                  {cat}
                </Badge>
              ))}
            </div>
          </>
        ) : (
          <div className="flex flex-col gap-0">
            {SUGGESTIONS.filter(s => s.toLowerCase().includes(query.toLowerCase())).map((s, i) => (
              <button 
                key={i}
                onClick={() => handleSearch(s)}
                className="flex items-center gap-3 py-4 border-b border-[#EEEEEE] text-left hover:bg-gray-50 -mx-6 px-6"
              >
                <Search className="w-4 h-4 text-[#6B6B6B]" />
                <span className="text-[#1A1A1A] text-sm">{s}</span>
              </button>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
