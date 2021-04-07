import 'package:flutter/material.dart';
import '../providers/products_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/app_bar.dart';
import '../widgets/item_description.dart';
import '../widgets/show_item_pic.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product_detail';

  void _toDoFunction(context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments as Product;
    final productItem =
        Provider.of<Products>(context, listen: false).findById(product.id);
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          ShowItemPic(
            product: productItem,
          ),
          Positioned(
            left: 0,
            top: 0,
            child: CustomAppBar(
              iconData: Icons.arrow_back,
              toDo: _toDoFunction,
              title: productItem.title,
              textStyle: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.black),
              popupMenuButton: false,
              alignment: MainAxisAlignment.start,
            ),
          ),
          Positioned(
            bottom: mediaQuery.height * .1,
            right: 0,
            child: ItemDescription(
              product: productItem,
            ),
          )
        ],
      )),
    );
  }
}
