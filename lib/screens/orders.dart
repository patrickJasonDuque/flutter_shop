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
    // final orderData = Provider.of<Order>(context);

    return Scaffold(
      drawer: DrawerNavigation(),
      appBar: AppBar(
        title: Text(
          'Orders',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: FutureBuilder(
        future: Provider.of<Order>(context, listen: false).getOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          } else {
            if (snapshot.error != null) {
              return Center(
                child: Text(
                  'Something went wrong',
                  style: Theme.of(context).textTheme.headline6,
                ),
              );
            } else {
              return Consumer<Order>(
                child: Center(
                  child: Text(
                    'No orders yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                builder: (_, orderData, child) {
                  return orderData.orders.length > 0
                      ? ListView.builder(
                          itemBuilder: (BuildContext ctx, int i) => OrderItem(
                              amount: orderData.orders[i].amount,
                              date: orderData.orders[i].dateTime,
                              products: orderData.orders[i].products),
                          itemCount: orderData.orders.length,
                        )
                      : child;
                },
              );
            }
          }
        },
      ),
    );
  }
}
