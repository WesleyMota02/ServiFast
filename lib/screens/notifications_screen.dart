import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/empty_state.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista mock de notificações
    final List<Map<String, dynamic>> mockNotifications = [
      {
        'title': 'Solicitação Aceita!',
        'body': 'O profissional João Silva aceitou seu serviço. Entre em contato para detalhes.',
        'time': 'Agora',
        'isRead': false,
        'icon': Icons.check_circle_rounded,
        'color': AppTheme.successColor,
      },
      {
        'title': 'Novo Pedido Recebido',
        'body': 'Você tem um novo pedido de instalação elétrica na sua área.',
        'time': 'Há 2 horas',
        'isRead': true,
        'icon': Icons.inbox_rounded,
        'color': AppTheme.primaryColor,
      },
      {
        'title': 'Bem-vindo ao ServiFast!',
        'body': 'Sua conta foi criada com sucesso. Comece a explorar agora.',
        'time': 'Ontem',
        'isRead': true,
        'icon': Icons.waving_hand_rounded,
        'color': Color(0xFF3498DB),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Notificações', style: TextStyle(color: AppTheme.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: mockNotifications.isEmpty
          ? const EmptyState(
              icon: Icons.notifications_off_rounded,
              title: 'Nenhuma notificação',
              description: 'Você não tem novas notificações no momento.',
            )
          : ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: mockNotifications.length,
              itemBuilder: (context, index) {
                final notif = mockNotifications[index];
                return _buildNotificationCard(
                  title: notif['title'],
                  body: notif['body'],
                  time: notif['time'],
                  isRead: notif['isRead'],
                  icon: notif['icon'],
                  color: notif['color'],
                );
              },
            ),
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String body,
    required String time,
    required bool isRead,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isRead ? Colors.white : color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isRead ? AppTheme.borderColor : color.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isRead ? AppTheme.surfaceColor : color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: isRead ? AppTheme.iconGrey : color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: isRead ? FontWeight.w600 : FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(time, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
