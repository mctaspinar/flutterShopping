import 'package:flutter/material.dart';

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
    var _counter = widget.quantity;
    return ListTile(
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
            onPressed: () {},
          ),
        ],
      ),
      title: Text("${widget.title}"),
      subtitle: Text(
          "$_counter adet ${(widget.quantity * widget.price).toStringAsFixed(2)} ₺  "),
      trailing: FittedBox(
        child: Container(
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.add,
                  size: 15,
                ),
                onPressed: () {
                  setState(() {
                    _counter++;
                  });
                },
              ),
              Container(
                width: 20,
                child: Text(
                  "$_counter",
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.remove,
                  size: 15,
                ),
                onPressed: () {
                  setState(() {
                    if (_counter < 2) {
                      _counter = 1;
                    } else {
                      _counter--;
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
