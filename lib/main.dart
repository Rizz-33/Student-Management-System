import 'package:flutter/material.dart';
import 'package:inclass_test/read.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ReadDetails(),
    );
  }
}
