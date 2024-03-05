import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/common_widgets/horizontal_menu_item.dart';
import 'package:washcubes_admindashboard/src/common_widgets/responsiveness.dart';
import 'package:washcubes_admindashboard/src/common_widgets/vertical_menu_item.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final Function() onTap;
  const SideMenuItem({super.key, required this.itemName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isCustomSize(context)) {
      return VerticalMenuItem(
        itemName: itemName,
        onTap: onTap,
      );
    } else {
      return HorizontalMenuItem(
        itemName: itemName,
        onTap: onTap,
      );
    }
  }
}