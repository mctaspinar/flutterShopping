import 'package:flutter/material.dart';

import '../models/product.dart';

import '../screens/edit_product_screen.dart';

class EditItem extends StatelessWidget {
  final Product product;
  EditItem({this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.title),
      trailing: FittedBox(
        child: Row(
          children: [
            IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductScreen.routeName,
                      arguments: ['Ürünü Düzenle', product]);
                }),
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
