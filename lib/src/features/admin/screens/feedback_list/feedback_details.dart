import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/constants/sizes.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';
import 'package:washcubes_admindashboard/src/models/feedback.dart';

class FeedbackDetails extends StatefulWidget {
  final Feedbacks feedback;

  const FeedbackDetails({super.key, required this.feedback});

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
              'Feedback ID: ${widget.feedback.feedbackID}',
              style: CTextTheme.blackTextTheme.displayLarge,
            ),
            const SizedBox(height: cDefaultSize),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: Text('USERNAME', style: CTextTheme.greyTextTheme.headlineLarge,),
                    title: Text(widget.feedback.user!.phoneNumber.toString(), style: CTextTheme.blackTextTheme.headlineLarge,),
                  )
                ),
                Expanded(
                  child: ListTile(
                    leading: Text('DATE RECEIVED', style: CTextTheme.greyTextTheme.headlineLarge,),
                    title: Text(widget.feedback.getFormattedDateTime(widget.feedback.receivedAt), style: CTextTheme.blackTextTheme.headlineLarge,),
                  )
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: Text('IMPROVEMENT\nCATEGORIES', style: CTextTheme.greyTextTheme.headlineLarge,),
                    title: Text(widget.feedback.improvementCategories.toString().replaceAll('[', '').replaceAll(']', ''), style: CTextTheme.blackTextTheme.headlineLarge,),
                  )
                ),
                Expanded(
                  child: ListTile(
                    leading: Text('RATING', style: CTextTheme.greyTextTheme.headlineLarge,),
                    title: Row(
                      children: [
                        RatingBar.builder(
                          initialRating: widget.feedback.starRating,
                          minRating: 0.5,
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
            Text('MESSAGE', style: CTextTheme.greyTextTheme.headlineLarge,),
            const SizedBox(height: 10.0),
            Text(widget.feedback.message, style: CTextTheme.blackTextTheme.headlineLarge,),
            const Divider(height: cDefaultSize),
          ],
        ),
      ),
    );
  }
}