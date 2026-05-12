import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';

class ProServicesScreen extends StatefulWidget {
  const ProServicesScreen({super.key});

  @override
  State<ProServicesScreen> createState() => _ProServicesScreenState();
}

class _ProServicesScreenState extends State<ProServicesScreen> {
  // Mock data for professional services
  final List<Map<String, dynamic>> _services = [
    {
      'title': 'Manutenção Elétrica Residencial',
      'price': 'R\$ 150,00',
      'type': 'hora',
      'active': true,
    },
    {
      'title': 'Instalação de Chuveiro',
      'price': 'R\$ 80,00',
      'type': 'serviço',
      'active': true,
    },
    {
      'title': 'Troca de Fiação',
      'price': 'R\$ 300,00',
      'type': 'diária',
      'active': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text('Meus Serviços', style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: AppTheme.primaryColor),
            onPressed: () {
              // Add new service logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Adicionar novo serviço em breve.')),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _services.length,
        itemBuilder: (context, index) {
          final service = _services[index];
          return _buildServiceCard(
            service['title'],
            service['price'],
            service['type'],
            service['active'],
            index,
          );
        },
      ),
    );
  }

  Widget _buildServiceCard(String title, String price, String type, bool active, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Switch(
                  value: active,
                  activeColor: AppTheme.primaryColor,
                  onChanged: (val) {
                    setState(() {
                      _services[index]['active'] = val;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    color: AppTheme.successColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  ' / $type',
                  style: const TextStyle(color: AppTheme.textSecondary),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  label: const Text('Editar'),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.delete_outline, size: 18, color: AppTheme.errorColor),
                  label: const Text('Excluir', style: TextStyle(color: AppTheme.errorColor)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
