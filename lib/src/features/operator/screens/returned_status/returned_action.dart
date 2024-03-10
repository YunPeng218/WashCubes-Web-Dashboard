import 'package:flutter/material.dart';

class OrderDetailsPage extends StatelessWidget {
  final String orderId; // Pass the order ID when navigating to this page
  final Map<String, dynamic> orderData; // Assume this comes from your data source

  OrderDetailsPage({Key? key, required this.orderId, required this.orderData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order ID : #$orderId'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('ORDER RECEIVED'),
            subtitle: Text(orderData['dateReceived']),
            trailing: Text(orderData['orderStatus']),
          ),
          Divider(),
          ListTile(
            title: Text('ORDER ID'),
            subtitle: Text(orderData['orderId']),
          ),
          ListTile(
            title: Text('TAG ID'),
            subtitle: Text(orderData['tagId']),
          ),
          ListTile(
            title: Text('USER ID'),
            subtitle: Text(orderData['userId']),
          ),
          ListTile(
            title: Text('SERVICE TYPE'),
            subtitle: Text(orderData['serviceType']),
          ),
          ListTile(
            title: Text('PAYMENT PRICE'),
            subtitle: Text('${orderData['paymentPrice']}'),
          ),
          Divider(),
          ListTile(
            title: Text('RECEIVING DETAILS'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('DATE / TIME'),
                Text(orderData['receivingDateTime']),
                SizedBox(height: 10),
                Text('RIDER ID'),
                Text(orderData['riderId']),
                SizedBox(height: 10),
                Text('RECEIVED BY'),
                Text(orderData['receivedBy']),
              ],
            ),
          ),
          Divider(),
          ListTile(
            title: Text('VERIFICATION'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('STATUS'),
                Text(orderData['verificationStatus']),
              ],
            ),
          ),
          // Add more details and styling as needed...
        ],
      ),
    );
  }
}
