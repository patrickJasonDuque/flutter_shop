import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Widget
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../widgets/drawer_navigation.dart';

import '../providers/cart.dart';
import '../providers/products.dart';
import './cart.dart';

enum FilterOptions { Favorites, All }

class ProductsOverview extends StatefulWidget {
  static const routeName = '/';

  ProductsOverview({Key key}) : super(key: key);

  @override
  _ProductsOverviewState createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  bool _showFavorites = false;
  // bool _isInit = true;
  bool _isLoading = false;
  void _displayFavorites() => setState(() => _showFavorites = true);
  void _displayAll() => setState(() => _showFavorites = false);

  @override
  void initState() {
    super.initState();
    setState(() => _isLoading = true);
    Provider.of<Products>(context, listen: false)
        .getProducts()
        .then((_) => setState(() {
              _isLoading = false;
            }));
    // Future.delayed(Duration.zero)
    //     .then((_) => Provider.of<Products>(context).getProducts());
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (_isInit) {
  //     Provider.of<Products>(context).getProducts();
  //   }
  //   _isInit = false;
  // }

  Future<void> _refreshProducts() async {
    await Provider.of<Products>(context, listen: false).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        drawer: DrawerNavigation(),
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
        body: !_isLoading
            ? RefreshIndicator(
                backgroundColor: Theme.of(context).primaryColor,
                onRefresh: _refreshProducts,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: ProductsGrid(showFavorites: _showFavorites),
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColorDark),
              ),
      ),
    );
  }
}
