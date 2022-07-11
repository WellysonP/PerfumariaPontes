import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:perfumaria/widgets/subtitle_appbar.dart';

import 'package:perfumaria/provider/product_provider.dart';
import 'package:perfumaria/utils/app_routes.dart';
import 'package:provider/provider.dart';

import '../widgets/app_bar_custom.dart';
import '../widgets/bottom_bar_custom.dart';
import '../components/list_actions_perfil.dart';

class PerfilPageIn extends StatelessWidget {
  const PerfilPageIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBarCustom.isFilter(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SubtitleAppBar(text: "Perfil"),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.logout,
                    color: Colors.red,
                    size: 30,
                  ))
            ],
          ),
          Expanded(
            child: Container(
              child: ListView(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 75,
                    child: InkWell(
                      onTap: () {},
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Image.asset(
                              "assets/images/Group_22.png",
                              width: 40,
                              height: 40,
                            ),
                          ),
                          Image.asset("assets/images/account_circle.png"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 17),
                  SizedBox(
                    width: 185,
                    child: Text(
                      "Usuário",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ListActionsPerfil(),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomBarCustom.isPerfil(),
    );
  }
}
