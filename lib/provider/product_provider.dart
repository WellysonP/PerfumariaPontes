import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../data/product_dummy.dart';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> get _items => productDummy;
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
  final formData = <String, Object>{};
  final formKeyStep1 = GlobalKey<FormState>();
  final formKeyStep2 = GlobalKey<FormState>();
  final formKeyStep3 = GlobalKey<FormState>();

  final nameController = TextEditingController();

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

  void addProduct(ProductModel product) {
    _items.add(
      ProductModel(
          id: product.id,
          name: product.name,
          company: product.company,
          quantity: product.quantity,
          oldPrice: product.oldPrice,
          newPrice: product.newPrice,
          imageUrl: product.imageUrl,
          description: product.description),
    );
  }

  Future<void> saveProduct(Map<String, Object> data) async {
    bool hasId = data["id"] != null;
    final String chooseId =
        hasId ? data["id"] as String : Random().nextDouble().toString();
    final storageRef = FirebaseStorage.instance.ref();
    Reference? imagesRef = storageRef.child("product/$chooseId");

    await imagesRef.putFile(image!);

    final imageRefUrl = await imagesRef.getDownloadURL();

    final product = ProductModel(
      id: chooseId,
      name: data["name"] as String,
      company: data["company"] as String,
      quantity: data["quantity"] as int,
      oldPrice: data["oldPrice"] as double,
      newPrice: data["newPrice"] as double,
      imageUrl: imageRefUrl,
      description: data["description"] as String,
    );
    if (hasId) {
      return;
    } else {
      addProduct(product);
      print(product.imageUrl);
    }
  }

  Future<String?> uploadUserImage(File? image, String chooseId) async {}
}
