import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/common_widgets/large_screen.dart';
import 'package:washcubes_admindashboard/src/common_widgets/responsiveness.dart';
import 'package:washcubes_admindashboard/src/common_widgets/small_screen.dart';
import 'package:washcubes_admindashboard/src/common_widgets/top_nav.dart';
import 'package:washcubes_admindashboard/src/features/operator/screens/input_tag/tag_input_popup.dart';
import 'package:washcubes_admindashboard/src/features/operator/screens/order_detail/order_detail_popup.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class OperatorHomePage extends StatelessWidget {
  OperatorHomePage({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: topNavigationBar(context, scaffoldKey),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const InputTagPopUp();
                  },
                );
              }, 
              child: Text('Scan Tag', style: CTextTheme.blackTextTheme.headlineMedium)),
            ElevatedButton(
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const OrderDetailPopUp(orderStatus: 'Pending');
                  },
                );
              }, 
              child: Text('Pending', style: CTextTheme.blackTextTheme.headlineMedium)),
            ElevatedButton(
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const OrderDetailPopUp(orderStatus: 'Process');
                  },
                );
              }, 
              child: Text('Process', style: CTextTheme.blackTextTheme.headlineMedium)),
            ElevatedButton(
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const OrderDetailPopUp(orderStatus: 'Error');
                  },
                );
              }, 
              child: Text('Error', style: CTextTheme.blackTextTheme.headlineMedium)),
            ElevatedButton(
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const OrderDetailPopUp(orderStatus: 'Ready');
                  },
                );
              }, 
              child: Text('Ready', style: CTextTheme.blackTextTheme.headlineMedium)),
            ElevatedButton(
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const OrderDetailPopUp(orderStatus: 'Returned');
                  },
                );
              }, 
              child: Text('Returned', style: CTextTheme.blackTextTheme.headlineMedium)),
          ],
        ),
      ),
    );
  }
}