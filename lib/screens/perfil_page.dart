import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../components/app_bar_custom.dart';
import '../components/bottom_bar_custom.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBarCustom.isPerfil(),
      body: SafeArea(
        child: Column(
          children: [
            AppBarCustom(
              icon: Icons.filter_alt_outlined,
              text: "Perfil",
            ),
          ],
        ),
      ),
    );
  }
}
