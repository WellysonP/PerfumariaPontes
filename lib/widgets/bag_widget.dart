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
          child: SizedBox(
            height: 70,
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromRGBO(55, 55, 55, 1),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            ),
                            color: const Color.fromRGBO(251, 235, 196, 1),
                          ),
                          child: InkWell(
                            onTap: () {
                              bag.removeSingleitem(bagItem.productId);
                            },
                            child: const Icon(
                              Icons.remove,
                              color: Color.fromRGBO(55, 55, 55, 1),
                              size: 20,
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromRGBO(55, 55, 55, 1),
                              width: 1,
                            ),
                            color: const Color.fromRGBO(251, 235, 196, 1),
                          ),
                          child: Center(
                            child: Text(
                              bagItem.quantity.toString(),
                              style: const TextStyle(
                                color: Color.fromRGBO(55, 55, 55, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromRGBO(55, 55, 55, 1),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            color: const Color.fromRGBO(251, 235, 196, 1),
                          ),
                          child: InkWell(
                            onTap: () {
                              bag.addSingleitem(bagItem.productId);
                            },
                            child: const Icon(
                              Icons.add,
                              color: Color.fromRGBO(55, 55, 55, 1),
                              size: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Sub: R\$ ${(bagItem.oldPrice * bagItem.quantity).toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Color.fromRGBO(55, 55, 55, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        const DasheLine(),
      ],
    );
  }
}
