import 'package:flutter/cupertino.dart';
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
  bool simpleForm = true;
  bool showFavorite = false;
  int currentStep = 0;
  bool isEmphasis = false;

  int get itemsCount {
    return _items.length;
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
