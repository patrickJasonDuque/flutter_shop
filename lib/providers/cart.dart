import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount {
    int count = 0;
    _items.forEach((key, value) {
      count += value.quantity;
    });
    return count;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items[productId].quantity++;
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          title: title,
          id: new DateTime.now().toIso8601String(),
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void subtractItemQuantity(String productId) {
    if (_items[productId].quantity >= 2) {
      _items[productId].quantity--;
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void addItemQuantity(String productId) {
    _items[productId].quantity++;
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
