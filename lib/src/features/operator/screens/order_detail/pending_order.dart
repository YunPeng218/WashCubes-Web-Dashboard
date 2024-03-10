// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/models/order.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:washcubes_admindashboard/config.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

//import './edit_order_details.dart';

class PendingOrder extends StatefulWidget {
  final Order? order;
  final String serviceName;

  const PendingOrder({
    super.key,
    required this.order,
    required this.serviceName,
  });

  @override
  State<PendingOrder> createState() => PendingOrderState();
}

class PendingOrderState extends State<PendingOrder> {
  Color statusColor = Colors.grey;

  Future<void> approveOrder() async {
    if (widget.order != null) {
      try {
        final Map<String, dynamic> data = {'orderId': widget.order?.id};
        final response = await http.post(
          Uri.parse('${url}orders/operator/approve-order-details'),
          body: json.encode(data),
          headers: {'Content-Type': 'application/json'},
        );
        if (response.statusCode == 200) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Verification Complete',
                  textAlign: TextAlign.center,
                ),
                content: Text(
                  'The order items for Order ${widget.order?.orderNumber} has been verified.',
                  textAlign: TextAlign.center,
                  // style: CTextTheme.blackTextTheme.headlineSmall,
                ),
                actions: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Nice!',
                            //style: CTextTheme.blackTextTheme.headlineSmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        }
      } catch (error) {
        print('Error approve order details: $error');
      }
    }
  }

  void showEditOrderDialog() {
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return EditPendingOrder(
    //         order: widget.order, serviceName: widget.serviceName);
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orderItems = widget.order?.orderItems;
    return AlertDialog(
      icon: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the alert dialog
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
        ],
      ),
      content: SizedBox(
        width: size.width * 0.6,
        height: size.height * 0.6,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Order Number: ${widget.order?.orderNumber ?? 'Loading...'}',
                style: CTextTheme.blackTextTheme.displayLarge,
              ),
              //Order Detail Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text(
                            'ORDER RECEIVED:',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            '${widget.order?.orderStage?.inProgress.dateUpdated ?? 'Loading...'}',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'OPERATOR ID:',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            'To Implement',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'BARCODE ID:',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            widget.order?.barcodeID ?? 'Loading...',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text(
                            'USER PHONE NUMBER:',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            widget.order?.user?.phoneNumber.toString() ??
                                'Loading...',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'SERVICE TYPE:',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            widget.serviceName,
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'LATEST STATUS',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            widget.order?.orderStage?.getInProgressStatus() ??
                                'Loading...',
                            style: CTextTheme.blackTextTheme.headlineMedium
                                ?.copyWith(color: statusColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              //Receiving Detail Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text(
                            'RECEIVING DETAILS',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'DATE / TIME:',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            '${widget.order?.orderStage?.inProgress.dateUpdated ?? 'Loading...'}',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text(
                            'RIDER ID:',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            'To Implement',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'RECEIVED BY:',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            'To Implement',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
            ],
          ),
        ),
      ),
      // content: Column(
      //   children: [
      //     const SizedBox(height: 20.0),
      //     Row(
      //       children: [
      //         Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text('Receiving Details'),
      //             Text('Date / Time:'),
      //           ],
      //         ),
      //         const SizedBox(width: 100.0),
      //         Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text('Rider ID:'),
      //             Text('Received By:'),
      //           ],
      //         ),
      //       ],
      //     ),
      //     const Divider(),
      //     const Text('Verification'),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Column(
      //           children: [
      //             Text('Service Type: ${widget.serviceName}'),
      //             Text(
      //                 'Payment Price: RM${widget.order?.estimatedPrice.toStringAsFixed(2)}'),
      //           ],
      //         ),
      //         const SizedBox(width: 100.0),
      //         Row(
      //           children: [
      //             ElevatedButton(
      //                 onPressed: showEditOrderDialog, child: Text('Edit')),
      //             ElevatedButton(
      //                 onPressed: () async {
      //                   await approveOrder();
      //                 },
      //                 child: Text('Approve')),
      //           ],
      //         ),
      //       ],
      //     ),
      //     const SizedBox(height: 20.0),
      //     orderItems != null
      //         ? Container(
      //             height: 300,
      //             width: 800,
      //             child: ListView.builder(
      //               itemCount: orderItems.length,
      //               itemBuilder: (context, index) {
      //                 return Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                   children: [
      //                     Text(orderItems[index].name),
      //                     Text(
      //                         '${orderItems[index].price}/${orderItems[index].unit}'),
      //                     Text(orderItems[index].quantity.toString()),
      //                     Text(orderItems[index].cumPrice.toStringAsFixed(2)),
      //                   ],
      //                 );
      //               },
      //             ),
      //           )
      //         : Text('Loading...')
      //   ],
      // ),
      actions: <Widget>[
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue[100]!)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Back',
                      //style: CTextTheme.blackTextTheme.headlineSmall,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ],
    );
  }
}
