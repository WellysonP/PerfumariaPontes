import 'package:flutter/material.dart';
import 'package:perfumaria/widgets/app_bar_custom.dart';
import 'package:perfumaria/widgets/bottom_bar_custom.dart';
import 'package:perfumaria/components/company_items.dart';
import 'package:perfumaria/provider/company_provider.dart';
import 'package:provider/provider.dart';

import '../components/product_items.dart';
import '../widgets/subtitle_appbar.dart';
import '../provider/product_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final company = Provider.of<CompanyProvider>(context);
    final product = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBarCustom.isFilter(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubtitleAppBar(text: "Destaques"),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      height: 123,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: company.itemsCount,
                        itemBuilder: (ctx, i) =>
                            CompanyItems(companyItem: company.items[i]),
                      ),
                    ),
                    SizedBox(height: 50),
                    Container(
                      height: 275,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: product.itemsCount,
                        itemBuilder: (ctx, i) =>
                            ProductItems(productItems: product.items[i]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomBarCustom.isHome(),
    );
  }
}
