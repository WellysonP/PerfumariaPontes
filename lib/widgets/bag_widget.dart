import 'package:flutter/material.dart';
import 'package:perfumaria/provider/bag_provider.dart';
import 'package:perfumaria/widgets/dashe_line_widget.dart';
import 'package:provider/provider.dart';

import '../models/bag_model.dart';

class BagWidget extends StatelessWidget {
  final BagModel bagItem;
  const BagWidget({
    Key? key,
    required this.bagItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bag = Provider.of<BagProvider>(context);
    final sizeDevice = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 12.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: sizeDevice.width * 0.07,
                    backgroundImage: NetworkImage(bagItem.imageUrl),
                  ),
                  const SizedBox(width: 7),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bagItem.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color.fromRGBO(55, 55, 55, 1),
                        ),
                      ),
                      Text(
                        "De R\$ ${bagItem.oldPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                          color: Color.fromRGBO(55, 55, 55, 1),
                        ),
                      ),
                      Text(
                        "Por R\$ ${bagItem.newPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(55, 55, 55, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(244, 213, 131, 1),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            topLeft: Radius.circular(5),
                          ),
                          color: const Color.fromRGBO(55, 55, 55, 1),
                        ),
                        child: InkWell(
                          onTap: () {
                            bag.removeSingleitem(bagItem.productId);
                          },
                          child: const Icon(
                            Icons.remove,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 25,
                        color: const Color.fromRGBO(55, 55, 55, 1),
                        child: Center(
                          child: Text(
                            bagItem.quantity.toString(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(244, 213, 131, 1),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                          color: const Color.fromRGBO(55, 55, 55, 1),
                        ),
                        child: InkWell(
                          onTap: () {
                            bag.addSingleitem(bagItem.productId);
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SubText(bagItem: bagItem, text: "Sub: ", size: 14),
                      SubText(
                        bagItem: bagItem,
                        text:
                            "R\$ ${(bagItem.oldPrice * bagItem.quantity).toStringAsFixed(2)}",
                        size: 16,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        const DasheLine(),
      ],
    );
  }
}

class SubText extends StatelessWidget {
  final String text;
  final double size;
  const SubText({
    Key? key,
    required this.bagItem,
    required this.text,
    required this.size,
  }) : super(key: key);

  final BagModel bagItem;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: const Color.fromRGBO(55, 55, 55, 1),
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
