import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_login/component/format.dart';
import 'package:tugas_login/component/text.dart';
import 'package:tugas_login/dataSource/anggota.dart';
import 'package:tugas_login/screen/anggota/detailAnggota.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final _storage = GetStorage();
  final _anggotas = ValueNotifier<List<Map<String, dynamic>>>([]);
  bool _isLoading = false;

  int _currentIndex = 1;
  int anggotaCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchAnggota();
  }

  Future<void> _fetchAnggota() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final anggotas = await getAllAnggota(context);
      _anggotas.value = anggotas;
      anggotaCount = anggotas.length;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 110,
                decoration: BoxDecoration(
                  color: Color(0xffB0EBB4),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 40),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            textBoldStyle("Hello, ${_storage.read('name')}", 20)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              textBoldStyle("List Anggota", 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 18),
                    child: textStyle(
                        "Banyak Anggota: ${anggotaCount.toString()}", 12),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 10),
                    child: SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffB0EBB4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/createAnggota');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            SizedBox(width: 5),
                            Flexible(child: textStyle("Tambah Anggota", 11))
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 31, top: 18),
                  //   child: Container(
                  //     width: 170,
                  //     height: 40,
                  //     child: TextField(
                  //       decoration: InputDecoration(
                  //         hintText: 'Cari nama',
                  //         prefixIcon: Icon(Icons.search),
                  //         border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(20),
                  //         ),
                  //         filled: true,
                  //         fillColor: Color(0xfff0f0f0),
                  //         enabledBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(10),
                  //           borderSide:
                  //               BorderSide(color: Color(0xffB0EBB4), width: 1),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : ValueListenableBuilder<List<Map<String, dynamic>>>(
                        valueListenable: _anggotas,
                        builder: (context, anggotas, _) {
                          return ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: anggotas.length,
                            itemBuilder: (context, index) {
                              anggotaCount = anggotas.length;
                              final anggota = anggotas[index];
                              return Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return detailAnggotaPage(
                                          anggotaDetail: anggota,
                                        );
                                      },
                                    ));
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                      color: Color(0xffE0FBE2),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 17),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  anggota['nama'],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                textStyle(
                                                    anggota['telepon'], 11),
                                                SizedBox(height: 5),
                                                textStyle(
                                                    anggota['alamat'], 11),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                textBoldStyle(
                                                    CurrencyFormat.convertToIdr(
                                                        anggota['saldo'], 2),
                                                    16),
                                                SizedBox(height: 5),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffACE1AF),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.circle,
                                                        color:
                                                            anggota['status_aktif'] ==
                                                                    1
                                                                ? Colors.green
                                                                : Colors.red,
                                                        size: 10,
                                                      ),
                                                      SizedBox(width: 5),
                                                      textStyle(
                                                          anggota['status_aktif'] ==
                                                                  1
                                                              ? 'Aktif'
                                                              : 'Tidak Aktif',
                                                          11),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.money),
          label: 'Bunga',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _currentIndex,
      selectedItemColor: Colors.blue,
      backgroundColor: Color(0xffBFF6C3),
      onTap: _onTap,
    );
  }

  void _onTap(int tabIndex) {
    switch (tabIndex) {
      case 0:
        Navigator.pushNamed(context, '/bunga');
        break;
      case 1:
        Navigator.pushNamed(context, '/home');
        break;
      case 2:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }
}
