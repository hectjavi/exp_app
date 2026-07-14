
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../providers/cart_providers.dart';

class CartView extends ConsumerWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartNotifierProvider);

    final items = cartState.data?.items ?? [];
    final count = items.length;
    final total = cartState.data?.total ?? 0;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverToBoxAdapter(
              child: _buildAppBar(context),
            ),

            // Cart Items or Empty State
            if (items.isEmpty)
              SliverFillRemaining(
                child: _buildEmptyCart(context),
              )
            else ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                  child: Text(
                    '$count ${count == 1 ? 'item' : 'items'} in your bag',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                ),
              ),

              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = items[index];
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: _buildCartItem(context, ref, item),
                    );
                  },
                  childCount: items.length,
                ),
              ),

              // Divider
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Divider(
                    color: AppTheme.borderColor,
                    thickness: 1,
                  ),
                ),
              ),

              // Total Section
              SliverToBoxAdapter(
                child: _buildTotalSection(context, total),
              ),

              // Checkout Button
              SliverToBoxAdapter(
                child: _buildCheckoutButton(context),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => context.pop(),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Your bag',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_bag_outlined, size: 80),
          const SizedBox(height: 20),
          Text(
            'Your bag is empty',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          CustomButton(
            text: 'Continue Shopping',
            onPressed: () => context.pop(),
          ),
        ],
      ),
    );
  }

Widget _buildCartItem(BuildContext context, WidgetRef ref, dynamic item) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 📦 Imagen
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade200,
            image: item.product.images.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(item.product.images.first),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        ),

        const SizedBox(width: 12),

        // 🧾 Info del producto
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                '${item.selectedColor} / ${item.selectedSize}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 8),

              // 🔢 Cantidad
              Row(
                children: [
                  _qtyButton(
                    icon: Icons.remove,
                    onTap: () {
                      ref
                          .read(cartNotifierProvider.notifier)
                          .updateQuantity(item.id, item.quantity - 1);
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text('${item.quantity}'),
                  ),

                  _qtyButton(
                    icon: Icons.add,
                    onTap: () {
                      ref
                          .read(cartNotifierProvider.notifier)
                          .updateQuantity(item.id, item.quantity + 1);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),

        // 💰 Precio
        Text(
          'Q ${(item.product.price * item.quantity).toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

  Widget _buildTotalSection(BuildContext context, double total) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Total'),
          Text(
            'Q ${total.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CustomButton(
        text: 'Checkout',
        
    onPressed: () => context.push('/checkout'),

      ),
    );
  }
  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade200,
      ),
      child: Icon(icon, size: 16),
    ),
  );
}
}
