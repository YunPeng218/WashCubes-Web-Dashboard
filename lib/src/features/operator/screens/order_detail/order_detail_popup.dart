import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:washcubes_admindashboard/src/common_widgets/confirmation_popup.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/features/operator/screens/image_proof/proof_popup.dart';
import 'package:washcubes_admindashboard/src/features/operator/screens/image_proof/upload_image_popup.dart';
import 'package:washcubes_admindashboard/src/features/operator/screens/order_detail/order_item_list.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class OrderDetailPopUp extends StatefulWidget {
  final String orderStatus;
  const OrderDetailPopUp({
    super.key,
    required this.orderStatus,
  });

  @override
  State<OrderDetailPopUp> createState() => _OrderDetailPopUpState();
}

class _OrderDetailPopUpState extends State<OrderDetailPopUp> {
  // Order item list data
  final List<Map<String, dynamic>> itemDetails = [
    {'item': 'Top', 'price': 2.00, 'quantity': 5, 'total price': 10.00},
    {'item': 'Bottom', 'price': 2.00, 'quantity': 3, 'total price': 6.00},
    {'item': 'Baju Kurung', 'price': 4.00, 'quantity': 1, 'total price': 4.00},
  ];

  String get orderStatus => widget.orderStatus; //Get order status
  Color statusColor = Colors.grey; // Default status color
  bool verifStatusVisible = false; // Flag to track ListTile visibility
  bool buttonsVisible = true; // Flag to track button visibility
  bool errorStatus = true; // Error status

  void changeOrderStatus(orderStatus) {
    setState(() {
      switch (orderStatus) {
        case 'Processing':
          statusColor = Colors.orange; // Change status color accordingly
          buttonsVisible = false; // Hide the buttons
          isEditing = false;
          break;
        case 'Order Error':
          statusColor = Colors.red;
          buttonsVisible = false; // Hide the buttons
          isEditing = false;
          break;
        case 'Ready':
          statusColor = Colors.green;
          buttonsVisible = false; // Hide the buttons
          isEditing = false;
          break;
        case 'Returned':
          statusColor = Colors.blue;
          buttonsVisible = false; // Hide the buttons
          isEditing = false;
          break;
        default:
          statusColor = Colors.grey;
          buttonsVisible = true; // Hide the buttons
          break;
      }

      verifStatusVisible = true; // ShHow verification status
    });
  }

  bool isEditing = false;
  void editItem(int index) {
    setState(() {
      isEditing = true;
      itemDetails[index]['item'] =
          ''; // Set the item data to an empty string to hide the text
    });
  }

