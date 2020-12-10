import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String productId;
  const CartItem(
      {Key key, this.quantity, this.price, this.id, this.title, this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);

    return Dismissible(
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
        padding: const EdgeInsets.all(20.0),
        color: Colors.black54,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 50.0,
        ),
        alignment: Alignment.centerLeft,
      ),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        cart.removeItem(productId);
      },
      key: ValueKey(id),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Consumer<Products>(
              builder: (_, products, __) => CircleAvatar(
                backgroundImage:
                    NetworkImage(products.findById(productId).imageUrl),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text('Quantity: $quantity'),
                Text('Total: ₱${(price * quantity).toStringAsFixed(2)}'),
              ],
            ),
            trailing: FittedBox(
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        cart.addItemQuantity(productId);
                      }),
                  IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        cart.subtractItemQuantity(productId);
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
