import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FavoriteButtom extends StatelessWidget {
  final double radius;
  final double sizeFavorite;
  const FavoriteButtom({
    Key? key,
    required this.radius,
    required this.sizeFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(radius),
      child: CircleAvatar(
        backgroundColor: Color.fromRGBO(217, 217, 217, 1),
        radius: radius,
        child: Icon(
          Icons.favorite_border,
          color: Colors.black,
          size: sizeFavorite,
        ),
      ),
    );
  }
}
