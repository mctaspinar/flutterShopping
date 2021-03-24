import 'package:flutter/material.dart';
import '../models/product.dart';

class ShowItemPic extends StatelessWidget {
  final Product product;
  ShowItemPic({this.product});

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
    final mediaQuery = MediaQuery.of(context).size;
    return Container(
      height: mediaQuery.height - MediaQuery.of(context).padding.top,
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
    );
  }
}
