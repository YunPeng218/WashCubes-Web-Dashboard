import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/features/operator/screens/input_tag/tag_input_popup.dart';
import 'package:washcubes_admindashboard/src/features/operator/screens/order_detail/order_detail_popup.dart';
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
              Row(
                children: [
                  Text(
                    'Orders',
                    style: CTextTheme.blackTextTheme.displayLarge,
                  ),
                  IconButton(
                    onPressed: () {
                      //TODO: Refresh List Action
                    }, 
                    icon: const Icon(Icons.refresh_rounded, color: AppColors.cBlackColor,),)
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const InputTagPopUp();
                    },
                  );
                },
                child: Text(
                  'Scan Tag',
                  style: CTextTheme.blackTextTheme.headlineMedium,
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
                    checkOrderAction(order, context);
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

  void checkOrderAction(Order order, BuildContext context) {
    switch (order.status) {
      case 'Pending':
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const OrderDetailPopUp(orderStatus: 'Pending');
          },
        );
        break;
      case 'Process':
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const OrderDetailPopUp(orderStatus: 'Process');
          },
        );
        break;
      case 'Error':
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const OrderDetailPopUp(orderStatus: 'Error');
          },
        );
        break;
      case 'Ready':
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const OrderDetailPopUp(orderStatus: 'Ready');
          },
        );
        break;
      case 'Returned':
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const OrderDetailPopUp(orderStatus: 'Returned');
          },
        );
        break;
      default:
    }
  }

  // Function to determine status color
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.grey;
      case 'Process':
        return Colors.orange;
      case 'Error':
        return Colors.red;
      case 'Ready':
        return Colors.green;
      case 'Returned':
        return Colors.blue;
      default:
        return Colors.grey;
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
