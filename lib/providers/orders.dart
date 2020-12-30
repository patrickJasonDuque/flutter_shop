import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/order_item.dart';
import '../models/cart_item.dart';

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders => [..._orders];

  Future<void> getOrders() async {
    try {
      var response = await http
          .get('https://flutter-test-f6e94.firebaseio.com/orders.json');
      var body = jsonDecode(response.body);
      if (body == null) {
        return;
      }
      List<OrderItem> newOrders = [];
      body.forEach((key, value) {
        newOrders.add(OrderItem(
          id: key,
          amount: value['amount'],
          dateTime: DateTime.parse(value['dateTime']),
          products: (value['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title'],
                ),
              )
              .toList(),
        ));
      });
      _orders = newOrders;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    try {
      DateTime timestamp = DateTime.now();
      var response = await http.post(
        'https://flutter-test-f6e94.firebaseio.com/orders.json',
        body: jsonEncode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((cartItem) => {
                    'id': cartItem.id,
                    'quantity': cartItem.quantity,
                    'price': cartItem.price,
                    'title': cartItem.title
                  })
              .toList()
        }),
      );

      _orders.add(OrderItem(
          id: jsonDecode(response.body)['name'],
          amount: total,
          dateTime: DateTime.now(),
          products: cartProducts));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
