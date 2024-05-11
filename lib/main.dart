import 'package:flutter/material.dart';
import 'package:tugas_login/screen/anggota.dart';
import 'package:tugas_login/screen/home.dart';
import 'package:tugas_login/screen/landing.dart';
import 'package:tugas_login/screen/login.dart';
import 'package:tugas_login/screen/profile.dart';
import 'package:tugas_login/screen/register.dart';
import 'package:tugas_login/screen/editAnggota.dart';
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
        '/anggota': (context) => anggotaPage(),
        '/editAnggota': (context) => editAnggotaPage(),
      },
      initialRoute: '/',
      // home: page1(),
      debugShowCheckedModeBanner: false,
    );
  }
}
