import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:washcubes_admindashboard/config.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/constants/sizes.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';
import 'package:http/http.dart' as http;
import 'package:washcubes_admindashboard/src/features/operator/screens/password_reset/password_reset.dart';

class OperatorProfile extends StatefulWidget {
  const OperatorProfile({super.key});

  @override
  State<OperatorProfile> createState() => _OperatorProfileState();
}

class _OperatorProfileState extends State<OperatorProfile> {
  Map<String, dynamic> operatorDetails = {};

  @override
  void initState() {
    super.initState();
    getOperatorDetails();
  }

  void getOperatorDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? '';
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(token);
      var reqUrl = '${url}operator?operatorId=${jwtDecodedToken["_id"]}';
      final response = await http.get(
        Uri.parse(reqUrl),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          operatorDetails = data['operator'];
        });
      } else {
        print('Failed to load operator details');
      }
    } catch (error) {
      print('Error fetching operator details: $error');
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
                              image: operatorDetails['profilePicURL'] != null
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(operatorDetails['profilePicURL']),
                                    )
                                  : null,
                            ),
                          ),
                          if (operatorDetails['profilePicURL'] == null)
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
                        'OPERATOR NAME',
                        style: CTextTheme.greyTextTheme.headlineLarge,
                      ),
                      title: Text(
                        operatorDetails['name'] ?? 'Loading...',
                        style: CTextTheme.blackTextTheme.headlineLarge,
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        'OPERATOR IC',
                        style: CTextTheme.greyTextTheme.headlineLarge,
                      ),
                      title: Text(
                        operatorDetails['icNumber'] ?? 'Loading...',
                        style: CTextTheme.blackTextTheme.headlineLarge,
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        'MOBILE NUMBER',
                        style: CTextTheme.greyTextTheme.headlineLarge,
                      ),
                      title: Text(
                        operatorDetails['phoneNumber'].toString(),
                        style: CTextTheme.blackTextTheme.headlineLarge,
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        'OPERATOR USERNAME',
                        style: CTextTheme.greyTextTheme.headlineLarge,
                      ),
                      title: Text(
                        operatorDetails['email'] ?? 'Loading...',
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