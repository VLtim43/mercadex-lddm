class Product {
  const Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.packaging,
    required this.ean,
    required this.category,
  });

  final String id;
  final String name;
  final String brand;
  final String packaging;
  final String ean;
  final String category;
}
