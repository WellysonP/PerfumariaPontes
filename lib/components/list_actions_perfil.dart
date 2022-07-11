import 'package:flutter/material.dart';
import 'package:perfumaria/widgets/action_perfil.dart';

class ListActionsPerfil extends StatelessWidget {
  const ListActionsPerfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        ActionPerfil(
          icon: Icons.settings,
          text: "Configurar Produtos",
          onPress: () {},
        ),
      ],
    );
  }
}
