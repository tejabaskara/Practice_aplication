import 'package:flutter/material.dart';

class anggotaPage extends StatefulWidget {
  const anggotaPage({super.key});

  @override
  State<anggotaPage> createState() => _anggotaPageState();
}

class _anggotaPageState extends State<anggotaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text("ANGGOTA",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold))),
        backgroundColor: const Color(0xffcfe17c),
      ),
      body: const Center(
        child: Text('Anggota Page'),
      ),
    );
  }
}
