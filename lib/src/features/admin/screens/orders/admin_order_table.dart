import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/orders/admin_order_details.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class AdminOrderTable extends StatefulWidget {
  const AdminOrderTable({super.key});

  @override
  State<AdminOrderTable> createState() => _AdminOrderTableState();
}

class _AdminOrderTableState extends State<AdminOrderTable> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    //TODO: Replace with actual order data
    final List<OrderDataRow> orders = [
      OrderDataRow(
        dateTime: '23 Nov 2023, 11:59', 
        orderId: '#12345', 
        itemId: '-', 
        serviceType: 'WashCubes', 
        orderPrice: 'RM 30.00', 
        orderLocation: "Taylor's University", 
        orderStatus: 'Reserved'
      ),
      OrderDataRow(
        dateTime: '23 Nov 2023, 11:59', 
        orderId: '#12345', 
        itemId: '-', 
        serviceType: 'WashCubes', 
        orderPrice: 'RM 30.00', 
        orderLocation: "Taylor's University", 
        orderStatus: 'Received'
      ),
      OrderDataRow(
        dateTime: '23 Nov 2023, 11:59', 
        orderId: '#12345', 
        itemId: '#12232458899', 
        serviceType: 'WashCubes', 
        orderPrice: 'RM 30.00', 
        orderLocation: "Taylor's University", 
        orderStatus: 'Collected'
      ),
      OrderDataRow(
        dateTime: '23 Nov 2023, 11:59', 
        orderId: '#12345', 
        itemId: '#12232458899', 
        serviceType: 'WashCubes', 
        orderPrice: 'RM 30.00', 
        orderLocation: "Taylor's University", 
        orderStatus: 'Process'
      ),
      OrderDataRow(
        dateTime: '23 Nov 2023, 11:59', 
        orderId: '#12345', 
        itemId: '#12232458899', 
        serviceType: 'WashCubes', 
        orderPrice: 'RM 30.00', 
        orderLocation: "Taylor's University", 
        orderStatus: 'Error'
      ),
      OrderDataRow(
        dateTime: '23 Nov 2023, 11:59', 
        orderId: '#12345', 
        itemId: '#12232458899', 
        serviceType: 'WashCubes', 
        orderPrice: 'RM 30.00', 
        orderLocation: "Taylor's University", 
        orderStatus: 'Ready'
      ),
      OrderDataRow(
        dateTime: '23 Nov 2023, 11:59', 
        orderId: '#12345', 
        itemId: '#12232458899', 
        serviceType: 'WashCubes', 
        orderPrice: 'RM 30.00', 
        orderLocation: "Taylor's University", 
        orderStatus: 'Returned'
      ),
      OrderDataRow(
        dateTime: '23 Nov 2023, 11:59', 
        orderId: '#12345', 
        itemId: '#12232458899', 
        serviceType: 'WashCubes', 
        orderPrice: 'RM 30.00', 
        orderLocation: "Taylor's University", 
        orderStatus: 'Ready For Collect'
      ),
      OrderDataRow(
        dateTime: '23 Nov 2023, 11:59', 
        orderId: '#12345', 
        itemId: '#12232458899', 
        serviceType: 'WashCubes', 
        orderPrice: 'RM 30.00', 
        orderLocation: "Taylor's University", 
        orderStatus: 'Completed'
      ),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columnSpacing: screenWidth * 0.01,
        columns: [
          DataColumn(
              label: Text(
            'DATE / TIME',
            style: CTextTheme.greyTextTheme.headlineMedium,
          )),
          DataColumn(
              label: Text(
            'ORDER ID',
            style: CTextTheme.greyTextTheme.headlineMedium,
          )),
          DataColumn(
              label: Text(
            'ITEM ID',
            style: CTextTheme.greyTextTheme.headlineMedium,
          )),
          DataColumn(
              label: Text(
            'SERVICE TYPE',
            style: CTextTheme.greyTextTheme.headlineMedium,
          )),
          DataColumn(
              label: Text(
            'ORDER PRICE',
            style: CTextTheme.greyTextTheme.headlineMedium,
          )),
          DataColumn(
              label: Text(
            'LOCATION',
            style: CTextTheme.greyTextTheme.headlineMedium,
          )),
          DataColumn(
              label: Text(
            'STATUS',
            style: CTextTheme.greyTextTheme.headlineMedium,
          )),
          const DataColumn(label: Text('')),
        ],
        rows: orders
            .map(
              (order) => DataRow(cells: [
                DataCell(Text(
                  order.dateTime,
                  style: CTextTheme.blackTextTheme.headlineMedium,
                )),
                DataCell(Text(
                  order.orderId,
                  style: CTextTheme.blackTextTheme.headlineMedium,
                )),
                DataCell(Text(
                  order.itemId,
                  style: CTextTheme.blackTextTheme.headlineMedium,
                )),
                DataCell(Text(
                  order.serviceType,
                  style: CTextTheme.blackTextTheme.headlineMedium,
                )),
                DataCell(Text(
                  order.orderPrice,
                  style: CTextTheme.blackTextTheme.headlineMedium,
                )),
                DataCell(Text(
                  order.orderLocation,
                  style: CTextTheme.blackTextTheme.headlineMedium,
                )),
                DataCell(Text(
                  order.orderStatus,
                  style: CTextTheme.blackTextTheme.headlineMedium?.copyWith(color: _getStatusColor(order.orderStatus)),
                )),
                DataCell(
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context, 
                        builder: (BuildContext context) {
                          return const AdminOrderDetails();
                        },);
                    },
                    child: Text(
                      'Check',
                      style: CTextTheme.blackTextTheme.headlineMedium,
                    ),
                  ),
                ),
              ]),
            )
            .toList(),
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

class OrderDataRow {
  final String dateTime;
  final String orderId;
  final String itemId;
  final String serviceType;
  final String orderPrice;
  final String orderLocation;
  final String orderStatus;

  OrderDataRow({
    required this.dateTime,
    required this.orderId,
    required this.itemId,
    required this.serviceType,
    required this.orderPrice,
    required this.orderLocation,
    required this.orderStatus,
  });
}