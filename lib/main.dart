import 'package:flutter/material.dart';
import 'package:qr_scanner_generator/pages/home.dart';
import 'package:qr_scanner_generator/pages/qr_generator.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => HomeScreen(),
      '/generator': (context) => QRGeneratorScreen(),
    },
  ));
}
