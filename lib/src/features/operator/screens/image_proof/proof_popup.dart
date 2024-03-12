import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/constants/sizes.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class ImageProof extends StatefulWidget {
  final List<String> proofPicUrls;

  const ImageProof(this.proofPicUrls, {Key? key}) : super(key: key);

  @override
  State<ImageProof> createState() => ImageProofState();
}

class ImageProofState extends State<ImageProof> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      icon: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
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
            Text(
              'Proof Images',
              style: CTextTheme.blackTextTheme.displayLarge,
            ),
            const SizedBox(height: cDefaultSize),
            if (widget.proofPicUrls.isNotEmpty)
              Image.network(
                widget.proofPicUrls[currentIndex],
                width: double.infinity,
                height: 350,
                fit: BoxFit.contain,
              ),
            const SizedBox(height: cDefaultSize),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.proofPicUrls.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: currentIndex == index
                            ? Colors.blue
                            : Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(widget.proofPicUrls[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}