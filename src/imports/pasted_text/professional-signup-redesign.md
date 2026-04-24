# 📝 Tela: Cadastro Profissional — Redesign Completo
### ServiFast · Laranja `#FF6B00` + Branco `#FFFFFF`

---

## ❌ Problema identificado na versão atual
- Tela vazia — sem campos de formulário visíveis
- Botão "Pular cadastro" em destaque errado (não deve ser o foco principal)
- Stepper de etapas sem indicador visual de progresso
- Sem hierarquia clara de informação

---

## ✅ Solução proposta — Visão geral

O cadastro profissional é dividido em **4 etapas** com um **stepper visual no topo**.
Cada etapa tem seus campos completos, validações e botões de navegação.

---

## 🔢 Stepper (componente fixo no topo — aparece em todas as etapas)

```
┌─────────────────────────────────────────┐
│  ●━━━━○━━━━○━━━━○                       │
│  1    2    3    4                        │
│  Dados Serv. Local Foto                  │
└─────────────────────────────────────────┘
```

**Especificações:**
- Círculo ativo: fundo `#FF6B00`, número branco, tamanho 32px
- Círculo futuro: borda `#EEEEEE`, número `#AAAAAA`
- Círculo concluído: fundo `#FF6B00` com ícone ✓ branco
- Linha conectando etapas: cinza `#EEEEEE` / laranja `#FF6B00` (até etapa atual)
- Label abaixo de cada círculo: Poppins Medium 11px, cinza

---

## 📋 Etapa 1 de 4 — Dados Pessoais

### Layout completo

```
┌─────────────────────────────────────────┐
│ [← Voltar]                    [Pular]   │  ← "Pular" pequeno, cinza, canto direito
├─────────────────────────────────────────┤
│  ●━━━━○━━━━○━━━━○                       │
│  1    2    3    4                        │
├─────────────────────────────────────────┤
│                                         │
│  Cadastro Profissional                  │  ← Poppins Bold 22px, #1A1A1A
│  Etapa 1: Dados pessoais                │  ← Poppins Regular 14px, #6B6B6B
│                                         │
│  ┌─────────────────────────────────┐    │
│  │ 👤  Nome completo               │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │ 📄  CPF                         │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │ 📱  Telefone / WhatsApp         │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │ ✉️  E-mail                      │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │ 🔒  Senha                   👁  │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │ 🔒  Confirmar senha         👁  │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ─────────────────────────────────────  │
│  Indicador de força da senha:           │
│  [████░░░░]  Média                      │  ← barra laranja
│                                         │
│  ┌─────────────────────────────────┐    │
│  │     Próximo →                   │    │  ← botão laranja sólido
│  └─────────────────────────────────┘    │
│                                         │
│  Já tem conta?  Entrar                  │  ← link no rodapé
└─────────────────────────────────────────┘
```

### Campos — Etapa 1

| Campo | Tipo | Validação |
|---|---|---|
| Nome completo | Text | Mínimo 2 palavras |
| CPF | Text (máscara 000.000.000-00) | CPF válido |
| Telefone | Text (máscara (00) 00000-0000) | Obrigatório |
| E-mail | Email | Formato válido + único |
| Senha | Password | Mínimo 8 caracteres |
| Confirmar senha | Password | Igual ao campo senha |

### Comportamento dos campos
- Borda padrão: `#EEEEEE` 1.5px
- Borda ao focar: `#FF6B00` 1.5px
- Borda com erro: `#E74C3C` 1.5px + mensagem de erro em vermelho abaixo
- Borda válida: `#27AE60` 1.5px + ícone ✓ verde à direita
- Label sobe e fica pequeno (float label) ao focar ou preencher

### Indicador de força da senha
```
Fraca   → [██░░░░░░]  vermelho   #E74C3C
Média   → [████░░░░]  laranja    #FF6B00
Forte   → [████████]  verde      #27AE60
```

---

## 🔧 Etapa 2 de 4 — Serviços

