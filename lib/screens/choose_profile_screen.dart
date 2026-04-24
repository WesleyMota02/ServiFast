import 'package:flutter/material.dart';

class ChooseProfileScreen extends StatefulWidget {
  const ChooseProfileScreen({super.key});

  @override
  State<ChooseProfileScreen> createState() => _ChooseProfileScreenState();
}

class _ChooseProfileScreenState extends State<ChooseProfileScreen> {
  String? _selectedProfile; // 'client' ou 'professional'

  void _selectProfile(String profile) {
    setState(() {
      _selectedProfile = profile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header com botão voltar
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A)),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                    splashRadius: 24,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Como você vai usar o app?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Opção: Sou Cliente
              Expanded(
                child: Column(
                  children: [
                    _buildProfileOption(
                      profile: 'client',
                      title: 'Sou Cliente',
                      subtitle: 'Quero contratar serviços',
                      iconData: Icons.home_rounded,
                      iconBgColor: const Color(0xFFFF6B00),
                    ),
                    const SizedBox(height: 16),
                    // Opção: Sou Profissional
                    _buildProfileOption(
                      profile: 'professional',
                      title: 'Sou Profissional',
                      subtitle: 'Quero oferecer meus serviços',
                      iconData: Icons.engineering_rounded, // Equivalente a HardHat
                      iconBgColor: const Color(0xFF1A1A1A),
                    ),
                  ],
                ),
              ),

              // Botão Continuar
              ElevatedButton(
                onPressed: _selectedProfile == null
                    ? null
                    : () {
                        if (_selectedProfile == 'client') {
                          Navigator.pushNamed(context, '/register_client');
                        } else {
                          Navigator.pushNamed(context, '/register_professional');
                        }
                      },
                child: const Text('Continuar'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required String profile,
    required String title,
    required String subtitle,
    required IconData iconData,
    required Color iconBgColor,
  }) {
    final isSelected = _selectedProfile == profile;
    
    return GestureDetector(
      onTap: () => _selectProfile(profile),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF3E8) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF6B00) : const Color(0xFFEEEEEE),
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: Icon(iconData, color: Colors.white, size: 24),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B6B6B),
                  ),
                ),
              ],
            ),
            if (isSelected)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF6B00),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
