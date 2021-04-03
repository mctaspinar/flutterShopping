import 'package:flutter/material.dart';

import '../screens/edit_product_screen.dart';

class EditItem extends StatelessWidget {
  final String title;
  final String imgUrl;
  final String id;
  EditItem({this.title, this.id, this.imgUrl});

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
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
