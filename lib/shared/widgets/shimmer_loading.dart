import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/theme/app_theme.dart';

class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Widget? child;

  const ShimmerLoading({
    super.key,
    this.width = double.infinity,
    this.height = 200,
    this.borderRadius = 12,
    this.child,
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
        child: child,
      ),
    );
  }
}

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerLoading(
            width: 160,
            height: 180,
            borderRadius: 16,
          ),
          const SizedBox(height: 12),
          ShimmerLoading(
            width: 120,
            height: 16,
            borderRadius: 4,
          ),
          const SizedBox(height: 8),
          ShimmerLoading(
            width: 80,
            height: 16,
            borderRadius: 4,
          ),
        ],
      ),
    );
  }
}

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App bar shimmer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerLoading(width: 44, height: 44, borderRadius: 12),
                      ShimmerLoading(width: 120, height: 24, borderRadius: 4),
                      Row(
                        children: [
                          ShimmerLoading(width: 44, height: 44, borderRadius: 12),
                          const SizedBox(width: 8),
                          ShimmerLoading(width: 44, height: 44, borderRadius: 12),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Banner shimmer
                  ShimmerLoading(
                    width: double.infinity,
                    height: 200,
                    borderRadius: 20,
                  ),
                  const SizedBox(height: 24),
                  // Section title shimmer
                  ShimmerLoading(width: 150, height: 24, borderRadius: 4),
                  const SizedBox(height: 16),
                  // Products shimmer
                  SizedBox(
                    height: 280,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (_, __) => const ProductCardShimmer(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Another section
                  ShimmerLoading(width: 150, height: 24, borderRadius: 4),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 280,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (_, __) => const ProductCardShimmer(),
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
