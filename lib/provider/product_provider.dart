import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  final List<ProductModel> _items = [];
  List<ProductModel> get items => [..._items];
  List<ProductModel> get itemsFavorite =>
      _items.where((element) => element.isFavorite).toList();
  List<ProductModel> get itemsEmphasis =>
      _items.where((element) => element.isEmphasis).toList();
  bool isLogin = true;
  bool showFavorite = false;
  int currentStep = 0;
  bool isEmphasis = false;
  File? image;
  List<XFile>? imageList = [];
  String? updatUrlImage;

  final formData = <String, Object>{};
  final formKeyStep1 = GlobalKey<FormState>();
  final formKeyStep2 = GlobalKey<FormState>();
  final formKeyStep3 = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final database = FirebaseDatabase.instance.ref();
  final DatabaseReference databaseRef =
      FirebaseDatabase.instance.ref().child("products");

  Future<void> getItems() async {
    _items.clear();

    final snapshot = await databaseRef.child("878986290").get();
    // final Map<String, dynamic> datas = snapshot.value as Map<String, dynamic>;
    final data = ProductModel.fromMap(snapshot.value);
    // final data = snapshot.value as Map;
    // print(snapshot.value);

    // const String jsonString = '''
//   {
//     "text": "foo", "value": 1 ,
//              "text": "bar", "value": 2

//   }
// ''';

    const String newJson = """
        {
          "quantity": 1,
          "oldPrice": 1000000000.00,
          "imageUrl": "https://firebasestorage.googleapis.com/v0/b/newperfumaria-50abf.appspot.com/o/product%2F648609429?alt=media&token=2f9c3484-afc5-4776-bbde-215fe2c6a1d3",
          "name": "Wellyson",
          "description": "O homem mais valioso do mundo",
          "company": "Jequiti",
          "id": "648609429",
          "newPrice": 1000000000.00
          }
        """;

    // final Map<String,dynamic> data = snapshot as Map<String, dynamic>;

    // Map<String, dynamic> data = jsonDecode(snapshotString);
    // data.forEach(
    //   (key, value) {
    _items.add(data);
    //   },
    // );

    // print(data["id"]);
    notifyListeners();
  }

  Future<void> submitForm(
      GlobalKey<FormState> formKey, BuildContext context) async {
    final isValidate = formKey.currentState?.validate() ?? false;

    if (!isValidate) {
      return;
    } else {
      formKey.currentState?.save();
      currentContinue(context);
    }
  }

  int get itemsCount {
    return _items.length;
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
  }

  void toogleEmphasis() {
    isEmphasis = !isEmphasis;
    notifyListeners();
  }

  Future<void> currentContinue(BuildContext context) async {
    if (currentStep == 2) {
      // uploadUserImage(image);
      await saveProduct(formData);
      Navigator.of(context).pop();
      isEmphasis = false;
      image = null;
      imageList = [];
      nameController.text = "";
      currentStep = 0;
    } else {
      currentStep += 1;
    }
    notifyListeners();
  }

  void currentCancel() {
    if (currentStep == 0) {
      return;
    } else {
      currentStep -= 1;
    }
    notifyListeners();
  }

  void showFavorites() {
    showFavorite = !showFavorite;
    notifyListeners();
  }

  void tooglefavorite(ProductModel product) {
    product.isFavorite = !product.isFavorite;
    notifyListeners();
  }

  void toogleLogin() {
    isLogin = !isLogin;
    notifyListeners();
  }

  Future<void> addProduct(ProductModel product) async {
    // final response = await http.post(
    //   Uri.parse(
    //       "https://newperfumaria-50abf-default-rtdb.firebaseio.com/products"),
    //   body: jsonEncode(
    //     {
    //       "id": product.id,
    //       "name": product.name,
    //       "company": product.company,
    //       "quantity": product.quantity,
    //       "oldPrice": product.oldPrice,
    //       "newPrice": product.newPrice,
    //       "imageUrl": product.imageUrl,
    //       "description": product.description,
    //     },
    //   ),
    // );

    await databaseRef.child(product.id).set(
      {
        "id": product.id,
        "name": product.name,
        "company": product.company,
        "quantity": product.quantity,
        "oldPrice": product.oldPrice,
        "newPrice": product.newPrice,
        "imageUrl": product.imageUrl,
        "description": product.description,
      },
    );
    // final id = jsonDecode(response.body)["quantity"];

    // _items.add(
    //   ProductModel(
    //     id: product.id,
    //     name: product.name,
    //     company: product.company,
    //     quantity: product.quantity,
    //     oldPrice: product.oldPrice,
    //     newPrice: product.newPrice,
    //     imageUrl: product.imageUrl,
    //     description: product.description,
    //   ),
    // );
  }

  Future<void> saveProduct(Map<String, Object> data) async {
    bool hasId = data["id"] != null;
    final String chooseId =
        hasId ? data["id"] as String : Random().nextInt(1000000000).toString();
    await uploadUserImage(chooseId);

    final product = ProductModel(
      id: chooseId,
      name: data["name"] as String,
      company: data["company"] as String,
      quantity: data["quantity"] as int,
      oldPrice: data["oldPrice"] as double,
      newPrice: data["newPrice"] as double,
      imageUrl: updatUrlImage!,
      description: data["description"] as String,
    );
    if (hasId) {
      return;
    } else {
      await addProduct(product);
    }
  }

  Future<String?> uploadUserImage(String chooseId) async {
    final storageRef = FirebaseStorage.instance.ref();
    Reference? imagesRef = storageRef.child("product/$chooseId");

    await imagesRef.putFile(image!);

    final String imageRefUrl = await imagesRef.getDownloadURL();
    updatUrlImage = imageRefUrl;
    return imageRefUrl;
  }
}
