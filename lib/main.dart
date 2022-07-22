import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:perfumaria/provider/company_provider.dart';
import 'package:perfumaria/provider/login_provider.dart';
import 'package:perfumaria/screens/bag_page.dart';
import 'package:perfumaria/screens/login_page.dart';
import 'package:perfumaria/screens/perfil_page_in.dart';
import 'package:perfumaria/screens/perfil_page_out.dart';
import 'package:perfumaria/screens/product_config_page.dart';
import 'package:perfumaria/screens/product_detail_page.dart';
import 'package:perfumaria/screens/product_page.dart';
import 'package:perfumaria/screens/product_registration_page.dart';
import 'package:perfumaria/utils/app_routes.dart';
import 'package:perfumaria/widgets/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'provider/bag_provider.dart';
import 'provider/product_provider.dart';
import 'screens/home_page.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      scaffoldBackgroundColor: const Color.fromRGBO(33, 33, 33, 1),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CompanyProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => BagProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
      ],
      child: MaterialApp(
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: const Color.fromRGBO(242, 134, 12, 1),
          ),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.home: (context) => const HomePage(),
          AppRoutes.explore: (context) => const ProductPage(),
          AppRoutes.perfilOut: (context) => const PerfilPageOut(),
          AppRoutes.perfilIn: (context) => const PerfilPageIn(),
          AppRoutes.productDescription: (context) => const ProductDetail(),
          AppRoutes.loginPage: (context) => const LoginPage(),
          AppRoutes.bagPage: (context) => const BagPage(),
          AppRoutes.productConfigPage: (context) => const ProductConfigPage(),
          AppRoutes.producRegistrationPage: (context) =>
              const ProductregistrationPage(),
          AppRoutes.progressIndicator: (context) =>
              const ProgressDialog(status: "Testando..."),
        },
      ),
    );
  }
}
