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
      body: orderData.orders.length > 0
          ? ListView.builder(
              itemBuilder: (BuildContext ctx, int i) => OrderItem(
                  amount: orderData.orders[i].amount,
                  date: orderData.orders[i].dateTime,
                  products: orderData.orders[i].products),
              itemCount: orderData.orders.length,
            )
          : Center(
              child: Text(
                'No orders yet!',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
      backgroundColor: Theme.of(context).accentColor,
    );
  }
}
