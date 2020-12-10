import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/cart.dart';

import '../screens/product_detail.dart';

class ProductItem extends StatelessWidget {
  ProductItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Product>(context, listen: false);
    final cartData = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetail.routeName, arguments: productData.id);
          },
          child: Image.network(
            productData.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: Consumer<Product>(
            builder: (_, productData, __) => IconButton(
              color: productData.isFavorite
                  ? Colors.red
                  : Theme.of(context).accentColor,
              icon: Icon(Icons.favorite),
              onPressed: productData.favorite,
            ),
          ),
          backgroundColor: Colors.black87,
          title: Text(
            productData.title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).accentColor, fontFamily: 'Montserrat'),
          ),
          trailing: IconButton(
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cartData.addItem(context, productData.id, productData.price,
                  productData.title);
            },
          ),
        ),
      ),
    );
  }
}
