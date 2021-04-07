import 'package:flutter/material.dart';
import '../models/cart.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';

class ItemDescription extends StatefulWidget {
  final Product product;
  ItemDescription({this.product});

  @override
  _ItemDescriptionState createState() => _ItemDescriptionState();
}

class _ItemDescriptionState extends State<ItemDescription> {
  bool _loading = false;

  void _submit() {
    setState(() {
      _loading = true;
    });

    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        color: Colors.black54,
      ),
      height: mediaQuery.height * .5,
      width: mediaQuery.width * .8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.product.description}',
              style: theme.textTheme.bodyText1.copyWith(
                fontSize: 24,
              ),
            ),
            Divider(
              color: theme.accentColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Fiyat ${widget.product.price} ₺',
                    style: theme.textTheme.bodyText1),
                ElevatedButton.icon(
                  onPressed: _loading
                      ? null
                      : () {
                          cart.addItem(
                            widget.product.id,
                            widget.product.price,
                            widget.product.title,
                          );
                          _submit();
                        },
                  icon: Icon(
                    _loading
                        ? Icons.shopping_cart
                        : Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                  label: Text(
                    !_loading ? 'Sepete Ekle' : 'Sepete Eklendi!',
                    style: theme.textTheme.bodyText1,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
