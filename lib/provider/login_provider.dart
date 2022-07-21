import 'package:flutter/cupertino.dart';

import '../utils/app_routes.dart';

class LoginProvider with ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKeyLogin = GlobalKey<FormState>();

  bool _isLogin = true;
  bool get isLogin => _isLogin;

  void toogleLogin() {
    _isLogin = !_isLogin;
    notifyListeners();
  }

  void registerOrLogin(BuildContext context) {
    final isValidate = formKeyLogin.currentState?.validate() ?? false;

    if (!isValidate) {
      return;
    } else {
      Navigator.of(context).pushReplacementNamed(AppRoutes.perfilIn);
    }
  }
}
