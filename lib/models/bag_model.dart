class BagModel {
  final String id;
  final String productId;
  final String name;
  final int quantity;
  final double oldPrice;
  final double newPrice;
  final String imageUrl;

  const BagModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.oldPrice,
    required this.newPrice,
    required this.imageUrl,
  });
}
