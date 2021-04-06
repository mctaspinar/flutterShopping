import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/orders.dart';
import '../widgets/app_bar.dart';
import '../widgets/order_item.dart';
import '../widgets/empty_page.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future _future; //future will be created just once with rebuild app

  Future _getFuture() {
    return Provider.of<Orders>(context, listen: false).getAllOrders();
  }

  @override
  void initState() {
    _future = _getFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _navigate() {
      Navigator.of(context).pop();
    }

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
                  .copyWith(color: Colors.black),
              popupMenuButton: false,
              alignment: MainAxisAlignment.start,
            ),
            Expanded(
              child: FutureBuilder(
                future: _future,
                builder: (context, dataSnapShot) {
                  if (dataSnapShot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (dataSnapShot.error != null) {
                      return Center(
                        child: Text(
                          "Bir hata oluştu!",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(fontSize: 22),
                        ),
                      );
                    } else {
                      return Consumer<Orders>(
                        builder: (ctx, orderData, child) {
                          return orderData.orders.length == 0
                              ? Center(
                                  child: EmptyPage(
                                    title: "Siparişiniz bulunmamaktadır.",
                                    buttonTitle: "Haydi alışverişe başla!",
                                    navigatePage: _navigate,
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: orderData.orders.length,
                                  itemBuilder: (ctx, index) {
                                    return OrderItems(orderData.orders[index]);
                                  });
                        },
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
