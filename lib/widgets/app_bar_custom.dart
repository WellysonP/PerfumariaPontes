import 'package:flutter/material.dart';

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
  Size get preferredSize => Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 54,
      centerTitle: true,
      titleSpacing: 0,
      leading: isFilter
          ? IconButton(
              onPressed: () {},
              icon: Icon(Icons.filter_alt_outlined, size: 24),
            )
          : null,
      backgroundColor: Color.fromRGBO(33, 33, 33, 1),
      elevation: 0,
      title: SizedBox(
        height: 35,
        child: TextField(
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Color.fromRGBO(150, 146, 146, 1)),
            hintText: "Procurar no aplicativo",
            fillColor: Colors.white,
            filled: true,
            suffixIcon: Icon(
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
            onPressed: () {},
            icon: Icon(
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
