// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'dart:js_interop';
import 'package:flutter/material.dart';
import 'package:flutter_image_to_text_ocr_app/constants/constants.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variable to hold the picked image file.
  File? _pickedImage;
  // Variable to hold the extracted text from the image.
  String? _extractedText;

  /// Method to pick image from gallery and perform OCR.
  Future<void> _pickFromGallery() async {
    Navigator.pop(context);
    try {
      final XFile? pickedImage = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 100);
      if (pickedImage != null) {
        setState(() {
          _pickedImage = File(pickedImage.path);
        });
        AppUtils.showSnackBar(context, 'Image Picked From Gallery');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _readTextFromImage() async {
    if (_pickedImage == null) {
      AppUtils.showSnackBar(
          context, 'Please pick an image first to extract text');
      return;
    }

    final inputImage = InputImage.fromFile(_pickedImage!);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    String text = recognizedText.text;

    textRecognizer.close();

    // Process the extracted text as required (e.g., display in a dialog).
    AppUtils.showDialogMethod(context, 'Extracted Text', text);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Image to Text OCR')),
      body: Container(
        height: size.height,
        width: size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: _pickedImage == null
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              if (_pickedImage == null)
                ElevatedButton(
                  onPressed: () {
                    _pickFromGallery();
                  },
                  child: const Text("Pick Image"),
                )
              else
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 300,
                      width: size.width,
                      child:
                          Image.file(_pickedImage!), // Displaying picked image.
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _readTextFromImage();
                      },
                      child: const Text("Extract Text"),
                    ),
                    const SizedBox(height: 16),
                    if (_extractedText != null)
                      Text(
                        'Extracted Text: $_extractedText',
                        style: const TextStyle(fontSize: 16),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
