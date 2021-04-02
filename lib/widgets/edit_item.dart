import 'package:flutter/material.dart';

class EditItem extends StatelessWidget {
  final String title;
  final String imgUrl;

  EditItem({this.imgUrl, this.title});

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
                onPressed: () {}),
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
