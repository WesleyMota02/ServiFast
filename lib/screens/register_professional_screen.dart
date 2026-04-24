import 'package:flutter/material.dart';
import '../widgets/floating_input.dart';
import 'package:confetti/confetti.dart';

class RegisterProfessionalScreen extends StatefulWidget {
  const RegisterProfessionalScreen({super.key});

  @override
  State<RegisterProfessionalScreen> createState() => _RegisterProfessionalScreenState();
}

class _RegisterProfessionalScreenState extends State<RegisterProfessionalScreen> {
  int _step = 1;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  final _nomeCtrl = TextEditingController();
  final _cpfCtrl = TextEditingController();
  final _telefoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _senhaCtrl = TextEditingController();
  final _confirmarSenhaCtrl = TextEditingController();
  
  final _descricaoCtrl = TextEditingController();
  final _precoCtrl = TextEditingController();
  
  final _cepCtrl = TextEditingController();
  final _cidadeCtrl = TextEditingController();
  final _estadoCtrl = TextEditingController();
  final _bairroCtrl = TextEditingController();
  final _novoBairroCtrl = TextEditingController();

  Map<String, String> _errors = {};
  
  String? _categoria;
  List<String> _servicos = [];
  String _tipoCobranca = 'Diária';
  
  double _raio = 15;
  List<String> _bairrosAtendidos = [];

  bool _termos = false;
  bool _foto = false;
  bool _documento = false;
  
  late ConfettiController _confettiController;

  final List<String> _categorias = [
    "Elétrico", "Hidráulico / Encanamento", "Pintura", "Pedreiro / Alvenaria", 
    "Marcenaria / Móveis", "Jardinagem", "Limpeza", "Reformas em Geral", 
    "Ar-condicionado", "Outros"
  ];

  final Map<String, List<String>> _servicosPorCategoria = {
    "Pintura": ["Pintura interna", "Pintura ext.", "Textura", "Grafiato", "Pintura metal", "Verniz"],
    "Elétrico": ["Instalação elétrica", "Manutenção", "Troca de fiação", "Quadro de luz", "Luminárias"],
    "default": ["Serviço Geral 1", "Serviço Geral 2", "Serviço Geral 3"]
  };

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _senhaCtrl.addListener(() => setState(() {}));
    _descricaoCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _cpfCtrl.dispose();
    _telefoneCtrl.dispose();
    _emailCtrl.dispose();
    _senhaCtrl.dispose();
    _confirmarSenhaCtrl.dispose();
    _descricaoCtrl.dispose();
    _precoCtrl.dispose();
    _cepCtrl.dispose();
    _cidadeCtrl.dispose();
    _estadoCtrl.dispose();
    _bairroCtrl.dispose();
    _novoBairroCtrl.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  List<String> _getServicosList() {
    return _servicosPorCategoria[_categoria] ?? _servicosPorCategoria["default"]!;
  }

  bool _validateStep1() {
    final newErrs = <String, String>{};
    if (_nomeCtrl.text.isEmpty || _nomeCtrl.text.split(' ').length < 2) newErrs['nome'] = "Mínimo 2 palavras";
    if (_cpfCtrl.text.length < 11) newErrs['cpf'] = "CPF inválido";
    if (_telefoneCtrl.text.isEmpty) newErrs['telefone'] = "Este campo é obrigatório";
    if (!_emailCtrl.text.contains('@')) newErrs['email'] = "Digite um e-mail válido";
    if (_senhaCtrl.text.length < 8) newErrs['senha'] = "Mínimo 8 caracteres";
    if (_senhaCtrl.text != _confirmarSenhaCtrl.text) newErrs['confirmarSenha'] = "As senhas não coincidem";
    
    setState(() => _errors = newErrs);
    return newErrs.isEmpty;
  }

  bool _validateStep2() {
    final newErrs = <String, String>{};
    if (_categoria == null) newErrs['categoria'] = "Este campo é obrigatório";
    if (_servicos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Selecione pelo menos 1 serviço'), backgroundColor: Color(0xFFFF6B00)));
      return false;
    }
    if (_descricaoCtrl.text.isEmpty) newErrs['descricao'] = "Este campo é obrigatório";
    if (_precoCtrl.text.isEmpty) newErrs['preco'] = "Este campo é obrigatório";
    
    setState(() => _errors = newErrs);
    return newErrs.isEmpty;
  }

