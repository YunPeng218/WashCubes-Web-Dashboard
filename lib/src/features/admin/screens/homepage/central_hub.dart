import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/lockers/locker_table.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/operator_list/operator_table.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/orders/admin_order_table.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/rider_list/rider_table.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/top_nav/top_nav.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/feedback_list/feedback_list.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/login/admin_login_page.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class CentralHub extends StatefulWidget {
  final String profilePicUrl;
  const CentralHub({super.key, required this.profilePicUrl});

  @override
  State<CentralHub> createState() => _CentralHubState();
}

class _CentralHubState extends State<CentralHub> {
  String? selectedFeature;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: topNavigationBar(context, scaffoldKey, widget.profilePicUrl),
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
      // case 'Dashboard':
      //   return AdminDashboard();
      case 'Orders':
        return const OrderData();
      // case 'Services':
      //   return Services();
      case 'Lockers':
        return const LockerPage();
      case 'Riders':
        return const RiderTable();
      case 'Operators':
        return const OperatorTable();
      case 'Feedback':
        return const FeedbackTable();
      default:
        // If no filter is selected, show dashboard
        return const OrderData();
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
        // buildNavBarItem('Dashboard', 'Dashboard'),
        buildNavBarItem('Orders', 'Orders'),
        // buildNavBarItem('Services', 'Services'),
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
