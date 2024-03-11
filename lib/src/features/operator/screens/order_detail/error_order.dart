// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/config.dart';
import 'package:washcubes_admindashboard/src/common_widgets/confirmation_popup.dart';
import 'package:washcubes_admindashboard/src/features/operator/screens/image_proof/proof_popup.dart';
import 'package:washcubes_admindashboard/src/features/operator/screens/order_detail/order_detail_popup.dart';
import 'package:washcubes_admindashboard/src/models/order.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';
import 'package:http/http.dart' as http;

class OrderError extends StatefulWidget {
  final Order? order;
  final String serviceName;
  final List<String> receiverDetails;

  const OrderError({
    super.key,
    required this.order,
    required this.serviceName,
    required this.receiverDetails,
  });

  @override
  OrderErrorState createState() => OrderErrorState();
}

class OrderErrorState extends State<OrderError> {
  @override
  void initState() {
    super.initState();
  }

    //Confirmation Pop Up
  Future<String?> showConfirmationDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return const ConfirmationPopUp();
      },
    );
  }

  Future<void> confirmProcessingComplete() async {
    try {
      final Map<String, dynamic> data = {'orderId': widget.order?.id};
      final response = await http.post(
        Uri.parse('${url}orders/operator/confirm-processing-complete'),
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
                'Processing Complete',
                textAlign: TextAlign.center,
              ),
              content: Text(
                'The order status for Order ${widget.order?.orderNumber} has been set to Processing Complete.',
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      //Back button
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
              //TODO: Change order ID to be dynamic
              Text(
                'Order Number: ${widget.order?.orderNumber ?? 'Loading...'}',
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
                            'ORDER RECEIVED',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            '${widget.order?.orderStage?.inProgress.dateUpdated ?? 'Loading...'}',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'BARCODE ID',
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
                            'USER PHONE NUMBER',
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
                            'LATEST STATUS',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            widget.order?.orderStage?.getInProgressStatus() ?? 'Loading...',
                            style: CTextTheme.blackTextTheme.headlineMedium?.copyWith(
                              color: widget.order?.orderStage?.getInProgressStatus() == 'Order Error'
                                  ? Colors.red
                                  : null,
                            ),
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
                            'DATE / TIME',
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
                            'RECEIVER NAME',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            widget.receiverDetails[0],
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'RECEIVED IC',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            widget.receiverDetails[1],
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
                            'ESTIMATED PRICE',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            'RM${(widget.order!.estimatedPrice).toStringAsFixed(2)}',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'FINAL PRICE',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            'RM${(widget.order!.finalPrice!).toStringAsFixed(2)}',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'PRICE DIFFERENCE',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            '-RM${(widget.order!.finalPrice! - widget.order!.estimatedPrice).toStringAsFixed(2)}',
                            style: CTextTheme.redTextTheme.headlineMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text(
                            'ERROR SETTLEMENT',
                            style:
                                CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'STATUS',
                            style:
                                CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: widget.order!.orderStage!.orderError.userRejected
                              ? Text(
                                  'Declined',
                                  style: CTextTheme
                                      .redTextTheme.headlineMedium,
                                )
                              : Text(
                                  'Waiting For User Decision',
                                  style: CTextTheme
                                      .greyTextTheme.headlineMedium,
                                ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                          //Proof button
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const ImageProof(); // Proceed to Ready Stage
                              },
                            );
                          },
                          child: Text(
                            'Proof',
                            style:
                                CTextTheme.blackTextTheme.headlineMedium,
                          )),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Visibility(
                        visible: widget.order!.orderStage!.orderError.userRejected,
                        child: ElevatedButton(
                          onPressed: () async {
                            final result = await showConfirmationDialog(context);
                            if (result == 'Confirm') {
                              confirmProcessingComplete();
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const OrderDetailPopUp(
                                    orderStatus: 'Returned',
                                  );
                                },
                              );
                            }
                          },
                          child: Text(
                            'Return',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10.0),
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
                    ],
                  ),
                  const Divider(),
                  // Order Item List
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.order!.orderItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.order!.orderItems[index];
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageDisplayDialog extends StatefulWidget {
  final List<String>? imageUrls;

  const ImageDisplayDialog({Key? key, this.imageUrls}) : super(key: key);

  @override
  _ImageDisplayDialogState createState() => _ImageDisplayDialogState();
}

class _ImageDisplayDialogState extends State<ImageDisplayDialog> {
  int currentIndex = 0;

  void nextImage() {
    setState(() {
      if (currentIndex < (widget.imageUrls?.length ?? 0) - 1) {
        currentIndex++;
      }
    });
  }

  void previousImage() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Proof Image ${currentIndex + 1} of ${widget.imageUrls?.length}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            if (widget.imageUrls != null && widget.imageUrls!.isNotEmpty)
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 600,
                    width: 500,
                    child: Image.network(
                      widget.imageUrls![currentIndex],
                      fit: BoxFit.contain,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: previousImage,
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: nextImage,
                      ),
                    ],
                  ),
                ],
              ),
            SizedBox(height: 10.0),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.blue[100]!)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}