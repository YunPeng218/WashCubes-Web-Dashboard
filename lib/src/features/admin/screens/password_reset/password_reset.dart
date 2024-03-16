import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:washcubes_admindashboard/config.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/constants/sizes.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';
import 'package:http/http.dart' as http;

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  bool _isObscure = true;
  bool _isObscure2 = true;
  bool _isObscure3 = true;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isNotValidateOldPassword = false;
  bool isNotValidatePassword = false;
  bool isNotValidatePassword1 = false;
  String errorTextOldPassword = '';
  String errorTextPassword = '';
  String errorTextPassword1 = '';

  void resetErrorText() {
    isNotValidateOldPassword = false;
    isNotValidatePassword = false;
    isNotValidatePassword1 = false;
    errorTextOldPassword = '';
    errorTextPassword = '';
    errorTextPassword1 = '';
  }

  //Password Validation Function
  void passwordValidation() {
    String oldPassword = oldPasswordController.text;
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;

    // Define validation criteria for new password
    RegExp uppercaseRegExp = RegExp(r'[A-Z]');
    RegExp lowercaseRegExp = RegExp(r'[a-z]');
    RegExp digitRegExp = RegExp(r'\d');
    RegExp specialCharRegExp = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    if (oldPassword.isEmpty) {
      setState(() {
        errorTextOldPassword = 'Please Enter Your Old Password.';
        isNotValidateOldPassword = true;
      });
      return;
    }
    if (newPassword.isNotEmpty) {
      if (newPassword.length < 8) {
        setState(() {
          errorTextPassword = 'Password must be at least 8 characters long.';
          isNotValidatePassword = true;
        });
      } else if (!uppercaseRegExp.hasMatch(newPassword)) {
        setState(() {
          errorTextPassword = 'Password must contain at least one uppercase letter.';
          isNotValidatePassword = true;
        });
      } else if (!lowercaseRegExp.hasMatch(newPassword)) {
        setState(() {
          errorTextPassword = 'Password must contain at least one lowercase letter.';
          isNotValidatePassword = true;
        });
      } else if (!digitRegExp.hasMatch(newPassword)) {
        setState(() {
          errorTextPassword = 'Password must contain at least one digit.';
          isNotValidatePassword = true;
        });
      } else if (!specialCharRegExp.hasMatch(newPassword)) {
        setState(() {
          errorTextPassword = 'Password must contain at least one special character.';
          isNotValidatePassword = true;
        });
      } else {
        // New password is valid
        setState(() {
          errorTextPassword = '';
          isNotValidatePassword = false;
        });
      }
    } else {
      setState(() {
        errorTextPassword = 'Please Enter Your Password.';
        isNotValidatePassword = true;
      });
    }

    // Confirm password validation
    if (newPassword != confirmPassword) {
      setState(() {
        errorTextPassword1 = 'Passwords do not match.';
        isNotValidatePassword1 = true;
      });
    } else {
      // Passwords match
      setState(() {
        errorTextPassword1 = '';
        isNotValidatePassword1 = false;
      });
    }

    if (!isNotValidateOldPassword && !isNotValidatePassword && !isNotValidatePassword1) {
      changePassword();
    }
  }

  void changePassword () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(token);
    var email = jwtDecodedToken["email"];
    var reqUrl = '${url}changePassAdmin';
    var response = await http.post(Uri.parse(reqUrl), body: {
      "email": email,
      "oldPassword": oldPasswordController.text,
      "newPassword": newPasswordController.text
    });
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == 'Success') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Success',
              textAlign: TextAlign.center,
              style: CTextTheme.blackTextTheme.headlineLarge
            ),
            content: Text(
              'Password updated successfully.',
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
    } else if (jsonResponse['status'] == 'Failed') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Error',
              textAlign: TextAlign.center,
              style: CTextTheme.blackTextTheme.headlineLarge
            ),
            content: Text(
              'The old password entered is incorrect. Please try again.',
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
        alignment: Alignment.center,
        width: size.width * 0.5,
        height: size.height * 0.5,
        child: Center(
          child: Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Row(
                  children: [
                    Expanded(child: Text(
                    'OLD PASSWORD',
                    style: CTextTheme.greyTextTheme.headlineLarge,
                    textAlign: TextAlign.start,
                  ),),
                  const SizedBox(width: cDefaultSize,),
                  Expanded(
                    child: TextField(
                      controller: oldPasswordController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        errorText: isNotValidateOldPassword ? errorTextOldPassword: null,
                        suffixIcon: GestureDetector(
                          onTap: () {
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
                  )
                  ],
                ),
                const SizedBox(height: cDefaultSize,),
                Row(
                  children: [
                    Expanded(child: Text(
                    'NEW PASSWORD',
                    style: CTextTheme.greyTextTheme.headlineLarge,
                    textAlign: TextAlign.start,
                  ),),
                  const SizedBox(width: cDefaultSize,),
                  Expanded(
                    child: TextField(
                      controller: newPasswordController,
                      obscureText: _isObscure2,
                      decoration: InputDecoration(
                        errorText: isNotValidatePassword ? errorTextPassword: null,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isObscure2 = !_isObscure2;
                            });
                          },
                          child: Icon(
                            //If Obscure=true, use visibility_off icon, else use visibility icon
                            _isObscure2 ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                  )
                  ],
                ),
                const SizedBox(height: cDefaultSize,),
                Row(
                  children: [
                    Expanded(child: Text(
                    'CONFIRM PASSWORD',
                    style: CTextTheme.greyTextTheme.headlineLarge,
                    textAlign: TextAlign.start,
                  ),),
                  const SizedBox(width: cDefaultSize,),
                  Expanded(
                    child: TextField(
                      controller: confirmPasswordController,
                      obscureText: _isObscure3,
                      decoration: InputDecoration(
                        errorText: isNotValidatePassword1 ? errorTextPassword1: null,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isObscure3 = !_isObscure3;
                            });
                          },
                          child: Icon(
                            //If Obscure=true, use visibility_off icon, else use visibility icon
                            _isObscure3 ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                  )
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: (){
                    resetErrorText();
                    passwordValidation();
                  }, 
                  child: Text('Confirm', style: CTextTheme.blackTextTheme.headlineLarge,)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}