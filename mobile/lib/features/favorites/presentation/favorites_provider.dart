import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => {'arroz-5kg', 'cafe-500g'};

  bool contains(String productId) => state.contains(productId);

  void toggle(String productId) {
    final next = {...state};
    if (!next.add(productId)) {
      next.remove(productId);
    }
    state = next;
  }
}

final favoritesProvider = NotifierProvider<FavoritesNotifier, Set<String>>(
  FavoritesNotifier.new,
);
