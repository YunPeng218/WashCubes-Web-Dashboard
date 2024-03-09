import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class ConfirmationPopUp extends StatelessWidget {
  const ConfirmationPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Are You Sure to Proceed?',
        style: CTextTheme.blackTextTheme.displaySmall,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context, 'Cancel');
              },
              child: Text(
                'Cancel',
                style: CTextTheme.blackTextTheme.headlineMedium,
              )),
            const VerticalDivider(),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context, 'Confirm');
              },
              child: Text(
                'Confirm',
                style: CTextTheme.blackTextTheme.headlineMedium,
              )),
          ],
        )
      ],
    );
  }
}
