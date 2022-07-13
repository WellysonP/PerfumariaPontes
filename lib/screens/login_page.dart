import 'package:flutter/material.dart';
import 'package:perfumaria/widgets/subtitle_appbar.dart';

import 'package:perfumaria/provider/product_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/app_bar_custom.dart';
import '../widgets/bottom_bar_custom.dart';
import '../components/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBarCustom.isFilter(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SubtitleAppBar(text: "Perfil"),
          Expanded(
            child: SizedBox(
              child: ListView(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 75,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(150),
                      onTap: () {},
                      child: Image.asset(
                        product.isLogin
                            ? "assets/images/account_circle.png"
                            : "assets/images/Group_33.png",
                        height: 150,
                        width: 150,
                      ),
                    ),
                  ),
                  const SizedBox(height: 17),
                  SizedBox(
                    width: 185,
                    child: Text(
                      product.isLogin ? "Login" : "Cadastro",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const LoginForm(),
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
