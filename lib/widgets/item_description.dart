import 'package:flutter/material.dart';
import '../models/product.dart';

class ItemDescription extends StatelessWidget {
  final Product product;
  ItemDescription({this.product});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.black54,
      ),
      height: mediaQuery.height * .5,
      width: mediaQuery.width * .8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${product.description}',
              style: theme.textTheme.bodyText1.copyWith(
                fontSize: 24,
              ),
            ),
            Divider(
              color: theme.accentColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Fiyat ${product.price} ₺',
                    style: theme.textTheme.bodyText1),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Sepete Ekle',
                    style: theme.textTheme.bodyText1,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
