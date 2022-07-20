// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:perfumaria/utils/app_routes.dart';

class BottomBarCustom extends StatelessWidget {
  final bool? isHome;
  final bool? isExplore;
  final bool? isPerfil;

  const BottomBarCustom.isHome({
    this.isHome = true,
    this.isExplore,
    this.isPerfil,
  });

  const BottomBarCustom.isExplore({
    this.isHome,
    this.isExplore = true,
    this.isPerfil,
  });

  const BottomBarCustom.isPerfil({
    this.isHome,
    this.isExplore,
    this.isPerfil = true,
  });

  @override
  Widget build(BuildContext context) {
    final devideSize = MediaQuery.of(context).size;
    return BottomAppBar(
      color: const Color.fromRGBO(33, 33, 33, 1),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
            },
            child: Container(
              color: const Color.fromRGBO(33, 33, 33, 1),
              height: 60,
              width: devideSize.width * 0.33,
              child: Icon(
                Icons.home_outlined,
                size: 40,
                color: isHome == true
                    ? Color.fromRGBO(242, 134, 12, 1)
                    : Colors.white,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(AppRoutes.explore, (route) => false);
            },
            child: Container(
              color: const Color.fromRGBO(33, 33, 33, 1),
              height: 60,
              width: devideSize.width * 0.34,
              child: Icon(
                Icons.explore_outlined,
                size: 40,
                color: isExplore == true
                    ? Color.fromRGBO(242, 134, 12, 1)
                    : Colors.white,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.perfilOut, (route) => false);
            },
            child: Container(
              color: const Color.fromRGBO(33, 33, 33, 1),
              height: 60,
              width: devideSize.width * 0.33,
              child: Icon(
                Icons.person_outline,
                size: 40,
                color: isPerfil == true
                    ? Color.fromRGBO(242, 134, 12, 1)
                    : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
