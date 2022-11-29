import 'package:flutter/cupertino.dart';
import 'package:perfumaria/provider/product_provider.dart';
import 'package:provider/provider.dart';

import 'product_grid_item.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeDevice = MediaQuery.of(context).size;
    final product = Provider.of<ProductProvider>(context);
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      itemCount: product.showFavorite
          ? product.itemsFavorite.length
          : product.items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: sizeDevice.width ~/ 165,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          mainAxisExtent: 200),
      itemBuilder: (ctx, i) => ProductGridItem(
          product: product.showFavorite
              ? product.itemsFavorite[i]
              : product.items[i]),
    );
  }
}
