// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:perfumaria/provider/bag_provider.dart';
import 'package:perfumaria/utils/app_routes.dart';
import 'package:provider/provider.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final bool isFilter;
  final bool isArrowBack;

  const AppBarCustom.isFilter({
    this.isFilter = true,
    this.isArrowBack = false,
  });

  const AppBarCustom.isArrowBack({
    this.isFilter = false,
    this.isArrowBack = true,
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
            Navigator.of(context).pop();
            if (bag.isBag) {
              bag.isBag = false;
            } else {
              return;
            }
          } else {}
        },
        icon: Icon(
          isFilter ? Icons.filter_alt_outlined : Icons.arrow_back,
          size: 24,
        ),
      ),
      backgroundColor: const Color.fromRGBO(33, 33, 33, 1),
      elevation: 0,
      title: SizedBox(
        height: 35,
        child: TextField(
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            hintStyle: const TextStyle(color: Color.fromRGBO(150, 146, 146, 1)),
            hintText: "Procurar no aplicativo",
            fillColor: Colors.white,
            filled: true,
            suffixIcon: const Icon(
              Icons.search,
              color: Color.fromRGBO(150, 146, 146, 1),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: IconButton(
            onPressed: () {
              if (bag.isBag) {
                return;
              } else {
                bag.viewMore = false;
                Navigator.of(context).pushNamed(AppRoutes.bagPage);
                bag.isBag = true;
              }
            },
            icon: const Icon(
              Icons.local_mall_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
