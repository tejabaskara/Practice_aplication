import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas_login/dataSource/api.dart';
import 'package:get_storage/get_storage.dart';

class createAnggotaPage extends StatefulWidget {
  const createAnggotaPage({super.key});

  @override
  State<createAnggotaPage> createState() => _registerPageState();
}

class _registerPageState extends State<createAnggotaPage> {
  final _storage = GetStorage();

  final nomerIndukController = TextEditingController();
  final namaController = TextEditingController();
  final alamatController = TextEditingController();
  final tglLahirController = TextEditingController();
  final teleponController = TextEditingController();
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
            Padding(
                padding: EdgeInsets.only(top: 10, bottom: 50),
                child: ElevatedButton(
                  onPressed: () {
                    createAnggota(
                        context,
                        int.parse(nomerIndukController.text),
                        teleponController.text,
                        status_aktif,
                        namaController.text,
                        alamatController.text,
                        tglLahirController.text);
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