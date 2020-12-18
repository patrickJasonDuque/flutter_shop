import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product.dart';

import './error_dialog.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  final Product product;
  const UserProductItem({Key key, this.product}) : super(key: key);

  Future<void> _removeProduct(ctx) async {
    try {
      await showDialog<Null>(
          context: ctx,
          builder: (c) => AlertDialog(
                content: Text('Are you sure you want to delete this product?'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      try {
                        await Provider.of<Products>(ctx, listen: false)
                            .deleteProduct(product.id)
                            .then(
                              (_) => Navigator.of(c).pop(),
                            );
                      } catch (error) {
                        Navigator.of(ctx).pop();
                        await showDialog<Null>(
                          context: ctx,
                          builder: (c) => ErrorDialogWidget(c),
                        );
                      }
                    },
                    child: Text(
                      'Yes',
                      style: TextStyle(
                        color: Theme.of(ctx).primaryColor,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(c).pop();
                    },
                    child: Text(
                      'No',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ));
    } catch (error) {
      await showDialog<Null>(
        context: ctx,
        builder: (c) => ErrorDialogWidget(c),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
      child: ListTile(
        title: Text(product.title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(product.imageUrl),
        ),
        trailing: FittedBox(
          child: Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductScreen.routeName,
                      arguments: product);
                },
                color: Theme.of(context).primaryColor,
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _removeProduct(context);
                },
                color: Colors.red[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
