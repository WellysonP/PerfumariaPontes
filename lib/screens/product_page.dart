import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:perfumaria/components/bottom_bar_custom.dart';
import 'package:perfumaria/components/subtitle_appbar.dart';

import '../components/app_bar_custom.dart';
import '../components/product_grid.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom.isFilter(),
      body: SafeArea(
        child: Column(
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
      ),
      bottomNavigationBar: BottomBarCustom.isExplore(),
    );
  }
}
