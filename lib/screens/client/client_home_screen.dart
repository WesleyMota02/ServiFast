import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../providers/firestore_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/loading_skeleton.dart';

class ClientHomeScreen extends ConsumerWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prosAsync = ref.watch(professionalsListProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Localização Atual', style: Theme.of(context).textTheme.bodySmall),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: AppTheme.primaryColor),
                const SizedBox(width: 4),
                Text('Centro, São Bernardo', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: AppTheme.textPrimary),
            onPressed: () {
              context.push('/notifications');
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                context.push('/client_settings');
              },
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: AppTheme.surfaceColor,
                child: Icon(Icons.person, color: AppTheme.textSecondary),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            GestureDetector(
              onTap: () {
                context.push('/search_results');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.borderColor),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: AppTheme.iconGrey),
                    const SizedBox(width: 12),
                    Text('Qual serviço você precisa hoje?', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.iconGrey)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Categories
            Text('Categorias', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            SizedBox(
              height: 110,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryItem('Eletricista', Icons.electrical_services),
                  _buildCategoryItem('Encanador', Icons.plumbing),
                  _buildCategoryItem('Pintor', Icons.format_paint),
                  _buildCategoryItem('Limpeza', Icons.cleaning_services),
                  _buildCategoryItem('Montador', Icons.handyman),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Profissionais Próximos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Profissionais Próximos', style: Theme.of(context).textTheme.titleLarge),
                TextButton(
                  onPressed: () {},
                  child: const Text('Ver todos'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            prosAsync.when(
              data: (pros) {
                if (pros.isEmpty) {
                  return const EmptyState(
                    icon: Icons.person_search_rounded,
                    title: 'Nenhum profissional',
                    description: 'Não encontramos profissionais na sua região no momento.',
                  );
                }
                return Column(
                  children: pros.map((pro) {
                    return _buildProCard(
                      context,
                      pro['name'] ?? 'Desconhecido',
                      pro['category'] ?? 'Geral',
                      (pro['rating'] ?? 5.0).toStringAsFixed(1),
                      '1.2 km', // Mock distance
                      pro['uid'],
                    );
                  }).toList(),
                );
              },
              loading: () => Column(
                children: const [
                  ProfessionalCardSkeleton(),
                  SizedBox(height: 16),
                  ProfessionalCardSkeleton(),
                  SizedBox(height: 16),
                  ProfessionalCardSkeleton(),
                ],
              ),
              error: (err, stack) => const Center(child: Text('Erro ao carregar profissionais')),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.iconGrey,
        backgroundColor: Colors.white,
        elevation: 16,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) context.push('/my_requests');
          if (index == 2) context.push('/client_settings');
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt_rounded), label: 'Pedidos'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'Perfil'),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String name, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppTheme.primaryColor, size: 32),
          ),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.textPrimary)),
        ],
      ),
    );
  }

  Widget _buildProCard(BuildContext context, String name, String category, String rating, String distance, String uid) {
    return GestureDetector(
      onTap: () {
        context.push('/professional_profile', extra: uid);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundColor: AppTheme.surfaceColor,
              child: Icon(Icons.person, color: AppTheme.iconGrey, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
                  const SizedBox(height: 4),
                  Text(category, style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF9E6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Color(0xFFF1C40F), size: 16),
                      const SizedBox(width: 4),
                      Text(rating, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFFB7950B))),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(distance, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

