import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';
import 'package:washcubes_admindashboard/src/models/order.dart';
import 'package:washcubes_admindashboard/src/models/service.dart';

class OrderItemList extends StatefulWidget {
  final List<OrderItem> orderItems;
  final Service service;
  final bool isEditing;

  const OrderItemList({
    required this.orderItems,
    required this.service,
    required this.isEditing,
    super.key,
  });

  @override
  OrderItemListState createState() => OrderItemListState();
}

class OrderItemListState extends State<OrderItemList> {
  // void initState() {
  //   super.initState();
  //   orderItems = widget.order?.orderItems ?? [];
  //   getServiceDetails();
  //   getFinalPrice();
  // }

  void addExistingOrderItems() {}

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.orderItems.length,
      itemBuilder: (context, index) {
        final item = widget.orderItems[index];
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: widget.isEditing
                      ? DropdownButton<String>(
                          isExpanded: true,
                          alignment: Alignment.center,
                          value: item.name,
                          onChanged: (newValue) {
                            // setState(() {
                            //   widget.itemDetails[index]['item'] = newValue!;
                            // });
                          },
                          items: <String>[
                            'Top',
                            'Bottom',
                            'Baju Kurung',
                            'Curtain',
                            'Bedsheet',
                            'Quilt / Comforter',
                          ].map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                alignment: Alignment.center,
                                value: value,
                                child: Text(
                                  value,
                                  style:
                                      CTextTheme.blackTextTheme.headlineMedium,
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          ).toList(),
                        )
                      : Text(
                          item.name,
                          style: CTextTheme.blackTextTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                ),
                Expanded(
                  child: Text(
                    'RM${item.price}/${item.unit}',
                    style: CTextTheme.blackTextTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: widget.isEditing
                      ? TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ], // Allow only numeric input
                          keyboardType: TextInputType
                              .number, // Set keyboard type to number
                          controller: TextEditingController(
                              text: item.quantity.toString()),
                          textAlign: TextAlign.center,
                          onChanged: (newValue) {
                            // setState(() {
                            //   widget.itemDetails[index]['quantity'] = int.tryParse(newValue) ?? 0;
                            // });
                          },
                        )
                      : Text(
                          item.quantity.toString(),
                          style: CTextTheme.blackTextTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                ),
                Expanded(
                  child: Text(
                    'RM${item.cumPrice.toStringAsFixed(2)}',
                    style: CTextTheme.blackTextTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                // Delete button
                widget.isEditing
                    ? IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete_outline_rounded,
                            color: Colors.red),
                      )
                    : const SizedBox(),
              ],
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}
