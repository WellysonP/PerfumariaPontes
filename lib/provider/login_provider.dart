import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perfumaria/models/user_model.dart';
import 'package:perfumaria/utils/constantes.dart';
import 'package:perfumaria/widgets/progress_dialog.dart';
import '../utils/app_routes.dart';
import 'package:http/http.dart' as http;

class LoginProvider with ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKeyLogin = GlobalKey<FormState>();

  File? image;
  List<XFile>? imageList = [];
  String? updatUrlImage;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late UserCredential user;

  String? perfilName = "user";
  String? perfilPhotoUrl = "";

  bool _isLogin = true;
  bool get isLogin => _isLogin;

  bool isAdm = false;

  void toogleLogin() {
    _isLogin = !_isLogin;
    notifyListeners();
  }

  void registerOrLogin({
    required String name,
    required String email,
    required String password,
    context,
  }) async {
    final isValidate = formKeyLogin.currentState?.validate() ?? false;
    if (!isValidate || (image == null && !isLogin)) {
      return;
    } else {
      formKeyLogin.currentState?.save();

      if (!isLogin) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: ((context) =>
              const ProgressDialog(status: "Criando sua conta.")),
        );

        user = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        DatabaseReference newUserRef =
            FirebaseDatabase.instance.ref("users/${user.user!.uid}");
        Map userMap = {
          "name": name,
          "email": email,
          "isAdm": false,
        };

        newUserRef.set(userMap);
        await uploadImage(user.user!.uid);
        await user.user!.updateDisplayName(name);
        await user.user!.updatePhotoURL(updatUrlImage);
        perfilName = FirebaseAuth.instance.currentUser!.displayName;
        perfilPhotoUrl = FirebaseAuth.instance.currentUser!.photoURL;

        Navigator.of(context).pushReplacementNamed(AppRoutes.perfilIn);
        formKeyLogin.currentState?.reset();
      } else {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: ((context) =>
              const ProgressDialog(status: "Acessando sua conta.")),
        );
        try {
          user = await _auth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
        } on FirebaseAuthException catch (erro) {
          final sizeDevice = MediaQuery.of(context).size;
          void _showErrorDialog(String msg) {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: const Color.fromRGBO(63, 58, 58, 1),
                title: Text(
                  "Ocorreu um erro",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                content: Text(
                  msg,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Fechar")),
                ],
              ),
            );
          }

          if (erro.code == 'user-not-found') {
            Navigator.of(context).pop();
            _showErrorDialog("E-mail não cadastrado.");
          } else if (erro.code == 'invalid-email') {
            Navigator.of(context).pop();
            _showErrorDialog("E-mail inválido.");
          } else if (erro.code == 'wrong-password') {
            Navigator.of(context).pop();
            _showErrorDialog("Senha incorreta.");
          }
        }
        perfilName = FirebaseAuth.instance.currentUser!.displayName;
        perfilPhotoUrl = FirebaseAuth.instance.currentUser!.photoURL;
        await getAdm();

        Navigator.of(context).pushReplacementNamed(AppRoutes.perfilIn);
        formKeyLogin.currentState?.reset();
      }
    }
  }

  Future<XFile?> pickImage() async {
    try {
      final image = await ImagePicker().pickMultiImage();
      if (image == null) {
      } else {
        imageList!.addAll(image);
        final imageTemporary = File(image.first.path);
        this.image = imageTemporary;
      }
    } on PlatformException catch (_) {}
    notifyListeners();
    return null;
  }

  Future<String?> uploadImage(String userId) async {
    final storageRef = FirebaseStorage.instance.ref();
    Reference? imagesRef = storageRef.child("user/$userId");

    await imagesRef.putFile(image!);

    final String imageRefUrl = await imagesRef.getDownloadURL();
    updatUrlImage = imageRefUrl;
    return imageRefUrl;
  }

  Future<void> getAdm() async {
    final response = await http.get(
      Uri.parse("${Constant.userBase}/${_auth.currentUser!.uid}.json"),
    );
    if (response.body == "null") return;
    Map<String, dynamic> data = await jsonDecode(response.body);
    final update = UserModel(
      name: data["name"],
      email: data["email"],
      isAdm: data["isAdm"],
    );

    isAdm = update.isAdm;
  }
}
