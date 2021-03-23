import 'package:flutter/material.dart';
import 'package:flutter_shopping/screens/product_detail_screen.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  ProductItem(this.product);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                  Icons.favorite_border,
                ),
                onPressed: () {},
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
