import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/models/order.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class ReadyOrder extends StatefulWidget {
  final Order? order;
  final String serviceName;
  final List<String> receiverDetails;

  const ReadyOrder({
    super.key,
    required this.order,
    required this.serviceName,
    required this.receiverDetails,
  });

  @override
  State<ReadyOrder> createState() => ReadyOrderState();
}

class ReadyOrderState extends State<ReadyOrder> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AlertDialog(
      icon: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
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
                            'LATEST STATUS:',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            widget.order?.orderStage?.getInProgressStatus() ??
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
                            'RECEIVER NAME:',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            widget.receiverDetails[0],
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'RECEIVER IC:',
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
                            'FINAL PRICE',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            'RM${widget.order!.finalPrice?.toStringAsFixed(2)}',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
