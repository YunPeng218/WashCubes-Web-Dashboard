import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/models/dropped_file.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class DropZoneWidget extends StatefulWidget {
  final ValueChanged<DroppedFile> onDroppedFile;
  
  const DropZoneWidget({super.key, required this.onDroppedFile});

  @override
  State<DropZoneWidget> createState() => _DropZoneWidgetState();
}

class _DropZoneWidgetState extends State<DropZoneWidget> {
  late DropzoneViewController controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)), // Rounded corners
        color: AppColors.cGreyColor2,
      ),
      width: size.width * 0.3,
      height: size.height * 0.3,
      child: Stack(
        children: [
          // File dropzone widget
          DropzoneView(
            onCreated: (controller) => this.controller = controller,
            onDrop: acceptFile,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.cloud_upload_outlined, color: AppColors.cGreyColor3),
                Text('Upload Image', style: CTextTheme.greyTextTheme.displaySmall),
                Text('Drag and drop Image here', style: CTextTheme.greyTextTheme.labelLarge),
                const SizedBox(height: 10.0),
                Text('--- OR ---', style: CTextTheme.greyTextTheme.headlineMedium,),
                const SizedBox(height: 10.0),

                // File browsing option
                TextButton.icon(
                  onPressed: () async{
                    final events = await controller.pickFiles();
                    if (events.isEmpty) return;
                    acceptFile(events.first);
                  }, 
                  icon: const Icon(Icons.search, color: AppColors.cGreyColor3,), 
                  label: Text('Choose Files', style: CTextTheme.greyTextTheme.displaySmall)
                )
              ],
            )
          ),
        ]
      ),
    );
  }

  //Image upload function
  Future acceptFile(dynamic event) async {
    final photoName = event.name;
    final mime = await controller.getFileMIME(event);
    final bytes = await controller.getFileSize(event);
    final url = await controller.createFileUrl(event);

    print('Name: $photoName'); // Check Image name
    print('Mime: $mime'); // Check Image mime
    print('Bytes: $bytes'); // Check Image bytes
    print('Url: $url'); // Check Image url

    final droppedFile = DroppedFile(
      url: url,
      photoName: photoName,
      mime: mime,
      bytes: bytes,
    );

    widget.onDroppedFile(droppedFile);
  }
}