import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future _orderFuture;

  Future _obtainOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    _orderFuture = _obtainOrdersFuture();
    super.initState();
  }
  // var _isLoading = false;

  // @override
  // void initState() {
  // Future.delayed(Duration.zero).then((_) async {

  // _isLoading = true;
  // Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_) {
  //   setState(() {
  //     _isLoading = false;
  //   });
  // });
  //doesn't return future by default so don't use async

  //This can be async because it's just a function. Don't use on initstate
  //listen: false apparently lets this work without using delayed...

  //   super.initState(); //other method instead of using didchangedependency
  // }

  /*Commented out because I used Future builder as an alternative to making
  stateful widget + using initState. Converted back to Stateless Widget */

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    /*Since code was refactored to use FutureBuilder, setting up a listener
    here causes infinite loop i.e When fetch and set runs, this builder
    refreshes and runs fetch and set again because of listener. So consumer
    was used here instead */
    print('Building orders'); //Print Statement to check infinite loop if exists
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _orderFuture,
        /*Be careful with this line of code because if anything causes build to 
        rerun, A new future will be obtained here and cause the http req to
        resend. So if there is any state changing logic, use stateful widget.
        Actually for better code ethiquette, I moved logic to state.*/
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              //do error handling
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
