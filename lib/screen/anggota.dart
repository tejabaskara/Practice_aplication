import 'package:flutter/material.dart';
import 'package:tugas_login/dataSource/api.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

final _storage = GetStorage();

class anggotaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
            icon: Icon(Icons.add),
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
            return Center(child: CircularProgressIndicator());
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
                  return Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text('${_storage.read('nama_${index + 1}')}'),
                        subtitle:
                            Text('${_storage.read('telepon_${index + 1}')}'),
                        trailing: PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text('Edit'),
                              value: 'Edit',
                            ),
                            PopupMenuItem(
                              child: Text('Delete'),
                              value: 'Delete',
                            ),
                            PopupMenuItem(
                              child: Text('Detail'),
                              value: 'Detail',
                            ),
                          ],
                          onSelected: (value) {
                            if (value == 'Edit') {
                              getEditAnggotaDetail(
                                  context, _storage.read('id_${index + 1}'));
                            } else if (value == 'Delete') {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              deleteUser(
                                                  context,
                                                  _storage
                                                      .read('id_${index + 1}'));
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
                                        contentPadding: EdgeInsets.all(20.0),
                                        content: Text(
                                          'Apakah anda yakin?',
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20)),
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
                                    title:
                                        Center(child: Text('Detail Anggota')),
                                    contentPadding: EdgeInsets.only(
                                        top: 20,
                                        bottom: 50,
                                        right: 20,
                                        left: 20),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text('Nama:',
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20))),
                                            ],
                                          ),
                                          Text(
                                              '${_storage.read('nama_${index + 1}')}',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20))),
                                          Row(
                                            children: [
                                              Text('Nomor Induk: ',
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20))),
                                            ],
                                          ),
                                          Text(
                                              '${_storage.read('nomor_induk_${index + 1}')}',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20))),
                                          Row(
                                            children: [
                                              Text('Telepon: ',
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20))),
                                            ],
                                          ),
                                          Text(
                                              '${_storage.read('telepon_${index + 1}')}',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20))),
                                          Row(
                                            children: [
                                              Text('Status Aktif:',
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20))),
                                            ],
                                          ),
                                          Text(
                                              _storage.read(
                                                          'status_aktif_${index + 1}') ==
                                                      1
                                                  ? "Aktif"
                                                  : "Tidak Aktif",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20))),
                                          Row(
                                            children: [
                                              Text('Alamat:',
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20))),
                                            ],
                                          ),
                                          Text(
                                              '${_storage.read('alamat_${index + 1}')}',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20))),
                                          Row(
                                            children: [
                                              Text('Tanggal Lahir:',
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20))),
                                            ],
                                          ),
                                          Text(
                                              '${_storage.read('tgl_lahir_${index + 1}')}',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20))),
                                        ],
                                      ),
                                    )),
                              );
                            }
                          },
                        )),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}




// class anggotaPage extends StatefulWidget {
//   const anggotaPage({super.key});

//   @override
//   State<anggotaPage> createState() => _anggotaPageState();
// }

// class _anggotaPageState extends State<anggotaPage> {
//   @override
//   Widget build(BuildContext context) {
//     getAnggota();
//     print(_storage.read('banyak_anggota'));
//     int index = _storage.read('banyak_anggota');

//     return Scaffold(
//         appBar: AppBar(
//           title: const Center(
//               child: Text("ANGGOTA",
//                   style: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold))),
//           backgroundColor: const Color(0xffcfe17c),
//         ),
//         body: Container(
//           child: ListView.separated(
//             padding: const EdgeInsets.all(10),
//             itemCount: index,
//             separatorBuilder: (BuildContext context, int index) =>
//                 const Divider(),
//             itemBuilder: (BuildContext context, int index) {
//               return Container(
//                   height: 50,
//                   color: Colors.amber,
//                   child: ListTile(
//                     title: Text('item $index'),
//                   )

//                   //  Column(children: [
//                   //   Row(
//                   //     children: [
//                   //       Text('Nama ${_storage.read('nama_${index + 1}')} \n'),
//                   //       Text('${_storage.read('index')}'),
//                   //     ],
//                   //   )
//                   // ]),
//                   );
//             },
//           ),
//         )

//         // Container(
//         //     child: ListView.separated(
//         //   padding: const EdgeInsets.all(8),
//         //   itemCount: _storage.read('index'),
//         //   itemBuilder: (BuildContext context, int index) {
//         //     return Container(
//         //         height: 100,
//         //         color: Colors.blue,
//         //         child: Center(
//         //           child: Column(children: [
//         //             Text('Nama ${_storage.read('nama_${index + 1}')}'),
//         //             Text(index.toString())
//         //           ]),
//         //         ));
//         //   },
//         //   separatorBuilder: (BuildContext context, int index) =>
//         //       const Divider(),
//         // ))

//         );
//   }
// }
