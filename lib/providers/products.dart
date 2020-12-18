import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';

import '../models/http_exception.dart';

class Products with ChangeNotifier {
  final String _baseUrl = 'https://flutter-test-f6e94.firebaseio.com';

  List<Product> _items = [];

  List<Product> get items => [..._items];

  List<Product> get favoriteItems =>
      [..._items.where((item) => item.isFavorite)];

  Future<void> addProduct(Product product) async {
    const String url = '/products.json';

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

  Future<void> updateProduct(Product prod) async {
    const String url = '/products';

    try {
      var response = await http.patch(_baseUrl + url + '/${prod.id}.json',
          body: jsonEncode({
            'description': prod.description,
            'title': prod.title,
            'price': prod.price,
            'imageUrl': prod.imageUrl,
          }));
      var body = jsonDecode(response.body);
      final Product editedProd = Product(
          description: body['description'],
          title: body['title'],
          price: body['price'],
          imageUrl: body['imageUrl'],
          id: prod.id);

      final List<Product> editedProducts = [..._items];
      editedProducts[editedProducts.indexWhere((item) => item.id == prod.id)] =
          editedProd;
      _items = editedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteProduct(String id) async {
    const String url = '/products';
    try {
      var response = await http.delete(_baseUrl + url + '/$id.json');
      if (response.statusCode >= 400) {
        throw HttpException('Error deleting product.');
      }
      _items.removeWhere((prod) => prod.id == id);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> getProducts() async {
    const String url = '/products.json';
    try {
      final response = await http.get(_baseUrl + url);
      final body = jsonDecode(response.body);
      final List<Product> newProducts = [];
      body.forEach((key, value) => newProducts.add(
            Product(
                description: value['description'],
                title: value['title'],
                price: value['price'],
                imageUrl: value['imageUrl'],
                isFavorite: value['isFavorite'],
                id: key),
          ));
      _items = newProducts;
      print('fetched data');
      notifyListeners();
    } catch (error) {
      print('error' + error);
      throw error;
    }
  }

  Product findById(id) {
    return items.firstWhere((item) => item.id == id);
  }
}
