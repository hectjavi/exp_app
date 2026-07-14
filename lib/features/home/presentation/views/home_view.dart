import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/shimmer_loading.dart';
import '../../../cart/presentation/providers/cart_providers.dart';
import '../../../../shared/models/product_model.dart';
import '../../../product/domain/entities/product_entity.dart';

// ✅ providers
import '../../../product/presentation/providers/product_provider.dart';
import '../../../login/presentation/providers/auth_provider.dart';

// ✅ datasource (IMPORTANTE para delete)
import '../../../product/data/product_remote_datasource.dart';

import '../widgets/product_carousel_section.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int _currentBannerIndex = 0;
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authNotifierProvider);
    final isAdmin = auth.user?.rol == 'admin';

    final productsAsync = ref.watch(productsProvider);
    final cartItemsCount = ref.watch(cartItemsCountProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,

      // ✅ BOTÓN ADMIN
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: () {
                context.push('/admin/create-product');
              },
              child: const Icon(Icons.add),
            )
          : null,

      body: productsAsync.when(
        loading: () => const HomeShimmer(),

        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline,
                  color: AppTheme.errorColor, size: 60),
              const SizedBox(height: 16),
              Text('Error: $e'),
            ],
          ),
        ),

        data: (products) => SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _buildAppBar(cartItemsCount),
              ),

              SliverToBoxAdapter(
                child: _buildBannerCarousel([
                  'https://images.unsplash.com/photo-1551028719-00167b16eac5',
                ]),
              ),

              SliverToBoxAdapter(
                child: _buildCategoriesSection([
                  {'name': 'Men'},
                  {'name': 'Women'},
                ]),
              ),

              // ✅ PRODUCTOS + ADMIN CONTROLS
              SliverToBoxAdapter(
                child: ProductCarouselSection(
                  title: 'Products',
                  products: products,
                  onSeeMore: () => _showSeeMore('Products'),
                  onProductTap: (product) =>
                      _navigateToProduct(product),

                  // ✅ ADMIN
                  isAdmin: isAdmin,
                  onEdit: (product) {
                    context.push('/admin/edit-product', extra: product);
                  },
                  onDelete: (product) {
                    _deleteProduct(product);
                  },
                ),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // ✅ ELIMINAR PRODUCTO (uso datasource)
  Future<void> _deleteProduct(ProductModel product) async {
    try {
      final datasource = ref.read(productRemoteDataSourceProvider);

      await datasource.deleteProduct(product.id);

      // ✅ REFRESH
      ref.invalidate(productsProvider);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto eliminado')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // ✅ APP BAR
  Widget _buildAppBar(int cartCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.search),

          Text(
            'E-commerce',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),

          Row(
            children: [
              const Icon(Icons.favorite_outline),
              const SizedBox(width: 8),

              GestureDetector(
                onTap: () => context.push('/cart'),
                child: Stack(
                  children: [
                    const Icon(Icons.shopping_bag_outlined),

                    if (cartCount > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: AppTheme.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '$cartCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ✅ BANNER
  Widget _buildBannerCarousel(List<String> banners) {
    if (banners.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentBannerIndex = index;
              });
            },
          ),
          items: banners.map((banner) {
            return Image.network(banner, fit: BoxFit.cover);
          }).toList(),
        ),
        const SizedBox(height: 8),
        AnimatedSmoothIndicator(
          activeIndex: _currentBannerIndex,
          count: banners.length,
          effect: const WormEffect(),
        ),
      ],
    );
  }

  // ✅ CATEGORIES
  Widget _buildCategoriesSection(List<dynamic> categories) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: categories.map((category) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Chip(
              label: Text(category['name']),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ✅ NAV BAR
  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentNavIndex,
      onTap: (index) {
        setState(() {
          _currentNavIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Categories'),
        BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Stores'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }

  // ✅ NAVIGACIÓN
  void _navigateToProduct(ProductModel product) {
    final entity = ProductEntity(
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      images: product.images,
      sizes: product.sizes,
      colors: product.colors,
      category: product.category,
      rating: product.rating,
      reviewCount: product.reviewCount,
      isFavorite: product.isFavorite,
      stockQuantity: product.stockQuantity,
      brand: product.brand,
      material: product.material,
    );

    context.push(
      '/product/${product.id}',
      extra: entity,
    );
  }

  void _showSeeMore(String section) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('See more: $section')),
    );
  }
}
