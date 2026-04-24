# 📱 ServiFast — Design de Telas do Aplicativo
### Plataforma de Serviços Hiperlocal

---

## 🎨 Identidade Visual

| Elemento | Valor |
|---|---|
| **Nome sugerido** | ServiFast |
| **Slogan** | *"O serviço certo, perto de você."* |
| **Cor Primária** | Laranja `#FF6B00` |
| **Cor Secundária** | Laranja claro `#FF8C38` |
| **Cor de Fundo** | Branco puro `#FFFFFF` |
| **Superfícies/Cards** | Branco off `#F9F9F9` |
| **Texto Principal** | Cinza escuro `#1A1A1A` |
| **Texto Secundário** | Cinza médio `#6B6B6B` |
| **Bordas suaves** | `#EEEEEE` |
| **Sucesso** | Verde `#27AE60` |
| **Erro** | Vermelho `#E74C3C` |
| **Fonte Título** | Poppins Bold |
| **Fonte Corpo** | Poppins Regular / Medium |

---

## 👥 Tipos de Usuário

O app possui **2 perfis**:
- 🏠 **Cliente** — quem contrata serviços
- 👷 **Profissional** — quem oferece serviços

---

## 🗺️ Mapa de Telas

```
FLUXO GERAL
│
├── 1. Splash Screen
├── 2. Onboarding (3 slides)
├── 3. Tela de Boas-vindas
├── 4. Escolha de Perfil (Cliente ou Profissional)
│
├── FLUXO CLIENTE
│   ├── 5.  Cadastro Cliente
│   ├── 6.  Login
│   ├── 7.  Home Cliente
│   ├── 8.  Busca de Serviços
│   ├── 9.  Resultados da Busca
│   ├── 10. Perfil do Profissional
│   ├── 11. Solicitar Serviço
│   ├── 12. Confirmação de Solicitação
│   ├── 13. Chat com Profissional
│   ├── 14. Minhas Solicitações
│   ├── 15. Avaliar Profissional
│   └── 16. Perfil do Cliente
│
├── FLUXO PROFISSIONAL
│   ├── 17. Cadastro Profissional
│   ├── 18. Home Profissional
│   ├── 19. Solicitações Recebidas
│   ├── 20. Detalhe da Solicitação
│   ├── 21. Chat com Cliente
│   ├── 22. Meus Serviços (gerenciar)
│   ├── 23. Minhas Avaliações
│   └── 24. Perfil Profissional (público)
│
└── TELAS GERAIS
    ├── 25. Notificações
    ├── 26. Configurações
    ├── 27. Recuperar Senha
    └── 28. Tela de Erro / Sem Conexão
```

---

## 📋 Descrição Detalhada de Cada Tela

---

### 1. 🟠 Splash Screen

**Objetivo:** Primeira tela ao abrir o app, exibida por 2–3 segundos.

**Layout:**
- Fundo laranja `#FF6B00` (tela inteira)
- Centro: logotipo do **ServiFast** em branco (ícone de ferramenta + raio)
- Abaixo do logo: slogan em branco, fonte Poppins Light, 14px
- Animação: logo aparece com fade-in suave

**Elementos:**
```
[Fundo laranja]
        🔧⚡
     ServiFast
  "O serviço certo,
    perto de você."
```

---

### 2. 📖 Onboarding (3 Slides)

**Objetivo:** Apresentar o app para novos usuários. Aparece apenas na 1ª instalação.

**Navegação:** Swipe lateral ou botão "Próximo". Último slide tem botão "Começar".

---

**Slide 1 — Encontre profissionais**
- Ilustração: pessoa no celular vendo lista de profissionais
- Título: *"Encontre quem você precisa"*
- Subtítulo: *"Pintores, eletricistas, encanadores e muito mais, perto de você."*
- Fundo branco, ilustração colorida, título em laranja

---

**Slide 2 — Segurança e avaliações**
- Ilustração: estrelas de avaliação e ícone de escudo
- Título: *"Profissionais avaliados"*
- Subtítulo: *"Veja a reputação de cada profissional antes de contratar."*

---

**Slide 3 — Rápido e fácil**
- Ilustração: check verde com cronômetro
- Título: *"Serviço combinado em minutos"*
- Subtítulo: *"Solicite, negocie e confirme tudo pelo app."*
- Botão: **[Começar agora]** — laranja, bordas arredondadas, largura total

**Rodapé (todos os slides):**
- Indicador de progresso: bolinhas (● ○ ○), laranja = ativo
- Link "Pular" no canto superior direito em cinza

---

