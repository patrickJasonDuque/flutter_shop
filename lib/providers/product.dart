import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.imageUrl,
      @required this.price,
      this.isFavorite = false});

  Future<void> favorite() async {
    try {
      bool newFavorite = !isFavorite;
      isFavorite = newFavorite;
      notifyListeners();
      var response = await http.patch(
        'https://flutter-test-f6e94.firebaseio.com/products/$id.json',
        body: jsonEncode({
          'description': description,
          'title': title,
          'price': price,
          'imageUrl': imageUrl,
          'isFavorite': newFavorite
        }),
      );
      if (response.statusCode >= 400) {
        isFavorite = !newFavorite;
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }
}
