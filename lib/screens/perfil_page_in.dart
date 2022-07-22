import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:perfumaria/provider/login_provider.dart';
import 'package:perfumaria/utils/app_routes.dart';
import 'package:perfumaria/widgets/subtitle_appbar.dart';
import 'package:provider/provider.dart';
import '../widgets/app_bar_custom.dart';
import '../widgets/bottom_bar_custom.dart';
import '../components/list_actions_perfil.dart';

class PerfilPageIn extends StatelessWidget {
  const PerfilPageIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginProvider>(context);
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
                onPressed: () async {
                  login.updatUrlImage = "";
                  login.image = null;
                  login.imageList = [];
                  login.isAdm = false;
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.perfilOut);
                },
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
                          ClipOval(
                            child: Image.network(
                              login.perfilPhotoUrl.toString(),
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Image.asset(
                              "assets/images/Group_22.png",
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 17),
                  SizedBox(
                    width: 185,
                    child: Text(
                      login.perfilName.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
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
