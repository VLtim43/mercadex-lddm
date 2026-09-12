import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mercadex/core/widgets/mercadex_bottom_navigation.dart';
import 'package:mercadex/features/favorites/presentation/pages/favorites_page.dart';
import 'package:mercadex/features/home/presentation/pages/home_page.dart';
import 'package:mercadex/features/markets/presentation/pages/comparison_page.dart';
import 'package:mercadex/features/prices/presentation/pages/add_price_page.dart';
import 'package:mercadex/features/products/presentation/pages/product_details_page.dart';
import 'package:mercadex/features/products/presentation/pages/search_page.dart';
import 'package:mercadex/features/profile/presentation/pages/profile_page.dart';
import 'package:mercadex/features/scanner/presentation/pages/scanner_page.dart';
import 'package:mercadex/features/shopping_list/presentation/pages/shopping_list_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/home', redirect: (_, _) => '/'),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MercadexBottomNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/', builder: (context, state) => const HomePage()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/favorites',
                builder: (context, state) => const FavoritesPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/shopping-list',
                builder: (context, state) => const ShoppingListPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(path: '/search', builder: (context, state) => const SearchPage()),
      GoRoute(
        path: '/product/:id',
        builder: (context, state) {
          return ProductDetailsPage(productId: state.pathParameters['id']!);
        },
      ),
      GoRoute(
        path: '/scanner',
        builder: (context, state) => const ScannerPage(),
      ),
      GoRoute(
        path: '/add-price/:productId',
        builder: (context, state) {
          return AddPricePage(productId: state.pathParameters['productId']!);
        },
      ),
      GoRoute(
        path: '/compare',
        builder: (context, state) => const ComparisonPage(),
      ),
    ],
  );
});
