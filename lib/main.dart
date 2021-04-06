import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './screens/auth_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import './screens/order_screen.dart';
import './screens/cart_screen.dart';
import './screens/manage_product_screen.dart';
import './screens/edit_product_screen.dart';

import './models/cart.dart';
import './models/orders.dart';
import './models/auth.dart';

import './providers/products_provider.dart';

void main() {
  Intl.defaultLocale = 'tr_TR';
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (ctx) => Products('', '', []),
          update: (ctx, auth, prevProducts) => Products(auth.token, auth.userId,
              prevProducts == null ? [] : prevProducts.items),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders('', '', []),
          update: (ctx, auth, prevOrder) => Orders(auth.token, auth.userId,
              prevOrder == null ? [] : prevOrder.orders),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, authData, _) => MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', 'US'),
            const Locale('tr', 'TR  '),
          ],
          debugShowCheckedModeBanner: false,
          title: 'Alışveriş Uygulaması',
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              color: Colors.white,
              elevation: 0,
              brightness: Brightness.light,
              textTheme: GoogleFonts.quicksandTextTheme(
                Theme.of(context).textTheme.copyWith(
                      headline6: GoogleFonts.quicksand(
                              textStyle: Theme.of(context).textTheme.headline6)
                          .copyWith(
                        fontSize: 24,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              ),
            ),
            errorColor: Colors.brown[400],
            primarySwatch: Colors.orange,
            accentColor: Colors.yellow[600],
            iconTheme: IconThemeData(color: Colors.orange),
            textTheme: GoogleFonts.montserratTextTheme().copyWith(
                bodyText1: GoogleFonts.quicksand(
                        textStyle: Theme.of(context).textTheme.bodyText1)
                    .copyWith(
                        color: Colors.white, fontWeight: FontWeight.normal),
                bodyText2: GoogleFonts.quicksand(
                        textStyle: Theme.of(context).textTheme.bodyText2)
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w300),
                headline6: GoogleFonts.quicksand(
                        textStyle: Theme.of(context).textTheme.headline6)
                    .copyWith(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                )),
          ),
          home: authData.isAuth ? ProductOverViewScreen() : AuthScreen(),
          routes: routes(authData),
        ),
      ),
    );
  }

  Map<String, WidgetBuilder> routes(Auth authData) {
    return {
      // ('/'): (context) =>
      //     authData.isAuth ? ProductOverViewScreen() : AuthScreen(),
      ProductOverViewScreen.routeName: (context) =>
          authData.isAuth ? ProductOverViewScreen() : AuthScreen(),
      ProductDetailScreen.routeName: (context) =>
          authData.isAuth ? ProductDetailScreen() : AuthScreen(),
      CartScreen.routeName: (context) =>
          authData.isAuth ? CartScreen() : AuthScreen(),
      OrdersScreen.routeName: (context) =>
          authData.isAuth ? OrdersScreen() : AuthScreen(),
      ManageProductScreen.routeName: (context) =>
          authData.isAuth ? ManageProductScreen() : AuthScreen(),
      EditProductScreen.routeName: (context) =>
          authData.isAuth ? EditProductScreen() : AuthScreen(),
    };
  }
}
