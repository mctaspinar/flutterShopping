import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Function toDo;
  final IconData iconData;
  final GlobalKey<ScaffoldState> scaffoldState;
  final TextStyle textStyle;
  CustomAppBar({
    this.title,
    this.toDo,
    this.iconData,
    this.scaffoldState,
    this.textStyle,
  });

  void _iconFunction(BuildContext context) {
    if (scaffoldState != null) {
      scaffoldState.currentState.openDrawer();
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(iconData),
          onPressed: () => _iconFunction(context),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(
            title,
            style: textStyle,
          ),
        ),
      ],
    );
  }
}
