import 'package:flutter/material.dart';

class CategoriesBar extends StatelessWidget {
  final List<String> categories = [
    'Giyim',
    'Elektronik',
    'Kisisel Bakım',
    'Spor',
    'Süper Market',
    'Kitap',
    'Bebek'
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Container(
      width: mediaQuery.size.width,
      height: mediaQuery.size.height * .07,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
            color: theme.primaryColor,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((e) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  print(e);
                },
                child: Container(
                  child: Text(
                    e,
                    style: theme.textTheme.bodyText2.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
