import 'package:flutter/material.dart';
import 'package:perfumaria/models/product_model.dart';
import 'package:perfumaria/utils/app_routes.dart';

import 'favorite_buttom.dart';

class ProductGridItem extends StatelessWidget {
  final ProductModel product;
  const ProductGridItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: GridTile(
            child: Column(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.PRODUCT_DESCRIPTION,
                      arguments: product,
                    );
                  },
                  child: Image.network(
                    product.imageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  color: Color.fromRGBO(130, 129, 129, 0.2),
                  height: 50,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "R\$${product.oldPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(169, 169, 169, 1),
                              decoration: TextDecoration.lineThrough),
                        ),
                        Text(
                          "R\$${product.newPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: InkWell(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              onTap: () {},
              child: Container(
                height: 50,
                width: 50,
                color: Theme.of(context).colorScheme.primary,
                child: Icon(Icons.add, size: 30),
              ),
            ),
          ),
        ),
        Positioned(
            top: 8,
            right: 8,
            child: FavoriteButtom(
              radius: 15,
              sizeFavorite: 20,
              product: product,
            )),
      ],
    );
  }
}
