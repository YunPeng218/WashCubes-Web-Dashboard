import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/constants/sizes.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class AdminOrderDetails extends StatefulWidget {
  const AdminOrderDetails({super.key});

  @override
  State<AdminOrderDetails> createState() => _AdminOrderDetailsState();
}

class _AdminOrderDetailsState extends State<AdminOrderDetails> {
  final orderStatus = 'Completed';
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
            icon: const Icon(Icons.cancel, color: AppColors.cBarColor,size: cButtonHeight,),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Order ID : #12345', style: CTextTheme.blackTextTheme.displayLarge,),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text('ORDER CREATED', style: CTextTheme.greyTextTheme.headlineMedium,),
                          title: Text('23 Nov 2023, 11:59', style: CTextTheme.blackTextTheme.headlineMedium,),
                        ),
                        ListTile(
                          leading: Text('DROP OFF', style: CTextTheme.greyTextTheme.headlineMedium,),
                          title: Text("Taylor's University 23 Nov 2023, 11:59", style: CTextTheme.blackTextTheme.headlineMedium,),
                        ),
                        ListTile(
                          leading: Text('PICK UP', style: CTextTheme.greyTextTheme.headlineMedium,),
                          title: Text("Taylor's University 23 Nov 2023, 11:59", style: CTextTheme.blackTextTheme.headlineMedium,),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text('USER ID', style: CTextTheme.greyTextTheme.headlineMedium,),
                          title: Text('#12232458899', style: CTextTheme.blackTextTheme.headlineMedium,),
                        ),
                        ListTile(
                          leading: Text('ITEM ID', style: CTextTheme.greyTextTheme.headlineMedium,),
                          title: Text('#12232458899', style: CTextTheme.blackTextTheme.headlineMedium,),
                        ),
                        ListTile(
                          leading: Text('LATEST STATUS', style: CTextTheme.greyTextTheme.headlineMedium,),
                          title: Text(orderStatus, style: CTextTheme.blackTextTheme.headlineMedium?.copyWith(color: _getStatusColor(orderStatus)),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 50.0,),
              Text('ORDER SUMMARY', style: CTextTheme.blackTextTheme.headlineLarge,),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text('SERVICE TYPE', style: CTextTheme.greyTextTheme.headlineMedium,),
                          title: Text('WashCubes', style: CTextTheme.blackTextTheme.headlineMedium,),
                        ),
                        ListTile(
                          leading: Text('ITEM / QTY', style: CTextTheme.greyTextTheme.headlineMedium,),
                          title: Text('Top/pcs -1 \nBottom/pcs -1 \nAll Garments/kg -5', style: CTextTheme.blackTextTheme.headlineMedium,),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text('SERVICE PRODUCT', style: CTextTheme.greyTextTheme.headlineMedium,),
                          title: Text('Dry Cleaning', style: CTextTheme.blackTextTheme.headlineMedium,),
                        ),
                        ListTile(
                          leading: Text('TOTAL ORDER PRICE', style: CTextTheme.greyTextTheme.headlineMedium,),
                          title: Text('RM 30.00', style: CTextTheme.blackTextTheme.headlineMedium,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 50.0,),
              Text('EN ROUTE', style: CTextTheme.blackTextTheme.headlineLarge,),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text('RIDER ID', style: CTextTheme.greyTextTheme.headlineMedium,),
                          title: Text('#12345', style: CTextTheme.blackTextTheme.headlineMedium,),
                        ),
                        ListTile(
                          leading: Text('COLLECTED ON', style: CTextTheme.greyTextTheme.headlineMedium,),
                          title: Text('23 Nov 2023, 11:59', style: CTextTheme.blackTextTheme.headlineMedium,),
                        ),
                        ListTile(
                          leading: Text('APPLY TAG', style: CTextTheme.greyTextTheme.headlineMedium,),
                          title: Text('Updated on 23 Nov 2023, 11:59', style: CTextTheme.blueTextTheme.headlineMedium,),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text('RECEIVED BY', style: CTextTheme.greyTextTheme.headlineMedium,),
                          title: Text('Thomas, 780129-83-****', style: CTextTheme.blackTextTheme.headlineMedium,),
                        ),
                        ListTile(
                          leading: Text('RECEIVED ON', style: CTextTheme.greyTextTheme.headlineMedium,),
                          title: Text('23 Nov 2023, 11:59', style: CTextTheme.blackTextTheme.headlineMedium,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 50.0,),
              Text('IN PREPARATION', style: CTextTheme.blackTextTheme.headlineLarge,),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text('OPERATOR ID', style: CTextTheme.greyTextTheme.headlineMedium,),
                          title: Text('#12345', style: CTextTheme.blackTextTheme.headlineMedium,),
                        ),
                        ListTile(
                          leading: Text('VERIFICATION', style: CTextTheme.greyTextTheme.headlineMedium,),
                          title: Text('Verification Completed', style: CTextTheme.blueTextTheme.headlineMedium,),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text('ERROR SETTLEMENT', style: CTextTheme.greyTextTheme.headlineMedium,),
                          title: Text('-', style: CTextTheme.blackTextTheme.headlineMedium,),
                        ),
                        ListTile(
                          leading: Text('STATUS', style: CTextTheme.greyTextTheme.headlineMedium,),
                          title: Text('-', style: CTextTheme.blackTextTheme.headlineMedium,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 50.0,),
              Text('COMPLETION', style: CTextTheme.blackTextTheme.headlineLarge,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text('PREPARATION DONE', style: CTextTheme.greyTextTheme.headlineMedium,),
                          title: Text('23 Nov 2023, 11:59', style: CTextTheme.blackTextTheme.headlineMedium,),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text('RIDER ID', style: CTextTheme.greyTextTheme.headlineMedium,),
                          title: Text('#12345', style: CTextTheme.blackTextTheme.headlineMedium,),
                        ),
                        ListTile(
                          leading: Text('PICK UP', style: CTextTheme.greyTextTheme.headlineMedium,),
                          title: Text('23 Nov 2023, 11:59', style: CTextTheme.blackTextTheme.headlineMedium,),
                        ),
                        ListTile(
                          leading: Text('RETURNED', style: CTextTheme.greyTextTheme.headlineMedium,),
                          title: Text('23 Nov 2023, 11:59', style: CTextTheme.blackTextTheme.headlineMedium,),
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