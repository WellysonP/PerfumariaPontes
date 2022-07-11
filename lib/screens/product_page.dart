import 'package:flutter/material.dart';
import 'package:perfumaria/widgets/bottom_bar_custom.dart';
import 'package:perfumaria/widgets/subtitle_appbar.dart';
import '../widgets/app_bar_custom.dart';
import '../components/product_grid.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom.isFilter(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const SubtitleAppBar(text: "Catálogo"),
          // ignore: prefer_const_constructors
          Expanded(
            // ignore: prefer_const_constructors
            child: ProductGrid(),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBarCustom.isExplore(),
    );
  }
}
