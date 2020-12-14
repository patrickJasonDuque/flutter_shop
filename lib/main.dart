import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';

// Screens
import './screens/user_products.dart';
import './screens/products_overview.dart';
import './screens/product_detail.dart';
import './screens/cart.dart';
import './screens/orders.dart';
import './screens/edit_product.dart';
import './screens/add_product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider<Cart>(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider<Order>(
          create: (_) => Order(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            actionsIconTheme: IconThemeData(color: Colors.white),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          textTheme: TextTheme(
            headline6: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          primarySwatch: Colors.lightBlue,
          accentColor: Colors.cyan[100],
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Montserrat',
        ),
        home: ProductsOverview(),
        routes: {
          ProductDetail.routeName: (ctx) => ProductDetail(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
          AddProductScreen.routeName: (ctx) => AddProductScreen(),
        },
      ),
    );
  }
}
