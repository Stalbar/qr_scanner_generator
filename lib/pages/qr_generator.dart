import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGeneratorScreen extends StatefulWidget {
  const QRGeneratorScreen({super.key});

  @override
  State<QRGeneratorScreen> createState() => _QRGeneratorScreenState();
}

class _QRGeneratorScreenState extends State<QRGeneratorScreen> {
  final informationController = TextEditingController();
  final fileNameController = TextEditingController();
  String information = "";

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
                  onPressed: () {
                    setState(() {
                      information = informationController.text;
                    });
                  },
                  child: Text(
                    "Generate"
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(fixedSize: Size(150, 10)),
                  onPressed: () {}, 
                  child: Text(
                    "Save",
                  )
                )
              ]
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
              child: QrImage(
                data: information,
                version: QrVersions.auto,
                size: 200.0,
              )
            ),
          ],
        ),
      )); 
  }
}