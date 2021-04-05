import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../models/auth.dart';
import '../models/product.dart';

import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    //listen false diyerek sadece veriyi getirmesini istiyoruz
    //değişen veriden ui güncellemesi için consumer widgetı kullanıyoruz.
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                    arguments: product);
              },
              child: Hero(
                tag: '${product.id}',
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  height: 250,
                  width: 250,
                ),
              ),
            ),
            Positioned(
              right: 0,
              //değişmesini istediğimiz yer
              child: Consumer<Product>(
                builder: (context, product, _) => IconButton(
                  icon: Icon(
                    !product.isFavorite
                        ? Icons.favorite_border
                        : Icons.favorite,
                  ),
                  onPressed: () {
                    product.toggleFavorite(auth.token);
                  },
                ),
              ),
            )
          ],
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
              size: 22,
              color: theme.primaryColor,
            ),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${product.title} sepete eklendi."),
                  duration: Duration(milliseconds: 1500),
                  action: SnackBarAction(
                    label: "Geri Al",
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyText1,
          ),
          trailing: Text(
            '${product.price} ₺',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