  //Add Item
  void addItem() {
    setState(() {
      itemDetails.add({
        'item': 'Top',
        'price': 2.00,
        'quantity': 0,
        'total price': 0.0,
      });
    });
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    changeOrderStatus(orderStatus);
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
                'Order ID : #0000',
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
                            'ORDER RECEIVED',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            '23 Nov 2023, 14:34',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'OPERATOR ID',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            '#337932',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'ITEM ID',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            '#123456789',
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
                            'USER ID',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            '#906010912023',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'SERVICE TYPE',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            'Dry Cleaning',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'LATEST STATUS',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            orderStatus,
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
                            'DATE / TIME',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            '23 Nov 2023, 14:34',
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
                            'RIDER ID',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            '1911109579612',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'RECEIVED BY',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            'Thomas',
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
                            'VERIFICATION',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        if (orderStatus !=
                            'Pending') // Render verification status if approved
                          ListTile(
                            leading: Text(
                              'STATUS',
                              style: CTextTheme.greyTextTheme.headlineMedium,
                            ),
                            title: orderStatus == 'Order Error'
                                ? Text(
                                    'Verification Error',
                                    style:
                                        CTextTheme.redTextTheme.headlineMedium,
                                  )
                                : Text(
                                    'Verified',
                                    style:
                                        CTextTheme.blueTextTheme.headlineMedium,
                                  ),
                          ),
                        ListTile(
                          leading: Text(
                            'SERVICE TYPE',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            'Dry Cleaning',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                        ListTile(
                          leading: Text(
                            'PAYMENT PRICE',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            'RM 20.00',
                            style: orderStatus == 'Order Error'
                                ? CTextTheme.redTextTheme.headlineMedium
                                : CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(children: [
                    if (buttonsVisible) // Render buttons if visible
                      //Edit Button
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isEditing = !isEditing;
                            });
                          },
                          child: Text(
                            isEditing ? 'Cancel' : 'Edit',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          )),
                    const SizedBox(
                      width: 10.0,
                    ),
                    // If editing mode is on,
                    isEditing
                        //Update Button
                        ? ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const UploadImagePopUp();
                                },
                              );
                            },
                            child: Text(
                              'Update',
                              style: CTextTheme.blackTextTheme.headlineMedium,
                            ))
                        // Approve Button
                        : orderStatus == 'Pending'
                            ? ElevatedButton(
                                onPressed: () async {
                                  final result = await showConfirmationDialog(
                                      context); //Ask for confirmation
                                  if (result == 'Confirm') {
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const OrderDetailPopUp(
                                          orderStatus: 'Processing',
                                        ); // Proceed to Process Stage
                                      },
                                    );
                                  }
                                },
                                child: Text(
                                  'Approve',
                                  style:
                                      CTextTheme.blackTextTheme.headlineMedium,
                                ))
                            : orderStatus == 'Processing'
                                // Complete Process Button
                                ? ElevatedButton(
                                    onPressed: () async {
                                      final result =
                                          await showConfirmationDialog(
                                              context); //Ask for confirmation
                                      if (result == 'Confirm') {
                                        Navigator.pop(context);
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const OrderDetailPopUp(
                                              orderStatus: 'Ready',
                                            ); // Proceed to Ready Stage
                                          },
                                        );
                                      }
                                    },
                                    child: Text(
                                      'Complete Process',
                                      style: CTextTheme
                                          .blackTextTheme.headlineMedium,
                                    ))
                                : const SizedBox(),
                  ]),
                ],
              ),
              const Divider(),
              //Error Settlement Row If Encounter Error
              orderStatus == 'Order Error'
                  ? Row(
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
                                title: errorStatus
                                    ? Text(
                                        'Accepted',
                                        style: CTextTheme
                                            .blueTextTheme.headlineMedium,
                                      )
                                    : Text(
                                        'Declined',
                                        style: CTextTheme
                                            .redTextTheme.headlineMedium,
                                      ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            //TODO: Testing Purpose, when user respond recorded put here ig
                            OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    errorStatus = !errorStatus;
                                  });
                                },
                                child: Text('Switch Status')),
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
                            errorStatus
                                ? ElevatedButton(
                                    //Proceed button
                                    onPressed: () async {
                                      final result =
                                          await showConfirmationDialog(
                                              context); //Ask for confirmation
                                      if (result == 'Confirm') {
                                        Navigator.pop(context);
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const OrderDetailPopUp(
                                              orderStatus: 'Processing',
                                            ); // Proceed to Process Stage
                                          },
                                        );
                                      }
                                    },
                                    child: Text(
                                      'Proceed',
                                      style: CTextTheme
                                          .blackTextTheme.headlineMedium,
                                    ))
                                : ElevatedButton(
                                    //Return button
                                    onPressed: () async {
                                      final result =
                                          await showConfirmationDialog(
                                              context); //Ask for confirmation
                                      if (result == 'Confirm') {
                                        Navigator.pop(context);
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const OrderDetailPopUp(
                                              orderStatus: 'Returned',
                                            ); // Proceed to Process Stage
                                          },
                                        );
                                      }
                                    },
                                    child: Text(
                                      'Return',
                                      style: CTextTheme
                                          .blackTextTheme.headlineMedium,
                                    )),
                          ],
                        )
                      ],
                    )
                  : const SizedBox(),
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
                        'TOTAL PRICE',
                        style: CTextTheme.greyTextTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      )),
                    ],
                  ),
                  const Divider(),
                  // OrderItemList(
                  //   isEditing: isEditing,
                  //   itemDetails: itemDetails,
                  // ),
                  // Add item button
                  isEditing
                      ? ListTile(
                          leading: const Icon(
                            Icons.add,
                            color: AppColors.cBlackColor,
                          ),
                          title: Text(
                            'ADD',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                          onTap: addItem,
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
