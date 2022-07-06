import 'package:flutter/material.dart';
import 'package:perfumaria/provider/product_provider.dart';
import 'package:provider/provider.dart';
import '../components/app_bar_custom.dart';
import '../components/bottom_bar_custom.dart';
import '../components/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBarCustom.isFilter(
                icon: Icons.filter_alt_outlined, text: "Perfil"),
            const SizedBox(height: 17),
            //Retirar o Inkell quando decidir formulário
            InkWell(
              borderRadius: BorderRadius.circular(150),
              onTap: product.toogleForm,
              child: Image.asset(
                product.isLogin
                    ? "assets/images/account_circle.png"
                    : "assets/images/Group_33.png",
                height: 150,
                width: 150,
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
            SizedBox(height: 20),
            LoginForm(),
          ],
        ),
      ),
      bottomNavigationBar: BottomBarCustom.isPerfil(),
    );
  }
}
