import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/constants/image_strings.dart';
import 'package:washcubes_admindashboard/src/constants/sizes.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class LockerDetails extends StatefulWidget {
  const LockerDetails({super.key});

  @override
  State<LockerDetails> createState() => _LockerDetailsState();
}

class _LockerDetailsState extends State<LockerDetails> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.cancel, color: AppColors.cBarColor,size: cButtonHeight,),
          ),
        ],
      ),
      content: SizedBox(
        width: size.width * 0.5,
        height: size.height * 0.4,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Taylor's University", style: CTextTheme.blackTextTheme.displayLarge,),
                  ListTile(
                    leading: Icon(Icons.circle, color: AppColors.cBlueColor2,),
                    title: Text('Available', style: CTextTheme.blueTextTheme.headlineMedium,),
                  ),
                  const Divider(
                    height: 30.0,
                  ),
                  Text('ADDRESS', style: CTextTheme.greyTextTheme.displaySmall,),
                  Text('1, Jln Taylors, 47500 Subang Jaya, Selangor.', style: CTextTheme.blackTextTheme.headlineLarge,),
                ],
              ),
            ),
            Expanded(child: Image.asset(cLocker))
          ],
        ),
      ),
    );
  }
}