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
  Widget _buildAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Emin Misiniz?",
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: Colors.black,
              fontSize: 24,
            ),
      ),
      content: Text("Bu ürün sepetinizden çıkarılacaktır.",
          style: Theme.of(context).textTheme.bodyText2),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text("Hayır")),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text("Evet")),
      ],
    );
  }

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
      confirmDismiss: (value) {
        return showDialog(
            context: context,
            builder: (_) {
              return _buildAlertDialog(context);
            });
      },
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
                return showDialog(
                        context: context,
                        builder: (_) {
                          return _buildAlertDialog(context);
                        })
                    .then((value) =>
                        value ? cartFunction.deleteItem(widget.id) : null);
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
