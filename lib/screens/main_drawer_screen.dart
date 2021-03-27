import 'package:flutter/material.dart';

import '../screens/order_screen.dart';
import '../screens/cart_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget _listTileBuilder({
    String text,
    IconData leadingData,
    IconData trailingData,
    ThemeData theme,
    Function function,
  }) {
    return ListTile(
      onTap: function,
      title: Text(
        text,
        style: theme.textTheme.bodyText2,
      ),
      leading: Icon(leadingData),
      trailing: Icon(trailingData),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
        child: Column(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.primaryColor,
                theme.accentColor,
              ],
            ),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.shopping_basket,
                    size: 80,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  'Alışveriş Uygulaması',
                  style: theme.textTheme.headline6,
                ),
              ],
            ),
          ),
        ),
        _listTileBuilder(
            text: 'Giriş',
            leadingData: Icons.login,
            trailingData: Icons.arrow_forward,
            theme: theme,
            function: () {
              Navigator.of(context).pop();
            }),
        _listTileBuilder(
            text: 'Sepetim',
            leadingData: Icons.shopping_cart_outlined,
            trailingData: Icons.arrow_forward,
            theme: theme,
            function: () {
              Navigator.of(context).popAndPushNamed(CartScreen.routeName);
            }),
        _listTileBuilder(
            text: 'Siparişlerim',
            leadingData: Icons.local_shipping_outlined,
            trailingData: Icons.arrow_forward,
            theme: theme,
            function: () {
              Navigator.of(context).popAndPushNamed(OrdersScreen.routeName);
            }),
      ],
    ));
  }
}
