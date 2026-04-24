# 🎨 ServiFast — Atualização de Design: Telas de Cadastro
### Ajustes visuais — Ícones cinza + Cadastro Cliente igual ao Profissional

---

## ✏️ Alterações desta versão

| Item | Antes | Depois |
|---|---|---|
| Ícones nos campos (profissional) | Coloridos (roxo, laranja, etc.) | Cinza `#9E9E9E` |
| Ícones nos campos (cliente) | Cinza padrão simples | Cinza `#9E9E9E` (padronizado) |
| Layout cadastro cliente | Simples, sem float label | Igual ao profissional (float label + validação) |
| Stepper no cadastro cliente | Não tinha | Adicionado (3 etapas) |

---

## 🔩 Padrão de Ícones (Ambas as Telas)

Todos os ícones dentro dos campos de formulário (tanto cliente quanto profissional) devem seguir:

```
Cor padrão:    #9E9E9E  (cinza médio)
Cor ao focar:  #FF6B00  (laranja — junto com a borda)
Cor validado:  #27AE60  (verde — aparece o ícone ✓ à direita)
Cor com erro:  #E74C3C  (vermelho — ícone ✗ à direita)
Tamanho:       20px
Posição:       Lado esquerdo do campo, centralizado verticalmente
```

### Mapeamento de ícones por campo

| Campo | Ícone | Nome (Lucide / Material) |
|---|---|---|
| Nome completo | 👤 | `user` |
| CPF | 🪪 | `id-card` / `badge` |
| E-mail | ✉️ | `mail` |
| Telefone / WhatsApp | 📱 | `phone` |
| Senha | 🔒 | `lock` |
| Confirmar senha | 🔒 | `lock` |
| Cidade / Bairro | 📍 | `map-pin` |
| CEP | 📍 | `map-pin` |

> ⚠️ **Regra:** Nenhum ícone deve ter cor própria (roxo, azul, verde, etc.). Todos partem de `#9E9E9E` e mudam apenas ao focar ou validar.

---

## 👤 Cadastro Cliente — Redesign Completo

O cadastro do cliente agora segue o **mesmo padrão visual** do cadastro profissional:
float labels, ícones cinza, barra de força de senha, stepper e validação visual.

O cliente tem **3 etapas** (mais simples que o profissional que tem 4).

---

### Stepper — Cadastro Cliente

```
●━━━━○━━━━○
1    2    3
Dados Local Foto
```

- Mesmas especificações do stepper do profissional
- Círculo ativo: `#FF6B00` com número branco
- Concluído: `#FF6B00` com ícone ✓
- Futuro: borda `#EEEEEE`, número `#AAAAAA`

---

### Etapa 1 de 3 — Dados Pessoais (Cliente)

```
┌─────────────────────────────────────────┐
│ [← Voltar]                    [Pular]   │
├─────────────────────────────────────────┤
│  ●━━━━○━━━━○                            │
│  1    2    3                             │
├─────────────────────────────────────────┤
│                                         │
│  Criar conta                            │  ← Poppins Bold 22px #1A1A1A
│  Etapa 1: Seus dados                    │  ← Poppins Regular 14px #6B6B6B
│                                         │
│  ┌─────────────────────────────────┐    │
│  │ 👤 (cinza)  Nome completo       │    │  ← float label laranja ao focar
│  └─────────────────────────────────┘    │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │ ✉️ (cinza)  E-mail              │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │ 📱 (cinza)  Telefone (WhatsApp) │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │ 🔒 (cinza)  Senha           👁  │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │ 🔒 (cinza)  Confirmar senha 👁  │    │
│  └─────────────────────────────────┘    │
│                                         │
│  Indicador de força da senha:   Média   │  ← label cinza + "Média" laranja
│  [████░░░░░░░░░░░]                      │  ← barra laranja preenchida
│                                         │
│  ┌─────────────────────────────────┐    │
│  │        Próximo →                │    │  ← botão laranja sólido
│  └─────────────────────────────────┘    │
│                                         │
│  Já tem conta?  Entrar                  │  ← link rodapé
└─────────────────────────────────────────┘
```

### Campos — Etapa 1 Cliente

| Campo | Tipo | Máscara | Validação |
|---|---|---|---|
| Nome completo | Text | — | Mínimo 2 palavras |
| E-mail | Email | — | Formato válido |
| Telefone (WhatsApp) | Tel | (00) 00000-0000 | Obrigatório |
| Senha | Password | — | Mínimo 8 caracteres |
| Confirmar senha | Password | — | Igual à senha |

