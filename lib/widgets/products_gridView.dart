import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../widgets/product_item.dart';

class ProductsGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prodcutsData = Provider.of<Products>(context);
    final productsItem = prodcutsData.items;
    return productsItem.length == 0
        ? Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
                child: Column(
              children: [
                Text('Henüz favorilerinize bir ürün eklemediniz.'),
                TextButton(
                  child: Text('Tüm ürünleri gör.'),
                  onPressed: () => prodcutsData.showAll(),
                ),
              ],
            )),
          )
        : Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              itemCount: productsItem.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3 / 2,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) => ChangeNotifierProvider.value(
                value: productsItem[index],
                child: ProductItem(),
              ),
            ),
          );
  }
}
