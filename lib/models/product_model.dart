class ProductModel {
  final String id;
  final String name;
  final double oldPrice;
  final double newPrice;
  final String imageUrl;

  const ProductModel({
    required this.id,
    required this.name,
    required this.oldPrice,
    required this.newPrice,
    required this.imageUrl,
  });
}
