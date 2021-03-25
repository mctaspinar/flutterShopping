import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/badge.dart';
import '../providers/products_provider.dart';
import 'package:provider/provider.dart';

enum FilterOptions { Favorites, All }

class CustomAppBar extends StatelessWidget {
  final String title;
  final Function toDo;
  final IconData iconData;
  final GlobalKey<ScaffoldState> scaffoldState;
  final TextStyle textStyle;
  final bool popupMenuButton;
  final MainAxisAlignment alignment;
  CustomAppBar({
    this.title,
    this.toDo,
    this.iconData,
    this.scaffoldState,
    this.textStyle,
    this.popupMenuButton,
    @required this.alignment,
  });

  void _iconFunction(BuildContext context) {
    if (scaffoldState != null) {
      scaffoldState.currentState.openDrawer();
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context, listen: false);
    return FittedBox(
      child: Row(
        mainAxisAlignment: alignment,
        children: [
          IconButton(
            icon: Icon(iconData),
            onPressed: () => _iconFunction(context),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              title,
              style: textStyle,
            ),
          ),
          popupMenuButton
              ? Row(
                  children: [
                    PopupMenuButton(
                      itemBuilder: (_) => [
                        PopupMenuItem(
                          child: Text(
                            'Favori Ürünler',
                            style: textStyle.copyWith(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          value: FilterOptions.Favorites,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'Tüm Ürünler',
                            style: textStyle.copyWith(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          value: FilterOptions.All,
                        ),
                      ],
                      icon: Icon(Icons.more_vert),
                      onSelected: (FilterOptions filterOptionValue) {
                        if (filterOptionValue == FilterOptions.Favorites) {
                          productsProvider.showFavorites();
                        } else {
                          productsProvider.showAll();
                        }
                      },
                    ),
                    Consumer<Cart>(
                      builder: (_, cart, ch) => Badge(
                        child: IconButton(
                          icon: Icon(Icons.shopping_cart_outlined),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(CartScreen.routeName);
                          },
                        ),
                        value: cart.itemCount.toString(),
                      ),
                    )
                  ],
                )
              : SizedBox()
        ],
      ),
    );
  }
}
