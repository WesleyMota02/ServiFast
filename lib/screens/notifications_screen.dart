import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/firestore_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/empty_state.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  Future<void> _markAsRead(WidgetRef ref, String notificationId) async {
    final firestore = ref.read(firestoreProvider);
    await firestore.collection('notifications').doc(notificationId).update({'isRead': true});
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
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
        body: const Center(child: Text('Usuário não autenticado.')),
      );
    }

    final notificationsAsync = ref.watch(notificationsProvider(user.uid));
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
      body: notificationsAsync.when(
        data: (notifications) {
          if (notifications.isEmpty) {
            return const EmptyState(
              icon: Icons.notifications_off_rounded,
              title: 'Nenhuma notificação',
              description: 'Você não tem novas notificações no momento.',
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notif = notifications[index];
              
              DateTime? dt;
              if (notif['createdAt'] != null) {
                dt = (notif['createdAt'] as Timestamp).toDate();
              }
              String timeStr = dt != null ? DateFormat('dd/MM HH:mm').format(dt) : 'Agora';

              IconData iconData = Icons.notifications;
              Color iconColor = AppTheme.primaryColor;
              if (notif['type'] == 'success') {
                iconData = Icons.check_circle_rounded;
                iconColor = AppTheme.successColor;
              } else if (notif['type'] == 'info') {
                iconData = Icons.info_outline_rounded;
                iconColor = const Color(0xFF3498DB);
              }

              return GestureDetector(
                onTap: () {
                  if (!(notif['isRead'] ?? false)) {
                    _markAsRead(ref, notif['id']);
                  }
                },
                child: _buildNotificationCard(
                  title: notif['title'] ?? 'Nova Notificação',
                  body: notif['body'] ?? '',
                  time: timeStr,
                  isRead: notif['isRead'] ?? false,
                  icon: iconData,
                  color: iconColor,
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor)),
        error: (err, stack) => Center(child: Text('Erro: $err')),
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
