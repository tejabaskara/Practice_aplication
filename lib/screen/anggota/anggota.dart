import 'package:flutter/material.dart';
import 'package:tugas_login/dataSource/anggota.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

final _storage = GetStorage();

class anggotaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        title: const Center(
            child: Text("ANGGOTA",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold))),
        backgroundColor: const Color(0xffcfe17c),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/createAnggota');
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: getAnggota(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            int index = _storage.read('banyak_anggota');
            return Container(
              child: ListView.separated(
                padding: const EdgeInsets.all(10),
                itemCount: index,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return newMethod(index, context);
                },
              ),
            );
          }
        },
      ),
    );
  }

  Container newMethod(int index, BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
          leading: const Icon(Icons.person),
          title: Text('${_storage.read('nama_${index + 1}')}'),
          subtitle: Text('${_storage.read('telepon_${index + 1}')}'),
          trailing: PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'Edit',
                child: Text('Edit'),
              ),
              const PopupMenuItem(
                value: 'Delete',
                child: Text('Delete'),
              ),
              const PopupMenuItem(
                value: 'Detail',
                child: Text('Detail'),
              ),
            ],
            onSelected: (value) {
              if (value == 'Edit') {
                print("Edit");
              } else if (value == 'Delete') {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          actions: [
                            TextButton(
                              onPressed: () {
                                deleteUser(
                                    context, _storage.read('id_${index + 1}'));
                              },
                              child: const Text('ya'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('tidak'),
                            )
                          ],
                          contentPadding: const EdgeInsets.all(20.0),
                          content: Text(
                            'Apakah anda yakin?',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ),
                        ));
              } else if (value == 'Detail') {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('close'),
                        ),
                      ],
                      title: const Center(child: Text('Detail Anggota')),
                      contentPadding: const EdgeInsets.only(
                          top: 20, bottom: 50, right: 20, left: 20),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Nama:',
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20))),
                              ],
                            ),
                            Text('${_storage.read('nama_${index + 1}')}',
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Colors.black, fontSize: 20))),
                            Row(
                              children: [
                                Text('Nomor Induk: ',
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20))),
                              ],
                            ),
                            Text('${_storage.read('nomor_induk_${index + 1}')}',
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Colors.black, fontSize: 20))),
                            Row(
                              children: [
                                Text('Telepon: ',
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20))),
                              ],
                            ),
                            Text('${_storage.read('telepon_${index + 1}')}',
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Colors.black, fontSize: 20))),
                            Row(
                              children: [
                                Text('Status Aktif:',
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20))),
                              ],
                            ),
                            Text(
                                _storage.read('status_aktif_${index + 1}') == 1
                                    ? "Aktif"
                                    : "Tidak Aktif",
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Colors.black, fontSize: 20))),
                            Row(
                              children: [
                                Text('Alamat:',
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20))),
                              ],
                            ),
                            Text('${_storage.read('alamat_${index + 1}')}',
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Colors.black, fontSize: 20))),
                            Row(
                              children: [
                                Text('Tanggal Lahir:',
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20))),
                              ],
                            ),
                            Text('${_storage.read('tgl_lahir_${index + 1}')}',
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Colors.black, fontSize: 20))),
                          ],
                        ),
                      )),
                );
              }
            },
          )),
    );
  }
}
