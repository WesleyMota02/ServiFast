import 'package:flutter/material.dart';
import '../widgets/floating_input.dart';
import 'package:confetti/confetti.dart';

class RegisterClientScreen extends StatefulWidget {
  const RegisterClientScreen({super.key});

  @override
  State<RegisterClientScreen> createState() => _RegisterClientScreenState();
}

class _RegisterClientScreenState extends State<RegisterClientScreen> {
  int _step = 1;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  final _nomeCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _telefoneCtrl = TextEditingController();
  final _senhaCtrl = TextEditingController();
  final _confirmarSenhaCtrl = TextEditingController();
  final _cepCtrl = TextEditingController();
  final _cidadeCtrl = TextEditingController();
  final _estadoCtrl = TextEditingController();
  final _bairroCtrl = TextEditingController();

  Map<String, String> _errors = {};
  bool _termos = false;
  bool _foto = false;
  
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _senhaCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _emailCtrl.dispose();
    _telefoneCtrl.dispose();
    _senhaCtrl.dispose();
    _confirmarSenhaCtrl.dispose();
    _cepCtrl.dispose();
    _cidadeCtrl.dispose();
    _estadoCtrl.dispose();
    _bairroCtrl.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _clearError(String field) {
    if (_errors.containsKey(field)) {
      setState(() {
        _errors.remove(field);
      });
    }
  }

  bool _validateStep1() {
    final newErrs = <String, String>{};
    if (_nomeCtrl.text.isEmpty || _nomeCtrl.text.split(' ').length < 2) newErrs['nome'] = "Mínimo 2 palavras";
    if (_telefoneCtrl.text.isEmpty) newErrs['telefone'] = "Este campo é obrigatório";
    if (!_emailCtrl.text.contains('@')) newErrs['email'] = "Digite um e-mail válido";
    if (_senhaCtrl.text.length < 8) newErrs['senha'] = "Mínimo 8 caracteres";
    if (_senhaCtrl.text != _confirmarSenhaCtrl.text) newErrs['confirmarSenha'] = "As senhas não coincidem";
    
    setState(() => _errors = newErrs);
    return newErrs.isEmpty;
  }

  bool _validateStep2() {
    final newErrs = <String, String>{};
    if (_cepCtrl.text.isEmpty) newErrs['cep'] = "Este campo é obrigatório";
    if (_bairroCtrl.text.isEmpty) newErrs['bairro'] = "Este campo é obrigatório";
    
    setState(() => _errors = newErrs);
    return newErrs.isEmpty;
  }

