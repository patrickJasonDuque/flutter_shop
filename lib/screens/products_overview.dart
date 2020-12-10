import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Widget
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';

import '../providers/cart.dart';
import './cart.dart';

enum FilterOptions { Favorites, All }

class ProductsOverview extends StatefulWidget {
  static const routeName = '/products-overview';

  ProductsOverview({Key key}) : super(key: key);

  @override
  _ProductsOverviewState createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  bool _showFavorites = false;
  void _displayFavorites() => setState(() => _showFavorites = true);
  void _displayAll() => setState(() => _showFavorites = false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Products', style: Theme.of(context).textTheme.headline6),
          actions: <Widget>[
            Consumer<Cart>(
              builder: (_, cart, child) => Badge(
                child: child,
                value: cart.itemCount.toString(),
                color: Colors.red,
              ),
              child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  }),
            ),
            PopupMenuButton(
              color: Theme.of(context).accentColor,
              onSelected: (FilterOptions value) {
                value == FilterOptions.Favorites
                    ? _displayFavorites()
                    : _displayAll();
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                    child: Text('Only Favorites'),
                    value: FilterOptions.Favorites),
                PopupMenuItem(
                    child: Text('Show All'), value: FilterOptions.All),
              ],
              icon: Icon(
                Icons.more_vert,
              ),
            ),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          color: Theme.of(context).accentColor,
          child: ProductsGrid(showFavorites: _showFavorites),
        ),
      ),
    );
  }
}
