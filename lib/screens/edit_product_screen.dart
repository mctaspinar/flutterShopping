import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shopping/models/product.dart';

import '../widgets/app_bar.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void dispose() {
    _imageUrlController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as List;
    if (arguments.length > 1) {
      Product product = arguments[1];
      _imageUrlController.text = product.imageUrl;
      _titleController.text = product.title;
      _descriptionController.text = product.description;
      _priceController.text = product.price.toString();
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              iconData: Icons.arrow_back,
              toDo: () {
                Navigator.of(context).pop();
              },
              title: arguments[0],
              textStyle: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.black54),
              popupMenuButton: false,
              alignment: MainAxisAlignment.start,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  child: ListView(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Ürün adı'),
                        textInputAction: TextInputAction.next,
                        controller: _titleController,
                      ),
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Ürün açıklaması'),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                        controller: _descriptionController,
                      ),
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Ürün resim linki'),
                        textInputAction: TextInputAction.next,
                        controller: _imageUrlController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Ürün fiyatı'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        controller: _priceController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _imageUrlController.text.isNotEmpty
                          ? Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(border: Border.all()),
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.fill,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress
                                                  .expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*


*/
