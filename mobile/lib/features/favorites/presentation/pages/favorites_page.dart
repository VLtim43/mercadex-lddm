import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mercadex/core/constants/app_constants.dart';
import 'package:mercadex/core/theme/app_colors.dart';
import 'package:mercadex/core/widgets/empty_state.dart';
import 'package:mercadex/core/widgets/product_card.dart';
import 'package:mercadex/features/favorites/presentation/favorites_provider.dart';
import 'package:mercadex/features/prices/data/mock_prices.dart';
import 'package:mercadex/features/products/data/mock_products.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteIds = ref.watch(favoritesProvider);
    final products = MockProducts.all
        .where((product) => favoriteIds.contains(product.id))
        .toList();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            20,
            12,
            20,
            AppConstants.tabContentBottomPadding,
          ),
          children: [
            Text(
              'Favoritos',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.deepGreen,
              ),
            ),
            const SizedBox(height: 16),
            if (products.isEmpty)
              const EmptyState(
                icon: Icons.favorite_outline,
                title: 'Nenhum favorito ainda',
                message: 'Toque no coração na página do produto para salvar.',
              )
            else
              ...products.map(
                (product) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ProductCard(
                    product: product,
                    price: MockPrices.lowestFor(product.id)?.price,
                    onTap: () => context.push('/product/${product.id}'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
