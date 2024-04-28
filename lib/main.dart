import 'package:flutter/material.dart';
import 'package:tugas_login/anggota.dart';
import 'package:tugas_login/home.dart';
import 'package:tugas_login/landing.dart';
import 'package:tugas_login/login.dart';
import 'package:tugas_login/profile.dart';
import 'package:tugas_login/register.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage.init;
  runApp(const MyApp());
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
        '/anggota': (context) => const anggotaPage(),
      },
      initialRoute: '/',
      // home: page1(),
      debugShowCheckedModeBanner: false,
    );
  }
}
