class PriceObservation {
  const PriceObservation({
    required this.id,
    required this.productId,
    required this.branchId,
    required this.price,
    required this.updatedLabel,
  });

  final String id;
  final String productId;
  final String branchId;
  final double price;
  final String updatedLabel;
}
