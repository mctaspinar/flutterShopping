import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  final String title;
  final String buttonTitle;
  final Function navigatePage;

  EmptyPage({this.title, this.buttonTitle, this.navigatePage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Center(
          child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 22),
          ),
          TextButton(
            onPressed: navigatePage,
            child: Text(buttonTitle),
            style: TextButton.styleFrom(primary: Colors.orange),
          )
        ],
      )),
    );
  }
}
