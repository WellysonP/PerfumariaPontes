import 'package:flutter/material.dart';
import 'package:perfumaria/components/product_list.dart';
import 'package:perfumaria/provider/company_provider.dart';
import 'package:perfumaria/provider/product_provider.dart';
import 'package:perfumaria/utils/app_routes.dart';
import 'package:perfumaria/widgets/app_bar_custom.dart';
import 'package:provider/provider.dart';

class ProductConfigPage extends StatelessWidget {
  const ProductConfigPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    final company = Provider.of<CompanyProvider>(context);
    return Scaffold(
      appBar: AppBarCustom.isArrowBack(
        isBag: false,
        text: "Configurar Produtos",
        colorIcon: Theme.of(context).colorScheme.primary,
        sizeIcon: 30,
        icon: Icons.add,
        onTap: () => {
          product.isEmphasis = false,
          product.image = null,
          product.imageList = [],
          product.formData.clear(),
          Navigator.of(context).pushNamed(AppRoutes.producRegistrationPage),
        },
        isArrowBackFunction: () {
          Navigator.of(context).pop();
        },
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            width: double.infinity,
            height: 100,
            child: Row(
              children: [
                // Container(
                //   width: 170,
                //   height: 30,
                //   child: Form(
                //     child: DropdownButtonFormField<String>(
                //       decoration: InputDecoration(
                //         contentPadding: const EdgeInsets.symmetric(
                //             vertical: 4, horizontal: 12),
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(20)),
                //         labelStyle: const TextStyle(
                //           fontSize: 14,
                //         ),
                //         labelText: "Fabricante",
                //         fillColor: Colors.white,
                //         filled: true,
                //       ),
                //       value: product.formData.isEmpty
                //           ? null
                //           : product.formData["company"].toString(),
                //       items: company.itemsFilter
                //           .map(
                //             (item) => DropdownMenuItem<String>(
                //               value: item.name,
                //               child: Text(item.name),
                //             ),
                //           )
                //           .toList(),
                //       onChanged: (value) {
                //         company.value = value;
                //       },
                //       onSaved: (company) =>
                //           product.formData["company"] = company ?? "",
                //       validator: (_company) {
                //         final company = _company ?? "";
                //         if (company.isEmpty) {
                //           return "Campo Obrigatório";
                //         }
                //         return null;
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ListView.builder(
                itemCount: product.items.length,
                itemBuilder: (context, i) =>
                    ProductList(product: product.items[i]),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.producRegistrationPage);
          },
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(255, 163, 34, 1),
                  Color.fromRGBO(240, 129, 4, 1),
                ],
              ),
            ),
            height: 60,
            child: const Center(
              child: Text(
                "Adicionar Produto",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(72, 31, 1, 1)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
