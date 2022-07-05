import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:perfumaria/components/bottom_bar_custom.dart';

import '../components/app_bar_custom.dart';
import '../components/product_grid.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarCustom.isFilter(
              icon: Icons.filter_alt_outlined,
              text: "Catálogo",
            ),
            SizedBox(height: 17),
            Expanded(
              child: ProductGrid(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBarCustom.isExplore(),
    );
  }
}
