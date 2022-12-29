import 'package:flutter/material.dart';
import 'package:perfumaria/provider/login_provider.dart';
import 'package:perfumaria/provider/product_provider.dart';
import 'package:perfumaria/utils/app_routes.dart';
import 'package:perfumaria/widgets/action_perfil.dart';
import 'package:provider/provider.dart';

class ListActionsPerfil extends StatelessWidget {
  const ListActionsPerfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    final login = Provider.of<LoginProvider>(context);
    return Column(
      children: [
        ActionPerfil(
          icon: Icons.favorite_outline,
          text: "Favoritos",
          onPress: () {},
        ),
        ActionPerfil(
          icon: Icons.history,
          text: "Pedidos",
          onPress: () {},
        ),
        ActionPerfil(
          icon: Icons.person_pin_circle_outlined,
          text: "Encontrar Loja",
          onPress: () {},
        ),
        ActionPerfil(
          icon: Icons.account_circle_outlined,
          text: "Editar Perfil",
          onPress: () {},
        ),
        if (login.isAdm)
          ActionPerfil(
            icon: Icons.settings,
            text: "Configurar Produtos",
            onPress: () {
              product.companyFilter = "Todos";
              product.productFilter = "Todos";
              Navigator.of(context).pushNamed(AppRoutes.productConfigPage);
            },
          ),
      ],
    );
  }
}
