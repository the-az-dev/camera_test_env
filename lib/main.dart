import 'package:camera/camera.dart';
import 'package:camera_dev/flows/record/presentation/screens/record_screen.dart';
import 'package:flutter/material.dart';

import 'flows/record/presentation/screens/project_editor_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: RecordScreen(),
    );
  }
}