import 'package:mercadex/features/markets/domain/market.dart';
import 'package:mercadex/features/markets/domain/market_branch.dart';
import 'package:mercadex/features/markets/domain/market_comparison.dart';

class MockMarkets {
  const MockMarkets._();

  static const Market bh = Market(id: 'mercado-bh', name: 'Mercado BH');
  static const Market carrefour = Market(id: 'carrefour', name: 'Carrefour');
  static const Market supernosso = Market(id: 'supernosso', name: 'Supernosso');

  static const List<Market> all = [bh, carrefour, supernosso];

  static const MarketBranch bhSavassi = MarketBranch(
    id: 'bh-savassi',
    marketId: 'mercado-bh',
    name: 'Mercado BH',
    unitLabel: 'Mercado BH - Savassi',
    distanceKm: 1.2,
  );

  static const MarketBranch bhPampulha = MarketBranch(
    id: 'bh-pampulha',
    marketId: 'mercado-bh',
    name: 'Mercado BH',
    unitLabel: 'Mercado BH - Pampulha',
    distanceKm: 2.1,
  );

  static const MarketBranch carrefourPampulha = MarketBranch(
    id: 'carrefour-pampulha',
    marketId: 'carrefour',
    name: 'Carrefour',
    unitLabel: 'Carrefour - Pampulha',
    distanceKm: 2.8,
  );

  static const MarketBranch carrefourContagem = MarketBranch(
    id: 'carrefour-contagem',
    marketId: 'carrefour',
    name: 'Carrefour',
    unitLabel: 'Carrefour - Contagem',
    distanceKm: 4.5,
  );

  static const MarketBranch supernossoLourdes = MarketBranch(
    id: 'supernosso-lourdes',
    marketId: 'supernosso',
    name: 'Supernosso',
    unitLabel: 'Supernosso - Lourdes',
    distanceKm: 3.1,
  );

  static const MarketBranch supernossoBuritis = MarketBranch(
    id: 'supernosso-buritis',
    marketId: 'supernosso',
    name: 'Supernosso',
    unitLabel: 'Supernosso - Buritis',
    distanceKm: 3.6,
  );

  static const List<MarketBranch> branches = [
    bhSavassi,
    bhPampulha,
    carrefourPampulha,
    carrefourContagem,
    supernossoLourdes,
    supernossoBuritis,
  ];

  static Market byId(String id) {
    return all.firstWhere((market) => market.id == id);
  }

  static MarketBranch branchById(String id) {
    return branches.firstWhere((branch) => branch.id == id);
  }

  static List<MarketBranch> branchesForMarket(String marketId) {
    return branches.where((branch) => branch.marketId == marketId).toList();
  }

  static const List<MarketComparison> listComparison = [
    MarketComparison(
      marketId: 'mercado-bh',
      total: 84.30,
      distanceKm: 1.8,
      savings: 8.80,
    ),
    MarketComparison(marketId: 'carrefour', total: 89.70, distanceKm: 2.8),
    MarketComparison(marketId: 'supernosso', total: 93.10, distanceKm: 3.1),
  ];
}
