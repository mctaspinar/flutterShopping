import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget _listTileBuilder(
      {String text,
      IconData leadingData,
      IconData trailingData,
      ThemeData theme,
      Function function}) {
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
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Drawer(
        child: ListView(
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
            child: Column(
              children: [
                Icon(
                  Icons.shopping_basket,
                  size: 80,
                  color: Colors.white,
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
            text: 'Sepetim',
            leadingData: Icons.shopping_cart_outlined,
            trailingData: Icons.arrow_forward,
            theme: theme,
            function: () {}),
        _listTileBuilder(
            text: 'Favorilerim',
            leadingData: Icons.favorite_border,
            trailingData: Icons.arrow_forward,
            theme: theme,
            function: () {
            }),
      ],
    ));
  }
}
