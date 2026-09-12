class MarketBranch {
  const MarketBranch({
    required this.id,
    required this.marketId,
    required this.name,
    required this.unitLabel,
    required this.distanceKm,
  });

  final String id;
  final String marketId;
  final String name;
  final String unitLabel;
  final double distanceKm;
}
