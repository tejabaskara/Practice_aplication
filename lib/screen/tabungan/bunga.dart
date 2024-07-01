import 'package:flutter/material.dart';
import 'package:tugas_login/component/text.dart';
import 'package:tugas_login/dataSource/tabungan.dart';
import 'package:tugas_login/screen/anggota/detailAnggota.dart';

class bungaPage extends StatefulWidget {
  const bungaPage({super.key});

  @override
  State<bungaPage> createState() => _bungaPageState();
}

class _bungaPageState extends State<bungaPage> {
  final _bungas = ValueNotifier<List<Map<String, dynamic>>>([]);
  bool _isLoading = false;
  double _bungaActive = 0.0;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchBunga();
  }

  Future<void> _fetchBunga() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final bungas = await getBunga(context);
      _bungas.value = bungas;
      for (var bunga in bungas) {
        if (bunga['isaktif'] == 1) {
          _bungaActive = bunga['persen'];
          print(bunga['persen'].toString());
        }
      }
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
                  padding: EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      textBoldStyle("Bunga Aktif", 20),
                      textBoldStyle("${_bungaActive.toString()} %", 20),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              textBoldStyle("List bunga", 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 18),
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
                          Navigator.pushNamed(context, '/addBunga');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            SizedBox(width: 5),
                            Flexible(child: textStyle("Tambah Bunga", 11))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : ValueListenableBuilder<List<Map<String, dynamic>>>(
                        valueListenable: _bungas,
                        builder: (context, bungas, _) {
                          return ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: bungas.length,
                            itemBuilder: (context, index) {
                              final bunga = bungas[index];
                              return Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return detailAnggotaPage(
                                          anggotaDetail: bunga,
                                        );
                                      },
                                    ));
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                      color: bunga['isaktif'] == 1
                                          ? Colors.blue
                                          : Color(0xffE0FBE2),
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
                                                  "${bunga['persen'].toString()} %",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
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
