import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_item.dart';

import '../providers/cart.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    final cartItems = cartData.items;

    return Scaffold(
        appBar: AppBar(
          title: Text('Cart', style: Theme.of(context).textTheme.headline6),
        ),
        backgroundColor: Theme.of(context).accentColor,
        body: cartData.itemCount > 0
            ? Column(children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      itemBuilder: (BuildContext ctx, int i) {
                        return CartItem(
                          quantity: cartItems.values.toList()[i].quantity,
                          price: cartItems.values.toList()[i].price,
                          title: cartItems.values.toList()[i].title,
                          id: cartItems.values.toList()[i].id,
                          productId: cartItems.keys.toList()[i],
                        );
                      },
                      itemCount: cartItems.values.toList().length),
                ),
                Card(
                  margin: const EdgeInsets.all(15.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Total',
                          style: const TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Chip(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          label: Text(
                            '₱${cartData.totalAmount.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          backgroundColor: Theme.of(context).primaryColorDark,
                        ),
                        FlatButton(
                          onPressed: () {},
                          child: Text(
                            'PAY NOW',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ])
            : Center(
                child: Text('No items in cart',
                    style: Theme.of(context).textTheme.headline6),
              ));
  }
}
