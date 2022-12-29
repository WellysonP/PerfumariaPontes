// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:perfumaria/provider/bag_provider.dart';
import 'package:perfumaria/utils/app_routes.dart';
import 'package:provider/provider.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final bool isFilter;
  final bool isArrowBack;
  final bool isBag;
  IconData icon;
  String text;
  Color colorIcon;
  double sizeIcon;
  void Function()? onTap;
  void Function()? isArrowBackFunction;

  AppBarCustom.isFilter({
    this.isFilter = true,
    this.isArrowBack = false,
    this.isBag = true,
    this.icon = Icons.local_mall_outlined,
    this.text = "",
    this.colorIcon = Colors.white,
    this.sizeIcon = 24,
  });

  AppBarCustom.isArrowBack({
    this.isFilter = false,
    this.isArrowBack = true,
    this.isBag = true,
    this.icon = Icons.local_mall_outlined,
    this.text = "",
    this.colorIcon = Colors.white,
    this.sizeIcon = 24,
    this.onTap,
    required this.isArrowBackFunction,
  });

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    final bag = Provider.of<BagProvider>(context);
    return AppBar(
      leadingWidth: 54,
      centerTitle: true,
      titleSpacing: 0,
      leading: IconButton(
        onPressed: () {
          if (isArrowBack) {
            isArrowBackFunction!();
          } else {}
        },
        icon: Icon(
          isFilter ? Icons.filter_alt_outlined : Icons.arrow_back,
          size: 24,
        ),
      ),
      backgroundColor: const Color.fromRGBO(33, 33, 33, 1),
      elevation: 0,
      title: isFilter
          ? SizedBox(
              height: 35,
              child: TextField(
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  hintStyle:
                      const TextStyle(color: Color.fromRGBO(150, 146, 146, 1)),
                  hintText: "Procurar no aplicativo",
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Color.fromRGBO(150, 146, 146, 1),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            )
          : Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: IconButton(
            onPressed: () {
              if (icon == Icons.local_mall_outlined) {
                Navigator.of(context).pushNamed(AppRoutes.bagPage);
              } else {
                onTap!();
              }
            },
            icon: Stack(
              children: [
                Icon(
                  icon,
                  color: colorIcon,
                  size: sizeIcon,
                ),
                if (isBag)
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: ClipOval(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Text(
                            bag.countItems.toString(),
                            style: TextStyle(
                              fontSize: 8,
                            ),
                          ),
                        ),
                        color: Colors.red,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
