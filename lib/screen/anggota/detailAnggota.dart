import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas_login/component/dialogBox.dart';
import 'package:tugas_login/component/format.dart';
import 'package:tugas_login/component/text.dart';
import 'package:tugas_login/dataSource/anggota.dart';
import 'package:tugas_login/dataSource/tabungan.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_login/screen/anggota/editAnggota.dart';
import 'package:tugas_login/screen/tabungan/addTabungan.dart';

class detailAnggotaPage extends StatefulWidget {
  final Map<String, dynamic> anggotaDetail;
  const detailAnggotaPage({super.key, required this.anggotaDetail});

  @override
  State<detailAnggotaPage> createState() => _detailTabunganState();
}

class _detailTabunganState extends State<detailAnggotaPage> {
  final _trxHistories = ValueNotifier<List<Map<String, dynamic>>>([]);
  final _trxType = ValueNotifier<List<Map<String, dynamic>>>([]);
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchTrxHistories();
    _fetchTrxType();
  }

  Future<void> _fetchTrxType() async {
    final trxType = await getTrxType(context);
    _trxType.value = trxType;
  }

  Future<void> _fetchTrxHistories() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final trxHistories =
          await getAllTrxMember(context, widget.anggotaDetail['id'].toString());
      _trxHistories.value = trxHistories;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _getTrxTypeName(int id) {
    List<Map<String, dynamic>> trxTypeList = _trxType.value;
    if (trxTypeList.isNotEmpty && id >= 1 && id <= trxTypeList.length) {
      return trxTypeList[id - 1]['trx_name'];
    } else {
      return 'Transaksi';
    }
  }

  // final _storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffACE1AF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        title: const Center(
            child: Text("Detail Anggota",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold))),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return addTabunganPage(
                  anggotaDetail: widget.anggotaDetail,
                );
              }));
            },
          ),
        ],
      ),
      body: Column(children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffB0EBB4),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 17, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textBoldStyle(widget.anggotaDetail['nama'], 25),
                    SizedBox(height: 5),
                    textStyle(widget.anggotaDetail['telepon'], 18),
                    SizedBox(height: 5),
                    textStyle(widget.anggotaDetail['alamat'], 18),
                    SizedBox(height: 5),
                    textStyle(
                        widget.anggotaDetail['nomor_induk'].toString(), 18),
                    SizedBox(height: 5),
                    textStyle(widget.anggotaDetail['tgl_lahir'], 18),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    textBoldStyle(
                        CurrencyFormat.convertToIdr(
                            widget.anggotaDetail['saldo'], 2),
                        25),
                    SizedBox(height: 5),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Color(0xffACE1AF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: widget.anggotaDetail['status_aktif'] == 1
                                ? Colors.green
                                : Colors.red,
                            size: 17,
                          ),
                          SizedBox(width: 15),
                          textStyle(
                              widget.anggotaDetail['status_aktif'] == 1
                                  ? 'Aktif'
                                  : 'Tidak Aktif',
                              18),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 17, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => editAnggotaPage(
                            anggotaDetail: widget.anggotaDetail,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            size: 17,
                          ),
                          SizedBox(width: 15),
                          textStyle('Edit Anggota', 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      showReminderDialog(context, "Hapus Anggota",
                          "Apakah anda yakin ingin menghapus anggota?", () {
                        deleteUser(
                            context, widget.anggotaDetail['id'].toString());
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            size: 17,
                          ),
                          SizedBox(width: 15),
                          textStyle('Hapus Anggota', 18),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
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
        Expanded(
          child: _isLoading
              ? Center(child: const CircularProgressIndicator())
              : ValueListenableBuilder<List<Map<String, dynamic>>>(
                  valueListenable: _trxHistories,
                  builder: (context, trxHistories, _) {
                    if (trxHistories.isEmpty) {
                      return const Center(
                        child: Text(
                          'Tidak ada riwayat transaksi',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      );
                    } else {
                      return SingleChildScrollView(
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: trxHistories.length,
                          itemBuilder: (context, index) {
                            final trx = trxHistories[index];
                            return Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/home');
                                },
                                child: Card(
                                  color: trx['trx_id'] == 1
                                      ? Colors.white
                                      : trx['trx_id'] == 2
                                          ? Colors.green
                                          : trx['trx_id'] == 3
                                              ? Colors.red
                                              : Colors.yellow,
                                  child: ListTile(
                                    title: trx['trx_id'] == 1
                                        ? textStyle('Saldo Awal', 11)
                                        : trx['trx_id'] == 2
                                            ? textStyle(
                                                "Simpanan ${trx['id']}", 11)
                                            : trx['trx_id'] == 3
                                                ? textStyle(
                                                    "Penarikan ${trx['id']}",
                                                    11)
                                                : textStyle(
                                                    "Bunga Simpanan ${trx['id']}",
                                                    11),
                                    subtitle: textStyle(
                                        CurrencyFormat.convertToIdr(
                                            trx['trx_nominal'], 2),
                                        11),
                                    trailing: textStyle(trx['trx_tanggal'], 11),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
        ),
      ]),
    );
  }
}
