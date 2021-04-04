import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_bar.dart';
import '../widgets/edit_item.dart';

import '../screens/edit_product_screen.dart';

import '../providers/products_provider.dart';

class ManageProductScreen extends StatelessWidget {
  static const routeName = '/manageProducts';
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    final providedProduct = Provider.of<Products>(context).items;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(EditProductScreen.routeName);
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
                  .copyWith(color: Colors.black),
              popupMenuButton: false,
              alignment: MainAxisAlignment.start,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _refreshProducts(context),
                child: ListView.builder(
                    itemCount: providedProduct.length,
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          EditItem(
                            id: providedProduct[index].id,
                            imgUrl: providedProduct[index].imageUrl,
                            title: providedProduct[index].title,
                          ),
                          Divider(),
                        ],
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
