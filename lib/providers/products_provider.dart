import 'package:flutter/material.dart';
import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Kırmızı Tişört',
      description: 'Kırmızı bir tişört..',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Pantolon',
      description: 'Bol kesim siyah pantolon.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Sarı Atkı',
      description: 'Sıcak ve rahat - tam da kış için ihtiyacınız olan şey.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Tava',
      description:
          'İstediğiniz herhangi bir yemeği hazırlayın.İstediğiniz herhangi bir yemeği hazırlayın.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  var _showFavorite = false;

  List<Product> get items {
    if (_showFavorite) {
      _showFavorite = !_showFavorite;
      return _items.where((element) => element.isFavorite).toList();
    }
    return [..._items];
  }

  void addProduct(Product product) {
    final newProduct = Product(
      title: product.title,
      description: product.description,
      imageUrl: product.imageUrl,
      price: product.price,
      id: DateTime.now().toString(),
    );
    _items.insert(0, newProduct);
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void showFavorites() {
    _showFavorite = true;
    notifyListeners();
  }

  void showAll() {
    _showFavorite = false;
    notifyListeners();
  }
}
