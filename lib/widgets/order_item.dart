import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/orders.dart';

class OrderItems extends StatefulWidget {
  final OrderItem order;
  OrderItems(this.order);

  @override
  _OrderItemsState createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    var date = DateFormat.yMMMEd('tr_TR').format(widget.order.dateTime);
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(
                '${widget.order.amount.toStringAsFixed(2)}₺ tutarındaki siparişiniz.'),
            subtitle: Text('Sipariş Tarihi : $date'),
            trailing: IconButton(
              icon: Icon(
                _expanded ? Icons.expand_less : Icons.expand_more,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          AnimatedContainer(
            curve: Curves.bounceOut,
            duration: Duration(seconds: 1),
            height: !_expanded ? 0 : widget.order.products.length * 50.0,
            child: ListView.builder(
                itemCount: widget.order.products.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.order.products[index].title),
                        Text(
                            '${widget.order.products[index].quantity}x  ${widget.order.products[index].price}₺'),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
