import 'package:flutter/material.dart';
import 'package:perfumaria/utils/app_routes.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: Form(
        child: Column(
          children: [
            if (!product.isLogin)
              SizedBox(
                height: 50,
                child: TextFormField(
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelStyle: const TextStyle(
                      fontSize: 15,
                    ),
                    labelText: "Nome completo",
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: TextFormField(
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelStyle: const TextStyle(
                    fontSize: 15,
                  ),
                  labelText: "E-mail",
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: TextFormField(
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelStyle: const TextStyle(
                    fontSize: 15,
                  ),
                  labelText: "Senha",
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            if (!product.isLogin) const SizedBox(height: 10),
            if (!product.isLogin)
              SizedBox(
                height: 50,
                child: TextFormField(
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelStyle: const TextStyle(
                      fontSize: 15,
                    ),
                    labelText: "Confirmar senha",
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.PERFIL_IN);
                },
                child: Container(
                  height: 60,
                  width: 250,
                  color: Theme.of(context).colorScheme.primary,
                  child: Center(
                    child: Text(
                      product.isLogin ? "Entrar" : "Cadastrar",
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product.isLogin
                      ? "Não possui conta?"
                      : "Já possui uma conta?",
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 3),
                TextButton(
                  onPressed: product.toogleLogin,
                  child: Text(
                    "Clique aqui",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
