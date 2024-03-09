import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:washcubes_admindashboard/src/constants/sizes.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class OrderTable extends StatefulWidget {
  const OrderTable({super.key});

  @override
  State<OrderTable> createState() => _OrderTableState();
}

class _OrderTableState extends State<OrderTable> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Orders',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle Scan Tag button tap
                },
                child: const Text(
                  'Scan Tag',
                  style: TextStyle(
                    color: Color(0xFF182738),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: 40.0,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by ID',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {
                //TODO: Handle search functionality
              },
            ),
          ),
        ),
        const Flexible(
          child: OrderList(),
        ),
      ],
    );
  }
}

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing device-specific information
    final screenWidth = MediaQuery.of(context).size.width;

    //TODO: Replace with actual order data
    final List<Order> orders = [
      Order(
        id: 101,
        dateTime: '2024-03-06 10:00 AM',
        tagId: 'A123',
        userId: 'user123',
        serviceType: 'Dry Cleaning',
        status: 'Pending',
      ),
      Order(
        id: 102,
        dateTime: '2024-03-06 10:00 AM',
        tagId: 'A123',
        userId: 'user123',
        serviceType: 'Dry Cleaning',
        status: 'Process',
      ),
      Order(
        id: 103,
        dateTime: '2024-03-06 10:00 AM',
        tagId: 'A123',
        userId: 'user123',
        serviceType: 'Dry Cleaning',
        status: 'Error',
      ),
      Order(
        id: 104,
        dateTime: '2024-03-06 10:00 AM',
        tagId: 'A123',
        userId: 'user123',
        serviceType: 'Dry Cleaning',
        status: 'Ready',
      ),
      Order(
        id: 105,
        dateTime: '2024-03-06 10:00 AM',
        tagId: 'A123',
        userId: 'user123',
        serviceType: 'Dry Cleaning',
        status: 'Returned',
      ),
    ];

    return Column(
      children: [
        DataTable(
          columnSpacing: screenWidth * 0.07,
          columns: [
            DataColumn(label: Text('ID', style: CTextTheme.greyTextTheme.headlineMedium,)),
            DataColumn(label: Text('Date/Time', style: CTextTheme.greyTextTheme.headlineMedium,)),
            DataColumn(label: Text('Tag ID', style: CTextTheme.greyTextTheme.headlineMedium,)),
            DataColumn(label: Text('User ID', style: CTextTheme.greyTextTheme.headlineMedium,)),
            DataColumn(label: Text('Service Type', style: CTextTheme.greyTextTheme.headlineMedium,)),
            DataColumn(label: Text('Status', style: CTextTheme.greyTextTheme.headlineMedium,)),
            DataColumn(label: Text('')),
          ],
          rows: orders
              .map(
                (order) => DataRow(cells: [
              DataCell(Text(order.id.toString(), style: CTextTheme.blackTextTheme.headlineMedium,)),
              DataCell(Text(order.dateTime, style: CTextTheme.blackTextTheme.headlineMedium,)),
              DataCell(SizedBox(width: 80, child: Text(order.tagId, style: CTextTheme.blackTextTheme.headlineMedium,))),
              DataCell(SizedBox(width: 80, child: Text(order.userId, style: CTextTheme.blackTextTheme.headlineMedium,))),
              DataCell(SizedBox(width: 100, child: Text(order.serviceType, style: CTextTheme.blackTextTheme.headlineMedium,))),
              DataCell(
                Text(
                  order.status,
                  style:  CTextTheme.blackTextTheme.headlineMedium?.copyWith(color: _getStatusColor(order.status)),
                ),
              ),
              DataCell(
                ElevatedButton(
                  onPressed: () {
                    //TODO: Handle check button tap
                  },
                  child: Text(
                    'Check',
                    style:  CTextTheme.blackTextTheme.headlineMedium,
                  ),
                ),
              ),
            ]),
          )
              .toList(),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  //TODO: Handle previous page button tap
                },
                icon: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFD7ECF7),
                  ),
                  child: const Icon(Icons.arrow_back),
                ),
              ),

              const SizedBox(width: 16), // Adjust spacing as needed
              Text(
                'Page 1 of 5', // Replace with actual page number
                style:  CTextTheme.blackTextTheme.headlineMedium,
              ),
              const SizedBox(width: 16), // Adjust spacing as needed
              IconButton(
                onPressed: () {
                  //TODO: Handle next page button tap
                },
                icon: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFD7ECF7),
                  ),
                  child: const Icon(Icons.arrow_forward),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Function to determine status color
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return const Color(0xFF979797);
      case 'Process':
        return const Color(0xFFF5B436);
      case 'Error':
        return const Color(0xFFFF0000);
      case 'Ready':
        return const Color(0xFF1B9544);
      case 'Returned':
        return const Color(0xFF438FF7);
      default:
        return Colors.black;
    }
  }
}

class Order {
  final int id;
  final String dateTime;
  final String tagId;
  final String userId;
  final String serviceType;
  final String status;

  Order({
    required this.id,
    required this.dateTime,
    required this.tagId,
    required this.userId,
    required this.serviceType,
    required this.status,
  });
}
