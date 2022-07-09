import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:perfumaria/widgets/dashe_line_widget.dart';

import '../models/bag_model.dart';

class BagWidget extends StatelessWidget {
  final BagModel bagItem;
  const BagWidget({
    Key? key,
    required this.bagItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12.5),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(bagItem.imageUrl),
              ),
              SizedBox(width: 7),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bagItem.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color.fromRGBO(55, 55, 55, 1),
                    ),
                  ),
                  Text(
                    "De R\$ ${bagItem.oldPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough,
                      color: Color.fromRGBO(55, 55, 55, 1),
                    ),
                  ),
                  Text(
                    "Por R\$ ${bagItem.newPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(55, 55, 55, 1),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        DasheLine(),
      ],
    );
  }
}
