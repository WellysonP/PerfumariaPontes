import 'package:flutter/material.dart';
import 'package:perfumaria/provider/company_provider.dart';
import 'package:perfumaria/screens/perfil_page.dart';
import 'package:perfumaria/screens/product_detail.dart';
import 'package:perfumaria/screens/product_page.dart';
import 'package:perfumaria/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'provider/product_provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CompanyProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: MaterialApp(
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
          AppRoutes.PRODUCT_DESCRIPTION: (context) => ProductDetail(),
        },
      ),
    );
  }
}
