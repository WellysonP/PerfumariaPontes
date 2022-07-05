import 'package:flutter/material.dart';
import 'package:perfumaria/models/company_model.dart';

import '../models/product_model.dart';

class ProductItems extends StatelessWidget {
  final ProductModel productItems;
  const ProductItems({Key? key, required this.productItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(productItems.imageUrl),
            ),
            const SizedBox(height: 5),
            Text(
              productItems.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "De: R\$ ${productItems.oldPrice.toStringAsFixed(2)}",
              style: TextStyle(
                  color: Color.fromRGBO(169, 169, 169, 1),
                  fontSize: 15,
                  decoration: TextDecoration.lineThrough),
            ),
            Text(
              "Por: R\$ ${productItems.newPrice.toStringAsFixed(2)}",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w900),
            )
          ],
        ),
      ],
    );
  }
}
