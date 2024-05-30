// main.dart
import 'package:flutter/material.dart';
import 'ex_device_info_plus.dart';
import 'ex_get.dart';

void main() {
  runApp(const MyApp());
  // runApp(const ExGetApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const DeviceInfoPlus(),
    );
  }
}
