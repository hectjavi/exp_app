import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/product_model.dart';
import '../../../../shared/widgets/section_header.dart';
import 'product_card.dart';

class HorizontalProductList extends StatelessWidget {
  final String title;
  final List<ProductModel> products;
  final VoidCallback onSeeMore;
  final Function(ProductModel) onProductTap;
  final double cardWidth;
  final double cardHeight;

  const HorizontalProductList({
    super.key,
    required this.title,
    required this.products,
    required this.onSeeMore,
    required this.onProductTap,
    this.cardWidth = 160,
    this.cardHeight = 280,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: title,
          actionText: 'See more',
          onActionTap: onSeeMore,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: cardHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Container(
                width: cardWidth,
                margin: EdgeInsets.only(
                  left: index == 0 ? 8 : 0,
                  right: 16,
                ),
                child: ProductCard(
                  product: product,
                  onTap: () => onProductTap(product),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CarouselProductSection extends StatelessWidget {
  final String title;
  final List<ProductModel> products;
  final VoidCallback onSeeMore;
  final Function(ProductModel) onProductTap;

  const CarouselProductSection({
    super.key,
    required this.title,
    required this.products,
    required this.onSeeMore,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: title,
            actionText: 'See more',
            onActionTap: onSeeMore,
          ),
          const SizedBox(height: 16),
          CarouselSlider(
            options: CarouselOptions(
              height: 280,
              viewportFraction: 0.45,
              enableInfiniteScroll: false,
              padEnds: false,
              initialPage: 0,
            ),
            items: products.map((product) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ProductCard(
                  product: product,
                  onTap: () => onProductTap(product),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
