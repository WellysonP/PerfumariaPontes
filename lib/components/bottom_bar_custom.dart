import 'package:flutter/material.dart';
import 'package:perfumaria/utils/app_routes.dart';

class BottomBarCustom extends StatelessWidget {
  final bool? isHome;
  final bool? isExplore;
  final bool? isPerfil;

  BottomBarCustom.isHome({
    this.isHome = true,
    this.isExplore,
    this.isPerfil,
  });
  BottomBarCustom.isExplore({
    this.isHome,
    this.isExplore = true,
    this.isPerfil,
  });
  BottomBarCustom.isPerfil({
    this.isHome,
    this.isExplore,
    this.isPerfil = true,
  });

  @override
  Widget build(BuildContext context) {
    final devideSize = MediaQuery.of(context).size;
    return BottomAppBar(
      color: Color.fromRGBO(33, 33, 33, 1),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(AppRoutes.HOME, (route) => false);
            },
            child: Container(
              color: isHome == true
                  ? Theme.of(context).colorScheme.primary
                  : Color.fromRGBO(33, 33, 33, 1),
              height: 80,
              width: devideSize.width * 0.33,
              child: Icon(
                Icons.home_outlined,
                size: 40,
                color: isHome == true ? Colors.black : Colors.white,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(AppRoutes.EXPLORE, (route) => false);
            },
            child: Container(
              color: isExplore == true
                  ? Theme.of(context).colorScheme.primary
                  : Color.fromRGBO(33, 33, 33, 1),
              height: 80,
              width: devideSize.width * 0.34,
              child: Icon(
                Icons.explore_outlined,
                size: 40,
                color: isExplore == true ? Colors.black : Colors.white,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(AppRoutes.PERFIL, (route) => false);
            },
            child: Container(
              color: isPerfil == true
                  ? Theme.of(context).colorScheme.primary
                  : Color.fromRGBO(33, 33, 33, 1),
              height: 80,
              width: devideSize.width * 0.33,
              child: Icon(
                Icons.person_outline,
                size: 40,
                color: isPerfil == true ? Colors.black : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