```
┌─────────────────────────────────────────┐
│ [← Voltar]                    [Pular]   │
├─────────────────────────────────────────┤
│  ✓━━━━●━━━━○━━━━○                       │
│  1    2    3    4                        │
├─────────────────────────────────────────┤
│                                         │
│  Seus serviços                          │  ← Poppins Bold 22px
│  Etapa 2: O que você oferece?           │  ← cinza
│                                         │
│  Categoria principal *                  │  ← label acima do campo
│  ┌─────────────────────────────────┐    │
│  │  Selecione uma categoria    ▼   │    │  ← dropdown
│  └─────────────────────────────────┘    │
│                                         │
│  Serviços específicos *                 │
│  Selecione todos que se aplicam:        │  ← instrução em cinza 13px
│                                         │
│  [✓ Pintura interna ] [○ Pintura ext.] │  ← chips selecionáveis
│  [○ Textura        ] [○ Grafiato     ] │
│  [○ Pintura metal  ] [○ Verniz       ] │
│                                         │
│  Chip selecionado: fundo laranja,       │
│  texto branco, borda laranja            │
│  Chip padrão: fundo branco,             │
│  texto cinza, borda #EEEEEE             │
│                                         │
│  Descrição dos seus serviços *          │
│  ┌─────────────────────────────────┐    │
│  │                                 │    │
│  │  Ex: "Sou pintor há 10 anos..." │    │  ← textarea 4 linhas
│  │                                 │    │
│  └─────────────────────────────────┘    │
│                            240/300 car. │  ← contador
│                                         │
│  Preço médio cobrado *                  │
│  ┌──────────────────┐                  │
│  │ R$  80,00        │                  │  ← campo numérico
│  └──────────────────┘                  │
│  Cobro por:  ○ Hora  ● Diária  ○ Serv. │  ← radio buttons
│                                         │
│  ┌─────────────────────────────────┐    │
│  │     Próximo →                   │    │  ← laranja
│  └─────────────────────────────────┘    │
└─────────────────────────────────────────┘
```

### Categorias disponíveis (dropdown)
- Elétrico
- Hidráulico / Encanamento
- Pintura
- Pedreiro / Alvenaria
- Marcenaria / Móveis
- Jardinagem
- Limpeza
- Reformas em Geral
- Ar-condicionado
- Outros

### Comportamento dos chips
- Ao tocar: animação de scale 0.95 → 1.05 → 1
- Máximo de chips selecionados: sem limite
- Mínimo: 1 obrigatório

---

## 📍 Etapa 3 de 4 — Localização

```
┌─────────────────────────────────────────┐
│ [← Voltar]                    [Pular]   │
├─────────────────────────────────────────┤
│  ✓━━━━✓━━━━●━━━━○                       │
│  1    2    3    4                        │
├─────────────────────────────────────────┤
│                                         │
│  Onde você atua?                        │  ← Poppins Bold 22px
│  Etapa 3: Localização e raio            │  ← cinza
│                                         │
│  CEP *                                  │
│  ┌─────────────────────────────────┐    │
│  │ 📍  00000-000              🔍   │    │  ← ícone buscar ao digitar CEP
│  └─────────────────────────────────┘    │
│                                         │
│  (Auto-preenchimento após digitar CEP:) │
│  ┌──────────────────┐ ┌─────────────┐  │
│  │ Cidade: Mauá     │ │ Estado: SP  │  │  ← readonly, preenchidos automaticamente
│  └──────────────────┘ └─────────────┘  │
│                                         │
│  Bairro principal *                     │
│  ┌─────────────────────────────────┐    │
│  │ 🏘️  Ex: Centro                 │    │
│  └─────────────────────────────────┘    │
│                                         │
│  Raio de atendimento *                  │
│  Até quantos km você se desloca?        │
│                                         │
│  ○────────────────●────────────────○   │
│  1 km                             50 km │  ← slider laranja
│               Selecionado: 15 km        │  ← label centralizado laranja bold
│                                         │
│  Você atende em quais bairros?          │  ← opcional
│  ┌─────────────────────────────────┐    │
│  │ + Adicionar bairro              │    │  ← chips removíveis
│  └─────────────────────────────────┘    │
│  [Centro ×] [Matriz ×] [Vila X ×]      │  ← chips com X para remover
│                                         │
│  ┌─────────────────────────────────┐    │
│  │     Próximo →                   │    │
│  └─────────────────────────────────┘    │
└─────────────────────────────────────────┘
```

---

## 📸 Etapa 4 de 4 — Foto e Finalização