### 3. 🏠 Tela de Boas-vindas

**Objetivo:** Entrada principal do app para quem já passou pelo onboarding.

**Layout:**
- Metade superior: fundo laranja com logotipo grande centralizado
- Metade inferior: fundo branco com dois botões empilhados

**Elementos:**
```
┌─────────────────────┐
│  [Fundo Laranja]    │
│                     │
│      🔧⚡            │
│    ServiFast        │
│                     │
├─────────────────────┤
│  [Fundo Branco]     │
│                     │
│  [Entrar na conta]  │  ← botão contorno laranja
│                     │
│  [Criar conta]      │  ← botão sólido laranja
│                     │
│  Termos de uso      │
└─────────────────────┘
```

---

### 4. 👤 Escolha de Perfil

**Objetivo:** Usuário escolhe se é cliente ou profissional no momento do cadastro.

**Layout:**
- Topo: seta "Voltar" + título "Como você vai usar o app?"
- Dois cards grandes, lado a lado ou empilhados

**Card Cliente:**
- Ícone: 🏠 casa
- Título: **"Sou Cliente"**
- Subtítulo: "Quero contratar serviços"
- Borda laranja quando selecionado

**Card Profissional:**
- Ícone: 👷 capacete
- Título: **"Sou Profissional"**
- Subtítulo: "Quero oferecer meus serviços"
- Borda laranja quando selecionado

**Botão:** [Continuar] — desabilitado até escolher uma opção

---

### 5. 📝 Cadastro — Cliente

**Objetivo:** Criar conta como cliente.

**Campos:**
- Nome completo
- E-mail
- Telefone (WhatsApp)
- Cidade / Bairro
- Senha
- Confirmar senha

**Layout:**
- Topo: seta voltar + "Criar conta"
- Campos com label flutuante (float label)
- Label e borda do campo ficam laranja quando em foco
- Botão [Cadastrar] — laranja, largura total, rodapé da tela
- Link abaixo: "Já tenho conta. Entrar"

**Validações visíveis:**
- Campo vazio com erro: borda vermelha + mensagem abaixo
- E-mail inválido: ícone ✗ vermelho dentro do campo

---

### 6. 🔐 Login

**Objetivo:** Autenticação do usuário (cliente ou profissional).

**Campos:**
- E-mail
- Senha (campo com ícone olho para mostrar/ocultar)

**Layout:**
- Logo pequeno no topo
- Título "Bem-vindo de volta!"
- Botão [Entrar] — laranja
- Link "Esqueci minha senha"
- Divisor "— ou —"
- Botão [Entrar com Google] — branco com borda cinza + ícone Google
- Rodapé: "Não tem conta? Cadastre-se"

---

### 7. 🏘️ Home — Cliente

**Objetivo:** Tela principal do cliente após login.

**Layout:**
```
┌─────────────────────────┐
│ Olá, João! 👋           │
│ Mauá, SP  📍            │
│                         │
│ [🔍 Buscar serviço...  ]│  ← barra de busca
│                         │
│ ── Categorias ──        │
│ [🔌][🔧][🎨][🚿][🌿]  │  ← ícones rolagem horizontal
│ Elétrico Hidráulico...  │
│                         │
│ ── Profissionais perto ─│
│ ┌───────┐ ┌───────┐    │
│ │ Card  │ │ Card  │    │  ← cards rolagem horizontal
│ └───────┘ └───────┘    │
│                         │
│ ── Mais solicitados ────│
│ ┌──────────────────┐   │
│ │     Card         │   │  ← lista vertical
│ └──────────────────┘   │
└─────────────────────────┘
[🏠][🔍][💬][📋][👤]   ← bottom navigation
```

**Bottom Navigation:**
- 🏠 Início
- 🔍 Buscar
- 💬 Chat
- 📋 Solicitações
- 👤 Perfil

**Cards de categoria (rolagem horizontal):**
- Ícone + nome (Elétrico, Hidráulico, Pintura, Gás, Jardinagem, Limpeza, Reforma, Outros)
- Selecionado: fundo laranja, texto branco

**Card de profissional (mini):**
- Foto redonda
- Nome
- Serviço principal
- ⭐ nota (ex: 4.8)
- Cidade/bairro

---

### 8. 🔍 Busca de Serviços

**Objetivo:** Cliente busca por tipo de serviço ou profissional.

**Layout:**
- Topo: campo de busca ativo (cursor piscando) com ícone lupa
- Abaixo: "Buscas recentes" com tags clicáveis (ex: Pintor, Eletricista)
- Sugestões em tempo real enquanto digita (lista dropdown)
- Filtro por cidade/bairro disponível (ícone filtro no canto)

