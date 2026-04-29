import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _slides = [
    {
      'icon': Icons.groups_rounded, // Users
      'title': 'Encontre quem você precisa',
      'subtitle': 'Pintores, eletricistas, encanadores e muito mais, perto de você.',
      'color': const Color(0xFF3498DB),
    },
    {
      'icon': Icons.verified_user_rounded, // ShieldCheck
      'title': 'Profissionais avaliados',
      'subtitle': 'Veja a reputação de cada profissional antes de contratar.',
      'color': const Color(0xFFF1C40F),
    },
    {
      'icon': Icons.access_time_rounded, // Clock
      'title': 'Serviço combinado em minutos',
      'subtitle': 'Solicite, negocie e confirme tudo pelo app.',
      'color': const Color(0xFF27AE60),
    },
  ];

  void _nextSlide() {
    if (_currentIndex < _slides.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      context.go('/welcome');
    }
  }

  void _skip() {
    context.go('/welcome');
  }

  @override
  Widget build(BuildContext context) {
    final currentSlide = _slides[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header (Pular)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _skip,
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF6B6B6B),
                  ),
                  child: const Text(
                    'Pular',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),

            // Conteúdo animado
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    final inAnimation = Tween<Offset>(
                            begin: const Offset(1.0, 0.0), end: Offset.zero)
                        .animate(animation);
                    final outAnimation = Tween<Offset>(
                            begin: const Offset(-1.0, 0.0), end: Offset.zero)
                        .animate(animation);

                    if (child.key == ValueKey<int>(_currentIndex)) {
                      return SlideTransition(position: inAnimation, child: child);
                    } else {
                      return SlideTransition(position: outAnimation, child: child);
                    }
                  },
                  child: Column(
                    key: ValueKey<int>(_currentIndex),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 256,
                        height: 256,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF9F9F9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          currentSlide['icon'],
                          size: 128,
                          color: currentSlide['color'],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        currentSlide['title'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF6B00),
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        currentSlide['subtitle'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF6B6B6B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Footer (Dots e Botão)
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _slides.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: index == _currentIndex ? 24 : 8,
                        decoration: BoxDecoration(
                          color: index == _currentIndex
                              ? const Color(0xFFFF6B00)
                              : const Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _nextSlide,
                    child: Text(
                      _currentIndex == _slides.length - 1
                          ? 'Começar agora'
                          : 'Próximo',
                    ),
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
