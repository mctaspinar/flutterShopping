import 'package:flutter/material.dart';
import './screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.yellow,
        iconTheme: IconThemeData(color: Colors.orange),
        textTheme: GoogleFonts.montserratTextTheme().copyWith(
            bodyText1: GoogleFonts.quicksand(
                    textStyle: Theme.of(context).textTheme.bodyText1)
                .copyWith(color: Colors.white, fontWeight: FontWeight.normal),
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
      routes: {
        ('/'): (context) => ProductOverViewScreen(),
        ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
      },
    );
  }
}
