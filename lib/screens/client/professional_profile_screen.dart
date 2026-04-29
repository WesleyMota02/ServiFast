import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/firestore_provider.dart';
import '../../theme/app_theme.dart';

class ProfessionalProfileScreen extends ConsumerWidget {
  final String uid;

  const ProfessionalProfileScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (uid.isEmpty) {
      return Scaffold(
        appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
        body: const Center(child: Text('Profissional não encontrado.')),
      );
    }

    final proAsync = ref.watch(professionalProfileProvider(uid));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: proAsync.when(
        data: (proData) {
          if (proData == null) {
            return const Center(child: Text('Profissional não encontrado.'));
          }
          
          return SingleChildScrollView(
            child: Column(
              children: [
                // Header: Foto e Nome
                const SizedBox(height: 16),
                const CircleAvatar(
                  radius: 56,
                  backgroundColor: AppTheme.surfaceColor,
                  child: Icon(Icons.person, size: 56, color: AppTheme.iconGrey),
                ),
                const SizedBox(height: 16),
                Text(proData['name'] ?? 'Desconhecido', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(proData['category'] ?? 'Especialista', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary)),
                const SizedBox(height: 12),
                
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF9E6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star_rounded, color: Color(0xFFF1C40F), size: 20),
                      const SizedBox(width: 4),
                      Text(
                        (proData['rating'] ?? 5.0).toStringAsFixed(1),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFB7950B)),
                      ),
                      Text(
                        ' (${proData['ratingCount'] ?? 0} avaliações)',
                        style: const TextStyle(fontSize: 14, color: Color(0xFFB7950B)),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                const Divider(color: AppTheme.borderColor, thickness: 8),
                
                // Descrição
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sobre mim', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
                      const SizedBox(height: 12),
                      Text(
                        proData['description'] ?? 'Sem descrição.',
                        style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary, height: 1.6),
                      ),
                      const SizedBox(height: 32),
                      
                      // Avaliações (Mocks por enquanto)
                      Text('Avaliações recentes', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
                      const SizedBox(height: 16),
                      _buildReviewCard('Maria Souza', 'Serviço rápido e muito bem feito. Recomendo!', '5.0'),
                      _buildReviewCard('Carlos Eduardo', 'Profissional pontual e educado.', '4.8'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor)),
        error: (err, stack) => const Center(child: Text('Erro ao carregar dados do profissional.')),
      ),
      bottomNavigationBar: proAsync.hasValue && proAsync.value != null ? SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ElevatedButton(
            onPressed: () {
              context.push('/request_service', extra: uid);
            },
            child: const Text('Solicitar Serviço'),
          ),
        ),
      ) : null,
    );
  }

  Widget _buildReviewCard(String name, String comment, String rating) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
              Row(
                children: [
                  const Icon(Icons.star_rounded, color: Color(0xFFF1C40F), size: 16),
                  const SizedBox(width: 4),
                  Text(rating, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(comment, style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
        ],
      ),
    );
  }
}
