import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  MainAppBar(this.scaffoldKey);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => scaffoldKey.currentState.openDrawer()),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(
            'Alışveriş Uygulaması',
            style: theme.textTheme.headline6.copyWith(color: Colors.orange),
          ),
        ),
      ],
    );
  }
}
