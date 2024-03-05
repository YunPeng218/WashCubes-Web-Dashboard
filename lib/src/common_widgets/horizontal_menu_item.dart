import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/constants/controllers.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class HorizontalMenuItem extends StatelessWidget {
  final String itemName;
  final Function()? onTap;
  const HorizontalMenuItem({super.key, required this.itemName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      onHover: (value){
        value ?
        menuController.onHover(itemName) : menuController.onHover("not hovering");
      },
      child: Obx(() => Container(
        color: menuController.isHovering(itemName) ? AppColors.cBarColor.withOpacity(.1) : Colors.transparent,
        child: Row(
          children: [
            Visibility(
              visible: menuController.isHovering(itemName) || menuController.isActive(itemName),
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: Container(
                width: 6,
                height: 40,
                color: AppColors.cWhiteColor,
              ),
            ),
            SizedBox(width:width / 88),

            Padding(
              padding: const EdgeInsets.all(16),
              child: menuController.returnIconFor(itemName),
            ),
            if(!menuController.isActive(itemName))
            Flexible(child: Text(itemName, style: menuController.isHovering(itemName) ? CTextTheme.whiteTextTheme.headlineMedium : CTextTheme.blackTextTheme.headlineMedium,))
            else
            Flexible(child: Text(itemName, style: CTextTheme.whiteTextTheme.headlineMedium,))

          ],
        ),
      ))
    );
  }
}