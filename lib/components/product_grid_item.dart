import 'package:flutter/material.dart';
import 'package:perfumaria/models/product_model.dart';
import 'package:perfumaria/provider/bag_provider.dart';
import 'package:perfumaria/utils/app_routes.dart';
import 'package:provider/provider.dart';

import '../widgets/favorite_buttom.dart';

class ProductGridItem extends StatelessWidget {
  final ProductModel product;
  const ProductGridItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeDevice = MediaQuery.of(context).size;
    final msg = ScaffoldMessenger.of(context);
    final bag = Provider.of<BagProvider>(context);
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: GridTile(
            child: Column(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.productDescription,
                      arguments: product,
                    );
                  },
                  child: Hero(
                    tag: product.id,
                    child: Image.network(
                      product.imageUrl,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  color: const Color.fromRGBO(130, 129, 129, 0.2),
                  height: 50,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                          child: Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(169, 169, 169, 1),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 165 - 51,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: 16,
                                child: Text(
                                  "R\$${product.newPrice.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Color.fromRGBO(10, 135, 38, 1)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.arrow_downward,
                                          size: 7,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          (((product.oldPrice -
                                                          product.newPrice) /
                                                      (product.oldPrice) *
                                                      100)
                                                  .toStringAsFixed(2) +
                                              "%"),
                                          style: const TextStyle(
                                              fontSize: 8, color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: InkWell(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
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
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(255, 187, 55, 1),
                      Color.fromRGBO(236, 125, 0, 1),
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  size: 30,
                  color: Color.fromRGBO(72, 31, 1, 1),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: FavoriteButtom(
            radius: 15,
            sizeFavorite: 20,
            product: product,
          ),
        ),
      ],
    );
  }
}
