import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:perfumaria/widgets/bottom_bar_custom.dart';
import 'package:perfumaria/widgets/subtitle_appbar.dart';

import '../widgets/app_bar_custom.dart';
import '../components/product_grid.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom.isFilter(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubtitleAppBar(text: "Catálogo"),
          Expanded(
            child: Container(
              child: ProductGrid(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBarCustom.isExplore(),
    );
  }
}
