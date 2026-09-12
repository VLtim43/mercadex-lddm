class MarketComparison {
  const MarketComparison({
    required this.marketId,
    required this.total,
    required this.distanceKm,
    this.savings,
  });

  final String marketId;
  final double total;
  final double distanceKm;
  final double? savings;
}
