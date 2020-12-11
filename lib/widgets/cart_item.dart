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
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(5.0),
        ),
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
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text(
              'Delete this item',
              style: TextStyle(color: Colors.black),
            ),
            content: const Text(
                'Are you sure you want to remove this item in the cart?'),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: Text(
                  'No',
                  style: TextStyle(color: Colors.red[400]),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: Text(
                  'Yes',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        );
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
