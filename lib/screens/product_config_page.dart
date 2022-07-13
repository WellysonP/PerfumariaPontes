import 'package:flutter/material.dart';
import 'package:perfumaria/utils/app_routes.dart';
import 'package:perfumaria/widgets/app_bar_custom.dart';

class ProductConfigPage extends StatelessWidget {
  const ProductConfigPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom.isArrowBack(
        text: "Configurar Produtos",
        colorIcon: Theme.of(context).colorScheme.primary,
        sizeIcon: 30,
        icon: Icons.add,
        onTap: () =>
            Navigator.of(context).pushNamed(AppRoutes.producRegistrationPage),
      ),
      body: Container(),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.primary,
        child: InkWell(
          onTap: () {},
          child: const SizedBox(
            height: 60,
            child: Center(
              child: Text(
                "Adicionar Produto",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
