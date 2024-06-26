import 'package:flutter/material.dart';
import 'package:tugas_login/screen/dashboard/home.dart';
import 'package:tugas_login/screen/dashboard/landing.dart';
import 'package:tugas_login/screen/loginRegister/login.dart';
import 'package:tugas_login/screen/loginRegister/profile.dart';
import 'package:tugas_login/screen/loginRegister/register.dart';
import 'package:tugas_login/screen/anggota/createAnggota.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_login/screen/tabungan/addBunga.dart';
import 'package:tugas_login/screen/tabungan/bunga.dart';

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
        '/createAnggota': (context) => createAnggotaPage(),
        '/bunga': (context) => bungaPage(),
        '/addBunga': (context) => addBungaPage(),
      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
