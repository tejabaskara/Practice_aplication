import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas_login/dataSource/anggota.dart';

class createAnggotaPage extends StatefulWidget {
  const createAnggotaPage({super.key});

  @override
  State<createAnggotaPage> createState() => _registerPageState();
}

class _registerPageState extends State<createAnggotaPage> {
  final nomerIndukController = TextEditingController();
  final namaController = TextEditingController();
  final alamatController = TextEditingController();
  final tglLahirController = TextEditingController();
  final teleponController = TextEditingController();
  final saldoController = TextEditingController();
  int status_aktif = 1;

  bool isVisible = false;
  bool isVisibleConfirm = false;

  void dispose() {
    nomerIndukController.dispose();
    namaController.dispose();
    alamatController.dispose();
    tglLahirController.dispose();
    teleponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text("TAMBAH ANGGOTA",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold))),
          backgroundColor: const Color(0xffcfe17c),
        ),
        body: ListView(children: [
          Column(children: [
            Padding(
                padding: EdgeInsets.only(top: 20),
                child: Center(
                    child: SizedBox(
                        width: 276,
                        child: TextField(
                          controller: nomerIndukController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nomer Induk',
                            fillColor: Color(0xffD9D9D9),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.blueGrey, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1),
                            ),
                          ),
                          onChanged: (value) {
                            print(nomerIndukController.text);
                          },
                        )))),
            formInput('Nama', namaController),
            formInput('Alamat', alamatController),
            formInput('Tanggal Lahir', tglLahirController),
            formInput('Nomer Telepon', teleponController),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: DropdownButton<int>(
                value: status_aktif,
                items: [
                  DropdownMenuItem<int>(
                    child: Text("Aktif"),
                    value: 1,
                  ),
                  DropdownMenuItem<int>(
                    child: Text("Tidak Aktif"),
                    value: 0,
                  ),
                ],
                onChanged: (int? value) {
                  if (value != null) {
                    setState(() {
                      status_aktif = value;
                    });
                  }
                },
              ),
            ),
            formInput('Saldo', saldoController),
            Padding(
                padding: EdgeInsets.only(top: 10, bottom: 50),
                child: ElevatedButton(
                  onPressed: () {
                    createAnggota(
                        nomerIndukController,
                        teleponController,
                        status_aktif,
                        namaController,
                        alamatController,
                        tglLahirController,
                        saldoController,
                        context);
                  },
                  child: Text(
                    "SUBMIT",
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

Widget formInput(String label, TextEditingController controller) {
  return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Center(
          child: SizedBox(
              width: 276,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: label,
                  fillColor: Color(0xffD9D9D9),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blueGrey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red, width: 1),
                  ),
                ),
                onChanged: (value) {
                  print(controller.text);
                },
              ))));
}
