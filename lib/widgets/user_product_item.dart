import 'package:flutter/material.dart';

import '../screens/edit_product.dart';

import '../providers/product.dart';

class UserProductItem extends StatelessWidget {
  final Product product;
  const UserProductItem({Key key, this.product}) : super(key: key);

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
                onPressed: () {},
                color: Colors.red[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
