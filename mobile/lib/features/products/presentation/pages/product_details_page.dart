import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mercadex/core/theme/app_colors.dart';
import 'package:mercadex/core/widgets/market_price_tile.dart';
import 'package:mercadex/core/widgets/price_card.dart';
import 'package:mercadex/core/widgets/primary_button.dart';
import 'package:mercadex/core/widgets/product_card.dart';
import 'package:mercadex/core/widgets/section_header.dart';
import 'package:mercadex/features/favorites/presentation/favorites_provider.dart';
import 'package:mercadex/features/markets/data/mock_markets.dart';
import 'package:mercadex/features/prices/data/mock_prices.dart';
import 'package:mercadex/features/products/data/mock_products.dart';
import 'package:mercadex/features/shopping_list/presentation/providers/shopping_list_provider.dart';

class ProductDetailsPage extends ConsumerWidget {
  const ProductDetailsPage({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = MockProducts.byId(productId);
    final prices = MockPrices.forProduct(productId);
    final lowest = prices.isEmpty ? null : prices.first;
    final isFavorite = ref.watch(favoritesProvider).contains(productId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produto'),
        actions: [
          IconButton(
            tooltip: isFavorite ? 'Remover dos favoritos' : 'Favoritar',
            onPressed: () {
              ref.read(favoritesProvider.notifier).toggle(productId);
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.redAccent : AppColors.deepGreen,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductAvatar(category: product.category, size: 72),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.deepGreen,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(product.brand),
                      const SizedBox(height: 8),
                      Text(
                        'EAN: ${product.ean}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (lowest != null) PriceCard(price: lowest.price),
            const SizedBox(height: 24),
            const SectionHeader(title: 'Preços encontrados'),
            const SizedBox(height: 12),
            ...prices.map(
              (observation) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: MarketPriceTile(
                  branch: MockMarkets.branchById(observation.branchId),
                  observation: observation,
                  highlighted: observation.id == lowest?.id,
                ),
              ),
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              label: 'Informar novo preço',
              icon: Icons.sell_outlined,
              onPressed: () => context.push('/add-price/$productId'),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () {
                ref.read(shoppingListProvider.notifier).add(productId);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Produto adicionado à lista')),
                );
              },
              icon: const Icon(Icons.add_shopping_cart_outlined),
              label: const Text('Adicionar à lista'),
            ),
          ],
        ),
      ),
    );
  }
}
