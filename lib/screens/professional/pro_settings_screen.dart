import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../providers/auth_provider.dart';
import '../../theme/app_theme.dart';

class ProSettingsScreen extends ConsumerWidget {
  const ProSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Perfil Profissional', style: TextStyle(color: AppTheme.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: user == null 
        ? const Center(child: Text('Não autenticado')) 
        : _buildProfileContent(context, ref, user),
    );
  }

  Widget _buildProfileContent(BuildContext context, WidgetRef ref, User user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 56,
            backgroundColor: AppTheme.surfaceColor,
            child: Icon(Icons.handyman_rounded, size: 50, color: AppTheme.iconGrey),
          ),
          const SizedBox(height: 16),
          Text(user.displayName ?? 'Profissional ServiFast', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(user.email ?? '', style: const TextStyle(color: AppTheme.textSecondary)),
          
          const SizedBox(height: 40),
          
          _buildSettingsOption(
            icon: Icons.person_outline_rounded,
            title: 'Editar Perfil Público',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Edição de perfil em breve!')));
            },
          ),
          
          _buildSettingsOption(
            icon: Icons.payments_outlined,
            title: 'Dados Bancários',
            onTap: () {},
          ),
          
          _buildSettingsOption(
            icon: Icons.analytics_outlined,
            title: 'Relatórios de Ganhos',
            onTap: () {},
          ),
          
          _buildSettingsOption(
            icon: Icons.help_outline_rounded,
            title: 'Central de Ajuda',
            onTap: () {},
          ),

          const SizedBox(height: 40),
          
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () async {
                await ref.read(authProvider.notifier).logout();
                if (context.mounted) context.go('/login');
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.errorColor,
                side: const BorderSide(color: AppTheme.errorColor),
              ),
              child: const Text('Sair da Conta'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsOption({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppTheme.primaryColor),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500, color: AppTheme.textPrimary)),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppTheme.iconGrey),
      onTap: onTap,
    );
  }
}
