import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/constants/image_strings.dart';
import 'package:washcubes_admindashboard/src/constants/sizes.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class AddRider extends StatefulWidget {
  const AddRider({super.key});

  @override
  State<AddRider> createState() => _AddRiderState();
}

class _AddRiderState extends State<AddRider> {
  bool _isObscure = true;
  final TextEditingController _nameController = TextEditingController();
  bool isNotValidateName = false;
  String errorTextName = '';
  final TextEditingController _emailController = TextEditingController();
  bool isNotValidateEmail = false;
  String errorTextEmail = '';
  final TextEditingController _passwordController = TextEditingController();
  bool isNotValidatePassword = false;
  String errorTextPassword = '';
  final TextEditingController _mobileNumberController = TextEditingController();
  bool isNotValidateMobileNumber = false;
  String errorTextMobileNumber = '';

  // Validation Function
  void validateInputs() async {
    // Name Validation
    if (_nameController.text.isEmpty) {
      setState(() {
        errorTextName = 'Please Enter Rider Name.';
        isNotValidateName = true;
      });
      return;
    }
    // Mobile Number Validation
    RegExp mobileNumberPattern = RegExp(r'^\+60 1[0-9]-\d{7,8}$');
    if (_mobileNumberController.text.isEmpty) {
      setState(() {
        errorTextMobileNumber = 'Please Enter Rider Mobile Number.';
        isNotValidateMobileNumber = true;
      });
      return;
    } else if (!mobileNumberPattern.hasMatch(_mobileNumberController.text)) {
      setState(() {
        errorTextMobileNumber = 'Invalid Number Entered.';
        isNotValidateMobileNumber = true;
      });
      return;
    }
    // Email Validation
    RegExp emailPattern = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (_emailController.text.isEmpty) {
      setState(() {
        errorTextEmail = 'Please Enter Rider Email.';
        isNotValidateEmail = true;
      });
      return;
    } else if (!emailPattern.hasMatch(_emailController.text)) {
      setState(() {
        errorTextEmail = 'Invalid Email Entered.';
        isNotValidateEmail = true;
      });
      return;
    }
    // Password Validation
    if (_passwordController.text.isEmpty) {
      setState(() {
        errorTextPassword = 'Please Enter Rider Password.';
        isNotValidatePassword = true;
      });
      return;
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
        width: size.width * 0.6,
        height: size.height * 0.6,
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
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: AppColors.cGreyColor1,
                            ),
                            color: AppColors.cGreyColor1,
                          ),
                          child: const Icon(Icons.camera_alt_rounded, color: AppColors.cBlueColor3),
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
                    leading: Text('RIDER ID', style: CTextTheme.greyTextTheme.headlineLarge,),
                    title: Text('#4318943857', style: CTextTheme.blackTextTheme.headlineLarge,),
                  ),
                  ListTile(
                    leading: Text('RIDER NAME', style: CTextTheme.greyTextTheme.headlineLarge,),
                    title: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Full Name',
                        errorText: isNotValidateName ? errorTextName : null,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Text('MOBILE NUMBER', style: CTextTheme.greyTextTheme.headlineLarge,),
                    title: TextField(
                      controller: _mobileNumberController,
                      decoration: InputDecoration(
                        hintText: '+60 14-906 0912',
                        errorText: isNotValidateMobileNumber ? errorTextMobileNumber : null,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Text('EMAIL', style: CTextTheme.greyTextTheme.headlineLarge,),
                    title: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'example@gmail.com',
                        errorText: isNotValidateEmail ? errorTextEmail : null,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Text('PASSWORD', style: CTextTheme.greyTextTheme.headlineLarge,),
                    title: TextField(
                      controller: _passwordController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        hintText: 'Password',
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
                        errorText: isNotValidatePassword ? errorTextPassword : null,
                      ),
                    ),
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
            setState(() {
              isNotValidateEmail = false;
              isNotValidatePassword = false;
              isNotValidateMobileNumber = false;
              isNotValidateName = false;
              errorTextName = '';
              errorTextMobileNumber = '';
              errorTextEmail = '';
              errorTextPassword = '';
            });
            validateInputs();
          }, 
          child: Text('Add Account', style: CTextTheme.blackTextTheme.headlineLarge,)
        )
      ],
    );
  }
}