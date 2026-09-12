import 'package:mercadex/features/markets/data/mock_markets.dart';
import 'package:mercadex/features/markets/domain/market_branch.dart';
import 'package:mercadex/features/prices/domain/price_observation.dart';
import 'package:mercadex/features/products/data/mock_products.dart';
import 'package:mercadex/features/products/domain/product.dart';

class ProductOffer {
  const ProductOffer({
    required this.product,
    required this.price,
    required this.branch,
    required this.updatedLabel,
  });

  final Product product;
  final double price;
  final MarketBranch branch;
  final String updatedLabel;
}

class MockPrices {
  const MockPrices._();

  static const List<PriceObservation> all = [
    PriceObservation(
      id: 'p1',
      productId: 'coke-2l',
      branchId: 'bh-savassi',
      price: 8.99,
      updatedLabel: 'Atualizado há 2 horas',
    ),
    PriceObservation(
      id: 'p2',
      productId: 'coke-2l',
      branchId: 'carrefour-pampulha',
      price: 9.49,
      updatedLabel: 'Atualizado hoje',
    ),
    PriceObservation(
      id: 'p3',
      productId: 'coke-2l',
      branchId: 'supernosso-lourdes',
      price: 10.20,
      updatedLabel: 'Atualizado ontem',
    ),
    PriceObservation(
      id: 'p4',
      productId: 'arroz-5kg',
      branchId: 'bh-savassi',
      price: 21.90,
      updatedLabel: 'Atualizado hoje',
    ),
    PriceObservation(
      id: 'p5',
      productId: 'arroz-5kg',
      branchId: 'carrefour-pampulha',
      price: 23.40,
      updatedLabel: 'Atualizado ontem',
    ),
    PriceObservation(
      id: 'p6',
      productId: 'feijao-1kg',
      branchId: 'bh-savassi',
      price: 7.49,
      updatedLabel: 'Atualizado há 4 horas',
    ),
    PriceObservation(
      id: 'p7',
      productId: 'cafe-500g',
      branchId: 'carrefour-pampulha',
      price: 18.90,
      updatedLabel: 'Atualizado hoje',
    ),
    PriceObservation(
      id: 'p8',
      productId: 'leite-1l',
      branchId: 'supernosso-lourdes',
      price: 5.79,
      updatedLabel: 'Atualizado há 1 hora',
    ),
  ];

  static List<PriceObservation> forProduct(String productId) {
    final prices = all.where((item) => item.productId == productId).toList()
      ..sort((a, b) => a.price.compareTo(b.price));
    return prices;
  }

  static ProductOffer? lowestFor(String productId) {
    final prices = forProduct(productId);
    if (prices.isEmpty) return null;
    final lowest = prices.first;
    return ProductOffer(
      product: MockProducts.byId(productId),
      price: lowest.price,
      branch: MockMarkets.branchById(lowest.branchId),
      updatedLabel: lowest.updatedLabel,
    );
  }

  static List<ProductOffer> nearbyOffers() {
    return [
      lowestFor('arroz-5kg')!,
      lowestFor('coke-2l')!,
      lowestFor('feijao-1kg')!,
    ];
  }

  static List<Product> recentlySearched() {
    return [MockProducts.coffee, MockProducts.milk, MockProducts.beans];
  }
}
