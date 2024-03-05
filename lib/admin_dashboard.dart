import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:washcubes_admindashboard/src/common_widgets/large_screen.dart';
import 'package:washcubes_admindashboard/src/common_widgets/responsiveness.dart';
import 'package:washcubes_admindashboard/src/common_widgets/side_menu.dart';
import 'package:washcubes_admindashboard/src/common_widgets/small_screen.dart';
import 'package:washcubes_admindashboard/src/common_widgets/top_nav.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/constants/image_strings.dart';
import 'package:washcubes_admindashboard/src/constants/sizes.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

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
  bool isSelected = false;
  // Color _buttonColor = Colors.blue;
  // Color _textColor = Colors.white;

  // void _changeButtonColor() {
  //   setState(() {
  //     if (_buttonColor == Colors.blue) {
  //       _buttonColor = Colors.green;
  //       _textColor = Colors.black;
  //     } else {
  //       _buttonColor = Colors.blue;
  //       _textColor = Colors.white;
  //     }
  //   });
  // }
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: topNavigationBar(context, scaffoldKey),
      drawer: const Drawer(child: SideMenu(),),
      body: const ResponsiveWidget(largeScreen: LargeScreen(), smallScreen: SmallScreen(),)
    );
  }
}
