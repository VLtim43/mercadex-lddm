import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mercadex/core/widgets/empty_state.dart';
import 'package:mercadex/core/widgets/mercadex_search_bar.dart';
import 'package:mercadex/core/widgets/product_card.dart';
import 'package:mercadex/features/prices/data/mock_prices.dart';
import 'package:mercadex/features/products/data/mock_products.dart';
import 'package:mercadex/features/products/presentation/providers/search_query_provider.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);
    final results = MockProducts.search(query);

    return Scaffold(
      appBar: AppBar(title: const Text('Buscar produtos')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: MercadexSearchBar(
                autofocus: true,
                onChanged: ref.read(searchQueryProvider.notifier).setQuery,
              ),
            ),
            Expanded(
              child: results.isEmpty
                  ? const EmptyState(
                      icon: Icons.search_off,
                      title: 'Nenhum produto encontrado',
                      message: 'Tente outro nome, marca ou embalagem.',
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                      itemCount: results.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final product = results[index];
                        final offer = MockPrices.lowestFor(product.id);
                        return ProductCard(
                          product: product,
                          price: offer?.price,
                          subtitle: offer == null
                              ? null
                              : 'Menor preço em ${offer.branch.name}',
                          onTap: () => context.push('/product/${product.id}'),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
