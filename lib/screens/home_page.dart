import 'package:flutter/material.dart';
import 'package:perfumaria/components/bottom_bar_custom.dart';
import 'package:perfumaria/components/company_items.dart';
import 'package:perfumaria/provider/company_provider.dart';
import 'package:provider/provider.dart';

import '../components/app_bar_custom.dart';
import '../components/product_items.dart';
import '../provider/product_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final company = Provider.of<CompanyProvider>(context);
    final product = Provider.of<ProductProvider>(context);
    return Scaffold(
      bottomNavigationBar: BottomBarCustom.isHome(),
      body: SafeArea(
        child: Column(
          children: [
            AppBarCustom.isFilter(
              icon: Icons.filter_alt_outlined,
              text: "Destaques",
            ),
            SizedBox(height: 31),
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
    );
  }
}
