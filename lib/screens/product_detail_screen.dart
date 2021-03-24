import 'package:flutter/material.dart';
import 'package:flutter_shopping/widgets/app_bar.dart';
import 'package:flutter_shopping/widgets/item_description.dart';
import 'package:flutter_shopping/widgets/show_item_pic.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product_detail';

  void _toDoFunction(context) {
    Navigator.of(context).pop();
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
                ShowItemPic(
                  product: product,
                ),
              ],
            ),
            Positioned(
              left: 0,
              top: 0,
              child: CustomAppBar(
                iconData: Icons.arrow_back,
                toDo: _toDoFunction,
                title: product.title,
                textStyle: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.black54),
              ),
            ),
            Positioned(
              bottom: mediaQuery.height * .1,
              right: 0,
              child: ItemDescription(
                product: product,
              ),
            )
          ],
        ),
      )),
    );
  }
}
