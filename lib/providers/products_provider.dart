import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Kırmızı Tişört',
    //   description: 'Kırmızı bir tişört..',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Pantolon',
    //   description: 'Bol kesim siyah pantolon.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Sarı Atkı',
    //   description: 'Sıcak ve rahat - tam da kış için ihtiyacınız olan şey.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'Tava',
    //   description:
    //       'İstediğiniz herhangi bir yemeği hazırlayın.İstediğiniz herhangi bir yemeği hazırlayın.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  var _showFavorite = false;

  List<Product> get items {
    if (_showFavorite) {
      _showFavorite = !_showFavorite;
      return _items.where((element) => element.isFavorite).toList();
    }
    return [..._items];
  }

  Future<void> addProduct(Product product) async {
    Uri url = Uri.parse(
        "https://shopping-project-d3268-default-rtdb.firebaseio.com/products.json");
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );

      print(json.decode(response.body));

      final newProduct = Product(
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        id: json
            .decode(response.body)['name'], //generated unique id from firebase
      );
      _items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> getAllProducts() async {
    Uri url = Uri.parse(
        "https://shopping-project-d3268-default-rtdb.firebaseio.com/products.json");
    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> tempList = [];
      data.forEach((productID, productData) {
        tempList.add(
          Product(
            id: productID,
            title: productData['title'],
            price: productData['price'],
            description: productData['description'],
            imageUrl: productData['imageUrl'],
            isFavorite: productData['isFavorite'],
          ),
        );
      });
      _items = tempList;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void deleteProduct(String id) {
    Uri url = Uri.parse(
        "https://shopping-project-d3268-default-rtdb.firebaseio.com/products/$id.json");
    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    var existingProduct = _items[existingProductIndex];
    http.delete(url).then((value) {
      existingProduct = null;
    }).catchError((_) {
      //if an error occured rollback will go on..
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
    });
    _items.removeAt(existingProductIndex);
    notifyListeners();
  }

  void showFavorites() {
    _showFavorite = true;
    notifyListeners();
  }

  void showAll() {
    _showFavorite = false;
    notifyListeners();
  }

  Future<void> updateProduct(String id, Product product) async {
    final productIndex = _items.indexWhere((element) => element.id == id);
    if (productIndex >= 0) {
      Uri url = Uri.parse(
          "https://shopping-project-d3268-default-rtdb.firebaseio.com/products/$id.json");
      await http.patch(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
          }));
      _items[productIndex] = product;
      notifyListeners();
    } else {}
  }
}
