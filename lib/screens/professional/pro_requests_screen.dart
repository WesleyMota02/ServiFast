import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../providers/firestore_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/empty_state.dart';

class ProRequestsScreen extends ConsumerWidget {
  const ProRequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const Scaffold(body: Center(child: Text('Não autenticado')));

    final requestsAsync = ref.watch(proRequestsProvider(user.uid));

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
            onPressed: () => context.pop(),
          ),
          title: const Text('Solicitações', style: TextStyle(color: AppTheme.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
          bottom: const TabBar(
            labelColor: AppTheme.primaryColor,
            unselectedLabelColor: AppTheme.iconGrey,
            indicatorColor: AppTheme.primaryColor,
            indicatorWeight: 3,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'Novas'),
              Tab(text: 'Aceitas'),
              Tab(text: 'Concluídas'),
            ],
          ),
        ),
        body: requestsAsync.when(
          data: (requests) {
            final novas = requests.where((r) => r['status'] == 'Pendente').toList();
            final aceitas = requests.where((r) => r['status'] == 'Aceita').toList();
            final concluidas = requests.where((r) => r['status'] == 'Concluída' || r['status'] == 'Recusada').toList();

            return TabBarView(
              children: [
                _buildList(novas, 'Nenhuma nova solicitação', Icons.inbox_rounded),
                _buildList(aceitas, 'Nenhuma solicitação aceita', Icons.check_circle_outline_rounded),
                _buildList(concluidas, 'Nenhum histórico', Icons.history_rounded),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor)),
          error: (err, stack) => const Center(child: Text('Erro ao carregar dados.')),
        ),
      ),
    );
  }

  Widget _buildList(List<Map<String, dynamic>> list, String emptyTitle, IconData emptyIcon) {
    if (list.isEmpty) {
      return EmptyState(
        icon: emptyIcon,
        title: emptyTitle,
        description: 'Você não tem solicitações nesta categoria no momento.',
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final req = list[index];
        Color statusColor;
        switch (req['status']) {
          case 'Aceita':
            statusColor = const Color(0xFF3498DB);
            break;
          case 'Recusada':
            statusColor = AppTheme.errorColor;
            break;
          case 'Concluída':
            statusColor = AppTheme.successColor;
            break;
          default:
            statusColor = const Color(0xFFF1C40F);
        }
        return _buildRequestItem(
          context,
          req['id'], // Passar id
          req['clientName'] ?? 'Cliente',
          req['description'] ?? 'Serviço',
          req['status'] ?? 'Pendente',
          statusColor,
        );
      },
    );
  }

  Widget _buildRequestItem(BuildContext context, String requestId, String name, String service, String status, Color statusColor) {
    return GestureDetector(
      onTap: () {
        context.push('/request_detail', extra: requestId);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: AppTheme.surfaceColor,
                      child: Icon(Icons.person, color: AppTheme.iconGrey),
                    ),
                    const SizedBox(width: 12),
                    Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(status, style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.build_circle_outlined, size: 18, color: AppTheme.primaryColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(service, style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
