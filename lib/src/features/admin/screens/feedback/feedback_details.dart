import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/constants/sizes.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:washcubes_admindashboard/src/constants/text_strings.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class FeedbackDetails extends StatefulWidget {
  const FeedbackDetails({super.key});

  @override
  State<FeedbackDetails> createState() => _FeedbackDetailsState();
}

class _FeedbackDetailsState extends State<FeedbackDetails> {
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
        width: size.width * 0.6,
        height: size.height * 0.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User ID: #9612',
              style: CTextTheme.blackTextTheme.displayLarge,
            ),
            const SizedBox(height: cDefaultSize),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: Text('USERNAME', style: CTextTheme.greyTextTheme.headlineLarge,),
                    title: Text('Trimity Wang', style: CTextTheme.blackTextTheme.headlineLarge,),
                  )
                ),
                Expanded(
                  child: ListTile(
                    leading: Text('DATE RECEIVED', style: CTextTheme.greyTextTheme.headlineLarge,),
                    title: Text('Nov 23, 2023, 12:59', style: CTextTheme.blackTextTheme.headlineLarge,),
                  )
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: Text('CATEGORY', style: CTextTheme.greyTextTheme.headlineLarge,),
                    title: Text('Overall Service', style: CTextTheme.blackTextTheme.headlineLarge,),
                  )
                ),
                Expanded(
                  child: ListTile(
                    leading: Text('RATING', style: CTextTheme.greyTextTheme.headlineLarge,),
                    title: Row(
                      children: [
                        Text('Satisfied', style: CTextTheme.blueTextTheme.headlineLarge,),
                        RatingBar.builder(
                          initialRating: 5,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: AppColors.cBlueColor2,
                          ),
                          onRatingUpdate: (rating) {},
                          ignoreGestures: true, //Disable interaction
                        ),
                      ],
                    ),
                  )
                ),
              ],
            ),
            const Divider(height: cDefaultSize),
            Text('FEEDBACK', style: CTextTheme.greyTextTheme.headlineLarge,),
            const SizedBox(height: 10.0),
            Text(cFeedbackComment, style: CTextTheme.blackTextTheme.headlineLarge,), //TODO: Text from textstring file cus too long
            const Divider(height: cDefaultSize),
          ],
        ),
      ),
    );
  }
}