import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:perfumaria/models/bag_model.dart';
import 'package:perfumaria/models/product_model.dart';

class BagProvider with ChangeNotifier {
  Map<String, BagModel> _items = {};
  Map<String, BagModel> get items => {..._items};
  bool isDiscount = true;
  bool viewMore = false;

  void listBag() {
    viewMore = !viewMore;
    notifyListeners();
  }

  void addItem(ProductModel product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingItem) => BagModel(
          id: existingItem.id,
          productId: existingItem.productId,
          name: existingItem.name,
          quantity: existingItem.quantity + 1,
          oldPrice: existingItem.oldPrice,
          newPrice: existingItem.newPrice,
          imageUrl: existingItem.imageUrl,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => BagModel(
            id: Random().nextDouble().toString(),
            productId: product.id,
            name: product.name,
            quantity: 1,
            oldPrice: product.oldPrice,
            newPrice: product.newPrice,
            imageUrl: product.imageUrl),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleitem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId]?.quantity == 1) {
      _items.remove(productId);
    } else {
      _items.update(
        productId,
        (existingItem) => BagModel(
          id: existingItem.id,
          productId: existingItem.productId,
          name: existingItem.name,
          quantity: existingItem.quantity - 1,
          oldPrice: existingItem.oldPrice,
          newPrice: existingItem.newPrice,
          imageUrl: existingItem.imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void addSingleitem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    _items.update(
      productId,
      (existingItem) => BagModel(
        id: existingItem.id,
        productId: existingItem.productId,
        name: existingItem.name,
        quantity: existingItem.quantity + 1,
        oldPrice: existingItem.oldPrice,
        newPrice: existingItem.newPrice,
        imageUrl: existingItem.imageUrl,
      ),
    );

    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

  int get countItems {
    return _items.length;
  }

  double get totalNewPriceAmount {
    double total = 0.0;
    _items.forEach((key, BagModel) {
      total += BagModel.newPrice * BagModel.quantity;
    });
    return total;
  }

  double get totalOldPriceAmount {
    double total = 0.0;
    _items.forEach((key, BagModel) {
      total += BagModel.oldPrice * BagModel.quantity;
    });
    return total;
  }

  double get totalDisccount {
    double total = 0.0;
    if (!isDiscount) {
      total = 0.0;
    } else {
      _items.forEach((key, BagModel) {
        total = totalOldPriceAmount - totalNewPriceAmount;
      });
    }
    return total;
  }

  void toogleDisccount() {
    isDiscount = !isDiscount;
    print("Old: $totalOldPriceAmount");
    print("New: $totalNewPriceAmount");
    print("Soma: ${totalOldPriceAmount - totalNewPriceAmount}");
    notifyListeners();
  }
}
