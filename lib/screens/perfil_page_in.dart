import 'package:flutter/material.dart';
import 'package:perfumaria/widgets/subtitle_appbar.dart';
import '../widgets/app_bar_custom.dart';
import '../widgets/bottom_bar_custom.dart';
import '../components/list_actions_perfil.dart';

class PerfilPageIn extends StatelessWidget {
  const PerfilPageIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom.isFilter(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SubtitleAppBar(text: "Perfil"),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.logout,
                  color: Theme.of(context).errorColor,
                  size: 30,
                ),
              ),
            ],
          ),
          Expanded(
            child: SizedBox(
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
                  const SizedBox(
                    width: 185,
                    child: Text(
                      "Usuário",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const ListActionsPerfil(),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: const BottomBarCustom.isPerfil(),
    );
  }
}
