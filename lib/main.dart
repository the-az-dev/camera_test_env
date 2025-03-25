import 'package:flutter/material.dart';
import 'flows/record/presentation/screens/record_preview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RecordPreviewScreen(),
    );
  }
}