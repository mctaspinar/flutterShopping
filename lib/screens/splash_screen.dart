import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.refresh,
              size: 64,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              'Yükleniyor..',
              style:
                  Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