---

### Etapa 2 de 3 — Localização (Cliente)

```
┌─────────────────────────────────────────┐
│ [← Voltar]                    [Pular]   │
├─────────────────────────────────────────┤
│  ✓━━━━●━━━━○                            │
│  1    2    3                             │
├─────────────────────────────────────────┤
│                                         │
│  Onde você mora?                        │  ← Poppins Bold 22px
│  Etapa 2: Localização                   │  ← cinza
│                                         │
│  ┌─────────────────────────────────┐    │
│  │ 📍 (cinza)  CEP             🔍  │    │  ← ícone busca à direita
│  └─────────────────────────────────┘    │
│                                         │
│  ┌──────────────────┐ ┌─────────────┐  │
│  │ 📍 Cidade        │ │ Estado      │  │  ← preenchidos via CEP (readonly)
│  └──────────────────┘ └─────────────┘  │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │ 📍 (cinza)  Bairro              │    │
│  └─────────────────────────────────┘    │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │        Próximo →                │    │
│  └─────────────────────────────────┘    │
└─────────────────────────────────────────┘
```

---

### Etapa 3 de 3 — Foto (Cliente)

```
┌─────────────────────────────────────────┐
│ [← Voltar]                              │
├─────────────────────────────────────────┤
│  ✓━━━━✓━━━━●                            │
│  1    2    3                             │
├─────────────────────────────────────────┤
│                                         │
│  Quase lá! 🎉                           │  ← Poppins Bold 22px
│  Etapa 3: Sua foto                      │  ← cinza
│                                         │
│         ┌──────────────┐                │
│         │              │                │
│         │  [câmera]    │                │  ← círculo 120px borda tracejada laranja
│         │  Adicionar   │                │
│         │    foto      │                │
│         └──────────────┘                │
│                                         │
│  Toque para tirar foto ou escolher      │
│  da galeria (opcional)                  │  ← cinza 13px
│                                         │
│  □  Aceito os Termos de Uso e           │
│     Política de Privacidade             │
│                                         │
│  ┌─────────────────────────────────┐    │
│  │   ✓  Criar minha conta          │    │  ← laranja, desabilitado sem checkbox
│  └─────────────────────────────────┘    │
└─────────────────────────────────────────┘
```

---

## ✅ Tela de Sucesso — Cliente

```
┌─────────────────────────────────────────┐
│                                         │
│            🎉                           │
│     (animação confetti laranja)         │
│                                         │
│    Conta criada com sucesso!            │  ← Poppins Bold 24px
│                                         │
│  Bem-vindo ao ServiFast, João!          │
│  Agora você pode contratar serviços     │
│  perto de você.                         │  ← cinza 15px
│                                         │
│  ┌─────────────────────────────────┐    │
│  │   Ir para o início →            │    │  ← laranja sólido
│  └─────────────────────────────────┘    │
└─────────────────────────────────────────┘
```

---

## 🎨 Token de Design — Ícones (Aplicar em Ambas as Telas)

```css
/* Estado padrão */
.input-icon {
  color: #9E9E9E;
  width: 20px;
  height: 20px;
}

/* Ao focar no campo */
.input-focused .input-icon {
  color: #FF6B00;
}

/* Campo válido — ícone à direita vira ✓ verde */
.input-valid .icon-right {
  color: #27AE60;
}

/* Campo com erro — ícone à direita vira ✗ vermelho */
.input-error .icon-right {
  color: #E74C3C;
}
```

---

## 📐 Comparativo lado a lado

| Elemento | Cadastro Cliente | Cadastro Profissional |
|---|---|---|
| Etapas | 3 | 4 |
| Labels dos campos | Float label laranja | Float label laranja ✅ |
| Ícones | Cinza `#9E9E9E` | Cinza `#9E9E9E` ✅ |
| Borda ao focar | Laranja `#FF6B00` | Laranja `#FF6B00` ✅ |
| Ícone validado | ✓ Verde direita | ✓ Verde direita ✅ |
| Força da senha | Barra laranja | Barra laranja ✅ |
| Stepper visual | ●━━○━━○ | ●━━○━━○━━○ ✅ |
| Botão avançar | Laranja sólido | Laranja sólido ✅ |

---

*ServiFast · Design Update v1.1 · Cadastro Cliente + Ícones Cinza*