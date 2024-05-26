import 'package:flutter/material.dart';
import 'package:tugas_login/dataSource/anggota.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

final _storage = GetStorage();

class tabunganPage extends StatelessWidget {
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
            child: Text("Tabungan Anggota",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold))),
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
                    const SizedBox(
                  height: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0xffD9D9D9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: Text('${_storage.read('nama_${index + 1}')}'),
                        subtitle: Text(
                            'Rp ${_storage.read('saldo_${_storage.read('id_${index + 1}')}')}'),
                        trailing: IconButton(
                          icon: Icon(Icons.info_outline_rounded),
                          onPressed: () {
                            getAnggotaDetail(_storage.read('id_${index + 1}'));
                            print(
                                'id anggota: ${_storage.read('id_${index + 1}')}');
                            Navigator.pushNamed(context, '/detailTabungan');
                          },
                        ),
                      ));
                },
              ),
            );
          }
        },
      ),
    );
  }
}
