import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product_detail';

  Widget _heroBuilder(product) {
    return Hero(
      tag: '${product.id}',
      child: Image.network(
        product.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments as Product;
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height:
                      mediaQuery.height - MediaQuery.of(context).padding.top,
                  width: mediaQuery.width,
                  child: GestureDetector(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (_) {
                            return Dialog(
                              child: Container(
                                child: _heroBuilder(product),
                              ),
                            );
                          });
                    },
                    child: _heroBuilder(product),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: theme.primaryColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  Text(
                    product.title,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.black54),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: mediaQuery.height * .1,
              right: 0,
              child: Container(
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
              ),
            )
          ],
        ),
      )),
    );
  }
}
