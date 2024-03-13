import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/common_widgets/top_nav.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/dashboard/admin_dashboard.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/feedback/feedback.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/lockers/locker.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/login/admin_login_page.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/operators/operator.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/riders/rider.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/services/service.dart';
import 'package:washcubes_admindashboard/src/features/operator/screens/order_list/order_list.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class CentralHub extends StatefulWidget {
  const CentralHub({super.key});

  @override
  State<CentralHub> createState() => _CentralHubState();
}

class _CentralHubState extends State<CentralHub> {
  // Dashboard Button List Data
  // final List<Map<String, dynamic>> items = [
  //   {'icon': Icons.auto_graph_rounded,'button-name': 'Dashboard',},
  //   {'icon': Icons.business_center_outlined,'button-name': 'Orders', },
  //   {'icon': Icons.room_service_outlined,'button-name': 'Services', },
  //   {'icon': Icons.lock_outline_rounded,'button-name': 'Lockers', },
  //   {'icon': Icons.person_outline_rounded,'button-name': 'Users', },
  //   {'icon': Icons.delivery_dining_outlined,'button-name': 'Riders', },
  //   {'icon': Icons.people_alt_outlined,'button-name': 'Operators', },
  //   {'icon': Icons.chat_rounded,'button-name': 'Feedback', },
  //   {'icon': Icons.logout_rounded,'button-name': 'Log Out', },
  // ];
  String? selectedFeature;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: topNavigationBar(context, scaffoldKey),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: AdminSideMenu(
            onFeatureSelected: (feature) {
              setState(() {
                selectedFeature = feature;
              });
            },
          )),
          Expanded(
            flex: 5,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: selectContent(selectedFeature), //Carry 
            ),
          )
        ],
      ),
    );
  }
  Widget selectContent(String? selectedFeature) {
    switch (selectedFeature) {
      case 'Dashboard':
        return AdminDashboard();
      case 'Orders':
        return OrderTable(filter: 'Pending',);
      case 'Services':
        return Services();
      case 'Lockers':
        return LockerPage();
      case 'Riders':
        return RiderData();
      case 'Operators':
        return OperatorData();
      case 'Feedback':
        return FeedbackList();
      default:
        // If no filter is selected, show dashboard
        return AdminDashboard();
    }
  }
}

class AdminSideMenu extends StatefulWidget {
  final Function(String?) onFeatureSelected;

  const AdminSideMenu({super.key, required this.onFeatureSelected});

  @override
  AdminSideMenuState createState() => AdminSideMenuState();
}

class AdminSideMenuState extends State<AdminSideMenu> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        buildNavBarItem('Dashboard', 'Dashboard'),
        buildNavBarItem('Orders', 'Orders'),
        buildNavBarItem('Services', 'Services'),
        buildNavBarItem('Lockers', 'Lockers'),
        buildNavBarItem('Riders', 'Riders'),
        buildNavBarItem('Operators', 'Operators'),
        buildNavBarItem('Feedback', 'Feedback'),
        const Spacer(),
        buildLogoutButton(),
      ],
    );
  }

  Widget buildNavBarItem(String text, String? feature) {
    final isSelected = selectedItem == feature;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItem = feature;
        });
        widget.onFeatureSelected(feature);
      },
      child: Container(
        width: double.infinity,
        color: isSelected
            ? AppColors.cBarColor
            : null, // Change color based on selection
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(text,
              style: isSelected
                  ? CTextTheme.whiteTextTheme.headlineLarge
                  : CTextTheme.blackTextTheme.headlineLarge),
        ),
      ),
    );
  }

  Widget buildLogoutButton() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      color: AppColors.cBarColor,
      child: TextButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const AdminLoginPage()),
              (route) => false);
        },
        child: const Text(
          'Logout',
          style: TextStyle(
            color: AppColors.cWhiteColor,
          ),
        ),
      ),
    );
  }
}
