import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:qr_image_generator/qr_image_generator.dart';
import 'package:path_provider/path_provider.dart';

class QRGeneratorScreen extends StatefulWidget {
  const QRGeneratorScreen({super.key});

  @override
  State<QRGeneratorScreen> createState() => _QRGeneratorScreenState();
}

class _QRGeneratorScreenState extends State<QRGeneratorScreen> {
  final informationController = TextEditingController();
  final fileNameController = TextEditingController();

  Future saveQrImage(String data, String fileName) async{
    String? fileDirectory = await FilePicker.platform.getDirectoryPath();
    String? filePath = "${fileDirectory.toString()}/${fileName.toString()}.png";

    final generator = QRGenerator();

    await generator.generate(
      data: data,
      filePath: filePath,
      scale: 10,
      padding: 2,
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      errorCorrectionLevel: ErrorCorrectionLevel.medium,
    );
  }

  @override
  void dispose() {
    super.dispose();
    informationController.dispose();
    fileNameController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'QR code generator', 
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
              child: TextField(
                controller: informationController,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
              child: TextField(
                controller: fileNameController,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(fixedSize: Size(150, 10)),
                  onPressed: () async {
                    await saveQrImage(informationController.text, fileNameController.text);
                  },
                  child: Text(
                    "Generate"
                  ),
                ),
              ]
            ),
          ],
        ),
      )
    ); 
  }
}