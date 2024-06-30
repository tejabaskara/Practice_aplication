import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas_login/component/formInput.dart';
import 'package:tugas_login/dataSource/tabungan.dart';
import 'package:tugas_login/screen/anggota/detailAnggota.dart';

class addBungaPage extends StatefulWidget {
  const addBungaPage({super.key});

  @override
  State<addBungaPage> createState() => _addBungaPageState();
}

class _addBungaPageState extends State<addBungaPage> {
  final nominalBungaController = TextEditingController();
  final aktifController = TextEditingController();

  int isAktif = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/bunga');
            },
          ),
          backgroundColor: Color(0xffACE1AF),
          title: const Center(
              child: Text("Tabungan Anggota",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold))),
        ),
        body: ListView(children: [
          Column(children: [
            formInput('Nominal Bunga(%)', nominalBungaController),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: DropdownButton<int>(
                value: isAktif,
                items: [
                  DropdownMenuItem<int>(
                    child: Text("Tidak Aktif"),
                    value: 0,
                  ),
                  DropdownMenuItem<int>(
                    child: Text("Aktif"),
                    value: 1,
                  ),
                ],
                onChanged: (int? value) {
                  if (value != null) {
                    setState(() {
                      isAktif = value;
                    });
                  }
                },
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10, bottom: 50),
                child: ElevatedButton(
                  onPressed: () {
                    addBunga(isAktif, nominalBungaController, context);
                  },
                  child: Text(
                    "TAMBAH",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(160, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Color(0xff8FFF74),
                      foregroundColor: Colors.black),
                ))
          ])
        ]));
  }
}
