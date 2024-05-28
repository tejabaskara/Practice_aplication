import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas_login/dataSource/anggota.dart';
import 'package:tugas_login/dataSource/tabungan.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_login/screen/tabungan/addTabungan.dart';

class detailTabunganPage extends StatefulWidget {
  const detailTabunganPage({super.key});

  @override
  State<detailTabunganPage> createState() => _detailTabunganState();
}

class _detailTabunganState extends State<detailTabunganPage> {
  final _storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/tabungan');
          },
        ),
        title: const Center(
            child: Text("Detail Tabungan Anggota",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold))),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/addTabungan');
            },
          ),
        ],
      ),
      body: Column(children: [
        Container(
          height: 240,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffD9D9D9),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 16),
                    child: Text('${_storage.read('anggota_nama')}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 5),
                    child: Text(
                      '${_storage.read('anggota_telepon')}',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 5),
                    child: Text(
                      '${_storage.read('anggota_alamat')}',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 5),
                    child: Text(
                      _storage.read('anggota_status_aktif') == 1
                          ? "Aktif"
                          : "Tidak Aktif",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 5),
                    child: Text(
                      'Total Saldo',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Rp. ${_storage.read('saldo_${_storage.read('anggotaId')}')}',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Text("Riwayat Transaksi",
              style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
        SizedBox(
          height: 15,
        ),
        FutureBuilder(
            future: getRiwayat(_storage.read('anggotaId')),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                int index = _storage.read('banyak_riwayat');

                return Expanded(
                  child: ListView.builder(
                    itemCount: index,
                    itemBuilder: (context, index) {
                      return Card(
                        color: _storage.read('trx_id_${index + 1}') == 1
                            ? Colors.white
                            : _storage.read('trx_id_${index + 1}') == 2
                                ? Colors.green
                                : _storage.read('trx_id_${index + 1}') == 3
                                    ? Colors.red
                                    : Colors.yellow,
                        child: ListTile(
                          title: _storage.read('trx_id_${index + 1}') == 1
                              ? Text('Saldo Awal')
                              : _storage.read('trx_id_${index + 1}') == 2
                                  ? Text("Simpanan")
                                  : _storage.read('trx_id_${index + 1}') == 3
                                      ? Text("Penarikan")
                                      : Text("Bunga Simpanan"),
                          subtitle: Text(
                              'Rp ${_storage.read('trx_nominal_${index + 1}')}'),
                          trailing: Text(
                              '${_storage.read('trx_tanggal_${index + 1}')}'),
                        ),
                      );
                    },
                  ),
                );
              }
            }),
      ]),
    );
  }
}
