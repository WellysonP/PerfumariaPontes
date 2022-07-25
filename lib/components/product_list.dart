import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:perfumaria/utils/constantes.dart';

import '../models/product_model.dart';

class ProductList extends StatelessWidget {
  final ProductModel product;
  const ProductList({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: SizedBox(
        height: 70,
        child: Card(
          color: const Color.fromRGBO(55, 55, 55, 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButtonList(product: product),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(product.imageUrl),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${product.name} - ${product.company}",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "De: R\$ ${product.oldPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Color.fromRGBO(169, 169, 169, 1),
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        "Por: R\$ ${product.newPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit_outlined,
                    color: Theme.of(context).errorColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IconButtonList extends StatefulWidget {
  final ProductModel product;
  const IconButtonList({Key? key, required this.product}) : super(key: key);

  @override
  State<IconButtonList> createState() => _IconButtonListState();
}

class _IconButtonListState extends State<IconButtonList> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        setState(() {
          widget.product.isEmphasis = !widget.product.isEmphasis;
        });
        await http.patch(
          Uri.parse("${Constant.productBase}/${widget.product.id}.json"),
          body: jsonEncode({"isEmphasis": widget.product.isEmphasis}),
        );
      },
      icon: Icon(
        widget.product.isEmphasis
            ? Icons.radio_button_checked
            : Icons.radio_button_unchecked,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
