import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shopping/models/product.dart';
import 'package:flutter_shopping/providers/products_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/app_bar.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  var _product = Product(
    id: null,
    title: '',
    description: '',
    price: 0.0,
    imageUrl: '',
  );
  var _isInit = true;
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final _productId = ModalRoute.of(context).settings.arguments as String;
      if (_productId != null) {
        _product =
            Provider.of<Products>(context, listen: false).findById(_productId);
        _initValues = {
          'title': _product.title,
          'description': _product.description,
          'price': _product.price.toString(),
          'imageUrl': '',
        };
        _imageUrlController.text = _product.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageFocusNode.removeListener(_updateImageUrl);
    _imageFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _saveProduct() {
    setState(() {});
  }

  void _updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final _isValid = _formKey.currentState.validate();
    if (_isValid) {
      _formKey.currentState.save();
      Provider.of<Products>(context, listen: false).addProduct(_product);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${_product.title} ürünü eklenmiştir."),
          duration: Duration(milliseconds: 850),
        ),
      );
      _initValues = {
        'title': "",
        'description': "",
        'price': "",
        'imageUrl': '',
      };
      _imageUrlController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomAppBar(
                  iconData: Icons.arrow_back,
                  toDo: () {
                    Navigator.of(context).pop();
                  },
                  title: arguments == null ? 'Yeni Ürün Ekle' : 'Ürünü Düzenle',
                  textStyle: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.black54),
                  popupMenuButton: false,
                  alignment: MainAxisAlignment.start,
                ),
                IconButton(icon: Icon(Icons.save), onPressed: _saveForm),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: _initValues['title'],
                        decoration: InputDecoration(labelText: 'Ürün adı'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        onSaved: (value) {
                          _product = Product(
                            id: null,
                            title: value,
                            description: _product.description,
                            price: _product.price,
                            imageUrl: _product.imageUrl,
                          );
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Lütfen ürün başlığı giriniz!";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['price'],
                        decoration: InputDecoration(labelText: 'Ürün fiyatı'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                        onSaved: (value) {
                          _product = Product(
                            id: null,
                            title: _product.title,
                            description: _product.description,
                            price: double.parse(value),
                            imageUrl: _product.imageUrl,
                          );
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Lütfen ürün fiyatını giriniz!";
                          }
                          if (double.tryParse(value) == null) {
                            return "Lütfen geçerli bir fiyat giriniz!";
                          }
                          if (double.parse(value) <= 0) {
                            return "Lütfen 0'dan büyük bir fiyat giriniz!";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['description'],
                        decoration:
                            InputDecoration(labelText: 'Ürün açıklaması'),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                        focusNode: _descriptionFocusNode,
                        onSaved: (value) {
                          _product = Product(
                            id: null,
                            title: _product.title,
                            description: value,
                            price: _product.price,
                            imageUrl: _product.imageUrl,
                          );
                        },
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return "Lütfen ürün açıklamaısını giriniz!";
                          }
                          if (value.trim().length <= 10) {
                            return "Ürün açıklaması yetersiz!";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Ürün resim linki'),
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        keyboardType: TextInputType.url,
                        focusNode: _imageFocusNode,
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        onSaved: (value) {
                          _product = Product(
                            id: null,
                            title: _product.title,
                            description: _product.description,
                            price: _product.price,
                            imageUrl: value,
                          );
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Lütfen ürün resim linki giriniz!";
                          }
                          if (!value.startsWith("http") &&
                              !value.startsWith("https")) {
                            return "Lütfen geçerli bir link giriniz!";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(border: Border.all()),
                        child: Image.network(
                          _imageUrlController.text,
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace stackTrace) {
                            return Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _imageUrlController.text.isEmpty
                                  ? Text("Resim linkini giriniz.")
                                  : Text(
                                      'Resim yüklenirken bir hata oluştu. Lütfen farklı bir resim adresi deneyiniz.',
                                      textAlign: TextAlign.center,
                                    ),
                            ));
                          },
                        ),
                      ),
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
