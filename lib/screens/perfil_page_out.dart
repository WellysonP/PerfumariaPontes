import 'package:flutter/material.dart';
import 'package:perfumaria/widgets/subtitle_appbar.dart';

import 'package:perfumaria/provider/product_provider.dart';
import 'package:perfumaria/utils/app_routes.dart';
import 'package:provider/provider.dart';

import '../widgets/app_bar_custom.dart';
import '../widgets/bottom_bar_custom.dart';

class PerfilPageOut extends StatelessWidget {
  const PerfilPageOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBarCustom.isFilter(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubtitleAppBar(text: "Perfil"),
          Expanded(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/account_circle.png",
                    height: 150,
                    width: 150,
                  ),
                  const SizedBox(height: 17),
                  const SizedBox(
                    width: 185,
                    child: Text(
                      "Você ainda não está logado",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 38),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        product.isLogin = true;
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.LOGIN_PAGE);
                      },
                      child: Container(
                        height: 60,
                        width: 185,
                        color: Theme.of(context).colorScheme.primary,
                        child: Center(
                          child: Text(
                            "Fazer login",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    "Ou",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(height: 25),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        product.isLogin = false;
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.LOGIN_PAGE);
                      },
                      child: Container(
                        height: 60,
                        width: 185,
                        color: Theme.of(context).colorScheme.primary,
                        child: Center(
                          child: Text(
                            "Cadastrar-se",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomBarCustom.isPerfil(),
    );
  }
}
