import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washcubes_admindashboard/src/common_widgets/responsiveness.dart';
import 'package:washcubes_admindashboard/src/common_widgets/side_menu_item.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/constants/controllers.dart';
import 'package:washcubes_admindashboard/src/constants/image_strings.dart';
import 'package:washcubes_admindashboard/src/routing/routes.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: AppColors.cWhiteColor,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(width: width / 48),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset(cAppLogo),
                    ),
                    Flexible(
                      child: Text('i3Cubes', style: CTextTheme.blackTextTheme.displaySmall,)
                    ),
                    SizedBox(width: width / 48),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          // Divider(
          //   color: Colors.grey.withOpacity(.1),
          // ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenuItems
                .map((item) => SideMenuItem(
                    itemName: item.name,
                    onTap: () {
                      if (item.route == LogOutPageRoute) {
                        // Get.offAllNamed(LogOutPageRoute);
                        // menuController
                        //     .changeActiveItemTo(overviewPageDisplayName);
                      }
                      if (!menuController.isActive(item.name)) {
                        // menuController.changeActiveItemTo(item.name);
                        // if (ResponsiveWidget.isSmallScreen(context)) {
                        //   Get.back();
                        // }
                        // navigationController.navigateTo(item.route);
                      }
                    }))
                .toList(),
          )
        ],
      ),
    );
  }
}
