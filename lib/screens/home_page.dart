import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:perfumaria/components/bottom_bar_custom.dart';

import '../components/app_bar_custom.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBarCustom.isHome(),
      body: SafeArea(
        child: Column(
          children: [
            AppBarCustom(
              icon: Icons.filter_alt_outlined,
              text: "Destaques",
            ),
          ],
        ),
      ),
    );
  }
}
