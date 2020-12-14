import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/product.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  AddProductScreen({Key key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _imageFocusNode = FocusNode();
  final TextEditingController _imageController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  Product _editedProduct =
      Product(id: null, title: '', price: 0, description: '', imageUrl: '');

  void _updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _imageFocusNode.addListener(_updateImageUrl);
  }

  @override
  void dispose() {
    super.dispose();
    _imageFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageFocusNode.dispose();
    _imageController.dispose();
  }

  void _submitForm() {
    final bool isValid = _form.currentState.validate();

    if (!isValid) return;

    _editedProduct = Product(
        id: DateTime.now().toString(),
        title: _editedProduct.title,
        price: _editedProduct.price,
        imageUrl: _editedProduct.imageUrl,
        description: _editedProduct.description);
    _form.currentState.save();
    Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _submitForm();
            },
          )
        ],
        title: Text(
          'Add Product',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                autocorrect: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: value,
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                    price: _editedProduct.price,
                  );
                },
                validator: (value) {
                  return value.isEmpty ? 'Please add a title' : null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                autocorrect: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Price',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                    price: double.parse(value),
                  );
                },
                validator: (value) {
                  if (value.isEmpty) return 'Please add a price.';
                  if (double.tryParse(value) == null)
                    return 'Please enter a valid number.';
                  if (double.tryParse(value) <= 0)
                    return 'Please enter a price higher than 0';
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                autocorrect: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Description',
                  alignLabelWithHint: true,
                ),
                focusNode: _descriptionFocusNode,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: value,
                    imageUrl: _editedProduct.imageUrl,
                    price: _editedProduct.price,
                  );
                },
                validator: (value) {
                  return value.isEmpty ? 'Please enter a description.' : null;
                },
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.black54),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: _imageController.text.isEmpty
                        ? Center(
                            child: Text('Enter a URL'),
                          )
                        : Image.network(
                            _imageController.text,
                            fit: BoxFit.cover,
                          ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                      decoration: InputDecoration(
                        labelText: 'Image URL',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      controller: _imageController,
                      focusNode: _imageFocusNode,
                      onFieldSubmitted: (_) {
                        _submitForm();
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          imageUrl: value,
                          price: _editedProduct.price,
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) return 'Please enter an image url';
                        if (!value.contains('www') || !value.contains('http'))
                          return 'Please enter a valid image url';
                        return null;
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
