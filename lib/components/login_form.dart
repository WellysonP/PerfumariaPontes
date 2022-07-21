import 'package:flutter/material.dart';
import 'package:perfumaria/utils/app_routes.dart';
import 'package:perfumaria/utils/email_validator.dart';
import 'package:provider/provider.dart';
import '../provider/login_provider.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: Form(
        key: login.formKeyLogin,
        child: Column(
          children: [
            if (!login.isLogin)
              TextFormField(
                keyboardType: TextInputType.text,
                controller: login.nameController,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelStyle: const TextStyle(
                    fontSize: 15,
                  ),
                  labelText: "Nome completo",
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (_name) {
                  final name = _name ?? "";
                  if (name.trim().isEmpty) {
                    return "Campo Obrigatório";
                  }
                  if (name.trim().length <= 8) {
                    return "Informar nome Completo";
                  }
                  return null;
                },
              ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: login.emailController,
              style: const TextStyle(fontSize: 20),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelStyle: const TextStyle(
                  fontSize: 15,
                ),
                labelText: "E-mail",
                fillColor: Colors.white,
                filled: true,
              ),
              validator: (_email) {
                final email = _email ?? "";
                if (email.trim().isEmpty) {
                  return "Campo Obrigatório";
                }
                if (!EmailValidator(email)) {
                  return "Informar endereço de e-mail válido";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              controller: login.passwordController,
              style: const TextStyle(fontSize: 20),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelStyle: const TextStyle(
                  fontSize: 15,
                ),
                labelText: "Senha",
                fillColor: Colors.white,
                filled: true,
              ),
              validator: (_password) {
                final password = _password ?? "";
                if (password.isEmpty) {
                  return "Campo Obrigatório";
                }
                if (password.length < 8) {
                  return "Senha deve conter no mínimo 8 caracteres";
                }
                return null;
              },
            ),
            if (!login.isLogin) const SizedBox(height: 10),
            if (!login.isLogin)
              TextFormField(
                obscureText: true,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelStyle: const TextStyle(
                    fontSize: 15,
                  ),
                  labelText: "Confirmar senha",
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (_confirmPassword) {
                  final confirmPassword = _confirmPassword ?? "";
                  if (confirmPassword.isEmpty) {
                    return "Campo Obrigatório";
                  }
                  if (confirmPassword != login.passwordController.text) {
                    return "Senhas diferentes";
                  }
                  return null;
                },
              ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  login.registerOrLogin(context);
                },
                child: Container(
                  height: 60,
                  width: 250,
                  color: const Color.fromRGBO(254, 174, 55, 1),
                  child: Center(
                    child: Text(
                      login.isLogin ? "Entrar" : "Cadastrar",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(103, 43, 0, 1),
                        fontWeight: FontWeight.w500,
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
                  login.isLogin ? "Não possui conta?" : "Já possui uma conta?",
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 3),
                TextButton(
                  onPressed: login.toogleLogin,
                  child: const Text(
                    "Clique aqui",
                    style: TextStyle(color: Color.fromRGBO(254, 174, 55, 1)),
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
