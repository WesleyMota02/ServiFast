import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/app_theme.dart';

class LoadingSkeleton extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const LoadingSkeleton({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

// Skeleton para card de profissional
class ProfessionalCardSkeleton extends StatelessWidget {
  const ProfessionalCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LoadingSkeleton(width: 64, height: 64, borderRadius: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LoadingSkeleton(width: 120, height: 20),
                  const SizedBox(height: 8),
                  const LoadingSkeleton(width: 80, height: 16),
                  const SizedBox(height: 16),
                  Row(
                    children: const [
                      LoadingSkeleton(width: 40, height: 16),
                      SizedBox(width: 16),
                      LoadingSkeleton(width: 60, height: 16),
                    ],
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

// Skeleton para card de categoria
class CategorySkeleton extends StatelessWidget {
  const CategorySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        LoadingSkeleton(width: 64, height: 64, borderRadius: 32),
        SizedBox(height: 8),
        LoadingSkeleton(width: 60, height: 14),
      ],
    );
  }
}
