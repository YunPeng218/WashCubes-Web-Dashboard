import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/config.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/constants/image_strings.dart';
import 'package:washcubes_admindashboard/src/constants/sizes.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/login/admin_login_page.dart';
import 'package:washcubes_admindashboard/src/features/operator/screens/homepage/operator_dashboard.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';
import 'package:http/http.dart' as http;

class OperatorLoginPage extends StatefulWidget {
  const OperatorLoginPage({super.key});

  @override
  State<OperatorLoginPage> createState() => _OperatorLoginPageState();
}

class _OperatorLoginPageState extends State<OperatorLoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  bool isNotValidateEmail = false;
  bool isNotValidatePassword = false;
  String errorTextEmail = '';
  String errorTextPassword = '';

  // Validation Function
  void validateInputs() async {
    // Email Validation
    RegExp emailPattern = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (emailController.text.isEmpty) {
      setState(() {
        errorTextEmail = 'Please Enter Your Username.';
        isNotValidateEmail = true;
      });
      return;
    } else if (!emailPattern.hasMatch(emailController.text)) {
      setState(() {
        errorTextEmail = 'Invalid Username Entered.';
        isNotValidateEmail = true;
      });
      return;
    }
    // Password Validation
    if (passwordController.text.isEmpty) {
      setState(() {
        errorTextPassword = 'Please Enter Your Password.';
        isNotValidatePassword = true;
      });
      return;
    }
    loginOperator();
  }

  void loginOperator() async {
    var reqUrl = '${url}loginOperator';
    var response = await http.post(Uri.parse(reqUrl), body: {
      "email": emailController.text,
      "password": passwordController.text
    });
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == true) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const OperatorDashboard()), 
        (route) => false
      );
    } else if (jsonResponse!['status'] == false) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid Credentials',
                textAlign: TextAlign.center,
                style: CTextTheme.blackTextTheme.headlineLarge),
            content: Text(
              'The credentials entered are incorrect. Please try again.',
              textAlign: TextAlign.center,
              style: CTextTheme.blackTextTheme.headlineSmall,
            ),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Close the dialog
                        Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cBarColor,
      body: Padding(
        padding: const EdgeInsets.all(cDefaultSize),
        child: Center(
          child: SizedBox(
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //App Logo
                Image.asset(cAppLogo),
                const SizedBox(height: 50.0,),
                //Username Text Field
                TextField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_outline, color: AppColors.cWhiteColor,),
                    hintText: 'Username',
                    errorText: isNotValidateEmail ? errorTextEmail : null,
                  ),
                ),
                const SizedBox(height: 10.0,),
                //Password Text Field
                TextField(
                  controller: passwordController,
                  style: const TextStyle(color: Colors.white),
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.cWhiteColor,),
                    hintText: 'Password',
                    errorText: isNotValidatePassword ? errorTextPassword : null,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      onLongPressEnd: (_) {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      child: Icon(
                        //If Obscure=true, use visibility_off icon, else use visibility icon
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: cDefaultSize,),
                //Log In Button
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){
                          setState(() {
                            isNotValidateEmail = false;
                            isNotValidatePassword = false;
                            errorTextEmail = '';
                            errorTextPassword = '';
                          });
                          validateInputs();
                        }, 
                        child: Text('Log In', style: CTextTheme.blackTextTheme.headlineMedium,)
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100.0,),
                //Login Page Switching
                TextButton(
                  onPressed: (){
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const AdminLoginPage()),
                      (route) => false,
                    );
                  }, 
                  child: Text('Change to Admin Site', style: CTextTheme.whiteTextTheme.headlineLarge,)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}