import 'package:flutter/material.dart';
import 'package:tugas_login/dataSource/api.dart';
import 'package:get_storage/get_storage.dart';

class anggotaPage extends StatefulWidget {
  const anggotaPage({super.key});

  @override
  State<anggotaPage> createState() => _anggotaPageState();
}

class _anggotaPageState extends State<anggotaPage> {
  final _storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    getAnggota();
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text("ANGGOTA",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold))),
          backgroundColor: const Color(0xffcfe17c),
        ),
        body: Container(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _storage.read('index'),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  color: Colors.amber,
                  child: Column(children: [
                    Text('Nama ${_storage.read('nama_${index + 1}')}'),
                    Text(index.toString())
                  ]),
                );
              }),
        ));
  }
}
