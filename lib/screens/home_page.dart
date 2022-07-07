import 'package:flutter/material.dart';
import 'package:perfumaria/components/app_bar_custom.dart';
import 'package:perfumaria/components/bottom_bar_custom.dart';
import 'package:perfumaria/components/company_items.dart';
import 'package:perfumaria/provider/company_provider.dart';
import 'package:provider/provider.dart';

import '../components/product_items.dart';
import '../components/subtitle_appbar.dart';
import '../provider/product_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final company = Provider.of<CompanyProvider>(context);
    final product = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBarCustom.isFilter(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubtitleAppBar(text: "Destaques"),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 175,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: company.itemsCount,
                        itemBuilder: (ctx, i) =>
                            CompanyItems(companyItem: company.items[i]),
                      ),
                    ),
                    Expanded(
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
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomBarCustom.isHome(),
    );
  }
}
