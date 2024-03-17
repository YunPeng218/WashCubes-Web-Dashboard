// ignore_for_file: unnecessary_set_literal

import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/constants/sizes.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';
import 'package:washcubes_admindashboard/src/models/order.dart';
import 'package:washcubes_admindashboard/src/models/locker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:washcubes_admindashboard/config.dart';

class AdminOrderDetails extends StatefulWidget {
  final Order order;
  final String dropOffLocation;
  final String pickupLocation;
  final String serviceName;

  const AdminOrderDetails({
    super.key,
    required this.order,
    required this.serviceName,
    required this.dropOffLocation,
    required this.pickupLocation,
  });

  @override
  State<AdminOrderDetails> createState() => _AdminOrderDetailsState();
}

class _AdminOrderDetailsState extends State<AdminOrderDetails> {
  final orderStatus = 'Completed';
  // final LockerSite? dropOffSite;
  // final LockerSite? pickUpSite;
  Map<String, String> jobDetails = {};

  @override
  void initState() {
    super.initState();
    getJobDetails(widget.order.id);
  }

  Future<void> getJobDetails(String orderId) async {
    try {
      final response = await http.get(
        Uri.parse('${url}jobs/order-job-details?orderId=$orderId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('response')) {
          Map<String, dynamic> responseMap = data['response'];
          setState(() {
            responseMap.entries.forEach((element) => {
                  jobDetails[element.key] = element.value.toString(),
                });
          });
        } else {
          print('Response data does not contain services.');
        }
      } else {
        print('Error: ${response.statusCode}');
        print('Error message: ${response.body}');
      }
    } catch (error) {
      print('Error Fetching Orders: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.cancel,
              color: AppColors.cBarColor,
              size: cButtonHeight,
            ),
          ),
        ],
      ),
      content: Container(
        alignment: Alignment.center,
        width: size.width * 0.6,
        height: size.height * 0.6,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Text(
                'Order Number: ${widget.order.orderNumber}',
                style: CTextTheme.blackTextTheme.displayLarge,
              ),
              const SizedBox(
                height: 30.0,
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
                            'ORDER CREATED:',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            widget.order
                                .getFormattedDateTime(widget.order.createdAt),
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'BARCODE ID:',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            widget.order.barcodeID,
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
                            widget.order.user?.phoneNumber.toString() ??
                                'Loading...',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'LATEST STATUS:',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            widget.order.orderStage?.getMostRecentStatus() ??
                                'Loading...',
                            style: CTextTheme.blackTextTheme.headlineMedium
                                ?.copyWith(color: Colors.green),
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
                            'EXTRA DETAILS',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'ORDER ERROR',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            widget.order.orderStage?.orderError.status == false
                                ? 'NONE'
                                : widget.order.orderStage?.orderError
                                            .userRejected ==
                                        true
                                    ? 'REJECTED'
                                    : 'RESOLVED',
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
                            'DROP OFF LOCATION:',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            widget.dropOffLocation,
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'PICK UP LOCATION:',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            widget.pickupLocation,
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              //Verification Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text(
                            'ORDER DETAILS',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'SERVICE TYPE',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            widget.serviceName,
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'EST / FINAL PRICE',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: widget.order.finalPrice == 0.0
                              ? Text(
                                  'RM${widget.order.estimatedPrice.toStringAsFixed(2)}',
                                  style:
                                      CTextTheme.blackTextTheme.headlineMedium,
                                )
                              : Text(
                                  'RM${widget.order.finalPrice?.toStringAsFixed(2)}',
                                  style:
                                      CTextTheme.blackTextTheme.headlineMedium,
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                'ORDER ITEMS',
                style: CTextTheme.blackTextTheme.headlineMedium,
              ),
              const Divider(),
              //Order Item List
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'ITEM',
                        style: CTextTheme.greyTextTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      )),
                      Expanded(
                          child: Text(
                        'PRICE',
                        style: CTextTheme.greyTextTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      )),
                      Expanded(
                          child: Text(
                        'QUANTITY',
                        style: CTextTheme.greyTextTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      )),
                      Expanded(
                          child: Text(
                        'CUM. PRICE',
                        style: CTextTheme.greyTextTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      )),
                      const SizedBox(width: 45.0),
                    ],
                  ),
                  const Divider(),
                  // Order Item List
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.order.orderItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.order.orderItems[index];
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.name,
                                  style:
                                      CTextTheme.blackTextTheme.headlineMedium,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'RM${item.price.toStringAsFixed(2)}/${item.unit}',
                                  style:
                                      CTextTheme.blackTextTheme.headlineMedium,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  item.quantity.toString(),
                                  style:
                                      CTextTheme.blackTextTheme.headlineMedium,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'RM${item.cumPrice.toStringAsFixed(2)}',
                                  style:
                                      CTextTheme.blackTextTheme.headlineMedium,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  )
                ],
              ),
            ],
          ),

          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text('Order ID : #12345', style: CTextTheme.blackTextTheme.displayLarge,),
          //     Row(
          //       children: [
          //         Expanded(
          //           child: Column(
          //             children: [
          //               ListTile(
          //                 leading: Text('ORDER CREATED', style: CTextTheme.greyTextTheme.headlineMedium,),
          //                 title: Text('23 Nov 2023, 11:59', style: CTextTheme.blackTextTheme.headlineMedium,),
          //               ),
          //               ListTile(
          //                 leading: Text('DROP OFF', style: CTextTheme.greyTextTheme.headlineMedium,),
          //                 title: Text("Taylor's University 23 Nov 2023, 11:59", style: CTextTheme.blackTextTheme.headlineMedium,),
          //               ),
          //               ListTile(
          //                 leading: Text('PICK UP', style: CTextTheme.greyTextTheme.headlineMedium,),
          //                 title: Text("Taylor's University 23 Nov 2023, 11:59", style: CTextTheme.blackTextTheme.headlineMedium,),
          //               ),
          //             ],
          //           ),
          //         ),
          //         Expanded(
          //           child: Column(
          //             children: [
          //               ListTile(
          //                 leading: Text('USER ID', style: CTextTheme.greyTextTheme.headlineMedium,),
          //                 title: Text('#12232458899', style: CTextTheme.blackTextTheme.headlineMedium,),
          //               ),
          //               ListTile(
          //                 leading: Text('ITEM ID', style: CTextTheme.greyTextTheme.headlineMedium,),
          //                 title: Text('#12232458899', style: CTextTheme.blackTextTheme.headlineMedium,),
          //               ),
          //               ListTile(
          //                 leading: Text('LATEST STATUS', style: CTextTheme.greyTextTheme.headlineMedium,),
          //                 title: Text(orderStatus, style: CTextTheme.blackTextTheme.headlineMedium?.copyWith(color: _getStatusColor(orderStatus)),),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //     const Divider(height: 50.0,),
          //     Text('ORDER SUMMARY', style: CTextTheme.blackTextTheme.headlineLarge,),
          //     Row(
          //       children: [
          //         Expanded(
          //           child: Column(
          //             children: [
          //               ListTile(
          //                 leading: Text('SERVICE TYPE', style: CTextTheme.greyTextTheme.headlineMedium,),
          //                 title: Text('WashCubes', style: CTextTheme.blackTextTheme.headlineMedium,),
          //               ),
          //               ListTile(
          //                 leading: Text('ITEM / QTY', style: CTextTheme.greyTextTheme.headlineMedium,),
          //                 title: Text('Top/pcs -1 \nBottom/pcs -1 \nAll Garments/kg -5', style: CTextTheme.blackTextTheme.headlineMedium,),
          //               ),
          //             ],
          //           ),
          //         ),
          //         Expanded(
          //           child: Column(
          //             children: [
          //               ListTile(
          //                 leading: Text('SERVICE PRODUCT', style: CTextTheme.greyTextTheme.headlineMedium,),
          //                 title: Text('Dry Cleaning', style: CTextTheme.blackTextTheme.headlineMedium,),
          //               ),
          //               ListTile(
          //                 leading: Text('TOTAL ORDER PRICE', style: CTextTheme.greyTextTheme.headlineMedium,),
          //                 title: Text('RM 30.00', style: CTextTheme.blackTextTheme.headlineMedium,),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //     const Divider(height: 50.0,),
          //     Text('EN ROUTE', style: CTextTheme.blackTextTheme.headlineLarge,),
          //     Row(
          //       children: [
          //         Expanded(
          //           child: Column(
          //             children: [
          //               ListTile(
          //                 leading: Text('RIDER ID', style: CTextTheme.greyTextTheme.headlineMedium,),
          //                 title: Text('#12345', style: CTextTheme.blackTextTheme.headlineMedium,),
          //               ),
          //               ListTile(
          //                 leading: Text('COLLECTED ON', style: CTextTheme.greyTextTheme.headlineMedium,),
          //                 title: Text('23 Nov 2023, 11:59', style: CTextTheme.blackTextTheme.headlineMedium,),
          //               ),
          //               ListTile(
          //                 leading: Text('APPLY TAG', style: CTextTheme.greyTextTheme.headlineMedium,),
          //                 title: Text('Updated on 23 Nov 2023, 11:59', style: CTextTheme.blueTextTheme.headlineMedium,),
          //               ),
          //             ],
          //           ),
          //         ),
          //         Expanded(
          //           child: Column(
          //             children: [
          //               ListTile(
          //                 leading: Text('RECEIVED BY', style: CTextTheme.greyTextTheme.headlineMedium,),
          //                 title: Text('Thomas, 780129-83-****', style: CTextTheme.blackTextTheme.headlineMedium,),
          //               ),
          //               ListTile(
          //                 leading: Text('RECEIVED ON', style: CTextTheme.greyTextTheme.headlineMedium,),
          //                 title: Text('23 Nov 2023, 11:59', style: CTextTheme.blackTextTheme.headlineMedium,),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //     const Divider(height: 50.0,),
          //     Text('IN PREPARATION', style: CTextTheme.blackTextTheme.headlineLarge,),
          //     Row(
          //       children: [
          //         Expanded(
          //           child: Column(
          //             children: [
          //               ListTile(
          //                 leading: Text('OPERATOR ID', style: CTextTheme.greyTextTheme.headlineMedium,),
          //                 title: Text('#12345', style: CTextTheme.blackTextTheme.headlineMedium,),
          //               ),
          //               ListTile(
          //                 leading: Text('VERIFICATION', style: CTextTheme.greyTextTheme.headlineMedium,),
          //                 title: Text('Verification Completed', style: CTextTheme.blueTextTheme.headlineMedium,),
          //               ),
          //             ],
          //           ),
          //         ),
          //         Expanded(
          //           child: Column(
          //             children: [
          //               ListTile(
          //                 leading: Text('ERROR SETTLEMENT', style: CTextTheme.greyTextTheme.headlineMedium,),
          //                 title: Text('-', style: CTextTheme.blackTextTheme.headlineMedium,),
          //               ),
          //               ListTile(
          //                 leading: Text('STATUS', style: CTextTheme.greyTextTheme.headlineMedium,),
          //                 title: Text('-', style: CTextTheme.blackTextTheme.headlineMedium,),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //     const Divider(height: 50.0,),
          //     Text('COMPLETION', style: CTextTheme.blackTextTheme.headlineLarge,),
          //     Row(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Expanded(
          //           child: Column(
          //             children: [
          //               ListTile(
          //                 leading: Text('PREPARATION DONE', style: CTextTheme.greyTextTheme.headlineMedium,),
          //                 title: Text('23 Nov 2023, 11:59', style: CTextTheme.blackTextTheme.headlineMedium,),
          //               ),
          //             ],
          //           ),
          //         ),
          //         Expanded(
          //           child: Column(
          //             children: [
          //               ListTile(
          //                 leading: Text('RIDER ID', style: CTextTheme.greyTextTheme.headlineMedium,),
          //                 title: Text('#12345', style: CTextTheme.blackTextTheme.headlineMedium,),
          //               ),
          //               ListTile(
          //                 leading: Text('PICK UP', style: CTextTheme.greyTextTheme.headlineMedium,),
          //                 title: Text('23 Nov 2023, 11:59', style: CTextTheme.blackTextTheme.headlineMedium,),
          //               ),
          //               ListTile(
          //                 leading: Text('RETURNED', style: CTextTheme.greyTextTheme.headlineMedium,),
          //                 title: Text('23 Nov 2023, 11:59', style: CTextTheme.blackTextTheme.headlineMedium,),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }

  // Function to determine status color
  Color _getStatusColor(String orderStatus) {
    switch (orderStatus) {
      case 'Reserved':
        return Colors.grey;
      case 'Received':
        return Colors.green;
      case 'Collected':
        return Colors.green;
      case 'Process':
        return Colors.orange;
      case 'Error':
        return Colors.red;
      case 'Ready':
        return Colors.green;
      case 'Returned':
        return Colors.blue;
      case 'Ready For Collect':
        return Colors.blue;
      case 'Completed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
