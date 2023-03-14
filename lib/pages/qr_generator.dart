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

  Future saveQrImage(String data, String fileName) async {
    if (fileName == '' || data == '') {
      return;
    }
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
        title: const Text(
          'QR code generator',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Data',
              ),
              controller: informationController,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'File Name',
              ),
              controller: fileNameController,
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: const Size(150, 10)),
              onPressed: () async {
                await saveQrImage(
                    informationController.text, fileNameController.text);
              },
              child: const Text("Generate"),
            ),
          ]),
        ],
      ),
    ));
  }
}
