import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tugas_login/component/dialogBox.dart';
import 'package:tugas_login/dataSource/anggota.dart';

class editAnggotaPage extends StatefulWidget {
  final Map<String, dynamic> anggotaDetail;
  const editAnggotaPage({super.key, required this.anggotaDetail});

  @override
  State<editAnggotaPage> createState() => _registerPageState();
}

class _registerPageState extends State<editAnggotaPage> {
  final nomerIndukController = TextEditingController();
  final namaController = TextEditingController();
  final alamatController = TextEditingController();
  final tglLahirController = TextEditingController();
  final teleponController = TextEditingController();
  int status_aktif = 1;

  bool isVisible = false;
  bool isVisibleConfirm = false;

  @override
  Widget build(BuildContext context) {
    // status_aktif = widget.anggotaDetail['status_aktif'];
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text("EDIT ANGGOTA",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold))),
          backgroundColor: const Color(0xffACE1AF),
        ),
        body: ListView(children: [
          Column(children: [
            formInput(
              "Nomer Induk",
              nomerIndukController,
              widget.anggotaDetail['nomor_induk'].toString(),
            ),
            formInput(
              'Nama',
              namaController,
              widget.anggotaDetail['nama'],
            ),
            formInput(
              'Alamat',
              alamatController,
              widget.anggotaDetail['alamat'],
            ),
            datePicker('Tanggal Lahir', tglLahirController,
                widget.anggotaDetail['tgl_lahir'], context),
            formInput(
              'Nomer Telepon',
              teleponController,
              widget.anggotaDetail['telepon'],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: DropdownButton<int>(
                value: widget.anggotaDetail['status_aktif'],
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
                      widget.anggotaDetail['status_aktif'] = value;
                    });
                  }
                },
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10, bottom: 50),
                child: ElevatedButton(
                  onPressed: () {
                    showReminderDialog(context, "Edit Anggota",
                        "Apakah anda yakin ingin mengubah data anggota?", () {
                      editAnggota(
                          widget.anggotaDetail['id'].toString(),
                          nomerIndukController,
                          teleponController,
                          widget.anggotaDetail['status_aktif'],
                          namaController,
                          alamatController,
                          tglLahirController,
                          context);
                    });
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

Widget formInput(String label, TextEditingController controller, data) {
  controller.text = data;
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

Widget datePicker(String label, TextEditingController controller, String date,
    BuildContext context) {
  controller.text = date;
  DateTime dataTtl = DateFormat('yyyy-MM-dd').parse(date);

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
          readOnly: true,
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: dataTtl,
              firstDate: DateTime(1900),
              lastDate: DateTime(2025),
            ).then((date) {
              if (date != null) {
                String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                controller.text = formattedDate;
              }
            });
          },
        ),
      )));
}