  void _handleNext() {
    if (_step == 1 && !_validateStep1()) return;
    if (_step == 2 && !_validateStep2()) return;
    
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
    setState(() => _step = 4);
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
    if (_step == 4) return _buildSuccessScreen();

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
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 2,
            width: double.infinity,
            color: const Color(0xFFEEEEEE),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: 0,
            top: 15,
            width: MediaQuery.of(context).size.width * 0.7 * ((_step - 1) / 2),
            child: Container(
              height: 2,
              color: const Color(0xFFFF6B00),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStepDot(1, "Dados"),
              _buildStepDot(2, "Local"),
              _buildStepDot(3, "Foto"),
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
    if (_step == 1) {
      final forca = _getForcaSenha();
      return Column(
        key: const ValueKey(1),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Criar conta', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A))),
          const SizedBox(height: 4),
          const Text('Etapa 1: Seus dados', style: TextStyle(fontSize: 14, color: Color(0xFF6B6B6B))),
          const SizedBox(height: 32),
          
          FloatingInput(
            label: 'Nome completo', icon: Icons.person_outline, controller: _nomeCtrl, errorText: _errors['nome'],
          ),
          const SizedBox(height: 16),
          FloatingInput(
            label: 'E-mail', icon: Icons.mail_outline, controller: _emailCtrl, keyboardType: TextInputType.emailAddress, errorText: _errors['email'],
          ),
          const SizedBox(height: 16),
          FloatingInput(
            label: 'Telefone (WhatsApp)', icon: Icons.phone_outlined, controller: _telefoneCtrl, keyboardType: TextInputType.phone, errorText: _errors['telefone'],
          ),
          const SizedBox(height: 16),
          FloatingInput(
            label: 'Senha', icon: Icons.lock_outline, controller: _senhaCtrl, obscureText: !_showPassword, errorText: _errors['senha'],
            rightElement: IconButton(
              icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility, color: const Color(0xFF6B6B6B)),
              onPressed: () => setState(() => _showPassword = !_showPassword),
            ),
          ),
          const SizedBox(height: 16),
          FloatingInput(
            label: 'Confirmar senha', icon: Icons.lock_outline, controller: _confirmarSenhaCtrl, obscureText: !_showConfirmPassword, errorText: _errors['confirmarSenha'],
            rightElement: IconButton(
              icon: Icon(_showConfirmPassword ? Icons.visibility_off : Icons.visibility, color: const Color(0xFF6B6B6B)),
              onPressed: () => setState(() => _showConfirmPassword = !_showConfirmPassword),
            ),
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
                  height: 8,
                  width: double.infinity,
                  decoration: BoxDecoration(color: const Color(0xFFEEEEEE), borderRadius: BorderRadius.circular(4)),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: forca['score'] as double,
                    child: Container(
                      decoration: BoxDecoration(color: forca['color'] as Color, borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                ),
              ],
            )
          ],

          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _handleNext,
            child: const Text('Próximo →'),
          ),
        ],
      );
    }

    if (_step == 2) {
      return Column(
        key: const ValueKey(2),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Onde você mora?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A))),
          const SizedBox(height: 4),
          const Text('Etapa 2: Localização', style: TextStyle(fontSize: 14, color: Color(0xFF6B6B6B))),
          const SizedBox(height: 32),
          
          FloatingInput(
            label: 'CEP', icon: Icons.location_on_outlined, controller: _cepCtrl, keyboardType: TextInputType.number, errorText: _errors['cep'],
            rightElement: IconButton(
              icon: const Icon(Icons.search, color: Color(0xFFFF6B00)),
              onPressed: _searchCep,
            ),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Cidade', style: TextStyle(fontSize: 11, color: Color(0xFF6B6B6B))),
                        Text(_cidadeCtrl.text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1A1A1A))),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: const Color(0xFFF9F9F9), border: Border.all(color: const Color(0xFFEEEEEE)), borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Estado', style: TextStyle(fontSize: 11, color: Color(0xFF6B6B6B))),
                        Text(_estadoCtrl.text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1A1A1A))),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],

          const SizedBox(height: 24),
          FloatingInput(
            label: 'Bairro', icon: Icons.location_city_outlined, controller: _bairroCtrl, errorText: _errors['bairro'],
          ),
          
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _handleNext,
            child: const Text('Próximo →'),
          ),
        ],
      );
    }

    // Step 3
    return Column(
      key: const ValueKey(3),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Quase lá! 🎉', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A))),
        const SizedBox(height: 4),
        const Text('Etapa 3: Sua foto', style: TextStyle(fontSize: 14, color: Color(0xFF6B6B6B))),
        const SizedBox(height: 32),
        
        Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => setState(() => _foto = true),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E8),
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFFF6B00), width: 2, style: BorderStyle.solid), // Seria dashed, mas Flutter nativo não tem dashed border simples.
                  ),
                  child: _foto
                      ? const ClipOval(child: Icon(Icons.person, size: 80, color: Color(0xFFFF6B00)))
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt, color: Color(0xFFFF6B00), size: 32),
                            Text('Adicionar\nfoto', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFFFF6B00), fontSize: 12, fontWeight: FontWeight.w500)),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 12),
              const Text('Toque para tirar foto ou escolher da galeria (opcional)', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Color(0xFF6B6B6B))),
            ],
          ),
        ),

        const SizedBox(height: 48),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => setState(() => _termos = !_termos),
              child: Container(
                width: 24,
                height: 24,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: _termos ? const Color(0xFFFF6B00) : Colors.white,
                  border: Border.all(color: _termos ? const Color(0xFFFF6B00) : const Color(0xFFAAAAAA), width: 2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: _termos ? const Icon(Icons.check, color: Colors.white, size: 16) : null,
              ),
            ),
            const Expanded(
              child: Text.rich(
                TextSpan(
                  text: 'Aceito os ',
                  style: TextStyle(fontSize: 13, color: Color(0xFF6B6B6B)),
                  children: [
                    TextSpan(text: 'Termos de Uso', style: TextStyle(color: Color(0xFFFF6B00), decoration: TextDecoration.underline, fontWeight: FontWeight.w500)),
                    TextSpan(text: ' e '),
                    TextSpan(text: 'Política de Privacidade', style: TextStyle(color: Color(0xFFFF6B00), decoration: TextDecoration.underline, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_termos) const Icon(Icons.check, size: 20),
              if (_termos) const SizedBox(width: 8),
              const Text('Criar minha conta'),
            ],
          ),
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
                Container(
                  width: 96,
                  height: 96,
                  decoration: const BoxDecoration(color: Color(0xFFFFF3E8), shape: BoxShape.circle),
                  child: const Center(child: Text('🎉', style: TextStyle(fontSize: 40))),
                ),
                const SizedBox(height: 24),
                const Text('Conta criada com sucesso!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A))),
                const SizedBox(height: 8),
                Text('Bem-vindo ao ServiFast, ${_nomeCtrl.text.split(" ").first.isNotEmpty ? _nomeCtrl.text.split(" ").first : "Cliente"}!', style: const TextStyle(fontSize: 18, color: Color(0xFF1A1A1A))),
                const SizedBox(height: 16),
                const Text('Agora você pode contratar serviços perto de você.', textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: Color(0xFF6B6B6B))),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.pushReplacementNamed(context, '/client_home');
                  },
                  child: const Text('Ir para o início →'),
                ),
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
