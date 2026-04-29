import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../../providers/firestore_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/empty_state.dart';

class MyRequestsScreen extends ConsumerWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const Scaffold(body: Center(child: Text('Não autenticado')));

    final requestsAsync = ref.watch(clientRequestsProvider(user.uid));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Meus Pedidos', style: TextStyle(color: AppTheme.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: requestsAsync.when(
        data: (requests) {
          if (requests.isEmpty) {
            return const EmptyState(
              icon: Icons.list_alt_rounded,
              title: 'Nenhum pedido ainda',
              description: 'Quando você solicitar um serviço, ele aparecerá aqui.',
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final req = requests[index];
              
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
                  statusColor = const Color(0xFFF1C40F); // Pendente
              }

              // Converter Timestamp para String
              DateTime? dt;
              if (req['createdAt'] != null) {
                dt = req['createdAt'].toDate();
              }
              String dateStr = dt != null ? DateFormat('dd MMM, yyyy HH:mm').format(dt) : 'Sem data';

              return _buildRequestCard(
                context,
                req['professionalName'] ?? 'Profissional',
                req['professionalCategory'] ?? 'Serviço',
                dateStr,
                req['status'] ?? 'Pendente',
                statusColor,
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor)),
        error: (err, stack) => Center(child: Text('Erro ao carregar: $err')),
      ),
    );
  }

  Widget _buildRequestCard(BuildContext context, String name, String service, String date, String status, Color statusColor) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(service, style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(status, style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: AppTheme.surfaceColor,
                child: Icon(Icons.person, color: AppTheme.iconGrey),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                    Text(date, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (status == 'Concluída')
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('Avaliar Profissional'),
              ),
            )
          else
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Ver Detalhes'),
              ),
            ),
        ],
      ),
    );
  }
}
