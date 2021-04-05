import 'package:flutter/material.dart';
import 'package:flutter_shopping/providers/products_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/products_gridView.dart';
import '../widgets/app_bar.dart';
import '../widgets/categories_bar.dart';
import './main_drawer_screen.dart';

class ProductOverViewScreen extends StatefulWidget {
  static const routeName = '/logged-Screen';
  @override
  _ProductOverViewScreenState createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  Future _future;
  Future getFuture() {
    return Provider.of<Products>(context, listen: false).getAllProducts();
  }

  @override
  void initState() {
    _future = getFuture();
    super.initState();
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomAppBar(
                iconData: Icons.menu,
                title: 'Alışveriş Uygulaması',
                scaffoldState: scaffoldKey,
                toDo: _openDrawer,
                textStyle:
                    theme.textTheme.headline6.copyWith(color: Colors.black87),
                popupMenuButton: true,
                alignment: MainAxisAlignment.spaceBetween,
              ),
              CategoriesBar(),
              FutureBuilder(
                  future: _future,
                  builder: (ctx, snapData) {
                    if (snapData.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ProductsGridView();
                    }
                  }),
            ],
          ),
        ));
  }
}
