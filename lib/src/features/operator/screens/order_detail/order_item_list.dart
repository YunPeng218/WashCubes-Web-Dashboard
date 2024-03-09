import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class OrderItemList extends StatefulWidget {
  final List<Map<String, dynamic>> itemDetails;
  final bool isEditing;

  const OrderItemList({
    required this.itemDetails,
    required this.isEditing,
    super.key,
  });

  @override
  _OrderItemListState createState() => _OrderItemListState();
}

class _OrderItemListState extends State<OrderItemList> {
  
  //Get price according to item name
  double getPrice(String itemName) {
    switch (itemName) {
      case 'Top':
        return 2.00;
      case 'Bottom':
        return 2.00;
      case 'Baju Kurung':
        return 4.00;
      case 'Curtain':
        return 5.00;
      case 'Bedsheet':
        return 6.00;
      case 'Quilt / Comforter':
        return 6.00;
      default:
        return 0.0; // Default price
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.itemDetails.length,
      itemBuilder: (context, index) {
        final item = widget.itemDetails[index];
        int total = item['quantity'] * getPrice(item['item']);
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: widget.isEditing
                      ? DropdownButton<String>(
                          isExpanded: true,
                          alignment: Alignment.center,
                          value: item['item'],
                          onChanged: (newValue) {
                            setState(() {
                              widget.itemDetails[index]['item'] = newValue!;
                            });
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
                                  style: CTextTheme.blackTextTheme.headlineMedium,
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          ).toList(),
                        )
                      : Text(
                          item['item'],
                          style: CTextTheme.blackTextTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                ),
                Expanded(
                  child: Text(
                    getPrice(item['item']).toString(),
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
                          keyboardType: TextInputType.number, // Set keyboard type to number
                          controller: TextEditingController(text: item['quantity'].toString()),
                          textAlign: TextAlign.center,
                          onChanged: (newValue) {
                            setState(() {
                              widget.itemDetails[index]['quantity'] = int.tryParse(newValue) ?? 0;
                            });
                          },
                        )
                      : Text(
                          item['quantity'].toString(),
                          style: CTextTheme.blackTextTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                ),
                Expanded(
                  child: Text(
                    total.toString(),
                    style: CTextTheme.blackTextTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                // Delete button
                widget.isEditing
                    ? IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
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
