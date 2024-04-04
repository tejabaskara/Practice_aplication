import 'package:flutter/material.dart';
import 'package:tugas_login/page1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: page1(),
      debugShowCheckedModeBanner: false,
    );
  }
}
