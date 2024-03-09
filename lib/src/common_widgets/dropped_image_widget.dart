import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/models/dropped_file.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class DroppedFileWidget extends StatelessWidget {
  final DroppedFile? file;

  const DroppedFileWidget({super.key, this.file});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      buildImage(),
      if (file != null) buildFileDetails(file!),
    ],
  );

  Widget buildImage() {
    if (file == null) return buildEmptyFile('--Chosen Image Will Display Here--');

    // Display chosen file image
    return Image.network(
      file!.url,
      width: 200,
      height: 200,
      fit: BoxFit.fitHeight,
      errorBuilder: (context, error, _) => buildEmptyFile('No Preview'), //Incompatible file uploaded
    );
  }

  // Display default text when no image chosen
  Widget buildEmptyFile(String text) => Text(
    text, 
    style: CTextTheme.greyTextTheme.headlineLarge,
  );

  // Display chosen image details
  Widget buildFileDetails(DroppedFile file) {
    final textStyle = CTextTheme.blackTextTheme.headlineLarge;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(file.photoName, style: textStyle,),
        const SizedBox(width: 10.0,),
        Text(file.size, style: textStyle,),
      ],
    );
  }
}