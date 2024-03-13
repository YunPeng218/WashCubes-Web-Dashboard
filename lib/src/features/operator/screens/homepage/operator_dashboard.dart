import 'package:flutter/material.dart';
//import 'package:washcubes_admindashboard/src/features/operator/screens/side_menu/operator_side_menu.dart';
import 'package:washcubes_admindashboard/src/common_widgets/top_nav.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/features/operator/screens/order_list/order_list.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';
import 'package:washcubes_admindashboard/src/features/operator/screens/login/operator_login_page.dart';

class OperatorDashboard extends StatefulWidget {
  const OperatorDashboard({super.key});

  @override
  State<OperatorDashboard> createState() => _OperatorDashboardState();
}

class _OperatorDashboardState extends State<OperatorDashboard> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String? selectedFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: topNavigationBar(context, scaffoldKey),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: OperatorSideMenu(
            onFilterSelected: (filter) {
              setState(() {
                selectedFilter = filter;
              });
            },
          )),
          Expanded(
            flex: 5,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: OrderTable(filter: selectedFilter),
            ),
          )
        ],
      ),
    );
  }
}

class OperatorSideMenu extends StatefulWidget {
  final Function(String?) onFilterSelected;

  const OperatorSideMenu({super.key, required this.onFilterSelected});

  @override
  OperatorSideMenuState createState() => OperatorSideMenuState();
}

class OperatorSideMenuState extends State<OperatorSideMenu> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        buildNavBarItem('All Orders', null),
        buildNavBarItem('Pending', 'Pending'),
        buildNavBarItem('Processing', 'Processing'),
        buildNavBarItem('Order Error', 'Order Error'),
        buildNavBarItem('Ready', 'Ready'),
        buildNavBarItem('Pending Return Approval', 'Pending Return Approval'),
        buildNavBarItem('Returned', 'Returned'),
        const Spacer(),
        buildLogoutButton(),
      ],
    );
  }

  Widget buildNavBarItem(String text, String? filter) {
    final isSelected = selectedItem == filter;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItem = filter;
        });
        widget.onFilterSelected(filter);
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
      color: const Color(0xFF182738),
      child: TextButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const OperatorLoginPage()),
              (route) => false);
        },
        child: const Text(
          'Logout',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
