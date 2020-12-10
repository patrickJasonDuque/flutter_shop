import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductDetail extends StatelessWidget {
  static const routeName = '/product-detail';

  const ProductDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String productId = ModalRoute.of(context).settings.arguments;
    final productData = Provider.of<Products>(context, listen: false);
    final productItem = productData.findById(productId);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          title: Text(
            productItem.title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image.network(
                  productItem.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10,),
              
            ],
          ),
        ),
      ),
    );
  }
}
