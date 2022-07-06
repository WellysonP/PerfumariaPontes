import 'package:flutter/cupertino.dart';

class ProductModel {
  final String id;
  final String name;
  final double oldPrice;
  final double newPrice;
  final String imageUrl;
  final String description;
  bool isFavorite;

  ProductModel({
    required this.id,
    required this.name,
    required this.oldPrice,
    required this.newPrice,
    required this.imageUrl,
    required this.description,
    this.isFavorite = false,
  });
}
