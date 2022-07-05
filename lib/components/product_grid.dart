import 'package:flutter/cupertino.dart';
import 'package:perfumaria/provider/product_provider.dart';
import 'package:provider/provider.dart';

import 'product_grid_item.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    final sizeDevide = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(right: 17, left: 17),
      child: GridView.builder(
        itemCount: product.itemsCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.859),
        itemBuilder: (ctx, i) => ProductGridItem(product: product.items[i]),
      ),
    );
  }
}
