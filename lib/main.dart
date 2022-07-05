import 'package:flutter/material.dart';
import 'package:perfumaria/screens/perfil_page.dart';
import 'package:perfumaria/screens/product_page.dart';
import 'package:perfumaria/utils/app_routes.dart';
import 'screens/home_page.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      scaffoldBackgroundColor: Color.fromRGBO(33, 33, 33, 1),
    );
    return MaterialApp(
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Color.fromRGBO(242, 134, 12, 1),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.HOME: (context) => HomePage(),
        AppRoutes.EXPLORE: (context) => ProductPage(),
        AppRoutes.PERFIL: (context) => PerfilPage(),
      },
    );
  }
}
