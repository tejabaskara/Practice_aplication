import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas_login/register.dart';

class page3 extends StatefulWidget {
  const page3({super.key});

  @override
  State<page3> createState() => _page3State();
}

class _page3State extends State<page3> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      Column(children: [
        imageTop(),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Center(
            child: Text(
              "Login",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
                child: SizedBox(
                    width: 276,
                    height: 40,
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        fillColor: Color(0xffD9D9D9),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.blueGrey, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                      ),
                      onChanged: (value) {
                        print(emailController.text);
                      },
                    )))),
        Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
                child: SizedBox(
                    width: 276,
                    height: 40,
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        fillColor: Color(0xffD9D9D9),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.blueGrey, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                      ),
                      onChanged: (value) {
                        print(passwordController.text);
                      },
                    )))),
        Row(children: [
          Padding(
            padding: EdgeInsets.only(top: 10, left: 50),
            child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const page2()));
                },
                child: Text(
                  "Don't have an Account ?",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: Color(0xff40B5AE),
                      fontSize: 12,
                    ),
                  ),
                )
                // Text(
                //   "Don't have an Account ?",
                //   style: GoogleFonts.inter(
                //     textStyle: TextStyle(
                //       color: Color(0xff40B5AE),
                //       fontSize: 12,
                //     ),
                //   ),
                // )
                ),
          )
        ]),
        Padding(
            padding: EdgeInsets.only(top: 30),
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
                  minimumSize: Size(158, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Color(0xff8FFF74),
                  foregroundColor: Colors.black),
            ))
      ])
    ]));
  }

  Padding imageTop() {
    return Padding(
        padding: EdgeInsets.only(top: 50),
        child: Center(
            child: Container(
          width: 280,
          height: 190,
          decoration: BoxDecoration(
            // color: Color(0xffD9D9D9),
            image: DecorationImage(
              image: AssetImage('assets/images/login_image.jpg'),
              fit: BoxFit.fitHeight,
            ),
          ),
        )));
  }
}
