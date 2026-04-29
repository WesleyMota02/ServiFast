import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../providers/firestore_provider.dart';
import '../../models/request_model.dart';
import '../../theme/app_theme.dart';

class RequestServiceScreen extends ConsumerStatefulWidget {
  final String professionalId;

  const RequestServiceScreen({super.key, required this.professionalId});

  @override
  ConsumerState<RequestServiceScreen> createState() => _RequestServiceScreenState();
}

class _RequestServiceScreenState extends ConsumerState<RequestServiceScreen> {
  final _descController = TextEditingController();
  String _selectedPeriod = 'Manhã';
  bool _isLoading = false;

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  Future<void> _submitRequest() async {
    if (_descController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Por favor, descreva o que você precisa.'), backgroundColor: AppTheme.primaryColor));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('Usuário não autenticado');

      // Buscar os nomes para facilitar exibição
      final firestore = ref.read(firestoreProvider);
      
      final clientDoc = await firestore.collection('users').doc(user.uid).get();
      final proDoc = await firestore.collection('users').doc(widget.professionalId).get();
      final proProfileDoc = await firestore.collection('professionals').doc(widget.professionalId).get();

      final request = RequestModel(
        id: '',
        clientId: user.uid,
        professionalId: widget.professionalId,
        description: _descController.text.trim(),
        period: _selectedPeriod,
        status: 'Pendente',
        createdAt: DateTime.now(),
        clientName: clientDoc.data()?['name'] ?? 'Cliente',
        professionalName: proDoc.data()?['name'] ?? 'Profissional',
        professionalCategory: proProfileDoc.data()?['category'] ?? 'Geral',
      );

      await firestore.collection('requests').add(request.toMap());

      if (!mounted) return;
      
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          contentPadding: const EdgeInsets.all(32),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.successColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_rounded, color: AppTheme.successColor, size: 64),
              ),
              const SizedBox(height: 24),
              Text('Solicitação enviada!', style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              const Text('O profissional foi notificado e responderá em breve.', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.textSecondary, fontSize: 15)),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.pop(); // Fecha o dialog
                    context.go('/my_requests'); // Vai para a aba de pedidos
                  },
                  child: const Text('Ver meus pedidos'),
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao enviar solicitação: $e'), backgroundColor: AppTheme.errorColor));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Solicitar Serviço', style: TextStyle(color: AppTheme.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Profissional', style: TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
            const SizedBox(height: 12),
            Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: AppTheme.surfaceColor,
                  child: Icon(Icons.person, color: AppTheme.iconGrey),
                ),
                const SizedBox(width: 16),
                const Text('João Silva', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
              ],
            ),
            const SizedBox(height: 32),

            Text('O que você precisa?', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16)),
            const SizedBox(height: 12),
            TextField(
              controller: _descController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Descreva o problema ou serviço com detalhes...',
              ),
            ),
            const SizedBox(height: 32),

            Text('Preferência de horário', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16)),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildPeriodOption('Manhã', Icons.wb_sunny_rounded),
                const SizedBox(width: 12),
                _buildPeriodOption('Tarde', Icons.wb_cloudy_rounded),
                const SizedBox(width: 12),
                _buildPeriodOption('Noite', Icons.nights_stay_rounded),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ElevatedButton(
            onPressed: _isLoading ? null : _submitRequest,
            child: _isLoading 
                ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : const Text('Enviar Solicitação'),
          ),
        ),
      ),
    );
  }

  Widget _buildPeriodOption(String title, IconData icon) {
    bool isSelected = _selectedPeriod == title;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedPeriod = title;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : Colors.white,
            border: Border.all(color: isSelected ? AppTheme.primaryColor : AppTheme.borderColor),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? AppTheme.primaryColor : AppTheme.iconGrey),
              const SizedBox(height: 8),
              Text(
                title, 
                style: TextStyle(
                  color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary, 
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
