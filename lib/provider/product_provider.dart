import 'package:flutter/cupertino.dart';
import '../data/product_dummy.dart';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> get _items => ProductDummy;
  List<ProductModel> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }
}
