// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/orders/admin_order_details.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:washcubes_admindashboard/config.dart';
import 'package:washcubes_admindashboard/src/models/order.dart';
import 'package:washcubes_admindashboard/src/models/service.dart';
import 'package:washcubes_admindashboard/src/models/locker.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';

class OrderData extends StatefulWidget {
  const OrderData({super.key});

  @override
  State<OrderData> createState() => _OrderDataState();
}

class _OrderDataState extends State<OrderData> {
  List<Order> orders = [];
  List<Order> allOrders = [];

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      final response = await http.get(
        Uri.parse('${url}orders'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        //print(response.body)
        final Map<String, dynamic> data = json.decode(response.body);
        //print(data);
        if (data.containsKey('orders')) {
          final List<dynamic> orderData = data['orders'];
          final List<Order> fetchedOrders =
              orderData.map((order) => Order.fromJson(order)).toList();
          print(fetchedOrders);
          setState(() {
            orders = fetchedOrders;
            allOrders = fetchedOrders;
          });
        } else {
          print('Response data does not contain services.');
        }
      } else {
        print('Error: ${response.statusCode}');
        print('Error message: ${response.body}');
      }
    } catch (error) {
      print('Error Fetching Orders: $error');
    }
  }

  Future<String> getServiceName(String serviceId) async {
    String serviceName = 'Loading...';
    try {
      final response = await http.get(Uri.parse('${url}services/$serviceId'),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('service')) {
          final dynamic serviceData = data['service'];
          final Service service = Service.fromJson(serviceData);
          serviceName = service.name;
        }
      }
    } catch (error) {
      print('Error Fetching Service Name: $error');
    }
    return serviceName;
  }

  Future<String> getLockerSiteDetails(String lockerSiteId) async {
    String dropOffLocation = 'Loading...';
    try {
      final response = await http.get(
          Uri.parse('${url}lockers?lockerSiteId=$lockerSiteId'),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('locker')) {
          final dynamic lockerData = data['locker'];
          final LockerSite lockerSite = LockerSite.fromJson(lockerData);
          dropOffLocation = lockerSite.name;
        }
      }
    } catch (error) {
      print('Error Fetching Drop Off Location: $error');
    }
    return dropOffLocation;
  }

  List<Order> filterOrdersByQuery(List<Order> orders, String? query) {
    if (query == null) {
      return orders;
    }
    return orders
        .where((orders) => orders.orderNumber.contains(query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Orders',
                    style: CTextTheme.blackTextTheme.displayLarge,
                  ),
                  IconButton(
                    onPressed: () async {
                      await fetchOrders();
                    },
                    icon: const Icon(
                      Icons.refresh_rounded,
                      color: AppColors.cBlackColor,
                    ),
                  )
                ],
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
                hintText: 'Search by Order No...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  orders = allOrders;
                  orders = filterOrdersByQuery(orders, value);
                });
              },
            ),
          ),
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AdminOrderTable(orders: orders),
            ],
          )
        ),
      ],
    );
  }
}

class AdminOrderTable extends StatefulWidget {
  List<Order> orders = [];

  AdminOrderTable({super.key, required this.orders});

  @override
  State<AdminOrderTable> createState() => _AdminOrderTableState();
}

class _AdminOrderTableState extends State<AdminOrderTable> {

