import 'package:flutter/material.dart';
import 'package:tugas_login/dataSource/api.dart';
import 'package:get_storage/get_storage.dart';

final _storage = GetStorage();

class anggotaPage extends StatelessWidget {
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
                              print('Delete');
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
                                    title: Text('Detail Anggota'),
                                    contentPadding: EdgeInsets.all(20.0),
                                    content: Column(
                                      children: [
                                        Text(
                                            'Nama: ${_storage.read('nama_${index + 1}')}'),
                                        Text(
                                            'Nomor Induk: ${_storage.read('nomor_induk_${index + 1}')}'),
                                        Text(
                                            'Telepon: ${_storage.read('telepon_${index + 1}')}'),
                                        Text(
                                            'Status Aktif: ${_storage.read('status_aktif_${index + 1}')}'),
                                        Text(
                                            'Alamat: ${_storage.read('alamat_${index + 1}')}'),
                                        Text(
                                            'Tanggal Lahir: ${_storage.read('tgl_lahir_${index + 1}')}'),
                                      ],
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
