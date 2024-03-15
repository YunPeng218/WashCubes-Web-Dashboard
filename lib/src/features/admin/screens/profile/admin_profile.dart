import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/common_widgets/password_reset.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/constants/image_strings.dart';
import 'package:washcubes_admindashboard/src/constants/sizes.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      //Cancel or X icon button
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
        alignment: Alignment.topCenter,
        width: size.width * 0.6,
        height: size.height * 0.6,
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: 250,
                        height: 250,
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
                            image: AssetImage(cRiderPFP),
                          ),
                        ),
                      ),
                      //Camera PFP Icon
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            // showEditDialog(context);
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: AppColors.cGreyColor1,
                              ),
                              color: AppColors.cGreyColor1,
                            ),
                            child: const Icon(Icons.camera_alt_rounded, color: AppColors.cBlueColor3, size: 40,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Text(
                        'ADMIN ID',
                        style: CTextTheme.greyTextTheme.headlineLarge,
                      ),
                      //TODO: Put ID here
                      title: Text(
                        '#12345',
                        style: CTextTheme.blackTextTheme.headlineLarge,
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        'ADMIN NAME',
                        style: CTextTheme.greyTextTheme.headlineLarge,
                      ),
                      //TODO: Put name here
                      title: Text(
                        'Aarav Patel',
                        style: CTextTheme.blackTextTheme.headlineLarge,
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        'MOBILE NUMBER',
                        style: CTextTheme.greyTextTheme.headlineLarge,
                      ),
                      //TODO: Put mobile number here
                      title: Text(
                        '+60 14-906 0912',
                        style: CTextTheme.blackTextTheme.headlineLarge,
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        'USERNAME',
                        style: CTextTheme.greyTextTheme.headlineLarge,
                      ),
                      //TODO: Put username / email here
                      title: Text(
                        'aaravpatel@gmail.com',
                        style: CTextTheme.blackTextTheme.headlineLarge,
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        'PASSWORD',
                        style: CTextTheme.greyTextTheme.headlineLarge,
                      ),
                      title: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return const PasswordReset();
                            },);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            color: AppColors.cGreyColor2,
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Row(
                            children: [
                              Text('hidden',style: CTextTheme.greyTextTheme.headlineLarge,),
                              const Spacer(),
                              const Icon(Icons.edit_outlined, color: AppColors.cGreyColor3,)
                            ],
                          ),
                        ),
                      ),
                      // trailing: IconButton(onPressed: (){}, icon: Icon(Icons.edit_outlined, color: AppColors.cGreyColor2,)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}