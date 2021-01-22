import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // ProductDetailsScreen(this.title, this.price);
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    //gets the argument id requested in the product_item page
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    //findbyid defined in the provider method, so code is leaner like this
    //Builder doesn't always need to be rebuilt so we make listen false
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}
