import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercadex/features/shopping_list/domain/shopping_list_item.dart';

class ShoppingListNotifier extends Notifier<List<ShoppingListItem>> {
  @override
  List<ShoppingListItem> build() => const [
    ShoppingListItem(productId: 'arroz-5kg', quantity: 1),
    ShoppingListItem(productId: 'feijao-1kg', quantity: 2),
    ShoppingListItem(productId: 'cafe-500g', quantity: 1),
    ShoppingListItem(productId: 'leite-1l', quantity: 6),
  ];

  int get totalUnits => state.fold(0, (sum, item) => sum + item.quantity);

  void add(String productId) {
    final index = state.indexWhere((item) => item.productId == productId);
    if (index >= 0) {
      increment(productId);
      return;
    }
    state = [...state, ShoppingListItem(productId: productId, quantity: 1)];
  }

  void increment(String productId) {
    state = [
      for (final item in state)
        if (item.productId == productId)
          item.copyWith(quantity: item.quantity + 1)
        else
          item,
    ];
  }

  void decrement(String productId) {
    state = [
      for (final item in state)
        if (item.productId == productId && item.quantity > 1)
          item.copyWith(quantity: item.quantity - 1)
        else
          item,
    ];
  }

  void remove(String productId) {
    state = state.where((item) => item.productId != productId).toList();
  }
}

final shoppingListProvider =
    NotifierProvider<ShoppingListNotifier, List<ShoppingListItem>>(
      ShoppingListNotifier.new,
    );
