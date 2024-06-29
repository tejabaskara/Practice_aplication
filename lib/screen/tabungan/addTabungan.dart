import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas_login/dataSource/tabungan.dart';
import 'package:tugas_login/screen/anggota/detailAnggota.dart';

class addTabunganPage extends StatefulWidget {
  final Map<String, dynamic> anggotaDetail;
  const addTabunganPage({super.key, required this.anggotaDetail});

  @override
  State<addTabunganPage> createState() => _registerPageState();
}

class _registerPageState extends State<addTabunganPage> {
  final nominalTrxController = TextEditingController();
  final jenisTrxController = TextEditingController();

  int jenis_trx = 2;

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
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return detailAnggotaPage(
                    anggotaDetail: widget.anggotaDetail,
                  );
                },
              ));
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
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: DropdownButton<int>(
                value: jenis_trx,
                items: [
                  DropdownMenuItem<int>(
                    child: Text("Simpanan"),
                    value: 2,
                  ),
                  DropdownMenuItem<int>(
                    child: Text("Penarikan"),
                    value: 3,
                  ),
                ],
                onChanged: (int? value) {
                  if (value != null) {
                    setState(() {
                      jenis_trx = value;
                    });
                  }
                },
              ),
            ),
            formInput('Nominal (Rp)', nominalTrxController),
            Padding(
                padding: EdgeInsets.only(top: 10, bottom: 50),
                child: ElevatedButton(
                  onPressed: () {
                    addTabungan(widget.anggotaDetail, jenis_trx,
                        nominalTrxController, context);
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
