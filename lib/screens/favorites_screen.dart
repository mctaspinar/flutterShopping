import 'package:flutter/material.dart';
import 'package:flutter_shopping/widgets/app_bar.dart';
import '../widgets/product_item.dart';

class FavoritesScreen extends StatelessWidget {
  void _toDoFunction(context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              iconData: Icons.arrow_back,
              title: 'Favorilerim',
              popupMenuButton: false,
              toDo: () => _toDoFunction(context),
              textStyle: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.black54),
              alignment: MainAxisAlignment.start,
            ),
          ],
        ),
      ),
    );
  }
}
