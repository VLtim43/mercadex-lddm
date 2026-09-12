import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mercadex/core/constants/app_constants.dart';
import 'package:mercadex/core/theme/app_colors.dart';
import 'package:mercadex/core/widgets/empty_state.dart';
import 'package:mercadex/core/widgets/primary_button.dart';
import 'package:mercadex/core/widgets/product_card.dart';
import 'package:mercadex/features/products/data/mock_products.dart';
import 'package:mercadex/features/shopping_list/presentation/providers/shopping_list_provider.dart';

class ShoppingListPage extends ConsumerWidget {
  const ShoppingListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(shoppingListProvider);
    final totalUnits = items.fold<int>(0, (sum, item) => sum + item.quantity);
    final availableToAdd = MockProducts.all
        .where((product) => items.every((item) => item.productId != product.id))
        .toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Minha Lista',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.deepGreen,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Compra do mês',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: items.isEmpty
                  ? const EmptyState(
                      icon: Icons.shopping_bag_outlined,
                      title: 'Sua lista está vazia',
                      message:
                          'Adicione produtos pela busca ou pelos detalhes.',
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                      itemCount: items.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final product = MockProducts.byId(item.productId);
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                            child: Column(
                              children: [
                                ProductCard(
                                  product: product,
                                  onTap: () =>
                                      context.push('/product/${product.id}'),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      tooltip: 'Diminuir',
                                      onPressed: () => ref
                                          .read(shoppingListProvider.notifier)
                                          .decrement(item.productId),
                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                      ),
                                    ),
                                    Text(
                                      '${item.quantity}x',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    IconButton(
                                      tooltip: 'Aumentar',
                                      onPressed: () => ref
                                          .read(shoppingListProvider.notifier)
                                          .increment(item.productId),
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                      ),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () => ref
                                          .read(shoppingListProvider.notifier)
                                          .remove(item.productId),
                                      child: const Text('Remover'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                0,
                20,
                AppConstants.tabContentBottomPadding,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '$totalUnits itens',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (availableToAdd.isNotEmpty)
                    OutlinedButton.icon(
                      onPressed: () {
                        ref
                            .read(shoppingListProvider.notifier)
                            .add(availableToAdd.first.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${availableToAdd.first.name} adicionado à lista',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Adicionar produto'),
                    ),
                  const SizedBox(height: 10),
                  PrimaryButton(
                    label: 'Comparar supermercados',
                    icon: Icons.compare_arrows,
                    onPressed: items.isEmpty
                        ? null
                        : () => context.push('/compare'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
