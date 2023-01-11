import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../utils/app_routes.dart';

class ProductItems extends StatelessWidget {
  final ProductModel productItems;
  const ProductItems({Key? key, required this.productItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.productDescription,
                    arguments: productItems,
                  );
                },
                child: Hero(
                  tag: productItems.id,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(productItems.imageUrl),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 190,
                height: 40,
                child: Center(
                  child: AutoSizeText(
                    productItems.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    minFontSize: 18,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Text(
                "De: R\$ ${productItems.oldPrice.toStringAsFixed(2)}",
                style: const TextStyle(
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
      ),
    );
  }
}
