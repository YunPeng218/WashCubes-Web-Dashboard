import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/constants/image_strings.dart';
import 'package:washcubes_admindashboard/src/constants/sizes.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class OperatorDetails extends StatefulWidget {
  const OperatorDetails({super.key});

  @override
  State<OperatorDetails> createState() => _OperatorDetailsState();
}

class _OperatorDetailsState extends State<OperatorDetails> {
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
      content: Container(
        alignment: Alignment.center,
        width: size.width * 0.5,
        height: size.height * 0.4,
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 10),
                          ),
                        ],
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(cRiderPFP),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Text('OPERATOR ID', style: CTextTheme.greyTextTheme.displaySmall,),
                    title: Text('#12345', style: CTextTheme.blackTextTheme.displaySmall,),
                  ),
                  ListTile(
                    leading: Text('OPERATOR NAME', style: CTextTheme.greyTextTheme.displaySmall,),
                    title: Text('Aarav Patel', style: CTextTheme.blackTextTheme.displaySmall,),
                  ),
                  ListTile(
                    leading: Text('MOBILE NUMBER', style: CTextTheme.greyTextTheme.displaySmall,),
                    title: Text('+60 14-906 3472', style: CTextTheme.blackTextTheme.displaySmall,),
                  ),
                  ListTile(
                    leading: Text('EMAIL', style: CTextTheme.greyTextTheme.displaySmall,),
                    title: Text('otps3345@gmail.com', style: CTextTheme.blackTextTheme.displaySmall,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: (){}, 
          child: Text('Delete Account', style: CTextTheme.blackTextTheme.headlineLarge,)
        )
      ],
    );
  }
}