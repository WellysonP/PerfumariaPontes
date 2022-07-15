import 'dart:io';
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
  final formKeyStep1 = GlobalKey<FormState>();
  final formKeyStep2 = GlobalKey<FormState>();
  final formKeyStep3 = GlobalKey<FormState>();

  Future<void> submitForm(
      GlobalKey<FormState> formKey, BuildContext context) async {
    final isValidate = formKey.currentState?.validate() ?? false;

    if (!isValidate) {
      return;
    } else {
      formKey.currentState?.save();
      currentContinue(context);
    }
    ;
  }

  int get itemsCount {
    return _items.length;
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickMultiImage();
      if (image == null) {
        return;
      } else {
        imageList!.addAll(image);
      }
      final imageTemporary = File(image.first.path);
      this.image = imageTemporary;
    } on PlatformException catch (_) {}
    notifyListeners();
  }

  void toogleEmphasis() {
    isEmphasis = !isEmphasis;
    notifyListeners();
  }

  void currentContinue(BuildContext context) {
    if (currentStep == 2) {
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
}
