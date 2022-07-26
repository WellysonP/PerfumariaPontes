import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perfumaria/exceptions/http_exceptions.dart';
import 'package:perfumaria/utils/constantes.dart';
import '../models/product_model.dart';
import 'package:http/http.dart' as http;

import '../widgets/progress_dialog.dart';

class ProductProvider with ChangeNotifier {
  final List<ProductModel> _items = [];
  List<ProductModel> get items => [..._items];

  List<ProductModel> get itemsFavorite =>
      _items.where((element) => element.isFavorite).toList();

  List<ProductModel> get itemsEmphasis =>
      _items.where((element) => element.isEmphasis).toList();

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

  void toogleEmphasis() {
    if (formData.isNotEmpty) {
      isEmphasis = !isEmphasis;
    }
    notifyListeners();
  }

  void tooglefavorite(ProductModel product) {
    product.isFavorite = !product.isFavorite;
    notifyListeners();
  }

  void showFavorites() {
    showFavorite = !showFavorite;
    notifyListeners();
  }

  Future<void> submitForm(
      GlobalKey<FormState> formKey, BuildContext context) async {
    final isValidate = formKey.currentState?.validate() ?? false;

    if (!isValidate || (formData.isEmpty && image == null)) {
      return;
    } else {
      formKey.currentState?.save();
      currentContinue(context);
    }
  }

  Future<void> currentContinue(BuildContext context) async {
    if (currentStep == 2) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: ((context) =>
            const ProgressDialog(status: "Criando produto.")),
      );
      await saveProduct(formData);
      isEmphasis = false;
      image = null;
      imageList = [];
      currentStep = 0;
      formData.clear();
      getItems();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } else {
      if (currentStep == 1 && formData["isEmphasis"] != null) {
        isEmphasis = formData["isEmphasis"] as bool;
      }
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
            cost: productData["cost"],
            oldPrice: productData["oldPrice"],
            newPrice: productData["newPrice"],
            imageUrl: productData["imageUrl"],
            description: productData["description"],
            isEmphasis: productData["isEmphasis"] ?? false,
          ),
        );
      },
    );
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
          "cost": product.cost,
          "oldPrice": product.oldPrice,
          "newPrice": product.newPrice,
          "imageUrl": product.imageUrl,
          "description": product.description,
          "isEmphasis": isEmphasis,
        },
      ),
    );

    final id = jsonDecode(response.body)["name"];
    _items.add(
      ProductModel(
        id: id,
        name: product.name,
        company: product.company,
        quantity: product.quantity,
        cost: product.cost,
        oldPrice: product.oldPrice,
        newPrice: product.newPrice,
        imageUrl: product.imageUrl,
        description: product.description,
        isEmphasis: product.isEmphasis,
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
      cost: data["cost"] as double,
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

  Future<void> removeProduct(ProductModel product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();
      final response = await http.delete(
        Uri.parse("${Constant.productBase}/${product.id}.json"),
      );

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();

        throw HttpException(
          msg: "Não foi possível excluir o produto.",
          statusCode: response.statusCode,
        );
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

  Future<String?> uploadImage(String chosseId) async {
    final storageRef = FirebaseStorage.instance.ref();
    Reference? imagesRef = storageRef.child("product/$chosseId");

    await imagesRef.putFile(image!);

    final String imageRefUrl = await imagesRef.getDownloadURL();
    updatUrlImage = imageRefUrl;
    return imageRefUrl;
  }
}
