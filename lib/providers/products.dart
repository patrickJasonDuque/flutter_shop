import 'package:flutter/material.dart';

import './product.dart';

class Products with ChangeNotifier {
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

  void addProduct(value) {
    // _items.add(value);
    notifyListeners();
  }

  Product findById(id) {
    return items.firstWhere((item) => item.id == id);
  }
}
