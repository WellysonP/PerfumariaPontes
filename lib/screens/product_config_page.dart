import 'package:flutter/material.dart';
import 'package:perfumaria/components/product_list.dart';
import 'package:perfumaria/provider/product_provider.dart';
import 'package:perfumaria/utils/app_routes.dart';
import 'package:perfumaria/widgets/app_bar_custom.dart';
import 'package:provider/provider.dart';

class ProductConfigPage extends StatelessWidget {
  const ProductConfigPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBarCustom.isArrowBack(
        text: "Configurar Produtos",
        colorIcon: Theme.of(context).colorScheme.primary,
        sizeIcon: 30,
        icon: Icons.add,
        onTap: () =>
            Navigator.of(context).pushNamed(AppRoutes.producRegistrationPage),
        isArrowBackFunction: () {},
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            width: double.infinity,
            height: 100,
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ListView.builder(
                itemCount: product.itemsCount,
                itemBuilder: (context, i) =>
                    ProductList(product: product.items[i]),
              ),
            ),
          )
        ],
      ),
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
