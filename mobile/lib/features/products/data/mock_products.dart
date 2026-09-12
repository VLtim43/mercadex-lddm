import 'package:mercadex/features/products/domain/product.dart';

class MockProducts {
  const MockProducts._();

  static const Product coke = Product(
    id: 'coke-2l',
    name: 'Coca-Cola Original 2L',
    brand: 'Coca-Cola',
    packaging: '2L',
    ean: '7894900011517',
    category: 'Bebidas',
  );

  static const Product rice = Product(
    id: 'arroz-5kg',
    name: 'Arroz Tipo 1 5kg',
    brand: 'Camil',
    packaging: '5kg',
    ean: '7896003701557',
    category: 'Mercearia',
  );

  static const Product beans = Product(
    id: 'feijao-1kg',
    name: 'Feijão Carioca 1kg',
    brand: 'Kicaldo',
    packaging: '1kg',
    ean: '7898911441013',
    category: 'Mercearia',
  );

  static const Product coffee = Product(
    id: 'cafe-500g',
    name: 'Café Tradicional 500g',
    brand: 'Pilão',
    packaging: '500g',
    ean: '7896005800157',
    category: 'Mercearia',
  );

  static const Product milk = Product(
    id: 'leite-1l',
    name: 'Leite Integral 1L',
    brand: 'Itambé',
    packaging: '1L',
    ean: '7891000100103',
    category: 'Laticínios',
  );

  static const List<Product> all = [coke, rice, beans, coffee, milk];

  static Product byId(String id) {
    return all.firstWhere((product) => product.id == id);
  }

  static List<Product> search(String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return all;
    return all.where((product) {
      return product.name.toLowerCase().contains(normalized) ||
          product.brand.toLowerCase().contains(normalized);
    }).toList();
  }
}
