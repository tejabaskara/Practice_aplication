import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffbe7c9),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('This section is under development!')));
              },
              icon: Icon(
                Icons.account_circle,
                size: 40,
              )),
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                  // width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    color: Color(0xfffbe7c9),
                    image: DecorationImage(
                      image: AssetImage('assets/images/home_image.jpg'),
                      fit: BoxFit.fitHeight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Color(0xff101617).withOpacity(0.11),
                      blurRadius: 40,
                      spreadRadius: 0.0)
                ]),
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(15),
                      hintText: 'What your insterest?',
                      hintStyle:
                          TextStyle(color: Color(0xffDDDADA), fontSize: 14),
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none)),
                ),
              ),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Container(
                          width: 70,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Color(0xff8FFF74),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Android",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ))),
                  Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Container(
                          width: 70,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Color(0xff8FFF74),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Cooking",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ))),
                  Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Container(
                          width: 70,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Color(0xff8FFF74),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Bussiness",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ))),
                  Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Container(
                          width: 70,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Color(0xff8FFF74),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Design",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ))),
                ],
              ),
              courseBox("Course 1", "4.5"),
              courseBox("Course 2", "3.0"),
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
}
