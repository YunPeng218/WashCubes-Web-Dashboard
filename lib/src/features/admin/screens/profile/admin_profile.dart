import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:washcubes_admindashboard/config.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/constants/sizes.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/password_reset/password_reset.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  Map<String, dynamic> adminDetails = {};

  @override
  void initState() {
    super.initState();
    getAdminDetails();
  }

  void getAdminDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? '';
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(token);
      var reqUrl = '${url}admin?adminId=${jwtDecodedToken["_id"]}';
      final response = await http.get(
        Uri.parse(reqUrl),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          adminDetails = data['admin'];
        });
      } else {
        print('Failed to load admin details');
      }
    } catch (error) {
      print('Error fetching admin details: $error');
    }
  }

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
                      Stack(
                        children: [
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
                              image: adminDetails['profilePicURL'] != null
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(adminDetails['profilePicURL']),
                                    )
                                  : null,
                            ),
                          ),
                          if (adminDetails['profilePicURL'] == null)
                            const Center(
                              child: CircularProgressIndicator(),
                            ),
                        ],
                      )
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
                        'ADMIN NAME',
                        style: CTextTheme.greyTextTheme.headlineLarge,
                      ),
                      title: Text(
                        adminDetails['name'] ?? 'Loading...',
                        style: CTextTheme.blackTextTheme.headlineLarge,
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        'ADMIN IC NUMBER',
                        style: CTextTheme.greyTextTheme.headlineLarge,
                      ),
                      title: Text(
                        adminDetails['icNumber'] ?? 'Loading...',
                        style: CTextTheme.blackTextTheme.headlineLarge,
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        'MOBILE NUMBER',
                        style: CTextTheme.greyTextTheme.headlineLarge,
                      ),
                      title: Text(
                        adminDetails['phoneNumber'].toString(),
                        style: CTextTheme.blackTextTheme.headlineLarge,
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        'ADMIN EMAIL',
                        style: CTextTheme.greyTextTheme.headlineLarge,
                      ),
                      title: Text(
                        adminDetails['email'] ?? 'Loading...',
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