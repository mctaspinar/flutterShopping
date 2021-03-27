import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/orders.dart';
import '../widgets/app_bar.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Orders>(context);
    final orderList = order.orders;
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
              title: 'Siparişlerim',
              textStyle: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.black54),
              popupMenuButton: false,
              alignment: MainAxisAlignment.start,
            ),
            orderList.length == 0
                ? Center(
                    child: Text("Siparişiniz bulunmamaktadır."),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: orderList.length,
                        itemBuilder: (ctx, index) {
                          return OrderItems(orderList[index]);
                        })),
          ],
        ),
      ),
    );
  }
}
