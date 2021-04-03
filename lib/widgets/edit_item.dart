import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';

import '../providers/products_provider.dart';

class EditItem extends StatelessWidget {
  final String title;
  final String imgUrl;
  final String id;
  EditItem({this.title, this.id, this.imgUrl});

  Widget _buildAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Emin Misiniz?",
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: Colors.black,
              fontSize: 24,
            ),
      ),
      content: Text("Ürün silinecektir!",
          style: Theme.of(context).textTheme.bodyText2),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text("Hayır")),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text("Evet")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
      ),
      title: Text(title),
      trailing: FittedBox(
        child: Row(
          children: [
            IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProductScreen.routeName, arguments: id);
                }),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                return showDialog(
                        context: context,
                        builder: (_) {
                          return _buildAlertDialog(context);
                        })
                    .then((value) => value
                        ? Provider.of<Products>(context, listen: false)
                            .deleteProduct(id)
                        : null);
              },
            ),
          ],
        ),
      ),
    );
  }
}
