import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas_login/register.dart';

// ignore: camel_case_types
class page1 extends StatefulWidget {
  const page1({super.key});

  @override
  State<page1> createState() => _page1State();
}

class _page1State extends State<page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        imageTop(),
        introText(),
        buttonLoginRegis(context),
        Padding(
            padding: EdgeInsets.only(top: 64),
            child: Center(
              child: Text(
                "Login or Register With",
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ),
            )),
        socialMediaButton(),
      ],
    ));
  }

  Padding socialMediaButton() {
    return Padding(
        padding: EdgeInsets.only(left: 80, top: 10),
        child: Row(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                  width: 60,
                  height: 60,
                  child: IconButton(
                    icon: Image.asset('assets/images/google_logo.png'),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                )),
            SizedBox(width: 20),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                  width: 60,
                  height: 60,
                  child: IconButton(
                    icon: Image.asset('assets/images/facebook_logo.png'),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                )),
            SizedBox(width: 20),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                  width: 60,
                  height: 60,
                  child: IconButton(
                    icon: Image.asset(
                      'assets/images/x_logo.jpg',
                      fit: BoxFit.fill,
                    ),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                )),
          ],
        ));
  }

  Center buttonLoginRegis(context) {
    return Center(
        child: Row(
      children: [
        Padding(
            padding: EdgeInsets.only(top: 75, left: 20),
            child: ElevatedButton(
              child: Text(
                "REGISTER",
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const page2()));
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(166, 70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Color(0xffD9D9D9),
                  foregroundColor: Colors.black),
            )
            // Container(
            //   width: 166,
            //   height: 70,
            //   child: Center(
            //     child: Text(
            //       "SIGN UP",
            //       style: GoogleFonts.inter(
            //         textStyle: TextStyle(
            //           color: Colors.black,
            //           fontSize: 12,
            //         ),
            //       ),
            //     ),
            //   ),
            //   decoration: BoxDecoration(
            //     color: Color(0xffD9D9D9),
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            // )
            ),
        SizedBox(width: 20),
        Padding(
            padding: EdgeInsets.only(top: 75, right: 20),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "LOGIN",
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(166, 70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Color(0xffD9D9D9),
                  foregroundColor: Colors.black),
            ))
      ],
    ));
  }

  Center introText() {
    return Center(
        child: Padding(
      padding: EdgeInsets.only(top: 50),
      child: Text(
        "JOIN US",
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ));
  }

  Center imageTop() {
    return Center(
        child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('assets/images/landing_image.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            )));
  }
}
