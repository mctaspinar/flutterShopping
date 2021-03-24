import 'package:flutter/material.dart';
import '../widgets/products_gridView.dart';
import '../widgets/app_bar.dart';
import '../widgets/categories_bar.dart';
import './main_drawer_screen.dart';

class ProductOverViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: scaffoldKey,
        drawer: MainDrawer(),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainAppBar(scaffoldKey),
              CategoriesBar(),
              ProductsGridView(),
            ],
          ),
        ));
  }
}