**Filtros (modal ao tocar no ícone):**
- Cidade / Bairro
- Categoria de serviço
- Avaliação mínima (slider 1–5 estrelas)
- Disponibilidade (Disponível agora / Qualquer)
- Botões: [Limpar] [Aplicar filtros]

---

### 9. 📃 Resultados da Busca

**Objetivo:** Exibir lista de profissionais encontrados.

**Layout:**
- Topo: "X profissionais encontrados para 'Pintor'"
- Chip de filtro ativo: ex. `Mauá ×` `⭐4+ ×`
- Lista vertical de cards de profissionais

**Card de profissional (completo):**
```
┌──────────────────────────────┐
│ [Foto] Nome do Profissional  │
│        ⭐ 4.8 · 32 avaliações│
│        📍 Centro, Mauá       │
│        🔧 Pintura · Reforma  │
│        💰 A partir de R$80   │
│              [Ver perfil →]  │
└──────────────────────────────┘
```
- Badge verde "Disponível agora" quando aplicável
- Badge cinza "Responde rápido" quando histórico indica

---

### 10. 👷 Perfil do Profissional

**Objetivo:** Cliente visualiza detalhes do profissional antes de contratar.

**Layout:**
```
┌─────────────────────────┐
│  [← Voltar]             │
│                         │
│  [Foto grande]          │
│  Carlos Silva           │
│  ⭐ 4.9 · 47 avaliações │
│  📍 Jardim Miranda, Mauá│
│  ✅ Disponível          │
│                         │
│  [Solicitar Serviço]    │  ← botão laranja
│  [Enviar mensagem]      │  ← botão contorno laranja
│                         │
│  ── Sobre ──            │
│  "Sou pintor há 10 anos,│
│  trabalho com tinta      │
│  acrílica e esmalte..."  │
│                         │
│  ── Serviços ──         │
│  • Pintura interna       │
│  • Pintura externa       │
│  • Textura e grafiato    │
│                         │
│  ── Avaliações ──       │
│  ┌──────────────────┐   │
│  │ ⭐⭐⭐⭐⭐ Maria  │   │
│  │ "Ótimo serviço!" │   │
│  └──────────────────┘   │
└─────────────────────────┘
```

---

### 11. 📤 Solicitar Serviço

**Objetivo:** Cliente detalha o que precisa e envia solicitação ao profissional.

**Campos:**
- Tipo de serviço (pré-selecionado ou lista)
- Descrição do serviço (campo de texto livre, max 300 caracteres)
- Endereço de atendimento
- Data preferida (date picker)
- Horário preferido (manhã / tarde / noite)
- Foto do local/problema (opcional — upload de imagem)

**Layout:**
- Topo: "Solicitar serviço para Carlos Silva"
- Cada campo com label e espaçamento generoso
- Contador de caracteres na descrição
- Botão [Enviar solicitação] — laranja, largura total

---

### 12. ✅ Confirmação de Solicitação

**Objetivo:** Confirmar que a solicitação foi enviada com sucesso.

**Layout:**
- Fundo branco
- Ícone animado: ✅ verde com efeito de pop
- Título: "Solicitação enviada!"
- Subtítulo: "Carlos Silva foi notificado e em breve entrará em contato."
- Card resumo: profissional, serviço, data solicitada
- Dois botões:
  - [Ver minhas solicitações] — laranja
  - [Voltar ao início] — contorno laranja

---

### 13. 💬 Chat com Profissional

**Objetivo:** Comunicação em tempo real entre cliente e profissional.

**Layout:**
```
┌─────────────────────────┐
│ [←] [Foto] Carlos Silva │
│          ● Online       │
├─────────────────────────┤
│                         │
│  [Balão deles]          │
│              [Balão meu]│
│  [Balão deles]          │
│                         │
├─────────────────────────┤
│ [📎][Mensagem...] [▶]  │
└─────────────────────────┘
```

**Detalhes:**
- Balões do cliente: fundo laranja, texto branco, alinhado à direita
- Balões do profissional: fundo cinza claro, texto escuro, alinhado à esquerda
- Horário embaixo de cada mensagem em cinza
- Ícone de clipe para enviar foto
- Status de leitura: ✓ enviado / ✓✓ lido (azul)

---

### 14. 📋 Minhas Solicitações — Cliente

**Objetivo:** Cliente acompanha todas as suas solicitações.

**Abas no topo:**
- `Em andamento` · `Aguardando` · `Concluídas` · `Canceladas`

