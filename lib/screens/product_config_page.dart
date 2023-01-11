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
          // product.imageList = [],
          product.formData.clear(),
          Navigator.of(context).pushNamed(AppRoutes.producRegistrationPage),
        },
        isArrowBackFunction: () {
          Navigator.of(context).pop();
        },
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 5),
                      width: 170,
                      height: 30,
                      child: Form(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelStyle: const TextStyle(
                              fontSize: 14,
                            ),
                            labelText: "Marca",
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          value: product.formData.isEmpty
                              ? null
                              : product.formData["company"].toString(),
                          items: product.isEmphasis
                              ? product.list
                                  .map(
                                    (item) => DropdownMenuItem(
                                      value: item.company,
                                      child: Text(item.company),
                                    ),
                                  )
                                  .toList()
                              : company.itemsFilter
                                  .map(
                                    (item) => DropdownMenuItem<String>(
                                      value: item.name,
                                      child: Text(item.name),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            product.companyFilter = value;
                            product.filterCompany();
                          },
                          onSaved: (_) {},
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 5),
                      width: 170,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: InkWell(
                        splashColor: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          product.filterEnphasis();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Destaques",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(97, 97, 97, 1),
                                ),
                              ),
                              Icon(
                                product.isEmphasis
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_unchecked,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                  width: 170,
                  height: 30,
                  child: Form(
                    child: DropdownButtonFormField<String>(
                      key: product.key,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 12),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        labelText: "Produto",
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      value: product.formData.isEmpty
                          ? null
                          : product.formData["name"].toString(),
                      items: product.isEmphasis
                          ? product.itemsEmphasis
                              .map(
                                (item) => DropdownMenuItem<String>(
                                  value: item.name,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    width: 120,
                                    child: Text(
                                      item.name,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ),
                              )
                              .toList()
                          : product.companyFilter == "Todos"
                              ? product.itemsFilter
                                  .map(
                                    (item) => DropdownMenuItem<String>(
                                      value: item.name,
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        width: 120,
                                        child: Text(
                                          item.name,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList()
                              : product.companyFilterItems
                                  .map(
                                    (item) => DropdownMenuItem<String>(
                                      value: item.name,
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        width: 120,
                                        child: Text(
                                          item.name,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                      onChanged: (value) {
                        product.productFilter = value;
                        product.filterProduct();
                      },
                      onSaved: (_) {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ListView.builder(
                itemCount: product.toogleLength(),
                itemBuilder: (context, i) =>
                    ProductList(product: product.toogleCompany(i)),
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
