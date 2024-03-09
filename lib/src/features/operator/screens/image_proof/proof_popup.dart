import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/common_widgets/dropped_image_widget.dart';
import 'package:washcubes_admindashboard/src/constants/sizes.dart';
import 'package:washcubes_admindashboard/src/models/dropped_file.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class ImageProof extends StatefulWidget {
  const ImageProof({super.key});

  @override
  State<ImageProof> createState() => _ImageProofState();
}

class _ImageProofState extends State<ImageProof> {
  DroppedFile ? file;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
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
      content: Container(
        alignment: Alignment.center,
        width: size.width * 0.6,
        height: size.height * 0.6, 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Proof', style: CTextTheme.blackTextTheme.displayLarge,),
            const SizedBox(height: cDefaultSize),
            DroppedFileWidget(file: file), //TODO: Show uploaded image
          ],
        ),
      ),
    );
  }
}