**Card de solicitação:**
```
┌──────────────────────────────┐
│ Pintura - Carlos Silva       │
│ 📅 15/07 às 09h              │
│ 📍 Rua X, nº 50              │
│ Status: 🟡 Aguardando resposta│
│ [Ver detalhes] [Chat]        │
└──────────────────────────────┘
```

**Status com cores:**
- 🟡 Aguardando resposta
- 🟠 Aceita — aguardando execução
- 🔵 Em andamento
- 🟢 Concluída
- 🔴 Cancelada

---

### 15. ⭐ Avaliar Profissional

**Objetivo:** Após conclusão do serviço, cliente avalia o profissional.

**Layout:**
- Foto do profissional + nome
- Título: "Como foi o serviço de Carlos?"
- 5 estrelas clicáveis (animação ao selecionar)
- Campo de texto: "Conta como foi... (opcional)"
- Tags rápidas: [Pontual] [Educado] [Bom trabalho] [Recomendo]
- Botão [Enviar avaliação] — laranja

---

### 16. 👤 Perfil do Cliente

**Objetivo:** Cliente visualiza e edita suas informações.

**Seções:**
- Foto + nome + e-mail + cidade
- [Editar perfil]
- Histórico de contratações
- Profissionais favoritos
- Configurações de notificação
- [Sair da conta] — texto vermelho

---

### 17. 📝 Cadastro — Profissional

**Objetivo:** Criar conta como prestador de serviços.

**Etapas (stepper no topo):**

**Etapa 1 — Dados pessoais:**
- Nome completo
- CPF
- Telefone (WhatsApp)
- E-mail
- Senha

**Etapa 2 — Serviços:**
- Categoria principal (lista suspensa)
- Serviços que oferece (múltipla escolha com chips)
- Descrição livre de seus serviços
- Preço médio (R$ por hora ou por diária)

**Etapa 3 — Localização:**
- CEP (auto-preenche cidade/estado)
- Bairro(s) em que atende
- Raio de atendimento (slider em km)

**Etapa 4 — Foto e documentos:**
- Foto de perfil (obrigatória)
- Foto segurando documento (opcional, para verificação futura)

**Rodapé de cada etapa:**
- [Voltar] [Próximo →] / [Cadastrar] na última etapa

---

### 18. 🏘️ Home — Profissional

**Objetivo:** Tela principal do profissional após login.

**Layout:**
```
┌─────────────────────────┐
│ Olá, Carlos! 👷         │
│ ● Disponível [toggle]  │  ← ativar/desativar disponibilidade
│                         │
│ ── Resumo do dia ───── │
│ 📨 2 solicitações novas │
│ 💬 1 mensagem não lida  │
│ ⭐ Sua nota: 4.9        │
│                         │
│ ── Novas solicitações ─ │
│ ┌──────────────────┐   │
│ │ Pintura - João   │   │
│ │ Hoje, 14h        │   │
│ │ [Aceitar][Recusar│   │
│ └──────────────────┘   │
└─────────────────────────┘
[🏠][📋][💬][⭐][👤]
```

**Toggle de disponibilidade:**
- Verde + "Disponível" = aparece nas buscas
- Cinza + "Indisponível" = não aparece

---

### 19. 📥 Solicitações Recebidas — Profissional

**Objetivo:** Profissional gerencia solicitações recebidas.

**Abas:**
- `Novas` (badge com número) · `Aceitas` · `Concluídas` · `Recusadas`

**Card de solicitação recebida:**
```
┌──────────────────────────────┐
│ João Mendes                  │
│ 🔧 Pintura de quarto         │
│ 📅 15/07 às manhã            │
│ 📍 Centro, Mauá              │
│ "Preciso pintar 2 quartos..."│
│                              │
│ [Recusar]    [Aceitar ✓]     │
└──────────────────────────────┘
```
- Botão Aceitar: fundo laranja
- Botão Recusar: contorno cinza

---

### 20. 📄 Detalhe da Solicitação — Profissional

**Objetivo:** Profissional visualiza todos os detalhes antes de aceitar.

**Informações:**
- Nome e foto do cliente
- Serviço solicitado
- Descrição completa
- Endereço
- Data e horário preferidos
- Foto enviada pelo cliente (se houver)
- Botões: [Recusar] [Aceitar e responder]

---

### 21. 💬 Chat com Cliente — Profissional

**Layout idêntico à tela 13**, com cores invertidas.
- Balões do profissional: laranja
- Acesso rápido ao detalhe da solicitação no topo

---

