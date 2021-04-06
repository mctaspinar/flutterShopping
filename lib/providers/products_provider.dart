import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class Products with ChangeNotifier {
  final String authToken;
  final String userId;
  Products(this.authToken, this.userId, this._items);
  List<Product> _items = [];
  List<Product> _userItems = [];

  var _showFavorite = false;

  List<Product> get items {
    if (_showFavorite) {
      _showFavorite = !_showFavorite;
      return _items.where((element) => element.isFavorite).toList();
    }
    return [..._items];
  }

  List<Product> get userItems {
    if (_showFavorite) {
      _showFavorite = !_showFavorite;
      return _userItems.where((element) => element.isFavorite).toList();
    }
    return [..._userItems];
  }

  Future<void> addProduct(Product product) async {
    Uri url = Uri.parse(
        "https://shopping-project-d3268-default-rtdb.firebaseio.com/products.json?auth=$authToken");
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'creatorId': userId,
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
      _userItems.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> getAllProducts([bool filter = false]) async {
    final filterUrl = filter ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url = Uri.parse(
        'https://shopping-project-d3268-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterUrl');
    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> tempList = [];
      if (data == null) return;
      url = Uri.parse(
          "https://shopping-project-d3268-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken");
      final favResponse = await http.get(url);
      final favData = json.decode(favResponse.body);
      //print(json.decode(response.body));
      data.forEach((productID, productData) {
        tempList.add(
          Product(
            id: productID,
            title: productData['title'],
            price: productData['price'],
            description: productData['description'],
            imageUrl: productData['imageUrl'],
            isFavorite: favData == null ? false : favData[productID] ?? false,
          ),
        );
      });
      if (filter) {
        _userItems = tempList.reversed.toList();
      } else {
        _items = tempList;
      }
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
        "https://shopping-project-d3268-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken");
    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    var existingProduct = _items[existingProductIndex];
    http.delete(url).then((value) {
      existingProduct = null;
    }).catchError((_) {
      //if an error occured rollback will go on..
      _items.insert(existingProductIndex, existingProduct);
      _userItems.insert(existingProductIndex, existingProduct);
      notifyListeners();
    });
    _items.removeAt(existingProductIndex);
    _userItems.removeAt(existingProductIndex);
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
    final userProductIndex =
        _userItems.indexWhere((element) => element.id == id);
    if (productIndex >= 0) {
      Uri url = Uri.parse(
          "https://shopping-project-d3268-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken");
      await http.patch(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
          }));
      _items[productIndex] = product;
      _userItems[userProductIndex] = product;
      notifyListeners();
    } else {}
  }
}