  Future<String> getServiceName(String serviceId) async {
    String serviceName = 'Loading...';
    try {
      final response = await http.get(Uri.parse('${url}services/$serviceId'),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('service')) {
          final dynamic serviceData = data['service'];
          final Service service = Service.fromJson(serviceData);
          serviceName = service.name;
        }
      }
    } catch (error) {
      print('Error Fetching Service Name: $error');
    }
    return serviceName;
  }

  Future<String> getLockerSiteDetails(String lockerSiteId) async {
    String dropOffLocation = 'Loading...';
    try {
      final response = await http.get(
          Uri.parse('${url}lockers?lockerSiteId=$lockerSiteId'),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('locker')) {
          final dynamic lockerData = data['locker'];
          final LockerSite lockerSite = LockerSite.fromJson(lockerData);
          dropOffLocation = lockerSite.name;
        }
      }
    } catch (error) {
      print('Error Fetching Drop Off Location: $error');
    }
    return dropOffLocation;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
            'ORDER NO.',
            style: CTextTheme.greyTextTheme.headlineMedium,
          )),
          DataColumn(
              label: Text(
            'SERVICE',
            style: CTextTheme.greyTextTheme.headlineMedium,
          )),
          DataColumn(
              label: Text(
            'EST/FINAL PRICE',
            style: CTextTheme.greyTextTheme.headlineMedium,
          )),
          DataColumn(
              label: Text(
            'DROP-OFF',
            style: CTextTheme.greyTextTheme.headlineMedium,
          )),
          DataColumn(
              label: Text(
            'PICKUP',
            style: CTextTheme.greyTextTheme.headlineMedium,
          )),
          DataColumn(
              label: Text(
            'STATUS',
            style: CTextTheme.greyTextTheme.headlineMedium,
          )),
          const DataColumn(label: Text('')),
        ],
        rows: widget.orders
            .map(
              (order) => DataRow(cells: [
                DataCell(Text(
                  order.getFormattedDateTime(order.createdAt),
                  style: CTextTheme.blackTextTheme.headlineMedium,
                )),
                DataCell(Text(
                  order.orderNumber,
                  style: CTextTheme.blackTextTheme.headlineMedium,
                )),
                DataCell(
                  FutureBuilder<String>(
                    future: getServiceName(order.serviceId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('Loading...');
                      } else if (snapshot.hasError) {
                        return const Text('Error');
                      } else {
                        return Text(
                          snapshot.data ?? 'Service Name Not Available',
                          style: CTextTheme.blackTextTheme.headlineMedium,
                        );
                      }
                    },
                  ),
                ),
                DataCell(Text(
                  order.finalPrice == 0.0
                      ? 'RM${order.estimatedPrice.toStringAsFixed(2)}'
                      : 'RM${order.finalPrice!.toStringAsFixed(2)}',
                  style: CTextTheme.blackTextTheme.headlineMedium,
                )),
                DataCell(
                  FutureBuilder<String>(
                    future:
                        getLockerSiteDetails(order.lockerDetails!.lockerSiteId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('Loading...');
                      } else if (snapshot.hasError) {
                        return const Text('Error');
                      } else {
                        return Text(
                          snapshot.data ?? 'Service Name Not Available',
                          style: CTextTheme.blackTextTheme.headlineMedium,
                        );
                      }
                    },
                  ),
                ),
                DataCell(
                  FutureBuilder<String>(
                    future: getLockerSiteDetails(
                        order.collectionSite!.lockerSiteId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('Loading...');
                      } else if (snapshot.hasError) {
                        return const Text('Error');
                      } else {
                        return Text(
                          snapshot.data ?? 'Service Name Not Available',
                          style: CTextTheme.blackTextTheme.headlineMedium,
                        );
                      }
                    },
                  ),
                ),
                DataCell(Text(
                  order.orderStage!.getMostRecentStatus(),
                  style: CTextTheme.blackTextTheme.headlineMedium?.copyWith(
                      color: _getStatusColor(
                          order.orderStage!.getMostRecentStatus())),
                )),
                DataCell(
                  ElevatedButton(
                    onPressed: () async {
                      String serviceName =
                          await getServiceName(order.serviceId);
                      String dropOffLocation = await getLockerSiteDetails(
                          order.lockerDetails!.lockerSiteId);
                      String pickupLocation = await getLockerSiteDetails(
                          order.collectionSite!.lockerSiteId);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AdminOrderDetails(
                            order: order,
                            serviceName: serviceName,
                            dropOffLocation: dropOffLocation,
                            pickupLocation: pickupLocation,
                          );
                        },
                      );
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
      case 'Completed':
        return Colors.green;
      case 'Ready For Collection':
        return Colors.blue;
      case 'Out For Delivery':
        return Colors.blue;
      case 'Processing Return':
        return Colors.red;
      case 'Order Error':
        return Colors.red;
      case 'Processing Complete':
        return Colors.blue;
      case 'In Progress':
        return Colors.orange;
      case 'Collected By Rider':
        return Colors.orange;
      case 'Drop Off':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}
