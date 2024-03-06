import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Row(
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF182738),
                        ),
                        child: NavBarItem(text: 'All Orders', color: Colors.white),
                      ),
                      NavBarItem(text: 'Pending'),
                      NavBarItem(text: 'Process'),
                      NavBarItem(text: 'Error'),
                      NavBarItem(text: 'Ready'),
                      NavBarItem(text: 'Returned'),
                      Spacer(),
                      Container(
                        width: double.infinity,
                        color: Color(0xFF182738),
                        child: TextButton(
                          onPressed: () {
                            // Handle logout button tap
                          },
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 1,
                color: Colors.black,
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
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
                            child: Text(
                              'Scan Tag',
                              style: TextStyle(
                                color: Color(0xFF182738),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFEBF4FF),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search by ID',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onChanged: (value) {
                            // Handle search functionality
                          },
                        ),
                      ),
                    ),

                    Expanded(
                      child: Container(
                        color: Colors.white60,
                        child: OrderList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Orders',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.lightBlueAccent,
                  child: OrderList(),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}


class OrderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Accessing device-specific information
    final screenWidth = MediaQuery.of(context).size.width;

    // Replace with actual order data
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
          columns: [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Date/Time')),
            DataColumn(label: Text('Tag ID')),
            DataColumn(label: Text('User ID')),
            DataColumn(label: Text('Service Type')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('')),
          ],
          rows: orders
              .map(
                (order) => DataRow(cells: [
              DataCell(Text(order.id.toString())),
              DataCell(Text(order.dateTime)),
              DataCell(Text(order.tagId)),
              DataCell(Text(order.userId)),
              DataCell(Text(order.serviceType)),
              DataCell(
                Text(
                  order.status,
                  style: TextStyle(color: _getStatusColor(order.status)),
                ),
              ),
              DataCell(
                ElevatedButton(
                  onPressed: () {
                    // Handle check button tap
                  },
                  child: Text(
                    'Check',
                    style: TextStyle(
                      color: Color(0xFF182738),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color(0xFFA1CCE5),
                    ),
                  ),
                ),
              ),
            ]),
          )
              .toList(),
        ),
        SizedBox(height: 200), // Added spacing for pagination
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  // Handle previous page button tap
                },
                icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFD7ECF7),
                  ),
                  child: Icon(Icons.arrow_back),
                ),
              ),

              SizedBox(width: 16), // Adjust spacing as needed
              Text(
                'Page 1 of 5', // Replace with actual page number
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 16), // Adjust spacing as needed
              IconButton(
                onPressed: () {
                  // Handle next page button tap
                },
                icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFD7ECF7),
                  ),
                  child: Icon(Icons.arrow_forward),
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
        return Color(0xFF979797);
      case 'Process':
        return Color(0xFFF5B436);
      case 'Error':
        return Color(0xFFFF0000);
      case 'Ready':
        return Color(0xFF1B9544);
      case 'Returned':
        return Color(0xFF438FF7);
      default:
        return Colors.black;
    }
  }
}

class NavBarItem extends StatelessWidget {
  final String text;
  final Color? color;

  const NavBarItem({Key? key, required this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
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

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Order Management'),
      ),
      body: LargeScreen(),
    ),
  ));
}
