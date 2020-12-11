import 'dart:math';

import '../models/cart_item.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final double amount;
  final DateTime date;
  final List<CartItem> products;
  const OrderItem(
      {Key key,
      @required this.amount,
      @required this.date,
      @required this.products})
      : super(key: key);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;
  // AnimationController animationController;

  // @override
  // void initState() {
  //   super.initState();
  //   animationController = AnimationController(
  //     duration: Duration(seconds: 1),
  //     vsync: OrderItem,
  //   );

  //   animationController.forward();

  //   animationController.addListener(() {
  //     setState(() {});
  //   });
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   animationController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.white,
          elevation: 10.0,
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          child: ListTile(
            title: Text('₱${widget.amount.toStringAsFixed(2)}'),
            subtitle: Text(
              DateFormat.yMMMMEEEEd().format(widget.date),
            ),
            trailing: IconButton(
              icon: Icon(
                _expanded
                    ? Icons.arrow_drop_up_rounded
                    : Icons.arrow_drop_down_rounded,
                color: Theme.of(context).primaryColor,
                size: 35.0,
              ),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
        ),
        if (_expanded)
          Hero(
            tag: 'order-details',
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[400],
                    spreadRadius: 2.0,
                    blurRadius: .5,
                    offset: Offset(0.5, 2),
                  ),
                ],
              ),
              height: min(widget.products.length.toDouble() * 20 + 50, 180),
              child: ListView(
                children: [
                  ...widget.products.map(
                    (product) => Container(
                      margin: const EdgeInsets.all(8.0),
                      child: Row(children: <Widget>[
                        Text(
                          product.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        Spacer(),
                        Text(
                          '₱' + product.price.toStringAsFixed(2),
                        ),
                        Text(
                          'X' + product.quantity.toString(),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          )
      ],
    );
  }
}
