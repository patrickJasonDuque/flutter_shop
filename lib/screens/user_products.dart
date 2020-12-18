import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

import './add_product.dart';

import '../widgets/user_product_item.dart';
import '../widgets/drawer_navigation.dart';

class UserProductsScreen extends StatelessWidget {
  static const String routeName = '/user-products';
  const UserProductsScreen({Key key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final productItems = productData.items;
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      drawer: DrawerNavigation(),
      appBar: AppBar(
        title: Text(
          'Manage Products',
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddProductScreen.routeName);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        backgroundColor: Theme.of(context).primaryColor,
        onRefresh: () => _refreshProducts(context),
        child: ListView.builder(
          itemBuilder: (_, int i) => UserProductItem(
            product: productItems[i],
          ),
          itemCount: productItems.length,
        ),
      ),
    );
  }
}
