// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  final String id;
  final String name;
  final String company;
  final int quantity;
  final double cost;
  final double oldPrice;
  final double newPrice;
  final String imageUrl;
  final String description;
  bool isFavorite;
  bool isEmphasis;

  ProductModel({
    required this.id,
    required this.name,
    required this.company,
    required this.quantity,
    required this.cost,
    required this.oldPrice,
    required this.newPrice,
    required this.imageUrl,
    required this.description,
    this.isFavorite = false,
    this.isEmphasis = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'company': company,
      'quantity': quantity,
      'cost': cost,
      'oldPrice': oldPrice,
      'newPrice': newPrice,
      'imageUrl': imageUrl,
      'description': description,
      'isFavorite': isFavorite,
      'isEmphasis': isEmphasis,
    };
  }

  factory ProductModel.fromMap(dynamic map) {
    return ProductModel(
      id: map['id'] as String,
      name: map['name'] as String,
      company: map['company'] as String,
      quantity: map['quantity'] as int,
      cost: map['cost'] as double,
      oldPrice: map['oldPrice'] as double,
      newPrice: map['newPrice'] as double,
      imageUrl: map['imageUrl'] as String,
      description: map['description'] as String,
      isFavorite: map['isFavorite'] == null ? false : map['isFavorite'],
      isEmphasis: map['isEmphasis'] == null ? false : map['isEmphasis'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
