import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/cart_item_model.dart';
import '../../../../shared/widgets/quantity_selector.dart';
import '../providers/cart_providers.dart';

class CartItemTile extends ConsumerWidget {
  final CartItemModel item;
  final VoidCallback? onRemoved;

  const CartItemTile({
    super.key,
    required this.item,
    this.onRemoved,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          InkWell(
            onTap: () => _navigateToProduct(context),
            borderRadius: BorderRadius.circular(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 80,
                height: 80,
                color: AppTheme.backgroundColor,
                child: Image.network(
                  item.product.images.first,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.image_not_supported,
                      color: AppTheme.textMuted,
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppTheme.primaryColor,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => _navigateToProduct(context),
                  child: Text(
                    item.product.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.selectedColor} / ${item.selectedSize}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),

                // Quantity and Price Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    QuantitySelector(
                      quantity: item.quantity,
                      onIncrement: () {
                        ref.read(cartNotifierProvider.notifier)
                            .updateQuantity(item.id, item.quantity + 1);
                      },
                      onDecrement: () {
                        ref.read(cartNotifierProvider.notifier)
                            .updateQuantity(item.id, item.quantity - 1);
                      },
                      compact: true,
                    ),

                    // Price
                    Text(
                      'Q ${(item.product.price * item.quantity).toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Remove Button
          InkWell(
            onTap: () {
              ref.read(cartNotifierProvider.notifier).removeItem(item.id);
              onRemoved?.call();
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(4),
              child: const Icon(
                Icons.close,
                color: AppTheme.textMuted,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToProduct(BuildContext context) {
    context.push('/product/${item.product.id}', extra: item.product);
  }
}
