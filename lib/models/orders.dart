import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import './cart.dart' show CartItems;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItems> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.dateTime,
    @required this.products,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrders(List<CartItems> cartProducts, double total) async {
    final timeStamp = DateTime.now();
    Uri url = Uri.parse(
        "https://shopping-project-d3268-default-rtdb.firebaseio.com/orders.json");
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProducts
              .map((e) => {
                    'id': e.id,
                    'title': e.title,
                    'quantity': e.quantity,
                    'price': e.price.toStringAsFixed(2),
                  })
              .toList(),
        }));
    _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          dateTime: DateTime.now(),
          products: cartProducts,
        ));
    notifyListeners();
  }

  Future<void> getAllOrders() async {
    Uri url = Uri.parse(
        "https://shopping-project-d3268-default-rtdb.firebaseio.com/orders.json");
    final response = await http.get(url);
    print(json.decode(response.body));
    final List<OrderItem> loadedOrders = [];
    final data = json.decode(response.body) as Map<String, dynamic>;
    //print(json.decode(response.body));
    if (data == null) {
      _orders.clear();
      notifyListeners();
      return;
    }
    data.forEach((orderID, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderID,
          amount: orderData['amount'] as double,
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map(
                (e) => CartItems(
                  id: e['id'],
                  price: double.parse(e['price']),
                  quantity: e['quantity'],
                  title: e['title'],
                ),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }
}
