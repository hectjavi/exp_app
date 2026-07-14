import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/orders/presentation/view/order_history_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/views/home_view.dart';
import '../../features/product/presentation/views/product_detail_view.dart';
import '../../features/cart/presentation/views/cart_view.dart';
import '../../features/checkout/presentation/views/checkout_view.dart';
import '../../features/login/presentation/views/login_view.dart';

import '../../features/product/domain/entities/product_entity.dart';
import '../../shared/models/product_model.dart';

import '../../features/login/presentation/providers/auth_provider.dart';

import '../../features/product/presentation/views/create_product_view.dart';
import '../../features/product/presentation/views/edit_product_view.dart';


// ✅ ROUTER COMO PROVIDER
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    debugLogDiagnostics: true,

    // ✅ REDIRECT GLOBAL (LOGIN CONTROL)
    redirect: (context, state) {
      final isLoggedIn = authState.isAuthenticated;

      final isLoggingIn = state.uri.toString() == '/login';

      // ❌ No logueado → siempre a login
      if (!isLoggedIn && !isLoggingIn) {
        return '/login';
      }

      // ✅ Ya logueado → evitar volver a login
      if (isLoggedIn && isLoggingIn) {
        return '/';
      }

      return null;
    },

    routes: [
      // ✅ HOME
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeView(),
      ),

      // ✅ PRODUCT DETAIL
      GoRoute(
        path: '/product/:id',
        name: 'productDetail',
        builder: (context, state) {
          final extra = state.extra;

          if (extra == null || extra is! ProductEntity) {
            return const Scaffold(
              body: Center(
                child: Text('Error: Producto inválido o no enviado'),
              ),
            );
          }

          final product = ProductModel.fromEntity(extra);

          return ProductDetailView(product: product);
        },
      ),

      // ✅ CART
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => const CartView(),
      ),

      // ✅ CHECKOUT (protegido automáticamente por redirect)
      GoRoute(
        path: '/checkout',
        name: 'checkout',
        builder: (context, state) => const CheckoutView(),
      ),

      // ✅ LOGIN
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
  path: '/admin/create-product',
  builder: (context, state) => const CreateProductView(),
),

GoRoute(
  path: '/admin/edit-product',
  builder: (context, state) {
    final product = state.extra as ProductModel;
    return EditProductView(product: product);
  },
),
GoRoute(
  path: '/orders',
  builder: (context, state) =>
      const OrderHistoryView(),
),

    ],
  );
});
