import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top Half (Laranja)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.55 + 32, // +32 para ficar por baixo do rounded bottom half
            child: Container(
              color: const Color(0xFFFF6B00),
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(
                          Icons.build_rounded,
                          size: 80,
                          color: Colors.white,
                        ),
                        Positioned(
                          right: -4,
                          bottom: -4,
                          child: const Icon(
                            Icons.bolt,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'ServiFast',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 40,
                          letterSpacing: -0.5,
                        ),
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom Half (Branco com bordas arredondadas)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1A000000), // 0.1 opacity black
                    blurRadius: 30,
                    offset: Offset(0, -8),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      // Botão Secundário
                      OutlinedButton(
                        onPressed: () {
                          context.push('/login');
                        },
                        child: const Text('Entrar na conta'),
                      ),
                      const SizedBox(height: 16),
                      // Botão Primário
                      ElevatedButton(
                        onPressed: () {
                          context.push('/choose_profile');
                        },
                        child: const Text('Criar conta'),
                      ),
                    ],
                  ),
                  
                  // Texto de Termos
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        color: Color(0xFF6B6B6B),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                      children: [
                        const TextSpan(text: 'Ao continuar, você concorda com nossos\n'),
                        TextSpan(
                          text: 'Termos de uso',
                          style: const TextStyle(
                            color: Color(0xFFFF6B00),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(text: ' e '),
                        TextSpan(
                          text: 'Política de Privacidade',
                          style: const TextStyle(
                            color: Color(0xFFFF6B00),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(text: '.'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
