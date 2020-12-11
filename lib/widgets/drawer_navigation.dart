import 'package:flutter/material.dart';
import '../screens/orders.dart';
import '../screens/products_overview.dart';

class DrawerNavigation extends StatelessWidget {
  const DrawerNavigation({Key key}) : super(key: key);

  Widget buildDrawerItem(
      BuildContext ctx, String text, IconData icon, Function tabHandler) {
    return InkWell(
      highlightColor: Theme.of(ctx).accentColor,
      onTap: tabHandler,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: Icon(
                icon,
                color: Colors.indigoAccent[100],
                size: 35,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(ctx).primaryColorDark),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Theme.of(context).accentColor,
              height: MediaQuery.of(context).size.height * .2,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_basket_outlined,
                        size: 40, color: Theme.of(context).primaryColorDark),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Shop Now',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            buildDrawerItem(context, 'Products', Icons.category, () {
              Navigator.of(context)
                  .pushReplacementNamed(ProductsOverview.routeName);
            }),
            buildDrawerItem(context, 'Orders', Icons.shopping_bag, () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            })
          ],
        ),
      ),
    );
  }
}
