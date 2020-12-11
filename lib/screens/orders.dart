import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';

import '../widgets/drawer_navigation.dart';
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const String routeName = '/orders';
  const OrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);

    return Scaffold(
      drawer: DrawerNavigation(),
      appBar: AppBar(
        title: Text(
          'Orders',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext ctx, int i) => OrderItem(),
        itemCount: orderData.orders.length,
      ),
      backgroundColor: Theme.of(context).accentColor,
    );
  }
}
