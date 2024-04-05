import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class page2 extends StatefulWidget {
  const page2({super.key});

  @override
  State<page2> createState() => _page2State();
}

class _page2State extends State<page2> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      Column(children: [
        Padding(
            padding: EdgeInsets.only(top: 50),
            child: Center(
                child: Container(
              width: 280,
              height: 190,
              decoration: BoxDecoration(
                // color: Color(0xffD9D9D9),
                image: DecorationImage(
                  image: AssetImage('assets/images/register_image.jpg'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ))),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Center(
            child: Text(
              "Register",
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
            padding: EdgeInsets.only(top: 50),
            child: Center(
                child: SizedBox(
                    width: 276,
                    height: 40,
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
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
                        print(nameController.text);
                      },
                    )))),
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
        Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
                child: SizedBox(
                    width: 276,
                    height: 40,
                    child: TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
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
                        print(confirmPasswordController.text);
                      },
                    )))),
        Row(children: [
          Padding(
              padding: EdgeInsets.only(top: 30, left: 60),
              child: Text(
                "Do have an Account ?",
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    color: Color(0xff40B5AE),
                    fontSize: 12,
                  ),
                ),
              )),
        ]),
        Padding(
            padding: EdgeInsets.only(top: 30),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "REGISTER",
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
                  backgroundColor: Color(0xffD9D9D9),
                  foregroundColor: Colors.black),
            ))
      ])
    ]));
  }
}
