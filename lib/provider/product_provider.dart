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
  String? companyFilter;
  String? productFilter;

  final GlobalKey<FormFieldState> key = GlobalKey<FormFieldState>();

  List<ProductModel> get items => [..._items];
  List<ProductModel> get itemsFilter => [
        ProductModel(
            id: "0",
            name: "Todos",
            company: companyFilter!,
            quantity: 0,
            cost: 0,
            oldPrice: 0,
            newPrice: 0,
            imageUrl: "imageUrl",
            description: 'description'),
        ..._items
      ];

  List<ProductModel> get itemsFavorite =>
      _items.where((element) => element.isFavorite).toList();

  List<ProductModel> get allCompany => items
      .where((element) => element.company.contains(companyFilter!))
      .toList();

  List<ProductModel> get companyFilterItems => itemsFilter
      .where((element) => element.company.contains(companyFilter!))
      .toList();

  List<ProductModel> get productsFilterItems =>
      _items.where((element) => element.name.contains(productFilter!)).toList();

  List<ProductModel> get itemsEmphasis =>
      _items.where((element) => element.isEmphasis).toList();

  List<ProductModel> get emphasisFilter => itemsEmphasis
      .where((element) => element.company.contains(companyFilter!))
      .toList();

  List<ProductModel> list = [];
  List allCompanyEnphasis = [];

  el() {
    list.clear();
    allCompanyEnphasis.clear();

    for (var i = 0; i < itemsEmphasis.length; i++) {
      allCompanyEnphasis.add(itemsEmphasis[i].company);
    }

    List singleCompanyEnphasis = allCompanyEnphasis.toSet().toList();

    for (var i = 0; i < singleCompanyEnphasis.length; i++) {
      list.add(
        ProductModel(
            id: "id",
            name: "name",
            company: singleCompanyEnphasis[i],
            quantity: 0,
            cost: 0,
            oldPrice: 0,
            newPrice: 0,
            imageUrl: "0",
            description: "0"),
      );
    }
    return list.toList();
  }

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

  test() {
    return print(itemsEmphasis);
  }

  void filterCompany() {
    if (productFilter != "Todos") {
      reset();
    }
    productFilter = "Todos";
    notifyListeners();
  }

  void filterProduct() {
    notifyListeners();
  }

  void filterEnphasis() {
    if (isEmphasis == false) {
      el();
    }
    isEmphasis = !isEmphasis;
    notifyListeners();
  }

  void reset() {
    key.currentState!.reset();
  }

  toogleCompany(int i) {
    if (isEmphasis == false) {
      if (companyFilter == "Todos") {
        if (productFilter != "Todos") {
          return productsFilterItems[i];
        } else {
          return items[i];
        }
      } else {
        if (productFilter != "Todos") {
          return productsFilterItems[i];
        } else {
          return allCompany[i];
        }
      }
    } else {
      if (companyFilter != "Todos") {
        return emphasisFilter[i];
      } else {
        return itemsEmphasis[i];
      }
    }
  }

  toogleLength() {
    if (isEmphasis == false) {
      if (companyFilter == "Todos") {
        if (productFilter != "Todos") {
          return productsFilterItems.length;
        } else {
          return items.length;
        }
      } else {
        if (productFilter != "Todos") {
          return productsFilterItems.length;
        } else {
          return allCompany.length;
        }
      }
    } else {
      if (companyFilter != "Todos") {
        return emphasisFilter.length;
      } else {
        return itemsEmphasis.length;
      }
    }
  }

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
      formKey.currentState?.reset();
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
      currentStep = 0;
      formData.clear();
      isEmphasis = false;
      image = null;
      imageList = [];
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

  Future<void> updateProduct(ProductModel product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse("${Constant.productBase}/${product.id}.json"),
        body: jsonEncode(
          {
            "name": product.name,
            "company": product.company,
            "quantity": product.quantity,
            "cost": product.cost,
            "oldPrice": product.oldPrice,
            "newPrice": product.newPrice,
            "isEmphasis": product.isEmphasis,
            "description": product.description,
            "imageUrl": product.imageUrl,
          },
        ),
      );
    }
  }

  Future<void> saveProduct(Map<String, Object> data) async {
    bool hasId = data["id"] != null;
    final chooseId =
        hasId ? data["id"] as String : Random().nextInt(1000000000).toString();

    if (!hasId) {
      await uploadImage(chooseId);
    }

    final product = ProductModel(
      id: chooseId,
      name: data["name"] as String,
      company: data["company"] as String,
      quantity: data["quantity"] as int,
      cost: data["cost"] as double,
      oldPrice: data["oldPrice"] as double,
      newPrice: data["newPrice"] as double,
      imageUrl: updatUrlImage ?? data["imageUrl"] as String,
      description: data["description"] as String,
    );
    if (hasId) {
      await updateProduct(product);
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
