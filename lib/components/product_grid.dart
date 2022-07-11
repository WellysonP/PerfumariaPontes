import 'package:flutter/cupertino.dart';
import 'package:perfumaria/provider/product_provider.dart';
import 'package:provider/provider.dart';

import 'product_grid_item.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      itemCount: product.itemsCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 0.859),
      itemBuilder: (ctx, i) => ProductGridItem(product: product.items[i]),
    );
  }
}
