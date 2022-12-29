import 'package:flutter/material.dart';
import 'package:perfumaria/provider/bag_provider.dart';
import 'package:perfumaria/widgets/favorite_buttom.dart';
import 'package:perfumaria/models/product_model.dart';
import 'package:provider/provider.dart';

import '../widgets/app_bar_custom.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    final sizeDevice = MediaQuery.of(context).size;
    final ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    final bag = Provider.of<BagProvider>(context);
    return Scaffold(
      appBar: AppBarCustom.isArrowBack(
        text: "Descrição",
        onTap: () {},
        isArrowBackFunction: () {
          Navigator.of(context).pop();
        },
      ),
      body: Column(
        children: [
          const SizedBox(height: 17),
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Hero(
                  tag: product.id,
                  child: Image.network(
                    product.imageUrl,
                    height: sizeDevice.height * 0.50,
                    width: sizeDevice.width * 1,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: FavoriteButtom(
                    radius: 20, sizeFavorite: 25, product: product),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: InkWell(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    onTap: () {},
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(254, 162, 64, 1),
                            Color.fromRGBO(245, 130, 0, 1),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "R\$${product.oldPrice.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(55, 55, 55, 1),
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Text(
                              "R\$${product.newPrice.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(72, 31, 1, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              width: sizeDevice.width * 1,
              color: const Color.fromRGBO(130, 129, 129, 0.2),
              child: Padding(
                padding: const EdgeInsets.only(top: 29, left: 17, right: 11),
                child: Text(
                  product.description,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      height: 1.5,
                      wordSpacing: 2),
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: InkWell(
          onTap: () {
            msg.hideCurrentSnackBar();
            msg.showSnackBar(
              SnackBar(
                backgroundColor: const Color.fromRGBO(63, 58, 58, 1),
                duration: const Duration(seconds: 2),
                content: Text("${product.name} Adicionado à Sacola"),
                action: SnackBarAction(
                  textColor: Theme.of(context).colorScheme.primary,
                  label: "DESFAZER",
                  onPressed: () => bag.removeSingleitem(product.id),
                ),
              ),
            );
            bag.addItem(product);
          },
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(254, 162, 64, 1),
                  Color.fromRGBO(245, 130, 0, 1),
                ],
              ),
            ),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Adicionar à sacola",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(72, 31, 1, 1),
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.local_mall_outlined,
                  size: 35,
                  color: Color.fromRGBO(72, 31, 1, 1),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
