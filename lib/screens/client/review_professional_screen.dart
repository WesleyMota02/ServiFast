import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';

class ReviewProfessionalScreen extends StatefulWidget {
  final String professionalId;
  final String requestId;

  const ReviewProfessionalScreen({
    super.key,
    required this.professionalId,
    required this.requestId,
  });

  @override
  State<ReviewProfessionalScreen> createState() => _ReviewProfessionalScreenState();
}

class _ReviewProfessionalScreenState extends State<ReviewProfessionalScreen> {
  int _rating = 0;
  final TextEditingController _commentController = TextEditingController();
  final List<String> _tags = ['Pontual', 'Educado', 'Preço Justo', 'Rápido', 'Caprichoso'];
  final List<String> _selectedTags = [];

  void _submitReview() {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, dê uma nota de 1 a 5 estrelas.'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }
    
    // Sucesso
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Icon(Icons.check_circle, color: AppTheme.successColor, size: 60),
        content: const Text(
          'Avaliação enviada com sucesso! Obrigado por ajudar a comunidade ServiFast.',
          textAlign: TextAlign.center,
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.pop(); // close dialog
                context.go('/client_home'); // volta para a home
              },
              child: const Text('Voltar ao Início'),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text('Avaliar Profissional', style: Theme.of(context).textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 48,
              backgroundColor: AppTheme.surfaceColor,
              child: Icon(Icons.person, size: 48, color: AppTheme.iconGrey),
            ),
            const SizedBox(height: 16),
            Text(
              'Como foi o serviço?',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 22),
            ),
            const SizedBox(height: 8),
            Text(
              'Sua avaliação ajuda outros clientes a escolherem bons profissionais.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
            ),
            const SizedBox(height: 32),
            
            // Estrelas
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                  iconSize: 48,
                  color: index < _rating ? const Color(0xFFF1C40F) : AppTheme.borderColor,
                  icon: Icon(index < _rating ? Icons.star_rounded : Icons.star_outline_rounded),
                );
              }),
            ),
            const SizedBox(height: 32),
            
            // Tags
            Align(
              alignment: Alignment.centerLeft,
              child: Text('O que se destacou?', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16)),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _tags.map((tag) {
                final isSelected = _selectedTags.contains(tag);
                return FilterChip(
                  label: Text(tag),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedTags.add(tag);
                      } else {
                        _selectedTags.remove(tag);
                      }
                    });
                  },
                  selectedColor: AppTheme.primaryColor.withOpacity(0.1),
                  checkmarkColor: AppTheme.primaryColor,
                  labelStyle: TextStyle(
                    color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                  backgroundColor: AppTheme.surfaceColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isSelected ? AppTheme.primaryColor : AppTheme.borderColor,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            
            // Comentário
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Deixe um comentário (Opcional)', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16)),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Conte um pouco sobre como foi a experiência...',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 48),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitReview,
                child: const Text('Enviar Avaliação'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
