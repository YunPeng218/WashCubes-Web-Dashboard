import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:washcubes_admindashboard/src/common_widgets/confirmation_popup.dart';
import 'package:washcubes_admindashboard/src/common_widgets/dropped_image_widget.dart';
import 'package:washcubes_admindashboard/src/common_widgets/dropzone_widget.dart';
import 'package:washcubes_admindashboard/src/constants/sizes.dart';
import 'package:washcubes_admindashboard/src/features/operator/screens/order_detail/order_detail_popup.dart';
import 'package:washcubes_admindashboard/src/models/dropped_file.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class UploadImagePopUp extends StatefulWidget {
  const UploadImagePopUp({super.key});

  @override
  State<UploadImagePopUp> createState() => _UploadImagePopUpState();
}

class _UploadImagePopUpState extends State<UploadImagePopUp> {
  DroppedFile ? file;

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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const OrderDetailPopUp(orderStatus: 'Pending',);
                },
              );
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
        ],
      ),
      content: Container(
        alignment: Alignment.center,
        width: size.width * 0.6,
        height: size.height * 0.6, 
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 5.0),
              Text(
                'Upload Proof',
                textAlign: TextAlign.center,
                style: CTextTheme.blackTextTheme.displayLarge,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(cDefaultSize),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DroppedFileWidget(file: file), //Show uploaded image
                    const SizedBox(height: cFormHeight,),
                    SizedBox(
                      height: 300,
                      child: DropZoneWidget(
                        onDroppedFile: (file) => setState(() => this.file = file),
                      ),
                    ),
                  ],
                ),
              ),
              //Confirm image button
              ElevatedButton(
                //TODO: Upload image and change status to error
                onPressed: () async {
                  final result = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const ConfirmationPopUp();
                    },
                  );
                  if (result == 'Confirm') {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const OrderDetailPopUp(orderStatus: 'Error',);
                      },
                    );
                  }
                }, 
                child: Text('Confirm', style: CTextTheme.blackTextTheme.headlineLarge,)
              ),
              const SizedBox(height: 10.0,),
            ],
          ),
        ),
      ),
    );
  }
}