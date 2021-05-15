import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';

import '../providers/products_provider.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    /*goes up the widget tree and searches through parent widgets till it 
    finds and creates a direct access to the change notifier provider of type 
    products (in main.dart) */
    final products = showFavs ? productsData.favoriteItems : productsData.items;
    //the list of items we work with
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        //defines how the grid should be structured
        itemCount: products.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              // create: (c) => products[i],
              value: products[i],
              //does'nt require context
              /*This method works better for gridsview or listview 
              because it keeps up with the recycled widgets(flutter recycles
              widgets that overflow off the screen in these builders)
               when data changes while the normal method will give errors*/
              child: ProductItem(
                  // products[i].id,
                  // products[i].title,
                  // products[i].imageUrl,
                  ),
            )
        //item builder defines how every grid item is built
        );
  }
}
