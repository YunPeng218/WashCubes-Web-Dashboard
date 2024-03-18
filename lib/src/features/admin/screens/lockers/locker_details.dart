import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/constants/sizes.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';
import 'package:washcubes_admindashboard/src/models/locker.dart';

class LockerDetails extends StatefulWidget {
  final LockerSite lockerSite;
  const LockerDetails({super.key, required this.lockerSite});

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
            icon: const Icon(
              Icons.cancel,
              color: AppColors.cBarColor,
              size: cButtonHeight,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: size.width * 0.6,
        height: size.height * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.lockerSite.name,
              style: CTextTheme.blackTextTheme.displayLarge,
            ),
            // ListTile(
            //   leading: Icon(Icons.circle, color: AppColors.cBlueColor2,),
            //   title: Text('Available', style: CTextTheme.blueTextTheme.headlineMedium,),
            // ),
            const Divider(
              height: 30.0,
            ),
            Text(
              'ADDRESS',
              style: CTextTheme.greyTextTheme.displaySmall,
            ),
            Text(
              widget.lockerSite.address,
              style: CTextTheme.blackTextTheme.headlineLarge,
            ),
            const SizedBox(height: 30),
            Text(
              'COMPARTMENTS:',
              style: CTextTheme.greyTextTheme.displaySmall,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.lockerSite.compartments.length,
                itemBuilder: (BuildContext context, int index) {
                  final compartment = widget.lockerSite.compartments[index];
                  return ListTile(
                    leading: Icon(
                      compartment.isAvailable
                          ? Icons.check_circle
                          : Icons.cancel,
                      color:
                          compartment.isAvailable ? Colors.green : Colors.red,
                    ),
                    title: Text(
                      'Compartment Number: ${compartment.compartmentNumber}',
                      style: CTextTheme.blackTextTheme.headlineMedium,
                    ),
                    subtitle: Text(
                      'Size: ${compartment.size}',
                      style: CTextTheme.blackTextTheme.headlineMedium,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
