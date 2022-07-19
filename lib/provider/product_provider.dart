import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perfumaria/utils/constantes.dart';
import '../models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  // String _token;
  // String _userId;
  final List<ProductModel> _items = [];

  // ProductProvider([
  //   this._token = "",
  //   this._userId = "",
  //   this._items = const [],
  // ]);
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

    final response = await http.get(
      Uri.parse("${Constant.productBase}.json"),
    );
    if (response.body == "null") return;

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach(
      (productId, productData) {
        _items.add(
          ProductModel(
            id: productId,
            name: productData["name"],
            company: productData["company"],
            quantity: productData["quantity"],
            oldPrice: productData["oldPrice"],
            newPrice: productData["newPrice"],
            imageUrl: productData["imageUrl"],
            description: productData["description"],
          ),
        );
      },
    );
    notifyListeners();

    // final snapshot = await databaseRef.get();
    // final dataEncode = jsonEncode(snapshot.value);
    // final dataDecode = jsonDecode(dataEncode);
    // // Map snapshotValue = snapshot.value as Map<String, dynamic>;

    // final data = ProductModel.fromMap(dataDecode);
    // _items.add(data);
    // notifyListeners();
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
    return null;
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
    final response = await http.post(
      Uri.parse("${Constant.productBase}.json"),
      body: jsonEncode(
        {
          "name": product.name,
          "company": product.company,
          "quantity": product.quantity,
          "oldPrice": product.oldPrice,
          "newPrice": product.newPrice,
          "imageUrl": product.imageUrl,
          "description": product.description,
        },
      ),
    );

    // await databaseRef.child(product.id).set(
    //   {
    //     "id": product.id,
    //     "name": product.name,
    //     "company": product.company,
    //     "quantity": product.quantity,
    //     "oldPrice": product.oldPrice,
    //     "newPrice": product.newPrice,
    //     "imageUrl": product.imageUrl,
    //     "description": product.description,
    //   },
    // );

    final id = jsonDecode(response.body)["name"];
    _items.add(
      ProductModel(
        id: id,
        name: product.name,
        company: product.company,
        quantity: product.quantity,
        oldPrice: product.oldPrice,
        newPrice: product.newPrice,
        imageUrl: product.imageUrl,
        description: product.description,
      ),
    );
  }

  Future<void> saveProduct(Map<String, Object> data) async {
    bool hasId = data["id"] != null;
    final chooseId =
        hasId ? data["id"] as String : Random().nextInt(1000000000).toString();
    await uploadImage(chooseId);

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

  Future<String?> uploadImage(String chosseId) async {
    final storageRef = FirebaseStorage.instance.ref();
    Reference? imagesRef = storageRef.child("product/$chosseId");

    await imagesRef.putFile(image!);

    final String imageRefUrl = await imagesRef.getDownloadURL();
    updatUrlImage = imageRefUrl;
    return imageRefUrl;
  }
}