### 22. 🔧 Meus Serviços — Profissional

**Objetivo:** Profissional gerencia os serviços que oferece.

**Layout:**
- Lista de serviços cadastrados com chips
- Botão [+ Adicionar serviço] — laranja
- Preço por serviço editável inline
- Toggle para ativar/desativar serviço específico
- Campo de edição de descrição do perfil

---

### 23. ⭐ Minhas Avaliações — Profissional

**Objetivo:** Profissional visualiza feedback dos clientes.

**Layout:**
- Topo: nota geral com estrelas grandes ⭐ 4.9
- Barra de distribuição (5★ ████ 38, 4★ ██ 7, ...)
- Lista de avaliações com foto do cliente, texto e data
- Opção de responder avaliação (campo de texto + botão Responder)

---

### 24. 👷 Perfil Público — Profissional

**Objetivo:** Versão pública do perfil (igual à tela 10, mas com opção de editar).

**Botão [Editar perfil]** visível somente para o próprio profissional.

---

### 25. 🔔 Notificações

**Objetivo:** Central de notificações do app (cliente e profissional).

**Layout:**
- Lista cronológica de notificações
- Ícone + texto + tempo relativo ("há 2 min")
- Notificações não lidas: fundo laranja claro `#FFF3E8`
- Tipos de notificação:
  - 📨 Nova solicitação recebida
  - ✅ Solicitação aceita
  - 💬 Nova mensagem
  - ⭐ Nova avaliação
  - 🔔 Lembrete de serviço agendado
- Botão "Marcar tudo como lido" no topo

---

### 26. ⚙️ Configurações

**Objetivo:** Ajustes do app.

**Seções:**
- **Conta:** editar e-mail, telefone, senha
- **Notificações:** toggles para cada tipo de notificação
- **Privacidade:** visibilidade do perfil, excluir conta
- **Aparência:** (futuro) modo escuro
- **Sobre:** versão do app, termos de uso, política de privacidade
- **Suporte:** enviar feedback, reportar problema

---

### 27. 🔑 Recuperar Senha

**Objetivo:** Redefinir senha esquecida.

**Etapa 1 — Informe o e-mail:**
- Campo de e-mail
- Botão [Enviar código]

**Etapa 2 — Código de verificação:**
- 4 caixas de dígito (OTP)
- "Reenviar código" com contador 60s

**Etapa 3 — Nova senha:**
- Campo nova senha + confirmar
- Botão [Redefinir senha]
- Redireciona para login com mensagem de sucesso

---

### 28. ❌ Tela de Erro / Sem Conexão

**Objetivo:** Comunicar falhas ao usuário de forma amigável.

**Layout:**
- Ilustração: cabo desconectado ou nuvem com X
- Título: "Ops! Algo deu errado."
- Subtítulo: "Verifique sua conexão e tente novamente."
- Botão [Tentar novamente] — laranja

**Variações:**
- Sem internet: ícone de Wi-Fi cortado
- Erro de servidor: ícone de nuvem com raio
- Lista vazia: ícone de lupa + "Nenhum resultado encontrado"

---

## 📐 Padrões de Componentes Reutilizáveis

### Botão Primário
```
Fundo: #FF6B00 | Texto: branco | Border-radius: 12px
Padding: 16px | Fonte: Poppins Bold 16px
Sombra: 0 4px 12px rgba(255,107,0,0.3)
Estado hover/press: #E65C00
```

### Botão Secundário (contorno)
```
Fundo: transparente | Borda: 2px solid #FF6B00
Texto: #FF6B00 | Border-radius: 12px
```

### Campo de Input
```
Borda: 1.5px solid #EEEEEE | Border-radius: 10px
Foco: borda #FF6B00 | Padding: 14px 16px
Label flutuante em laranja quando focado
```

### Card
```
Fundo: #F9F9F9 | Border-radius: 16px
Sombra: 0 2px 8px rgba(0,0,0,0.06)
Padding: 16px
```

### Badge de Status
```
Border-radius: 20px | Padding: 4px 12px
Fonte: Poppins Medium 12px
Cores conforme status (ver tela 14)
```

---

## 🚀 Ordem de Desenvolvimento Sugerida

| Fase | Telas | Descrição |
|---|---|---|
| **MVP (1ª versão)** | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 17, 18, 19, 20 | App funcional básico |
| **V1.1** | 13, 14, 21, 22, 28 | Chat + gestão de solicitações |
| **V1.2** | 15, 23, 24, 25 | Avaliações + notificações |
| **V2.0** | 26, 27 + novas features | Configurações + melhorias |

---