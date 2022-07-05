import 'package:flutter/material.dart';

import '../components/app_bar_custom.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarCustom.isArrowBack(
              icon: Icons.arrow_back,
              text: "Descrição",
            ),
          ],
        ),
      ),
    );
  }
}
