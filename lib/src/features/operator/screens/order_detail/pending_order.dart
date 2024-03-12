// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:washcubes_admindashboard/src/models/order.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:washcubes_admindashboard/config.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';
import 'package:washcubes_admindashboard/src/models/service.dart';
import 'package:file_picker/file_picker.dart';

class PendingOrder extends StatefulWidget {
  final Order? order;
  final String serviceName;
  final List<String> receiverDetails;

  const PendingOrder({
    super.key,
    required this.order,
    required this.serviceName,
    required this.receiverDetails,
  });

  @override
  State<PendingOrder> createState() => PendingOrderState();
}

class PendingOrderState extends State<PendingOrder> {
  Color statusColor = Colors.grey;
  bool isEditing = false;

  Map<String, int> updatedOrderItems = {};
  Service? service;
  ServiceItem? selectedItem;
  List<OrderItem> orderItems = [];
  List<Uint8List> fileBytesList = [];
  List<String> fileNamesList = [];
  List<String> imagesUrl = [];

  @override
  void initState() {
    super.initState();
    orderItems = widget.order?.orderItems ?? [];
    getServiceDetails();
    getFinalPrice();
  }

  double getFinalPrice() {
    double finalPrice = 0.0;
    if (service != null) {
      updatedOrderItems.forEach((itemId, quantity) {
        ServiceItem? item;
        for (var serviceItem in service!.items) {
          if (serviceItem.id == itemId) {
            item = serviceItem;
            break;
          }
        }

        if (item != null) {
          finalPrice += item.price * quantity;
        }
      });
    }
    return finalPrice;
  }

  double updateEstimatedPrice() {
    double estimatedPrice = 0.0;
    if (selectedItem != null) {
      int quantity = updatedOrderItems[selectedItem?.id] ?? 0;
      estimatedPrice = (selectedItem?.price ?? 0) * quantity;
    }
    return estimatedPrice;
  }

