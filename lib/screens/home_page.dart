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
      appBar: const AppBarCustom.isFilter(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SubtitleAppBar(text: "Destaques"),
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 123,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: company.itemsCount,
                        itemBuilder: (ctx, i) =>
                            CompanyItems(companyItem: company.items[i]),
                      ),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      height: 275,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: product.itemsEmphasis.length,
                        itemBuilder: (ctx, i) => ProductItems(
                            productItems: product.itemsEmphasis[i]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: const BottomBarCustom.isHome(),
    );
  }
}
