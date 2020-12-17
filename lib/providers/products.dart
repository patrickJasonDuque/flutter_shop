import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';

class Products with ChangeNotifier {
  final String _baseUrl = 'https://flutter-test-f6e94.firebaseio.com';

  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
        id: 'p2',
        title: 'Trousers',
        description: 'A nice pair of trousers.',
        price: 59.99,
        imageUrl:
            'https://www.kingsize.com.au/user/images/18901.jpg?t=1704051045'),
    Product(
        id: 'p3',
        title: 'Leather Shoes',
        description: 'A nice pair of shoes.',
        price: 199.99,
        imageUrl:
            'https://previews.123rf.com/images/gorbelabda/gorbelabda1205/gorbelabda120500148/13600984-mens-shoes-with-white-background.jpg'),
  ];

  List<Product> get items => [..._items];

  List<Product> get favoriteItems =>
      [..._items.where((item) => item.isFavorite)];

  Future<void> addProduct(Product product) async {
    const String url = '/products.jn';

    try {
      var response = await http.post(_baseUrl + url,
          body: jsonEncode({
            'title': product.title,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite,
            'description': product.description,
          }));

      final Product newProduct = Product(
          description: product.description,
          title: product.title,
          price: product.price,
          imageUrl: product.imageUrl,
          id: jsonDecode(response.body)['name']);

      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void updateProduct(Product prod) {
    final Product editedProd = Product(
        description: prod.description,
        title: prod.title,
        price: prod.price,
        imageUrl: prod.imageUrl,
        id: prod.id);

    _items[_items.indexWhere((item) => item.id == prod.id)] = editedProd;
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    const String url = '/products';

    try {
      await http.delete(_baseUrl + url + '/$id.json');

      _items.removeWhere((prod) => prod.id == id);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Product findById(id) {
    return items.firstWhere((item) => item.id == id);
  }
}
