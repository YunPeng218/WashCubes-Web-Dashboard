import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/common_widgets/top_nav.dart';
import 'package:washcubes_admindashboard/src/features/operator/screens/homepage/operator_dashboard.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  // Dashboard Button List Data
  final List<Map<String, dynamic>> items = [
    {'icon': Icons.auto_graph_rounded,'button-name': 'Dashboard',},
    {'icon': Icons.business_center_outlined,'button-name': 'Orders', },
    {'icon': Icons.room_service_outlined,'button-name': 'Services', },
    {'icon': Icons.lock_outline_rounded,'button-name': 'Lockers', },
    {'icon': Icons.person_outline_rounded,'button-name': 'Users', },
    {'icon': Icons.delivery_dining_outlined,'button-name': 'Riders', },
    {'icon': Icons.people_alt_outlined,'button-name': 'Operators', },
    {'icon': Icons.chat_rounded,'button-name': 'Feedback', },
    {'icon': Icons.logout_rounded,'button-name': 'Log Out', },
  ];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: topNavigationBar(context, scaffoldKey),
      body: const OperatorDashboard(),
    );
  }
}
