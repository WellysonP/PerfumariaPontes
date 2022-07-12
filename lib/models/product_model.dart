class ProductModel {
  final String id;
  final String name;
  final int quantity;
  final double oldPrice;
  final double newPrice;
  final String imageUrl;
  final String description;
  bool isFavorite;
  bool isEmphasis;

  ProductModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.oldPrice,
    required this.newPrice,
    required this.imageUrl,
    required this.description,
    this.isFavorite = false,
    this.isEmphasis = false,
  });
}