  Future<void> getServiceDetails() async {
    try {
      final response = await http.get(
        Uri.parse('${url}services/${widget.order?.serviceId}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('service')) {
          final dynamic serviceData = data['service'];
          final Service fetchedService = Service.fromJson(serviceData);
          print(fetchedService);
          setState(() {
            service = fetchedService;
          });

          for (var orderItem in widget.order!.orderItems) {
            ServiceItem item = service!.items
                .firstWhere((item) => item.name == orderItem.name);
            updatedOrderItems[item.id] = orderItem.quantity;
          }
        }
      }
    } catch (error) {
      print('Error getting service details: $error');
    }
  }

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
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Verification Complete',
                  textAlign: TextAlign.center,
                  style: CTextTheme.blackTextTheme.headlineLarge,
                ),
                content: Text(
                  'The order items for Order ${widget.order?.orderNumber} has been verified.',
                  textAlign: TextAlign.center,
                  style: CTextTheme.blackTextTheme.headlineSmall,
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
                            style: CTextTheme.blackTextTheme.headlineSmall,
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

  Future<void> editOrderDetails() async {
    if (widget.order != null) {
      try {
        double finalPrice = getFinalPrice();
        final Map<String, dynamic> data = {
          'orderId': widget.order?.id,
          'orderItems': orderItems.map((item) => item.toJson()).toList(),
          'finalPrice': finalPrice,
          'proofPicUrl': jsonEncode(imagesUrl)
        };
        final response = await http.patch(
          Uri.parse('${url}orders/operator/edit-order-details'),
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
                  'Order Details Updated',
                  textAlign: TextAlign.center,
                  style: CTextTheme.blackTextTheme.headlineLarge,
                ),
                content: Text(
                  'The final order price is RM$finalPrice. The user has been notified of the order error.',
                  textAlign: TextAlign.center,
                  style: CTextTheme.blackTextTheme.headlineSmall,
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
                            'OK',
                            style: CTextTheme.blackTextTheme.headlineSmall,
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
        print('Error Edit order details: $error');
      }
    }
  }

  Future<void> selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result != null) {
      for (var pickedFile in result.files) {
        Uint8List? fileBytes = pickedFile.bytes;
        var fileName = pickedFile.name;
        if (fileBytes != null) {
          fileBytesList.add(fileBytes);
          setState(() {
            fileNamesList.add(fileName);
          });
        }
      }
    }
  }

  Future<void> uploadImage() async {
    for (int index = 0; index < fileBytesList.length; index++) {
      try {
        final url =
            Uri.parse('https://api.cloudinary.com/v1_1/ddweldfmx/upload');
        final request = http.MultipartRequest('POST', url)
          ..fields['upload_preset'] = 'xcbbr3ok'
          ..files.add(
            http.MultipartFile.fromBytes(
              'file',
              fileBytesList[index],
              filename: fileNamesList[index],
            ),
          );
        final response = await request.send();
        if (response.statusCode == 200) {
          final responseData = await response.stream.toBytes();
          final responseString = utf8.decode(responseData);
          final jsonMap = jsonDecode(responseString);
          final url = jsonMap['url'];
          imagesUrl.add(url);
        }
      } catch (error) {
        print('Error uploading image: $error');
      }
    }
  }

  void addOrderItem() {
    if (selectedItem == null || selectedItem?.id == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'No Items Selected.',
              style: CTextTheme.blackTextTheme.headlineLarge,
            ),
            content: Text(
              'Please select some items to proceed.',
              style: CTextTheme.blackTextTheme.headlineSmall,
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: CTextTheme.blackTextTheme.headlineSmall,
                ),
              ),
            ],
          );
        },
      );
      return;
    }
    int quantity = updatedOrderItems[selectedItem?.id] ?? 0;
    if (quantity > 0) {
      OrderItem newItem = OrderItem(
        id: selectedItem?.id ?? 'N/A',
        name: selectedItem?.name ?? 'N/A',
        unit: selectedItem?.unit ?? 'N/A',
        price: selectedItem?.price ?? 0,
        quantity: quantity,
        cumPrice: updateEstimatedPrice(), // Ensure cumPrice is not null
      );
      setState(() {
        orderItems.add(newItem);
        selectedItem = null;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Zero Quantity Selected.',
              style: CTextTheme.blackTextTheme.headlineLarge,
            ),
            content: Text(
              'Please select a non-zero quantity.',
              style: CTextTheme.blackTextTheme.headlineSmall,
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: CTextTheme.blackTextTheme.headlineSmall,
                ),
              ),
            ],
          );
        },
      );
    }
  }

  String getFormattedDateTime(String? dateString) {
    if (dateString == null) {
      return 'Loading...';
    }
    DateTime dateTime = DateTime.parse(dateString);
    const timeZoneOffset = Duration(hours: 8);
    dateTime = dateTime.add(timeZoneOffset);
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    String formattedTime = DateFormat('HH:mm').format(dateTime);
    return '$formattedDate, $formattedTime';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                            getFormattedDateTime(widget.order?.createdAt.toString()),
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
                            getFormattedDateTime(widget.order?.orderStage?.inProgress.dateUpdated?.toString()),
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
                        if (widget.order!.orderStage?.getInProgressStatus() !=
                            'Pending') // Render verification status if approved
                          ListTile(
                            leading: Text(
                              'STATUS',
                              style: CTextTheme.greyTextTheme.headlineMedium,
                            ),
                            title: Text(
                              'Pending',
                              style: CTextTheme.redTextTheme.headlineMedium,
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
                            'PAYMENT PRICE',
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                          title: Text(
                            'RM${widget.order?.estimatedPrice}',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(children: [
                    // Render buttons if visible
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
                        ? Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    await selectImage();
                                  },
                                  child: Text(
                                    'Upload Proof',
                                    style: CTextTheme
                                        .blackTextTheme.headlineMedium,
                                  )),
                              const SizedBox(
                                width: 10.0,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    await uploadImage();
                                    await editOrderDetails();
                                  },
                                  child: Text(
                                    'Update',
                                    style: CTextTheme
                                        .blackTextTheme.headlineMedium,
                                  )),
                            ],
                          )
                        // Approve Button
                        : ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Approve This Order For Processing?',
                                      textAlign: TextAlign.center,
                                      style: CTextTheme
                                          .blackTextTheme.headlineLarge,
                                    ),
                                    actions: <Widget>[
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.red[100]!),
                                              ),
                                              child: Text(
                                                'Cancel',
                                                style: CTextTheme.blackTextTheme
                                                    .headlineSmall,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10.0),
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                await approveOrder();
                                              },
                                              child: Text(
                                                'Confirm',
                                                style: CTextTheme.blackTextTheme
                                                    .headlineSmall,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text(
                              'Approve',
                              style: CTextTheme.blackTextTheme.headlineMedium,
                            ))
                  ]),
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
                    ],
                  ),
                  const Divider(),
                  // Order Item List
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: orderItems.length,
                    itemBuilder: (context, index) {
                      final item = orderItems[index];
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
                              isEditing
                                  ? Expanded(
                                      child: Center(
                                        child: QuantitySelector(
                                            initialQuantity:
                                                orderItems[index].quantity,
                                            onChanged: (quantity) {
                                              setState(() {
                                                updatedOrderItems[
                                                        orderItems[index].id] =
                                                    quantity;
                                              });
                                            }),
                                      ),
                                    )
                                  : Expanded(
                                      child: Text(
                                        item.quantity.toString(),
                                        style: CTextTheme
                                            .blackTextTheme.headlineMedium,
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
                              // Delete button
                              isEditing
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          orderItems.removeAt(index);
                                        });
                                      },
                                      icon: const Icon(
                                          Icons.delete_outline_rounded,
                                          color: Colors.red),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                  // Add item button
                  isEditing
                      ? Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButton<ServiceItem>(
                                    isExpanded: true,
                                    alignment: Alignment.center,
                                    value: selectedItem,
                                    onChanged: (ServiceItem? newValue) {
                                      setState(() {
                                        selectedItem = newValue;
                                      });
                                    },
                                    hint: Text(
                                      'Select Items',
                                      style: CTextTheme
                                          .greyTextTheme.headlineMedium,
                                    ),
                                    items: service?.items
                                        .where((item) => !orderItems.any(
                                            (orderItem) =>
                                                orderItem.name == item.name))
                                        .map<DropdownMenuItem<ServiceItem>>(
                                            (ServiceItem item) {
                                      return DropdownMenuItem<ServiceItem>(
                                        value: item,
                                        child: Text(item.name),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                selectedItem != null
                                    ? Expanded(
                                        child: Text(
                                          'RM${selectedItem?.price.toStringAsFixed(2)}/${selectedItem?.unit}',
                                          style: CTextTheme
                                              .blackTextTheme.headlineMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    : Expanded(
                                        child: Text(
                                          'RM0.00/unit',
                                          style: CTextTheme
                                              .blackTextTheme.headlineMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                Expanded(
                                  child: Center(
                                    child: QuantitySelector(
                                        initialQuantity: 0,
                                        onChanged: (quantity) {
                                          setState(() {
                                            if (selectedItem != null) {
                                              updatedOrderItems[
                                                  selectedItem?.id ??
                                                      'N/A'] = quantity;
                                            }
                                          });
                                        }),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'RM${updateEstimatedPrice().toStringAsFixed(2)}',
                                    style: CTextTheme
                                        .blackTextTheme.headlineMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                // Delete button
                                IconButton(
                                  onPressed: addOrderItem,
                                  icon: const Icon(Icons.add,
                                      color: AppColors.cBlueColor3),
                                )
                              ],
                            ),
                            const Divider(),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
              if (fileNamesList.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30.0,
                    ),
                    RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          TextSpan(
                            text: 'SELECTED IMAGE FILES: ',
                            style: CTextTheme.blackTextTheme.headlineMedium,
                          ),
                          TextSpan(
                            text: fileNamesList.join(', '),
                            style: CTextTheme.greyTextTheme.headlineMedium,
                          ),
                        ],
                      ),
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

class QuantitySelector extends StatefulWidget {
  final int initialQuantity;
  final Function(int) onChanged;

  const QuantitySelector(
      {super.key, required this.initialQuantity, required this.onChanged});

  @override
  QuantitySelectorState createState() => QuantitySelectorState();
}

class QuantitySelectorState extends State<QuantitySelector> {
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            if (quantity > 0) {
              setState(() {
                quantity--;
                widget.onChanged(quantity);
              });
            }
          },
        ),
        Text(
          '$quantity',
          //style: CTextTheme.blackTextTheme.headlineSmall,
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              quantity++;
              widget.onChanged(quantity);
            });
          },
        ),
      ],
    );
  }
}
