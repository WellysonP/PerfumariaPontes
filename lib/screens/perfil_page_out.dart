import 'package:flutter/material.dart';
import 'package:perfumaria/widgets/subtitle_appbar.dart';
import 'package:perfumaria/utils/app_routes.dart';
import 'package:provider/provider.dart';
import '../provider/login_provider.dart';
import '../widgets/app_bar_custom.dart';
import '../widgets/bottom_bar_custom.dart';

class PerfilPageOut extends StatelessWidget {
  const PerfilPageOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginProvider>(context);
    return Scaffold(
      appBar: AppBarCustom.isFilter(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SubtitleAppBar(text: "Perfil"),
          Expanded(
            child: SizedBox(
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
                  const SizedBox(height: 38),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.loginPage);
                        if (login.isLogin == true) {
                          return;
                        } else {
                          login.toogleLogin();
                        }
                      },
                      child: Container(
                        height: 60,
                        width: 185,
                        color: const Color.fromRGBO(254, 174, 55, 1),
                        child: const Center(
                          child: Text(
                            "Fazer login",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(103, 43, 0, 1),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Ou",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 25),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.loginPage);
                        if (login.isLogin == true) {
                          login.toogleLogin();
                        } else {
                          return;
                        }
                      },
                      child: Container(
                        height: 60,
                        width: 185,
                        color: const Color.fromRGBO(254, 174, 55, 1),
                        child: const Center(
                          child: Text(
                            "Cadastrar-se",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(103, 43, 0, 1),
                              fontWeight: FontWeight.w500,
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
      bottomNavigationBar: const BottomBarCustom.isPerfil(),
    );
  }
}
