import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';

class ProReviewsScreen extends StatelessWidget {
  const ProReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for reviews
    final List<Map<String, dynamic>> reviews = [
      {
        'clientName': 'Maria Souza',
        'rating': 5.0,
        'comment': 'Serviço rápido e muito bem feito. Recomendo com certeza!',
        'date': '10/05/2026',
        'tags': ['Rápido', 'Educado'],
      },
      {
        'clientName': 'Carlos Eduardo',
        'rating': 4.0,
        'comment': 'Profissional pontual e educado. Resolveu o problema.',
        'date': '02/05/2026',
        'tags': ['Pontual'],
      },
      {
        'clientName': 'Ana Clara',
        'rating': 5.0,
        'comment': 'Preço justo e muita qualidade no serviço prestado.',
        'date': '28/04/2026',
        'tags': ['Preço Justo', 'Caprichoso'],
      },
    ];

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text('Minhas Avaliações', style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Column(
        children: [
          // Header Summary
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              border: const Border(bottom: BorderSide(color: AppTheme.borderColor)),
            ),
            child: Column(
              children: [
                Text(
                  '4.8',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 48, color: const Color(0xFFB7950B)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Icon(
                      index < 4 ? Icons.star_rounded : Icons.star_half_rounded,
                      color: const Color(0xFFF1C40F),
                      size: 24,
                    );
                  }),
                ),
                const SizedBox(height: 8),
                Text('Baseado em 12 avaliações', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          
          // Reviews List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return _buildReviewCard(review);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review['clientName'],
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                Text(
                  review['date'],
                  style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star_rounded, color: Color(0xFFF1C40F), size: 16),
                const SizedBox(width: 4),
                Text(
                  review['rating'].toStringAsFixed(1),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              review['comment'],
              style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (review['tags'] as List<String>).map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(color: AppTheme.primaryColor, fontSize: 11, fontWeight: FontWeight.w500),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
