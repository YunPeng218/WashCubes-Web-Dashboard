import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/constants/image_strings.dart';
import 'package:washcubes_admindashboard/src/constants/sizes.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/homepage/admin_dashboard.dart';
import 'package:washcubes_admindashboard/src/features/operator/screens/login/operator_login_page.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
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
                const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline, color: AppColors.cWhiteColor,),
                    hintText: 'username',
                  ),
                ),
                const SizedBox(height: 10.0,),
                //Password Text Field
                const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline_rounded, color: AppColors.cWhiteColor,),
                    hintText: 'password',
                  ),
                ),
                const SizedBox(height: cDefaultSize,),
                //Log In Button
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const AdminDashboard()), 
                            (route) => false
                          );
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
                      MaterialPageRoute(builder: (context) => const OperatorLoginPage()),
                      (route) => false,
                    );
                  }, 
                  child: Text('Change to Operator Site', style: CTextTheme.whiteTextTheme.headlineLarge,)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}