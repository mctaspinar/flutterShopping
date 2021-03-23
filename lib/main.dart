import 'package:flutter/material.dart';
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
        textTheme: GoogleFonts.montserratTextTheme().copyWith(
            bodyText1: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.bodyText1)
                .copyWith(color: Colors.white, fontWeight: FontWeight.normal),
            bodyText2: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.bodyText2)
                .copyWith(fontWeight: FontWeight.bold),
            headline6: GoogleFonts.montserrat(
                    textStyle: Theme.of(context).textTheme.headline6)
                .copyWith(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            )),
      ),
      home: ProductOverViewScreen(),
    );
  }
}
