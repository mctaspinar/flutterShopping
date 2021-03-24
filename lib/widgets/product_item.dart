import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final product = Provider.of<Product>(context);
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
              child: IconButton(
                icon: Icon(
                  !product.isFavorite ? Icons.favorite_border : Icons.favorite,
                ),
                onPressed: () {
                  product.toggleFavorite();
                },
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
            onPressed: () {},
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
