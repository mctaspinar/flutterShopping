import 'package:flutter/material.dart';
import 'package:flutter_shopping/models/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;

  CartItem({this.id, this.price, this.quantity, this.title});
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    final cartFunction = Provider.of<Cart>(context);
    return Dismissible(
      key: ValueKey(widget.id),
      background: Container(
        color: Theme.of(context).primaryColor,
        child: Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        padding: const EdgeInsets.only(right: 20),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cartFunction.deleteItem(widget.id);
      },
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.delete,
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                cartFunction.deleteItem(widget.id);
              },
            ),
          ],
        ),
        title: Text("${widget.title}"),
        subtitle: Text(
            "${widget.quantity} adet ${(widget.quantity * widget.price).toStringAsFixed(2)} ₺  "),
        trailing: FittedBox(
          child: Text("${widget.quantity} x Adet"),
        ),
      ),
    );
  }
}
