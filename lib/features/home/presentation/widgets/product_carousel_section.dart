import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/product_model.dart';
import 'product_card.dart';

class ProductCarouselSection extends StatelessWidget {
  final String title;
  final List<ProductModel> products;
  final VoidCallback onSeeMore;
  final Function(ProductModel) onProductTap;

  // ✅ NUEVOS
  final bool isAdmin;
  final Function(ProductModel)? onEdit;
  final Function(ProductModel)? onDelete;

  const ProductCarouselSection({
    super.key,
    required this.title,
    required this.products,
    required this.onSeeMore,
    required this.onProductTap,

    // ✅ opcionales
    this.isAdmin = false,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ HEADER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                InkWell(
                  onTap: onSeeMore,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      'See more',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ✅ CAROUSEL
          CarouselSlider(
            options: CarouselOptions(
              height: 280,
              viewportFraction: 0.45,
              enableInfiniteScroll: false,
              padEnds: false,
            ),
            items: products.map((product) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Stack(
                  children: [
                    // ✅ PRODUCT CARD
                    ProductCard(
                      product: product,
                      onTap: () => onProductTap(product),
                    ),

                    // ✅ ADMIN MENU
                    if (isAdmin)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: PopupMenuButton<String>(
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.black,
                          ),
                          onSelected: (value) {
                            if (value == 'edit') {
                              onEdit?.call(product);
                            } else if (value == 'delete') {
                              onDelete?.call(product);
                            }
                          },
                          itemBuilder: (context) => const [
                            PopupMenuItem(
                              value: 'edit',
                              child: Text('Editar'),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Text('Eliminar'),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
