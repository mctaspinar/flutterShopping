import 'package:flutter/material.dart';
import '../widgets/products_gridView.dart';
import '../widgets/app_bar.dart';
import '../widgets/categories_bar.dart';
import './main_drawer_screen.dart';

class ProductOverViewScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  void _openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final theme = Theme.of(context);
    return Scaffold(
        key: scaffoldKey,
        drawer: MainDrawer(),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                iconData: Icons.menu,
                title: 'Alışveriş Uygulaması',
                scaffoldState: scaffoldKey,
                toDo: _openDrawer,
                textStyle:
                    theme.textTheme.headline6.copyWith(color: Colors.black87),
                popupMenuButton: true,
                alignment: MainAxisAlignment.spaceAround,
              ),
              CategoriesBar(),
              ProductsGridView(),
            ],
          ),
        ));
  }
}
