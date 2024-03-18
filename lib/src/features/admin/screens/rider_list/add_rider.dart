import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/config.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/constants/image_strings.dart';
import 'package:washcubes_admindashboard/src/constants/sizes.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';
import 'package:http/http.dart' as http;

class AddRider extends StatefulWidget {
  final VoidCallback refreshTable;

  const AddRider({super.key, required this.refreshTable});

  @override
  State<AddRider> createState() => _AddRiderState();
}

class _AddRiderState extends State<AddRider> {
  bool _isObscure = true;
  bool _isObscure1 = true;
  final TextEditingController _nameController = TextEditingController();
  bool isNotValidateName = false;
  String errorTextName = '';
  final TextEditingController _emailController = TextEditingController();
  bool isNotValidateEmail = false;
  String errorTextEmail = '';
  final TextEditingController _passwordController = TextEditingController();
  bool isNotValidatePassword = false;
  String errorTextPassword = '';
  final TextEditingController _passwordController1 = TextEditingController();
  bool isNotValidatePassword1 = false;
  String errorTextPassword1 = '';
  final TextEditingController _mobileNumberController = TextEditingController();
  bool isNotValidateMobileNumber = false;
  String errorTextMobileNumber = '';
  Uint8List? fileBytes;
  String fileName = '';
  String imageUrl = '';

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
    RegExp mobileNumberPattern = RegExp(r'^(601)[0-46-9][0-9]{7,8}$');
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
    } else if (_passwordController.text.length < 8) {
      setState(() {
        errorTextPassword = 'Password must be at least 8 characters long.';
        isNotValidatePassword = true;
      });
      return;
    } else if (!_passwordController.text.contains(RegExp(r'[A-Z]'))) {
      setState(() {
        errorTextPassword = 'Password must contain at least 1 uppercase letter.';
        isNotValidatePassword = true;
      });
      return;
    } else if (!_passwordController.text.contains(RegExp(r'[a-z]'))) {
      setState(() {
        errorTextPassword = 'Password must contain at least 1 lowercase letter.';
        isNotValidatePassword = true;
      });
      return;
    } else if (!_passwordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      setState(() {
        errorTextPassword = 'Password must contain at least 1 symbol.';
        isNotValidatePassword = true;
      });
      return;
    }

    // Confirm Password Validation
    if (_passwordController1.text.isEmpty) {
      setState(() {
        errorTextPassword1 = 'Please Confirm Rider Password.';
        isNotValidatePassword1 = true;
      });
      return;
    } else if (_passwordController.text != _passwordController1.text) {
      setState(() {
        errorTextPassword1 = 'Passwords do not match.';
        isNotValidatePassword1 = true;
      });
      return;
    }

    if (!isNotValidateName && !isNotValidateMobileNumber && !isNotValidateEmail && !isNotValidatePassword && !isNotValidatePassword1) {
      registerRider();
    }
  }

  Future<void> selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;
      fileName = result.files.first.name;
      fileBytes = file.bytes!;
      uploadImage();
    }
  }

  Future<void> uploadImage() async {
    try {
      final url =
          Uri.parse('https://api.cloudinary.com/v1_1/ddweldfmx/upload');
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'xcbbr3ok'
        ..files.add(
          http.MultipartFile.fromBytes(
            'file',
            fileBytes!,
            filename: fileName,
          ),
        );
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = utf8.decode(responseData);
        final jsonMap = jsonDecode(responseString);
        final url = jsonMap['url'];
        setState(() {
          imageUrl = url;
        });
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  void registerRider() async {
    var reqUrl = '${url}registerRider';
    try {
      Map<String, dynamic> requestBody = {
        'email': _emailController.text,
        'password': _passwordController.text,
        'phoneNumber': _mobileNumberController.text,
        'name': _nameController.text,
      };
      if (imageUrl != '') {
        requestBody['profilePicURL'] = imageUrl;
      }
      final response = await http.post(
        Uri.parse(reqUrl),
        body: (requestBody),
      );

      if (response.statusCode == 200) {
        widget.refreshTable();
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
                'Rider has been added successfully.',
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
      } else {
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
                'Rider with the same email or phone number is already exist. Please try again.',
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
    } catch (error) {
      print('Error registering rider: $error');
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
                          image: imageUrl.isEmpty
                            ? const AssetImage(cRiderPFP) as ImageProvider
                            : NetworkImage(imageUrl),
                        ),
                      ),
                    ),
                    //Camera PFP Icon
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          selectImage();
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
                        hintText: '60123456789',
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
                          child: Icon(
                            //If Obscure=true, use visibility_off icon, else use visibility icon
                            _isObscure ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                        errorText: isNotValidatePassword ? errorTextPassword : null,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Text('CONFIRM PASSWORD', style: CTextTheme.greyTextTheme.headlineLarge,),
                    title: TextField(
                      controller: _passwordController1,
                      obscureText: _isObscure1,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isObscure1 = !_isObscure1;
                            });
                          },
                          child: Icon(
                            //If Obscure=true, use visibility_off icon, else use visibility icon
                            _isObscure1 ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                        errorText: isNotValidatePassword1 ? errorTextPassword1 : null,
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
              isNotValidatePassword1 = false;
              isNotValidateMobileNumber = false;
              isNotValidateName = false;
              errorTextName = '';
              errorTextMobileNumber = '';
              errorTextEmail = '';
              errorTextPassword = '';
              errorTextPassword1 = '';
            });
            validateInputs();
          }, 
          child: Text('Add Account', style: CTextTheme.blackTextTheme.headlineLarge,)
        )
      ],
    );
  }
}