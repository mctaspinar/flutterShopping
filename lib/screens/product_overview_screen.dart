import 'package:flutter/material.dart';
import 'package:flutter_shopping/widgets/product_item.dart';
import "../models/product.dart";
import 'main_drawer_screen.dart';

class ProductOverViewScreen extends StatelessWidget {
  final List<Product> products = [
    Product(
      id: 'p1',
      title: 'Kırmızı Tişört',
      description: 'Kırmızı bir tişört..',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Pantolon',
      description: 'Bol kesim siyah pantolon.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Sarı Atkı',
      description: 'Sıcak ve rahat - tam da kış için ihtiyacınız olan şey.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Tava',
      description:
          'İstediğiniz herhangi bir yemeği hazırlayın.İstediğiniz herhangi bir yemeği hazırlayın.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    final List<String> categories = [
      'Giyim',
      'Elektronik',
      'Kisisel Bakım',
      'Spor',
      'Süper Market',
      'Kitap'
    ];
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: scaffoldKey,
        drawer: MainDrawer(),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () => scaffoldKey.currentState.openDrawer()),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Text(
                      'Alışveriş Uygulaması',
                      style: theme.textTheme.headline6
                          .copyWith(color: Colors.orange),
                    ),
                  ),
                ],
              ),
              Container(
                width: mediaQuery.size.width,
                height: mediaQuery.size.height * .07,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: theme.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categories.map((e) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            print(e);
                          },
                          child: Container(
                            child: Text(
                              e,
                              style: theme.textTheme.bodyText2.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 3 / 2,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) => ProductItem(products[index]),
                ),
              ),
            ],
          ),
        ));
  }
}
