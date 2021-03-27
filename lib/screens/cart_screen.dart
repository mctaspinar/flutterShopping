import 'package:flutter/material.dart';
import '../models/cart.dart' show Cart;
import '../widgets/app_bar.dart';
import '../widgets/cart_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            iconData: Icons.arrow_back,
            toDo: () {
              Navigator.of(context).pop();
            },
            title: 'Sepetim',
            textStyle: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.black54),
            popupMenuButton: false,
            alignment: MainAxisAlignment.start,
          ),
          cart.itemCount == 0
              ? Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                    child: Text("Sepetiniz Boş."),
                  ),
                )
              : Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Toplam ${cart.totalQuantity} adet ürün ${cart.totalAmount.toStringAsFixed(2)} ₺",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(fontSize: 16),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: () {},
                                          icon:
                                              Icon(Icons.check_circle_outline),
                                          label: Text("Sipariş Ver"),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: cart.items.length,
                            itemBuilder: (ctx, index) => CartItem(
                                  price:
                                      cart.items.values.toList()[index].price,
                                  id: cart.items.values.toList()[index].id,
                                  quantity: cart.items.values
                                      .toList()[index]
                                      .quantity,
                                  title:
                                      cart.items.values.toList()[index].title,
                                )),
                      ),
                    ],
                  ),
                ),
        ],
      )),
    );
  }
}
