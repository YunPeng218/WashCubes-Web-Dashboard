import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/features/operator/screens/side_menu/operator_side_menu.dart';
import 'package:washcubes_admindashboard/src/common_widgets/top_nav.dart';
import 'package:washcubes_admindashboard/src/features/operator/screens/order_list/order_list.dart';

class OperatorDashboard extends StatefulWidget {
  const OperatorDashboard({super.key});

  @override
  State<OperatorDashboard> createState() => _OperatorDashboardState();
}

class _OperatorDashboardState extends State<OperatorDashboard> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: topNavigationBar(context, scaffoldKey),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(child: OperatorSideMenu()),
          Expanded(
            flex: 5,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: const OrderTable(),
            ),
          )
        ],
      ),
    );
  }
}