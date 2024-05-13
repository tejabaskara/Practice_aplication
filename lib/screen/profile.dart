import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_login/dataSource/api.dart';

class profilePage extends StatefulWidget {
  const profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  final _storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    // userInfo();
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("PROFILE",
                style: GoogleFonts.inter(
                    textStyle: TextStyle(color: Colors.black),
                    fontWeight: FontWeight.bold))),
        backgroundColor: Color(0xffcfe17c),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 28),
                  child: Center(
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage:
                          AssetImage('assets/images/profile_image.jpg'),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Container(
                          width: 280,
                          height: 20,
                          child: Text('Email',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ))),
                      Center(
                          child: Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Container(
                          width: 280,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xffD9D9D9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                              padding: EdgeInsets.only(top: 5, left: 10),
                              child: Text(_storage.read('email'),
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ))),
                        ),
                      ))
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Container(
                          width: 280,
                          height: 20,
                          child: Text("Name",
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ))),
                      Center(
                          child: Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Container(
                          width: 280,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xffD9D9D9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                              padding: EdgeInsets.only(top: 5, left: 10),
                              child: Text(_storage.read('name'),
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ))),
                        ),
                      ))
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'This section is under development!')));
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Edit Profile",
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(160, 50),
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Colors.blue,
                              // foregroundColor: Colors.black),
                            ))),
                    Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              logoutUser(context);
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
                            },
                            icon: Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Logout",
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(160, 50),
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Colors.red,
                              // foregroundColor: Colors.black),
                            ))),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
