import 'package:flutter/foundation.dart';

class CartItems {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItems({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItems> _items = {};

  Map<String, CartItems> get items {
    return {..._items};
  }

  int get itemCount {
    return _items == null ? 0 : _items.length;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      //change quantity
      _items.update(
        productId,
        (value) => CartItems(
          id: value.id,
          title: value.title,
          price: value.price,
          quantity: value.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItems(
                id: DateTime.now().toString(),
                price: price,
                title: title,
                quantity: 1,
              ));
    }
    notifyListeners();
  }

  double get totalAmount {
    var _total = 0.0;
    _items.forEach((key, cartItem) {
      _total += cartItem.price * cartItem.quantity;
    });
    return _total;
  }

  int get totalQuantity {
    var _total = 0;
    _items.forEach((key, cartItem) {
      _total += cartItem.quantity;
    });
    return _total;
  }

  void deleteItem(String productId) {
    _items.removeWhere((key, value) => value.id == productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
