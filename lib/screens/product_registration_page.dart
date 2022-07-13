import 'package:flutter/material.dart';
import 'package:perfumaria/widgets/app_bar_custom.dart';

class ProductregistrationPage extends StatelessWidget {
  const ProductregistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom.isArrowBack(
        icon: Icons.arrow_forward,
        onTap: () {},
        text: "Cadastrar Produto",
      ),
    );
  }
}