```
┌─────────────────────────────────────────┐
│ [← Voltar]                              │  ← sem botão Pular nesta etapa
├─────────────────────────────────────────┤
│  ✓━━━━✓━━━━✓━━━━●                       │
│  1    2    3    4                        │
├─────────────────────────────────────────┤
│                                         │
│  Quase lá! 🎉                           │  ← Poppins Bold 22px
│  Etapa 4: Foto do perfil                │  ← cinza
│                                         │
│  Sua foto de perfil *                   │
│                                         │
│         ┌──────────────┐                │
│         │              │                │
│         │   [câmera]   │                │  ← círculo 120px, borda tracejada laranja
│         │              │                │
│         │  Adicionar   │                │
│         │    foto      │                │
│         └──────────────┘                │
│                                         │
│  Toque para tirar foto ou escolher      │
│  da galeria                             │  ← cinza 13px centralizado
│                                         │
│  ───────────────────────────────────── │
│                                         │
│  Documento de verificação (opcional)   │
│  Aumenta sua credibilidade e gera      │
│  o badge ✅ Verificado no seu perfil   │
│                                         │
│         ┌──────────────┐                │
│         │  [document]  │                │  ← menor que a foto, borda tracejada cinza
│         │  Enviar foto │                │
│         │  segurando   │                │
│         │  documento   │                │
│         └──────────────┘                │
│                                         │
│  ───────────────────────────────────── │
│                                         │
│  □  Aceito os Termos de Uso e a        │
│     Política de Privacidade            │  ← checkbox obrigatório
│                                         │
│  ┌─────────────────────────────────┐    │
│  │   ✓  Criar minha conta          │    │  ← laranja, desabilitado sem checkbox
│  └─────────────────────────────────┘    │
└─────────────────────────────────────────┘
```

---

## ✅ Tela de Sucesso — Pós-cadastro

```
┌─────────────────────────────────────────┐
│                                         │
│                                         │
│            🎉                           │
│     (animação confetti laranja)         │
│                                         │
│    Cadastro realizado!                  │  ← Poppins Bold 24px
│                                         │
│  Bem-vindo ao ServiFast, Carlos!        │  ← nome do usuário
│                                         │
│  Seu perfil já está visível para        │
│  clientes da sua região.                │  ← cinza 15px
│                                         │
│  ┌──────────────────────────────────┐   │
│  │  ✅  Dados pessoais             │   │
│  │  ✅  Serviços cadastrados       │   │
│  │  ✅  Localização definida       │   │
│  │  ✅  Foto adicionada            │   │
│  └──────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │   Ir para minha Home →          │    │  ← laranja sólido
│  └─────────────────────────────────┘    │
│                                         │
│  [Completar perfil depois]              │  ← link cinza abaixo
└─────────────────────────────────────────┘
```

---

## 🔁 Navegação entre etapas

| Ação | Comportamento |
|---|---|
| Botão "Próximo" | Valida campos da etapa atual. Se OK → avança. Se não → mostra erros em vermelho |
| Botão "← Voltar" | Volta à etapa anterior sem perder dados já preenchidos |
| Botão "Pular" (etapas 1–3) | Vai para a Home sem concluir. Dados salvos como rascunho |
| Etapa 4 — "Criar conta" | Só ativa após aceitar os termos. Envia tudo ao servidor |
| Tocar em etapa concluída no stepper | Permite voltar a uma etapa anterior para editar |

---

## ⚠️ Validações e Mensagens de Erro

```
Campo vazio ao tentar avançar:
  → borda vermelha + "Este campo é obrigatório" abaixo

E-mail inválido:
  → "Digite um e-mail válido"

CPF inválido:
  → "CPF inválido. Verifique os números"

Senhas diferentes:
  → "As senhas não coincidem"

Nenhum serviço selecionado:
  → toast laranja no topo: "Selecione pelo menos 1 serviço"

CEP não encontrado:
  → "CEP não encontrado. Digite manualmente"

Sem foto:
  → Aviso suave, não bloqueia (foto é obrigatória mas pode ser enviada depois pelo perfil)
```

---

## 🎨 Tokens de Design — Cadastro Profissional

```css
/* Cores */
--primary: #FF6B00;
--primary-dark: #E65C00;
--primary-light: #FFF3E8;
--success: #27AE60;
--error: #E74C3C;
--text-main: #1A1A1A;
--text-sub: #6B6B6B;
--border: #EEEEEE;
--bg: #FFFFFF;
--surface: #F9F9F9;

/* Tipografia */
--font-title: 'Poppins', bold, 22px;
--font-subtitle: 'Poppins', regular, 14px;
--font-label: 'Poppins', medium, 13px;
--font-input: 'Poppins', regular, 15px;
--font-button: 'Poppins', bold, 16px;

/* Espaçamentos */
--padding-screen: 24px;
--gap-fields: 16px;
--border-radius-input: 10px;
--border-radius-button: 12px;

/* Sombras */
--shadow-card: 0 2px 8px rgba(0,0,0,0.06);
--shadow-button: 0 4px 12px rgba(255,107,0,0.30);
```

---

*Documento: Redesign — Tela Cadastro Profissional*
*App: ServiFast | Versão 1.0 | Cores: Laranja + Branco*