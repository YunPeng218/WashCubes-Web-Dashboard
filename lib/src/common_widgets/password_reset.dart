import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/constants/sizes.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  bool _isObscure = true;
  bool _isObscure2 = true;
  bool _isObscure3 = true;

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
                      obscureText: _isObscure,
                      decoration: InputDecoration(
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
                      obscureText: _isObscure2,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isObscure2 = !_isObscure2;
                            });
                          },
                          onLongPressEnd: (_) {
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
                      obscureText: _isObscure3,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isObscure3 = !_isObscure3;
                            });
                          },
                          onLongPressEnd: (_) {
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
                  onPressed: (){}, 
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