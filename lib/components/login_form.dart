import 'package:flutter/material.dart';
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
                height: product.simpleForm ? 50 : 50,
                child: TextFormField(
                  style: TextStyle(
                      color: product.simpleForm
                          ? null
                          : Theme.of(context).colorScheme.primary,
                      fontSize: 20),
                  decoration: InputDecoration(
                    enabledBorder: product.simpleForm
                        ? null
                        : UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 3,
                                color: Theme.of(context).colorScheme.primary)),
                    border: product.simpleForm
                        ? OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))
                        : null,
                    labelStyle: TextStyle(
                      color: product.simpleForm
                          ? null
                          : Theme.of(context).colorScheme.primary,
                      fontSize: 15,
                    ),
                    labelText: "Nome completo",
                    fillColor: product.simpleForm ? Colors.white : null,
                    filled: product.simpleForm ? true : null,
                  ),
                ),
              ),
            const SizedBox(height: 10),
            SizedBox(
              height: product.simpleForm ? 50 : 50,
              child: TextFormField(
                style: TextStyle(
                    color: product.simpleForm
                        ? null
                        : Theme.of(context).colorScheme.primary,
                    fontSize: 20),
                decoration: InputDecoration(
                  enabledBorder: product.simpleForm
                      ? null
                      : UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Theme.of(context).colorScheme.primary)),
                  border: product.simpleForm
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))
                      : null,
                  labelStyle: TextStyle(
                    color: product.simpleForm
                        ? null
                        : Theme.of(context).colorScheme.primary,
                    fontSize: 15,
                  ),
                  labelText: "E-mail",
                  fillColor: product.simpleForm ? Colors.white : null,
                  filled: product.simpleForm ? true : null,
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: product.simpleForm ? 50 : 50,
              child: TextFormField(
                style: TextStyle(
                    color: product.simpleForm
                        ? null
                        : Theme.of(context).colorScheme.primary,
                    fontSize: 20),
                decoration: InputDecoration(
                  enabledBorder: product.simpleForm
                      ? null
                      : UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Theme.of(context).colorScheme.primary)),
                  border: product.simpleForm
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))
                      : null,
                  labelStyle: TextStyle(
                    color: product.simpleForm
                        ? null
                        : Theme.of(context).colorScheme.primary,
                    fontSize: 15,
                  ),
                  labelText: "Senha",
                  fillColor: product.simpleForm ? Colors.white : null,
                  filled: product.simpleForm ? true : null,
                ),
              ),
            ),
            SizedBox(height: 10),
            if (!product.isLogin)
              SizedBox(
                height: product.simpleForm ? 50 : 50,
                child: TextFormField(
                  style: TextStyle(
                      color: product.simpleForm
                          ? null
                          : Theme.of(context).colorScheme.primary,
                      fontSize: 20),
                  decoration: InputDecoration(
                    enabledBorder: product.simpleForm
                        ? null
                        : UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 3,
                                color: Theme.of(context).colorScheme.primary)),
                    border: product.simpleForm
                        ? OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))
                        : null,
                    labelStyle: TextStyle(
                      color: product.simpleForm
                          ? null
                          : Theme.of(context).colorScheme.primary,
                      fontSize: 15,
                    ),
                    labelText: "Confirmar senha",
                    fillColor: product.simpleForm ? Colors.white : null,
                    filled: product.simpleForm ? true : null,
                  ),
                ),
              ),
            SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {},
                child: Container(
                  height: 60,
                  width: 250,
                  color: Theme.of(context).colorScheme.primary,
                  child: Center(
                    child: Text(
                      product.isLogin ? "Entrar" : "Cadastrar",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product.isLogin ? "Não possu conta?" : "Já possui uma conta?",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 3),
                InkWell(
                  onTap: () {
                    product.toogleLogin();
                  },
                  child: Text(
                    "Clique aqui",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
