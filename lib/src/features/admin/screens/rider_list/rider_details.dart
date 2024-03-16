import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/config.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/constants/sizes.dart';
import 'package:washcubes_admindashboard/src/models/rider.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';
import 'package:http/http.dart' as http;

class RiderDetails extends StatefulWidget {
  final Rider rider;

  const RiderDetails({super.key, required this.rider});

  @override
  State<RiderDetails> createState() => _RiderDetailsState();
}

class _RiderDetailsState extends State<RiderDetails> {

  void deleteAccount(String email) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirmation',
            textAlign: TextAlign.center,
            style: CTextTheme.blackTextTheme.headlineLarge,
          ),
          content: Text(
            'Are you sure you want to delete this rider\'s account?',
            textAlign: TextAlign.center,
            style: CTextTheme.blackTextTheme.headlineSmall,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(
                'Cancel',
                style: CTextTheme.blackTextTheme.headlineSmall,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      final response = await http.delete(
        Uri.parse('${url}deleteRiderAccount'),
        body: {
          'email': email,
        },
      );
      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Success',
                textAlign: TextAlign.center,
                style: CTextTheme.blackTextTheme.headlineLarge,
              ),
              content: Text(
                'This rider\'s account has been deleted successfully.',
                textAlign: TextAlign.center,
                style: CTextTheme.blackTextTheme.headlineSmall,
              ),
              actions: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'OK',
                          style: CTextTheme.blackTextTheme.headlineSmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      }
    }
  }

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
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.rider.profilePicURL),
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
                    leading: Text('RIDER NAME', style: CTextTheme.greyTextTheme.displaySmall,),
                    title: Text(widget.rider.name, style: CTextTheme.blackTextTheme.displaySmall,),
                  ),
                  ListTile(
                    leading: Text('EMAIL', style: CTextTheme.greyTextTheme.displaySmall,),
                    title: Text(widget.rider.email, style: CTextTheme.blackTextTheme.displaySmall,),
                  ),
                  ListTile(
                    leading: Text('PHONE NUMBER', style: CTextTheme.greyTextTheme.displaySmall,),
                    title: Text(widget.rider.phoneNumber.toString(), style: CTextTheme.blackTextTheme.displaySmall,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: (){
            deleteAccount(widget.rider.email);
          }, 
          child: Text('Delete Account', style: CTextTheme.blackTextTheme.headlineLarge,)
        )
      ],
    );
  }
}