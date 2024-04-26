import 'package:flutter/material.dart';
import 'package:tugas_login/home.dart';
import 'package:tugas_login/landing.dart';
import 'package:tugas_login/login.dart';
import 'package:tugas_login/profile.dart';
import 'package:tugas_login/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const page1(),
        '/register': (context) => const registerPage(),
        '/login': (context) => const loginPage(),
        '/home': (context) => const homePage(),
        '/profile': (context) => const profilePage(),
      },
      initialRoute: '/',
      // home: page1(),
      debugShowCheckedModeBanner: false,
    );
  }
}
