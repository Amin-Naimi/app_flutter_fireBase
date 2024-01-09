import 'dart:async';

import 'package:dsi32_flutter_project/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:dsi32_flutter_project/features/auth/presentation/pages/register_page.dart';
import 'package:dsi32_flutter_project/features/products/presentation/pages/add_product_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/pages/auth_apge.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/products/domain/entities/product.dart';
import '../features/products/presentation/pages/product_details_page.dart';
import '../features/products/presentation/pages/product_page.dart';

class AppRouter {
  final AuthBloc authBloc;

  AppRouter(this.authBloc);

  late final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        name: 'authentication',
        builder: (context, state) {
          return AuthPage();
        },
        routes: [
          GoRoute(
            path: 'product',
            name: 'product',
            builder: (context, state) {
              return ProductPage();
            },
          ),
          GoRoute(
            path: 'addproduct',
            name: 'addproduct',
            builder: (context, state) {
              bool isUpdateProduct = state.extra as bool;
              return AddProductPage(
                isUpdateProduct: isUpdateProduct,
              );
            },
          ),
          GoRoute(
            path: 'detailsproduct',
            name: 'detailsproduct',
            builder: (context, state) {
              Product product = state.extra as Product;
              return ProductItemPage(
                product: product,
              );
            },
          ),
          GoRoute(
            path: 'register',
            name: 'register',
            builder: (context, state) {
              return RegisterPage();
            },
          ),
          GoRoute(
            path: 'login',
            name: 'login',
            builder: (context, state) {
              return LoginPage();
            },
          ),
          /* GoRoute(
            path: 'update',
            name: 'update_user',
            builder: (context, state) {
              return UpdateUserPage();
            },
          ),*/
        ],
      ),
      /*GoRoute(
          path: '/galerie',
          name: 'galerie',//découpler l'URL de son utilisation, si je modifie l'url => name c le meme
          builder: (context, state) {
            return GallerieImagePage();
          }),*/
    ],
    /*errorBuilder: (context, state) => PageNotFound(),
    redirect: (context, state) {
      final bool unauthenticated = authBloc.state is UnAuthenticatedState;
      final bool isGaleriePage = (state.subloc == '/product');

      if (unauthenticated && isGaleriePage) {
        return '/';
      }
    },
    refreshListenable: GoRouterRefreshStream(authBloc.stream),*/
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
