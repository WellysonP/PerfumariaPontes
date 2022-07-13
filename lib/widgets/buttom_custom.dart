import 'package:flutter/material.dart';

import '../provider/product_provider.dart';

class ButtomCustom extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final void Function() onTap;
  const ButtomCustom({
    Key? key,
    required this.product,
    required this.text,
    required this.height,
    required this.width,
    required this.onTap,
  }) : super(key: key);

  final ProductProvider product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          onTap();
        },
        child: Container(
          height: height,
          width: width,
          color: Theme.of(context).colorScheme.primary,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
