# ServiFast — Plataforma de Serviços Hiperlocal
### Documentação do Projeto — Versão 2.0 (Flutter Edition)

> **Nota para IAs:** Este documento é a fonte de verdade do projeto ServiFast. Ao gerar código, telas, componentes ou qualquer artefato, siga rigorosamente as especificações aqui descritas: identidade visual (cores, fontes, bordas), estrutura de telas, fluxos de cadastro, modelos de dados Firestore e a stack tecnológica definida na seção 3. O app é desenvolvido em **Flutter + Dart**, **não** em React Native. Sempre priorize fidelidade ao design system antes de sugerir soluções alternativas.

---

## Índice

1. [Visão Geral do Projeto](#1-visão-geral-do-projeto)
2. [Identidade Visual](#2-identidade-visual)
3. [Arquitetura do Sistema](#3-arquitetura-do-sistema)
4. [Mapa de Telas](#4-mapa-de-telas)
5. [Especificação dos Cadastros](#5-especificação-dos-cadastros)
6. [Componentes Reutilizáveis](#6-componentes-reutilizáveis)
7. [Roadmap de Desenvolvimento](#7-roadmap-de-desenvolvimento)
8. [Estrutura do Banco de Dados (Firestore)](#8-estrutura-do-banco-de-dados-firestore)
9. [Modelo de Monetização (futuro)](#9-modelo-de-monetização-futuro)
10. [Histórico de Versões](#10-histórico-de-versões)

---

## 1. Visão Geral do Projeto

O **ServiFast** é uma plataforma mobile de serviços hiperlocal que conecta prestadores de serviços autônomos (eletricistas, pintores, encanadores, etc.) a clientes da mesma região. O objetivo é facilitar a contratação de serviços locais de forma rápida, segura e avaliada.

### 1.1 Problema que Resolve

Atualmente, a maioria dos prestadores de serviços autônomos depende exclusivamente de indicações pelo WhatsApp ou de plataformas nacionais que cobram taxas elevadas. Clientes não têm visibilidade de profissionais próximos e verificados. O ServiFast preenche essa lacuna com foco em cidades do **ABC Paulista**.

### 1.2 Público-alvo

| Perfil | Descrição | Região foco |
|--------|-----------|-------------|
| Cliente | Pessoa física que precisa contratar serviços domésticos | Todas as regiões |
| Profissional | Prestador autônomo de serviços (MEI ou informal) | Todas as regiões |

### 1.3 Proposta de Valor

- **Para o cliente:** encontrar profissionais avaliados perto de casa em minutos.
- **Para o profissional:** ter uma vitrine digital gratuita e receber solicitações pelo app.
- **Diferencial:** foco hiperlocal (uma cidade por vez) vs. plataformas nacionais.

---

## 2. Identidade Visual

> **Para IAs:** Utilize estes valores exatos ao gerar código Flutter. Defina-os como constantes em um arquivo `lib/core/theme/app_colors.dart` e `app_text_styles.dart`. Nunca use valores hardcoded nas telas — sempre referencie as constantes do tema.

### 2.1 Paleta de Cores

| Elemento | Valor | Uso |
|----------|-------|-----|
| Cor primária | `#FF6B00` | Botões principais, bordas ativas, ícones focados |
| Cor de fundo | `#FFFFFF` | Background geral |
| Superfícies / Cards | `#F9F9F9` | Cards, modais, containers |
| Texto principal | `#1A1A1A` | Títulos e textos primários |
| Texto secundário | `#6B6B6B` | Subtítulos, placeholders |
| Ícones de campo | `#9E9E9E` | Ícones padrão em campos de formulário |
| Sucesso | `#27AE60` | Estados válidos, status concluído |
| Erro | `#E74C3C` | Validações, status cancelado |
| Desabilitado | `#CCCCCC` | Botões e campos inativos |

### 2.2 Tipografia

- **Fonte:** Poppins (via `google_fonts` package)
- **Pesos usados:** Bold (700), Medium (500), Regular (400)

```dart
// Exemplo de configuração no ThemeData Flutter
TextTheme(
  headlineMedium: GoogleFonts.poppins(fontWeight: FontWeight.w700),
  bodyMedium: GoogleFonts.poppins(fontWeight: FontWeight.w400),
  labelLarge: GoogleFonts.poppins(fontWeight: FontWeight.w500),
)
```

### 2.3 Regra de Ícones nos Campos

- **Padrão:** ícone cinza `#9E9E9E`
- **Ao focar:** ícone muda para laranja `#FF6B00` junto com a borda
- **Validado:** aparece ícone `check` verde à direita (`#27AE60`)

> **Para IAs:** Em Flutter, implemente este comportamento usando `FocusNode` + `StatefulWidget` ou `flutter_hooks`. Nunca use cores hardcoded — sempre referencie `AppColors.primary`, `AppColors.iconDefault`, etc.

### 2.4 Nome e Slogan

- **Nome do app:** ServiFast
- **Slogan:** *O serviço certo, perto de você.*

---

## 3. Arquitetura do Sistema

> **Para IAs:** A stack está definida e não deve ser alterada sem instrução explícita. Ao sugerir soluções, use sempre os pacotes listados aqui. Se um pacote não estiver listado, pergunte antes de sugerir uma alternativa.

### 3.1 Tecnologias Escolhidas

| Camada | Tecnologia | Motivo |
|--------|-----------|--------|
| **Frontend Mobile** | Flutter (Dart) | Roda Android e iOS com um único código, alta performance nativa |
| **Navegação** | GoRouter | Padrão declarativo, suporte a deep links, rotas tipadas |
| **Estado global** | Riverpod | Reativo, testável, escalável para MVP e além |
| **Backend** | Firebase (BaaS) | Gratuito no início, escala rápido |
| **Banco de dados** | Firestore (NoSQL) | Tempo real, flexível |
| **Autenticação** | Firebase Auth | Login e-mail/senha + Google |
| **Chat** | Firestore Realtime | Mensagens em tempo real |
| **Armazenamento** | Firebase Storage | Fotos de perfil e documentos |
| **Notificações** | Firebase Cloud Messaging (FCM) | Alertas de solicitações |

### 3.2 Principais Pacotes Flutter

```yaml
# pubspec.yaml (referência)
dependencies:
  flutter:
    sdk: flutter
  go_router: ^13.0.0
  flutter_riverpod: ^2.5.0
  firebase_core: ^2.x
  firebase_auth: ^4.x
  cloud_firestore: ^4.x
  firebase_storage: ^11.x
  firebase_messaging: ^14.x
  google_fonts: ^6.x
  image_picker: ^1.x
  cached_network_image: ^3.x
  intl: ^0.19.0
```

### 3.3 Tipos de Usuário

- **Cliente:** quem contrata serviços — cadastro simples em 3 etapas.
- **Profissional:** quem oferece serviços — cadastro completo em 4 etapas.
- **Admin (futuro):** painel web para moderar conteúdo.

### 3.4 Fluxo Principal do Sistema

```
Cliente busca serviço
  → Vê lista de profissionais
  → Escolhe um
  → Envia solicitação
  → Profissional aceita
  → Chat para combinar detalhes
  → Serviço realizado
  → Cliente avalia
```

---

## 4. Mapa de Telas

### 4.1 Telas Comuns (pré-login)

| Nº | Tela | Descrição |
|----|------|-----------|
| 01 | Splash Screen | Logo animado na abertura do app |
| 02 | Onboarding | 3 slides apresentando o app (1ª vez) |
| 03 | Boas-vindas | Botões "Entrar" e "Criar conta" |
| 04 | Escolha de perfil | Cliente ou Profissional |
| 05 | Login | E-mail + senha + Google |
| 06 | Recuperar senha | Código OTP por e-mail |
| 07 | Erro / Sem conexão | Tela de fallback amigável |

### 4.2 Fluxo do Cliente

| Nº | Tela | Descrição |
|----|------|-----------|
| 08 | Cadastro Cliente — Etapa 1 | Dados pessoais: nome, email, tel, senha |
| 09 | Cadastro Cliente — Etapa 2 | Localização: CEP, cidade, bairro |
| 10 | Cadastro Cliente — Etapa 3 | Foto de perfil + termos |
| 11 | Home Cliente | Categorias, busca rápida, profissionais próximos |
| 12 | Busca de serviços | Campo de busca + filtros |
| 13 | Resultados da busca | Lista de profissionais encontrados |
| 14 | Perfil do profissional | Detalhes, avaliações, botão solicitar |
| 15 | Solicitar serviço | Formulário de solicitação com data e descrição |
| 16 | Confirmação | Feedback de solicitação enviada |
| 17 | Chat com profissional | Mensagens em tempo real |
| 18 | Minhas solicitações | Histórico com status coloridos |
| 19 | Avaliar profissional | Estrelas + texto + tags rápidas |
| 20 | Perfil do cliente | Dados + histórico + configurações |

### 4.3 Fluxo do Profissional

| Nº | Tela | Descrição |
|----|------|-----------|
| 21 | Cadastro Profissional — Etapa 1 | Dados pessoais: nome, CPF, tel, email, senha |
| 22 | Cadastro Profissional — Etapa 2 | Serviços: categoria, chips, descrição, preço |
| 23 | Cadastro Profissional — Etapa 3 | Localização: CEP, raio de atendimento |
| 24 | Cadastro Profissional — Etapa 4 | Foto + documento verificação + termos |
| 25 | Home Profissional | Toggle disponível, resumo do dia, novas solicitações |
| 26 | Solicitações recebidas | Abas: Novas, Aceitas, Concluídas |
| 27 | Detalhe da solicitação | Infos completas + aceitar/recusar |
| 28 | Chat com cliente | Mensagens em tempo real |
| 29 | Meus serviços | Gerenciar serviços e preços |
| 30 | Minhas avaliações | Nota geral + lista de feedbacks |
| 31 | Perfil público | Como o cliente vê o profissional |

### 4.4 Telas Gerais

| Nº | Tela | Descrição |
|----|------|-----------|
| 32 | Notificações | Central de alertas cronológicos |
| 33 | Configurações | Conta, notificações, privacidade, sobre |

---

## 5. Especificação dos Cadastros

> **Para IAs:** Ao implementar formulários em Flutter, use `TextFormField` dentro de `Form` com `GlobalKey<FormState>`. Aplique as máscaras usando o pacote `mask_text_input_formatter`. Implemente validação em tempo real (ao perder foco ou ao digitar).

### 5.1 Cadastro do Cliente — 3 Etapas

#### Etapa 1: Dados Pessoais

| Campo | Tipo | Máscara | Obrigatório |
|-------|------|---------|-------------|
| Nome completo | Text | — | Sim |
| E-mail | Email | — | Sim |
| Telefone (WhatsApp) | Tel | `(00) 00000-0000` | Sim |
| Senha | Password | — | Sim (mín. 8 chars) |
| Confirmar senha | Password | — | Sim |

#### Etapa 2: Localização

| Campo | Tipo | Obs. |
|-------|------|------|
| CEP | Text | Auto-preenche cidade e estado via API ViaCEP |
| Cidade | Text (readonly) | Preenchido via CEP |
| Estado | Text (readonly) | Preenchido via CEP |
| Bairro | Text | Manual |

#### Etapa 3: Foto

- Foto de perfil — opcional (pode adicionar depois)
- Aceite dos Termos de Uso — obrigatório para criar conta

---

### 5.2 Cadastro do Profissional — 4 Etapas

#### Etapa 1: Dados Pessoais

| Campo | Tipo | Máscara | Obrigatório |
|-------|------|---------|-------------|
| Nome completo | Text | — | Sim |
| CPF | Text | `000.000.000-00` | Sim |
| Telefone (WhatsApp) | Tel | `(00) 00000-0000` | Sim |
| E-mail | Email | — | Sim |
| Senha | Password | — | Sim (mín. 8 chars) |
| Confirmar senha | Password | — | Sim |

#### Etapa 2: Serviços

- **Categoria principal** — `DropdownButtonFormField` (obrigatório)
- **Serviços específicos** — chips de múltipla escolha com `FilterChip` (mínimo 1)
- **Descrição livre** — `TextField` com `maxLength: 300`
- **Preço médio** — campo numérico + seletor de tipo (por hora / diária / serviço)

#### Etapa 3: Localização

- CEP com auto-preenchimento via ViaCEP
- Bairro principal
- Raio de atendimento — `Slider` de 1 a 50 km
- Bairros adicionais — chips removíveis com `InputChip` (opcional)

#### Etapa 4: Foto e Verificação

- Foto de perfil — **obrigatória** (via `image_picker`)
- Foto segurando documento — opcional (gera badge "Verificado")
- Aceite dos Termos de Uso — obrigatório

---

## 6. Componentes Reutilizáveis

> **Para IAs:** Todos os componentes abaixo devem ser implementados como `StatelessWidget` ou `StatefulWidget` em `lib/core/widgets/`. Nunca repita lógica de estilo entre telas — crie o componente uma vez e reutilize.

### 6.1 Botões

| Nome | Estilo | Uso |
|------|--------|-----|
| Botão Primário | Fundo `#FF6B00`, texto branco, `borderRadius: 12` | Ação principal de cada tela |
| Botão Secundário | `OutlinedButton` cor laranja, fundo transparente | Ação alternativa |
| Botão Desabilitado | Fundo `#CCCCCC`, texto branco | Quando formulário incompleto |
| Link / Texto | `TextButton` cor laranja | Links de navegação (ex: "Já tem conta?") |

```dart
// Exemplo: AppPrimaryButton
class AppPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed; // null = desabilitado

  const AppPrimaryButton({required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: onPressed != null ? AppColors.primary : AppColors.disabled,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    onPressed: onPressed,
    child: Text(label, style: AppTextStyles.buttonLabel),
  );
}
```

### 6.2 Campos de Formulário

| Estado | Cor da borda | Observação |
|--------|-------------|------------|
| Padrão | `#EEEEEE` 1.5px | Label flutuante |
| Focado | `#FF6B00` 1.5px | Ícone esquerdo muda para laranja |
| Erro | `#E74C3C` 1.5px | Mensagem de erro abaixo do campo |
| Válido | `#27AE60` 1.5px | Ícone `check` verde à direita |

- **Float label:** use `InputDecoration` com `labelText` e `floatingLabelBehavior: FloatingLabelBehavior.auto`
- **Ícone esquerdo:** sempre cinza `#9E9E9E` padrão; muda para laranja ao focar (use `FocusNode`)

### 6.3 Cards

| Card | Campos exibidos |
|------|----------------|
| Card profissional (mini) | Foto, nome, serviço, nota, bairro |
| Card profissional (completo) | Foto, nome, nota, avaliações, localização, serviços, preço, badges |
| Card solicitação (cliente) | Nome profissional, serviço, data, status colorido |
| Card solicitação (profissional) | Nome cliente, serviço, data, descrição, botões aceitar/recusar |

### 6.4 Status de Solicitação

| Status | Cor | Hex |
|--------|-----|-----|
| Aguardando resposta | Amarelo | `#F1C40F` |
| Aceita | Laranja | `#FF6B00` |
| Em andamento | Azul | `#2980B9` |
| Concluída | Verde | `#27AE60` |
| Cancelada | Vermelho | `#E74C3C` |

```dart
// Enum de referência
enum RequestStatus { pending, accepted, ongoing, done, cancelled }

Color statusColor(RequestStatus s) => switch (s) {
  RequestStatus.pending   => const Color(0xFFF1C40F),
  RequestStatus.accepted  => const Color(0xFFFF6B00),
  RequestStatus.ongoing   => const Color(0xFF2980B9),
  RequestStatus.done      => const Color(0xFF27AE60),
  RequestStatus.cancelled => const Color(0xFFE74C3C),
};
```

---

## 7. Roadmap de Desenvolvimento

### 7.1 Fases de Desenvolvimento

| Fase | Descrição | Telas | Prazo estimado |
|------|-----------|-------|----------------|
| MVP | App funcional básico: cadastro, busca, solicitar | 01 a 27 | 3 a 4 meses |
| V1.1 | Chat em tempo real + gestão de solicitações | 17, 18, 28, 29, 07 | 1 mês |
| V1.2 | Sistema de avaliações + notificações push | 19, 30, 32 | 3 semanas |
| V2.0 | Configurações + melhorias de UX + performance | 33 + ajustes gerais | 1 mês |

### 7.2 Ordem de Aprendizado / Implementação Recomendada

1. Configurar Flutter + GoRouter (telas de onboarding e login)
2. Conectar Firebase Auth (cadastro e login funcionando)
3. Criar Firestore: estrutura de usuários (cliente e profissional)
4. Tela Home + busca básica (listar profissionais do Firestore)
5. Fluxo de solicitação (criar e listar solicitações)
6. Chat com Firestore Realtime
7. Sistema de avaliações
8. Notificações push com FCM

### 7.3 Estrutura de Pastas Recomendada (Flutter)

```
lib/
├── core/
│   ├── theme/
│   │   ├── app_colors.dart
│   │   └── app_text_styles.dart
│   ├── widgets/           # Componentes reutilizáveis
│   └── utils/
├── features/
│   ├── auth/              # Login, cadastro, recuperar senha
│   ├── home/              # Home cliente e profissional
│   ├── search/            # Busca e resultados
│   ├── requests/          # Solicitações
│   ├── chat/              # Chat em tempo real
│   ├── profile/           # Perfil público e privado
│   └── reviews/           # Avaliações
├── models/                # Modelos de dados (UserModel, ProfessionalModel, etc.)
├── providers/             # Riverpod providers
└── main.dart
```

---

## 8. Estrutura do Banco de Dados (Firestore)

> **Para IAs:** Use estes modelos como base para criar as classes Dart correspondentes em `lib/models/`. Inclua métodos `fromMap(Map<String, dynamic>)` e `toMap()` em cada modelo. Use `freezed` ou classes simples conforme a complexidade.

### 8.1 Coleção: `users`

```
users/{userId}
  uid: string
  type: 'client' | 'professional'
  name: string
  email: string
  phone: string
  city: string
  neighborhood: string
  photoURL: string
  createdAt: timestamp
```

### 8.2 Coleção: `professionals`

```
professionals/{userId}
  uid: string
  category: string
  services: string[]
  description: string
  price: number
  priceType: 'hour' | 'day' | 'service'
  cep: string
  radius: number (km)
  neighborhoods: string[]
  rating: number
  ratingCount: number
  available: boolean
  verified: boolean
```

### 8.3 Coleção: `requests`

```
requests/{requestId}
  clientId: string
  professionalId: string
  service: string
  description: string
  address: string
  date: timestamp
  timeSlot: 'morning' | 'afternoon' | 'evening'
  status: 'pending' | 'accepted' | 'ongoing' | 'done' | 'cancelled'
  photoURL: string (opcional)
  createdAt: timestamp
```

### 8.4 Coleção: `messages`

```
messages/{requestId}/chat/{messageId}
  senderId: string
  text: string
  imageURL: string (opcional)
  read: boolean
  createdAt: timestamp
```

### 8.5 Coleção: `reviews`

```
reviews/{reviewId}
  requestId: string
  clientId: string
  professionalId: string
  rating: number (1-5)
  comment: string
  tags: string[]
  createdAt: timestamp
```

---

## 9. Modelo de Monetização (futuro)

| Fase | Modelo | Descrição |
|------|--------|-----------|
| MVP (agora) | Gratuito 100% | Construir base de usuários sem restrição |
| V2 | Freemium profissional | Plano grátis: 3 contatos/mês / Plano Pro: ilimitado R$29/mês |
| V3 | Destaque em busca | Profissional paga para aparecer primeiro nos resultados |
| V4 | Comissão | % sobre serviços pagos pelo app (pagamento in-app) |

---

## 10. Histórico de Versões

| Versão | Data | Descrição |
|--------|------|-----------|
| 1.0 | Abril/2026 | Criação do documento inicial completo |
| 2.0 | Abril/2026 | Migração de React Native/Expo para Flutter/Dart; adaptação para uso por IAs; adição de exemplos de código, estrutura de pastas e notas contextuais |
| — | — | Próxima versão: adicionar wireframes e protótipos |

---

*Desenvolvido por: **Wesley Marques Mota Santos***
*Projeto: ServiFast — Plataforma de Serviços Hiperlocal*
