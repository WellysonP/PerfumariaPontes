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
    return Dismissible(
      key: ValueKey(bagItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: const Color.fromRGBO(63, 58, 58, 1),
            title: Text(
              "EXCLUIR",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            content: const Text(
              "Deseja excluir o item da sacola?",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Não"),
              ),
              TextButton(
                onPressed: () {
                  bag.removeItem(bagItem.productId);
                  Navigator.of(context).pop();
                },
                child: const Text("Sim"),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) {
        bag.removeItem(bagItem.productId);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(7),
            child: SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: sizeDevice.width * 0.07,
                        backgroundImage: NetworkImage(bagItem.imageUrl),
                      ),
                      const SizedBox(width: 7),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      const SizedBox(height: 2),
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
      ),
    );
  }
}
