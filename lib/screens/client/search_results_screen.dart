import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/loading_skeleton.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({super.key});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  bool _hasSearched = false;
  List<Map<String, String>> _results = [];

  void _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _hasSearched = false;
        _results = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _hasSearched = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    // Mock search logic
    if (query.toLowerCase().contains('ele')) {
      setState(() {
        _isLoading = false;
        _results = [
          {'name': 'João Silva', 'category': 'Eletricista', 'rating': '4.9', 'distance': '1.2 km', 'uid': 'mock1'},
          {'name': 'Marcos Oliveira', 'category': 'Eletricista Industrial', 'rating': '4.7', 'distance': '4.5 km', 'uid': 'mock2'},
        ];
      });
    } else {
      setState(() {
        _isLoading = false;
        _results = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          onSubmitted: _performSearch,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: 'Buscar serviço ou profissional...',
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppTheme.iconGrey),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: AppTheme.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_hasSearched) ...[
              Text('Resultados encontrados', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
            ],
            Expanded(
              child: _buildBodyContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyContent() {
    if (!_hasSearched) {
      return const EmptyState(
        icon: Icons.search_rounded,
        title: 'Faça uma busca',
        description: 'Digite o nome do serviço ou profissional que você está procurando.',
      );
    }

    if (_isLoading) {
      return Column(
        children: const [
          ProfessionalCardSkeleton(),
          SizedBox(height: 16),
          ProfessionalCardSkeleton(),
          SizedBox(height: 16),
          ProfessionalCardSkeleton(),
        ],
      );
    }

    if (_results.isEmpty) {
      return const EmptyState(
        icon: Icons.search_off_rounded,
        title: 'Nenhum resultado',
        description: 'Não encontramos nenhum profissional com este termo. Tente buscar por "eletricista" por exemplo.',
      );
    }

    return ListView.builder(
      itemCount: _results.length,
      itemBuilder: (context, index) {
        final res = _results[index];
        return _buildProCard(
          context,
          res['name']!,
          res['category']!,
          res['rating']!,
          res['distance']!,
          res['uid']!,
        );
      },
    );
  }

  Widget _buildProCard(BuildContext context, String name, String category, String rating, String distance, String uid) {
    return GestureDetector(
      onTap: () {
        context.push('/professional_profile', extra: uid);
      },
      child: Container(
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
        child: Row(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundColor: AppTheme.surfaceColor,
              child: Icon(Icons.person, color: AppTheme.iconGrey, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
                  const SizedBox(height: 4),
                  Text(category, style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF9E6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Color(0xFFF1C40F), size: 16),
                      const SizedBox(width: 4),
                      Text(rating, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFFB7950B))),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(distance, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
