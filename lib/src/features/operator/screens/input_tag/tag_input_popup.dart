import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:washcubes_admindashboard/src/constants/sizes.dart';
import 'package:washcubes_admindashboard/src/features/operator/screens/order_detail/order_detail_popup.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class InputTagPopUp extends StatelessWidget {
  const InputTagPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      //Back button
      icon: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the alert dialog
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
        ],
      ),
      actions: [
        //TODO: Guide user to appropriate step based on the tag input and the status it stored
        //Pending button
        ElevatedButton(
          onPressed: (){
            Navigator.of(context).pop(); // Close the alert dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const OrderDetailPopUp(orderStatus: 'Pending'); //Show order detal alert dialog
              },
            );
          }, 
          child: Text(
            'Confirm',
            style: CTextTheme.blackTextTheme.headlineMedium,
          ),
        ),
      ],
      content: Container(
        alignment: Alignment.center,
        width: size.width * 0.5,
        height: size.height * 0.4, 
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 5.0),
              Text(
                'Enter Tag Number:',
                textAlign: TextAlign.center,
                style: CTextTheme.blackTextTheme.displayMedium,
              ),
              const SizedBox(height: cFormHeight),
              //Tag Number Text Field
              TextField(
                textAlign: TextAlign.center,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))], // Allow only numeric input
                keyboardType: TextInputType.number, // Set keyboard type to number
                maxLength: 13,
                decoration: const InputDecoration(
                  hintText: '0000000000000',
                ),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}