import 'package:flutter/material.dart';
import 'package:perfumaria/models/product_model.dart';
import 'package:perfumaria/provider/product_provider.dart';
import 'package:provider/provider.dart';

class FavoriteButtom extends StatelessWidget {
  final double radius;
  final double sizeFavorite;
  final ProductModel product;
  const FavoriteButtom({
    Key? key,
    required this.radius,
    required this.sizeFavorite,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return InkWell(
      onTap: () {
        productProvider.tooglefavorite(product);
      },
      borderRadius: BorderRadius.circular(radius),
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: Color.fromRGBO(217, 217, 217, 1),
            radius: radius,
            child: Icon(
              product.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: product.isFavorite
                  ? Theme.of(context).colorScheme.primary
                  : Colors.black,
              size: sizeFavorite,
            ),
          ),
          // if (widget.product.isFavorite)
          //   CircleAvatar(
          //     backgroundColor: Colors.transparent,
          //     radius: widget.radius,
          //     child: Icon(
          //       Icons.favorite_border,
          //       color: Colors.black,
          //       size: widget.sizeFavorite,
          //     ),
          //   ),
        ],
      ),
    );
  }
}