  bool _validateStep3() {
    final newErrs = <String, String>{};
    if (_cepCtrl.text.isEmpty) newErrs['cep'] = "Este campo é obrigatório";
    if (_bairroCtrl.text.isEmpty) newErrs['bairro'] = "Este campo é obrigatório";
    
    setState(() => _errors = newErrs);
    return newErrs.isEmpty;
  }

  void _handleNext() {
    if (_step == 1 && !_validateStep1()) return;
    if (_step == 2 && !_validateStep2()) return;
    if (_step == 3 && !_validateStep3()) return;
    
    setState(() => _step++);
  }

  void _handleBack() {
    if (_step > 1) {
      setState(() => _step--);
    } else {
      Navigator.pop(context);
    }
  }

  void _handleFinish() {
    if (!_termos) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Você precisa aceitar os termos')),
      );
      return;
    }
    setState(() => _step = 5);
    _confettiController.play();
  }

  void _searchCep() {
    if (_cepCtrl.text.length >= 8) {
      setState(() {
        _cidadeCtrl.text = "Mauá";
        _estadoCtrl.text = "SP";
      });
    }
  }

  void _toggleServico(String serv) {
    setState(() {
      if (_servicos.contains(serv)) {
        _servicos.remove(serv);
      } else {
        _servicos.add(serv);
      }
    });
  }

  void _addBairro() {
    final b = _novoBairroCtrl.text.trim();
    if (b.isNotEmpty && !_bairrosAtendidos.contains(b)) {
      setState(() {
        _bairrosAtendidos.add(b);
        _novoBairroCtrl.clear();
      });
    }
  }

  Map<String, dynamic> _getForcaSenha() {
    final s = _senhaCtrl.text;
    if (s.isEmpty) return {'score': 0, 'label': '', 'color': const Color(0xFFEEEEEE)};
    if (s.length < 6) return {'score': 0.25, 'label': 'Fraca', 'color': const Color(0xFFE74C3C)};
    if (s.length >= 8 && s.contains(RegExp(r'[A-Z]')) && s.contains(RegExp(r'[0-9]'))) {
      return {'score': 1.0, 'label': 'Forte', 'color': const Color(0xFF27AE60)};
    }
    return {'score': 0.6, 'label': 'Média', 'color': const Color(0xFFFF6B00)};
  }

  @override
  Widget build(BuildContext context) {
    if (_step == 5) return _buildSuccessScreen();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A)),
                    onPressed: _handleBack,
                  ),
                ],
              ),
            ),
            
            // Stepper
            _buildStepper(),

            // Conteúdo
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _buildStepContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepper() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(height: 2, width: double.infinity, color: const Color(0xFFEEEEEE)),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: 0,
            top: 15,
            width: (MediaQuery.of(context).size.width - 48) * ((_step - 1) / 3),
            child: Container(height: 2, color: const Color(0xFFFF6B00)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStepDot(1, "Dados"),
              _buildStepDot(2, "Serv."),
              _buildStepDot(3, "Local"),
              _buildStepDot(4, "Foto"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepDot(int id, String label) {
    final bool isPast = _step > id;
    final bool isCurrent = _step == id;
    
    return GestureDetector(
      onTap: () {
        if (id < _step) setState(() => _step = id);
      },
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isPast || isCurrent ? const Color(0xFFFF6B00) : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: isPast || isCurrent ? const Color(0xFFFF6B00) : const Color(0xFFEEEEEE),
                width: 2,
              ),
              boxShadow: isCurrent ? [const BoxShadow(color: Color(0xFFFFF3E8), spreadRadius: 4)] : [],
            ),
            child: Center(
              child: isPast
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : Text(
                      id.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isCurrent ? Colors.white : const Color(0xFFAAAAAA),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: isPast || isCurrent ? const Color(0xFFFF6B00) : const Color(0xFFAAAAAA),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    if (_step == 1) return _buildStep1();
    if (_step == 2) return _buildStep2();
    if (_step == 3) return _buildStep3();
    if (_step == 4) return _buildStep4();
    return const SizedBox();
  }

  Widget _buildStep1() {
    final forca = _getForcaSenha();
    return Column(
      key: const ValueKey(1),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Cadastro Profissional', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A))),
        const SizedBox(height: 4),
        const Text('Etapa 1: Dados pessoais', style: TextStyle(fontSize: 14, color: Color(0xFF6B6B6B))),
        const SizedBox(height: 32),
        
        FloatingInput(label: 'Nome completo', icon: Icons.person_outline, controller: _nomeCtrl, errorText: _errors['nome']),
        const SizedBox(height: 16),
        FloatingInput(label: 'CPF', icon: Icons.badge_outlined, controller: _cpfCtrl, keyboardType: TextInputType.number, errorText: _errors['cpf']),
        const SizedBox(height: 16),
        FloatingInput(label: 'Telefone / WhatsApp', icon: Icons.phone_outlined, controller: _telefoneCtrl, keyboardType: TextInputType.phone, errorText: _errors['telefone']),
        const SizedBox(height: 16),
        FloatingInput(label: 'E-mail', icon: Icons.mail_outline, controller: _emailCtrl, keyboardType: TextInputType.emailAddress, errorText: _errors['email']),
        const SizedBox(height: 16),
        
        FloatingInput(
          label: 'Senha', icon: Icons.lock_outline, controller: _senhaCtrl, obscureText: !_showPassword, errorText: _errors['senha'],
          rightElement: IconButton(icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility, color: const Color(0xFF6B6B6B)), onPressed: () => setState(() => _showPassword = !_showPassword)),
        ),
        const SizedBox(height: 16),
        FloatingInput(
          label: 'Confirmar senha', icon: Icons.lock_outline, controller: _confirmarSenhaCtrl, obscureText: !_showConfirmPassword, errorText: _errors['confirmarSenha'],
          rightElement: IconButton(icon: Icon(_showConfirmPassword ? Icons.visibility_off : Icons.visibility, color: const Color(0xFF6B6B6B)), onPressed: () => setState(() => _showConfirmPassword = !_showConfirmPassword)),
        ),
        
        if (_senhaCtrl.text.isNotEmpty) ...[
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Indicador de força da senha:', style: TextStyle(fontSize: 13, color: Color(0xFF6B6B6B))),
                  Text(forca['label'] as String, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: forca['color'] as Color)),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                height: 8, width: double.infinity, decoration: BoxDecoration(color: const Color(0xFFEEEEEE), borderRadius: BorderRadius.circular(4)),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft, widthFactor: forca['score'] as double,
                  child: Container(decoration: BoxDecoration(color: forca['color'] as Color, borderRadius: BorderRadius.circular(4))),
                ),
              ),
            ],
          )
        ],

        const SizedBox(height: 32),
        ElevatedButton(onPressed: _handleNext, child: const Text('Próximo →')),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      key: const ValueKey(2),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Seus serviços', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A))),
        const SizedBox(height: 4),
        const Text('Etapa 2: O que você oferece?', style: TextStyle(fontSize: 14, color: Color(0xFF6B6B6B))),
        const SizedBox(height: 32),
        
        const Text('Categoria principal *', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF1A1A1A))),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(border: Border.all(color: _errors.containsKey('categoria') ? const Color(0xFFE74C3C) : const Color(0xFFEEEEEE), width: 1.5), borderRadius: BorderRadius.circular(12)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _categoria,
              hint: const Text('Selecione uma categoria'),
              isExpanded: true,
              items: _categorias.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (val) {
                setState(() {
                  _categoria = val;
                  _servicos.clear();
                  _errors.remove('categoria');
                });
              },
            ),
          ),
        ),
        if (_errors.containsKey('categoria')) Padding(padding: const EdgeInsets.only(top: 4), child: Text(_errors['categoria']!, style: const TextStyle(color: Color(0xFFE74C3C), fontSize: 12))),

        if (_categoria != null) ...[
          const SizedBox(height: 24),
          const Text('Serviços específicos *', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF1A1A1A))),
          const SizedBox(height: 4),
          const Text('Selecione todos que se aplicam:', style: TextStyle(fontSize: 13, color: Color(0xFF6B6B6B))),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: _getServicosList().map((serv) {
              final isSelected = _servicos.contains(serv);
              return GestureDetector(
                onTap: () => _toggleServico(serv),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFFF6B00) : Colors.white,
                    border: Border.all(color: isSelected ? const Color(0xFFFF6B00) : const Color(0xFFEEEEEE)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(isSelected ? Icons.check : Icons.circle_outlined, size: 14, color: isSelected ? Colors.white : const Color(0xFF6B6B6B)),
                      const SizedBox(width: 4),
                      Text(serv, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: isSelected ? Colors.white : const Color(0xFF6B6B6B))),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],

        const SizedBox(height: 24),
        const Text('Descrição dos seus serviços *', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF1A1A1A))),
        const SizedBox(height: 8),
        TextField(
          controller: _descricaoCtrl, maxLines: 4, maxLength: 300,
          decoration: InputDecoration(
            hintText: 'Ex: "Sou pintor há 10 anos, especialista em acabamento fino..."',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFEEEEEE), width: 1.5)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFEEEEEE), width: 1.5)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFFF6B00), width: 1.5)),
            errorText: _errors['descricao'],
          ),
        ),

        const SizedBox(height: 16),
        const Text('Preço médio cobrado *', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF1A1A1A))),
        const SizedBox(height: 8),
        FloatingInput(label: '0,00', icon: Icons.attach_money, controller: _precoCtrl, keyboardType: TextInputType.number, errorText: _errors['preco']),
        
        const SizedBox(height: 16),
        Row(
          children: [
            const Text('Cobro por:', style: TextStyle(fontSize: 13, color: Color(0xFF6B6B6B))),
            const SizedBox(width: 16),
            _buildRadio('Hora'), _buildRadio('Diária'), _buildRadio('Serv.'),
          ],
        ),

        const SizedBox(height: 32),
        ElevatedButton(onPressed: _handleNext, child: const Text('Próximo →')),
      ],
    );
  }

  Widget _buildRadio(String label) {
    final isSelected = _tipoCobranca == label;
    return GestureDetector(
      onTap: () => setState(() => _tipoCobranca = label),
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Row(
          children: [
            Container(
              width: 16, height: 16,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: isSelected ? const Color(0xFFFF6B00) : const Color(0xFFEEEEEE), width: 2)),
              child: isSelected ? Center(child: Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFFF6B00)))) : null,
            ),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A1A))),
          ],
        ),
      ),
    );
  }

  Widget _buildStep3() {
    return Column(
      key: const ValueKey(3),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Onde você atua?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A))),
        const SizedBox(height: 4),
        const Text('Etapa 3: Localização e raio', style: TextStyle(fontSize: 14, color: Color(0xFF6B6B6B))),
        const SizedBox(height: 32),
        
        FloatingInput(
          label: 'CEP', icon: Icons.location_on_outlined, controller: _cepCtrl, keyboardType: TextInputType.number, errorText: _errors['cep'],
          rightElement: IconButton(icon: const Icon(Icons.search, color: Color(0xFFFF6B00)), onPressed: _searchCep),
        ),
        
        if (_cidadeCtrl.text.isNotEmpty) ...[
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: const Color(0xFFF9F9F9), border: Border.all(color: const Color(0xFFEEEEEE)), borderRadius: BorderRadius.circular(12)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Cidade', style: TextStyle(fontSize: 11, color: Color(0xFF6B6B6B))), Text(_cidadeCtrl.text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1A1A1A)))]),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: const Color(0xFFF9F9F9), border: Border.all(color: const Color(0xFFEEEEEE)), borderRadius: BorderRadius.circular(12)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Estado', style: TextStyle(fontSize: 11, color: Color(0xFF6B6B6B))), Text(_estadoCtrl.text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1A1A1A)))]),
                ),
              ),
            ],
          )
        ],

        const SizedBox(height: 24),
        FloatingInput(label: 'Bairro principal', icon: Icons.location_city_outlined, controller: _bairroCtrl, errorText: _errors['bairro']),
        
        const SizedBox(height: 24),
        const Text('Raio de atendimento *', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF1A1A1A))),
        const Text('Até quantos km você se desloca?', style: TextStyle(fontSize: 13, color: Color(0xFF6B6B6B))),
        Slider(
          value: _raio, min: 1, max: 50, activeColor: const Color(0xFFFF6B00), inactiveColor: const Color(0xFFEEEEEE),
          onChanged: (val) => setState(() => _raio = val),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('1 km', style: TextStyle(fontSize: 12, color: Color(0xFF6B6B6B))), Text('50 km', style: TextStyle(fontSize: 12, color: Color(0xFF6B6B6B)))]),
        Center(child: Text('Selecionado: ${_raio.toInt()} km', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF6B00)))),

        const SizedBox(height: 24),
        const Text('Você atende em quais bairros?', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF1A1A1A))),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: TextField(controller: _novoBairroCtrl, decoration: InputDecoration(hintText: 'Adicionar bairro', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), contentPadding: const EdgeInsets.symmetric(horizontal: 16)), onSubmitted: (_) => _addBairro())),
            const SizedBox(width: 8),
            Container(decoration: BoxDecoration(color: const Color(0xFFFFF3E8), borderRadius: BorderRadius.circular(12)), child: IconButton(icon: const Icon(Icons.add, color: Color(0xFFFF6B00)), onPressed: _addBairro)),
          ],
        ),
        if (_bairrosAtendidos.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: _bairrosAtendidos.map((b) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: const Color(0xFFF9F9F9), border: Border.all(color: const Color(0xFFEEEEEE)), borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(b, style: const TextStyle(fontSize: 13)),
                  const SizedBox(width: 4),
                  GestureDetector(onTap: () => setState(() => _bairrosAtendidos.remove(b)), child: const Icon(Icons.close, size: 14, color: Color(0xFF6B6B6B))),
                ],
              ),
            )).toList(),
          ),
        ],

        const SizedBox(height: 32),
        ElevatedButton(onPressed: _handleNext, child: const Text('Próximo →')),
      ],
    );
  }

  Widget _buildStep4() {
    return Column(
      key: const ValueKey(4),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Quase lá! 🎉', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A))),
        const SizedBox(height: 4),
        const Text('Etapa 4: Foto do perfil', style: TextStyle(fontSize: 14, color: Color(0xFF6B6B6B))),
        const SizedBox(height: 32),
        
        const Text('Sua foto de perfil *', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => setState(() => _foto = true),
                child: Container(
                  width: 120, height: 120,
                  decoration: BoxDecoration(color: const Color(0xFFFFF3E8), shape: BoxShape.circle, border: Border.all(color: const Color(0xFFFF6B00), width: 2)),
                  child: _foto
                      ? const ClipOval(child: Icon(Icons.person, size: 80, color: Color(0xFFFF6B00)))
                      : const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.camera_alt, color: Color(0xFFFF6B00), size: 32), Text('Adicionar\nfoto', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFFFF6B00), fontSize: 12, fontWeight: FontWeight.w500))]),
                ),
              ),
              const SizedBox(height: 12),
              const Text('Toque para tirar foto ou escolher da galeria', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Color(0xFF6B6B6B))),
            ],
          ),
        ),

        const SizedBox(height: 24),
        const Divider(color: Color(0xFFEEEEEE), thickness: 1),
        const SizedBox(height: 24),

        const Text('Documento de verificação (opcional)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        const Text('Aumenta sua credibilidade e gera o badge Verificado no seu perfil', style: TextStyle(fontSize: 12, color: Color(0xFF6B6B6B))),
        const SizedBox(height: 16),
        Center(
          child: GestureDetector(
            onTap: () => setState(() => _documento = true),
            child: Container(
              width: 100, height: 100,
              decoration: BoxDecoration(color: const Color(0xFFF9F9F9), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFAAAAAA), width: 2)),
              child: _documento
                  ? Container(decoration: BoxDecoration(color: const Color(0xFFE5F7ED), borderRadius: BorderRadius.circular(14)), child: const Center(child: Icon(Icons.check, color: Color(0xFF27AE60), size: 32)))
                  : const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.description, color: Color(0xFFAAAAAA), size: 24), Text('Enviar foto\nsegurando doc.', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 11, fontWeight: FontWeight.w500))]),
            ),
          ),
        ),

        const SizedBox(height: 24),
        const Divider(color: Color(0xFFEEEEEE), thickness: 1),
        const SizedBox(height: 24),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => setState(() => _termos = !_termos),
              child: Container(
                width: 24, height: 24, margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(color: _termos ? const Color(0xFFFF6B00) : Colors.white, border: Border.all(color: _termos ? const Color(0xFFFF6B00) : const Color(0xFFAAAAAA), width: 2), borderRadius: BorderRadius.circular(4)),
                child: _termos ? const Icon(Icons.check, color: Colors.white, size: 16) : null,
              ),
            ),
            const Expanded(
              child: Text.rich(TextSpan(text: 'Aceito os ', style: TextStyle(fontSize: 13, color: Color(0xFF6B6B6B)), children: [TextSpan(text: 'Termos de Uso', style: TextStyle(color: Color(0xFFFF6B00), decoration: TextDecoration.underline, fontWeight: FontWeight.w500)), TextSpan(text: ' e a '), TextSpan(text: 'Política de Privacidade', style: TextStyle(color: Color(0xFFFF6B00), decoration: TextDecoration.underline, fontWeight: FontWeight.w500))])),
            ),
          ],
        ),

        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: _termos ? _handleFinish : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _termos ? const Color(0xFFFF6B00) : const Color(0xFFEEEEEE),
            foregroundColor: _termos ? Colors.white : const Color(0xFFAAAAAA),
            elevation: _termos ? 4 : 0,
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [if (_termos) const Icon(Icons.check, size: 20), if (_termos) const SizedBox(width: 8), const Text('Criar minha conta')]),
        ),
      ],
    );
  }

  Widget _buildSuccessScreen() {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 96, height: 96, decoration: const BoxDecoration(color: Color(0xFFFFF3E8), shape: BoxShape.circle), child: const Center(child: Text('🎉', style: TextStyle(fontSize: 40)))),
                const SizedBox(height: 24),
                const Text('Cadastro realizado!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A))),
                const SizedBox(height: 8),
                Text('Bem-vindo ao ServiFast, ${_nomeCtrl.text.split(" ").first.isNotEmpty ? _nomeCtrl.text.split(" ").first : "Profissional"}!', style: const TextStyle(fontSize: 18, color: Color(0xFF1A1A1A))),
                const SizedBox(height: 16),
                const Text('Seu perfil já está visível para clientes da sua região.', textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: Color(0xFF6B6B6B))),
                
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: const Color(0xFFF9F9F9), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFEEEEEE))),
                  child: Column(
                    children: [
                      Row(children: [const Icon(Icons.check_circle, color: Color(0xFF27AE60), size: 20), const SizedBox(width: 8), const Text('Dados pessoais', style: TextStyle(color: Color(0xFF1A1A1A)))]),
                      const SizedBox(height: 12),
                      Row(children: [const Icon(Icons.check_circle, color: Color(0xFF27AE60), size: 20), const SizedBox(width: 8), const Text('Serviços cadastrados', style: TextStyle(color: Color(0xFF1A1A1A)))]),
                      const SizedBox(height: 12),
                      Row(children: [const Icon(Icons.check_circle, color: Color(0xFF27AE60), size: 20), const SizedBox(width: 8), const Text('Localização definida', style: TextStyle(color: Color(0xFF1A1A1A)))]),
                      const SizedBox(height: 12),
                      Row(children: [const Icon(Icons.check_circle, color: Color(0xFF27AE60), size: 20), const SizedBox(width: 8), const Text('Foto adicionada', style: TextStyle(color: Color(0xFF1A1A1A)))]),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.pushReplacementNamed(context, '/professional_home');
                  },
                  child: const Text('Ir para minha Home →'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {},
                  child: const Text('Completar perfil depois', style: TextStyle(color: Color(0xFF6B6B6B), fontWeight: FontWeight.w500)),
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            colors: const [Color(0xFFFF6B00), Color(0xFFFFA466), Colors.white],
            shouldLoop: false,
          ),
        ),
      ],
    );
  }
}
