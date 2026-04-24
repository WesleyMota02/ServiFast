import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    // Dispara a validação de todos os TextFormFields
    if (_formKey.currentState!.validate()) {
      // Simulação de login
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Autenticando usuário...'),
          backgroundColor: Color(0xFFFF6B00),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                
                // 1. Header: Ícone de ferramenta em um container laranja arredondado
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.build_rounded, // Ferramenta
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 32),
                
                // 2. Título (H1)
                Text(
                  'Entrar',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Bem-vindo de volta! Faça login para continuar no ServiFast.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 40),

                // 3. Campos de Entrada (TextFormField) - Email
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu e-mail.';
                    }
                    if (!value.contains('@')) {
                      return 'Insira um endereço de e-mail válido.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // 3. Campos de Entrada (TextFormField) - Senha
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua senha.';
                    }
                    if (value.length < 6) {
                      return 'A senha deve conter no mínimo 6 caracteres.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Link: Esqueci minha senha
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Navegar para recuperação de senha
                    },
                    child: const Text('Esqueci minha senha'),
                  ),
                ),
                const SizedBox(height: 32),

                // 4. Botão Principal (ElevatedButton)
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Entrar'),
                ),
                const SizedBox(height: 32),

                // 5. Links de Navegação (Rodapé)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Não tem uma conta? ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        // Navegar para Cadastro
                      },
                      child: const Text('Cadastre-se'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
