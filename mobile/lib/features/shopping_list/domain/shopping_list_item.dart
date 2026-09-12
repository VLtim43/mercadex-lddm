class ShoppingListItem {
  const ShoppingListItem({required this.productId, required this.quantity});

  final String productId;
  final int quantity;

  ShoppingListItem copyWith({int? quantity}) {
    return ShoppingListItem(
      productId: productId,
      quantity: quantity ?? this.quantity,
    );
  }
}
