import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_storage/get_storage.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final _storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffbe7c9),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
                // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //     content: Text('This section is under development!')));
              },
              icon: Icon(
                Icons.account_circle,
                size: 40,
              )),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 280,
                decoration: BoxDecoration(
                  color: Color(0xfffbe7c9),
                  // image: DecorationImage(
                  //   image: AssetImage('assets/images/home_image.jpg'),
                  //   fit: BoxFit.fitHeight,
                  // ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 40),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Hello ${_storage.read('name')}",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                "Balances :",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.currency_pound_rounded,
                                color: Colors.green),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "999.999.999",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
              ),
              // Container(
              //   margin: EdgeInsets.only(top: 40, left: 20, right: 20),
              //   decoration: BoxDecoration(boxShadow: [
              //     BoxShadow(
              //         color: Color(0xff101617).withOpacity(0.11),
              //         blurRadius: 40,
              //         spreadRadius: 0.0)
              //   ]),
              //   child: TextField(
              //     decoration: InputDecoration(
              //         filled: true,
              //         fillColor: Colors.white,
              //         contentPadding: EdgeInsets.all(15),
              //         hintText: 'What your insterest?',
              //         hintStyle:
              //             TextStyle(color: Color(0xffDDDADA), fontSize: 14),
              //         prefixIcon: Icon(Icons.search),
              //         border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(15),
              //             borderSide: BorderSide.none)),
              //   ),
              // ),
              // Row(
              //   children: [
              //     Padding(
              //         padding: EdgeInsets.only(left: 20, top: 20),
              //         child: Container(
              //             width: 70,
              //             height: 35,
              //             decoration: BoxDecoration(
              //               color: Color(0xff8FFF74),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             child: Center(
              //               child: Text(
              //                 "Android",
              //                 style: GoogleFonts.poppins(
              //                   textStyle: TextStyle(
              //                     color: Colors.black,
              //                     fontSize: 12,
              //                   ),
              //                 ),
              //                 textAlign: TextAlign.center,
              //               ),
              //             ))),
              //     Padding(
              //         padding: EdgeInsets.only(left: 20, top: 20),
              //         child: Container(
              //             width: 70,
              //             height: 35,
              //             decoration: BoxDecoration(
              //               color: Color(0xff8FFF74),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             child: Center(
              //               child: Text(
              //                 "Cooking",
              //                 style: GoogleFonts.poppins(
              //                   textStyle: TextStyle(
              //                     color: Colors.black,
              //                     fontSize: 12,
              //                   ),
              //                 ),
              //                 textAlign: TextAlign.center,
              //               ),
              //             ))),
              //     Padding(
              //         padding: EdgeInsets.only(left: 20, top: 20),
              //         child: Container(
              //             width: 70,
              //             height: 35,
              //             decoration: BoxDecoration(
              //               color: Color(0xff8FFF74),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             child: Center(
              //               child: Text(
              //                 "Bussiness",
              //                 style: GoogleFonts.poppins(
              //                   textStyle: TextStyle(
              //                     color: Colors.black,
              //                     fontSize: 12,
              //                   ),
              //                 ),
              //                 textAlign: TextAlign.center,
              //               ),
              //             ))),
              //     Padding(
              //         padding: EdgeInsets.only(left: 20, top: 20),
              //         child: Container(
              //             width: 70,
              //             height: 35,
              //             decoration: BoxDecoration(
              //               color: Color(0xff8FFF74),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             child: Center(
              //               child: Text(
              //                 "Design",
              //                 style: GoogleFonts.poppins(
              //                   textStyle: TextStyle(
              //                     color: Colors.black,
              //                     fontSize: 12,
              //                   ),
              //                 ),
              //                 textAlign: TextAlign.center,
              //               ),
              //             ))),
              //   ],
              // ),
              // courseBox("Course 1", "4.5"),
              // courseBox("Course 2", "3.0"),
            ],
          )
        ],
      ),
    );
  }

  Padding courseBox(String courseName, review) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 20, right: 10),
      child: Container(
        width: 300,
        height: 150,
        decoration: BoxDecoration(
          color: Color(0xffD8FFC6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(courseName,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ))),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                  ),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color(0xffD9D9D9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text('image',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          )),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 100),
                          child: Icon(Icons.star, color: Colors.yellow),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(review,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: Color(0xff0066FF),
                                  fontSize: 20,
                                ),
                              )),
                        ),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                          top: 10,
                          left: 10,
                        ),
                        child: Text(
                            'Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit.\nPraesent vel. ',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ))),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'List Anggota',
      ),
    ], selectedItemColor: Colors.amber, onTap: _onTap);
  }

  _onTap(int tabIndex) {
    switch (tabIndex) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, "/anggota");
        break;
    }
  }
}
