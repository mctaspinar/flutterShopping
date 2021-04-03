import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_bar.dart';
import '../widgets/edit_item.dart';

import '../screens/edit_product_screen.dart';

import '../providers/products_provider.dart';

class ManageProductScreen extends StatelessWidget {
  static const routeName = '/manageProducts';
  @override
  Widget build(BuildContext context) {
    final providedProduct = Provider.of<Products>(context).items;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(EditProductScreen.routeName,
              arguments: ['Yeni Ürün Ekle']);
        },
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomAppBar(
              iconData: Icons.arrow_back,
              toDo: () {
                Navigator.of(context).pop();
              },
              title: 'Ürünleri Düzenle',
              textStyle: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.black54),
              popupMenuButton: false,
              alignment: MainAxisAlignment.start,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: providedProduct.length,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        EditItem(
                          product: providedProduct[index],
                        ),
                        Divider(),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
