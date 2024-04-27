import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isChecked = false;
  bool isVisible = false;

  final _dio = Dio();
  final _storage = GetStorage();
  final _apiUrl = 'https://mobileapis.manpits.xyz/api';

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                    // height: 40,
                    child: TextFormField(
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    )))),
        Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
                child: SizedBox(
                    width: 276,
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: !isVisible,
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
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: (isVisible
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off)),
                        ),
                      ),
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter your password';
                      //   }
                      //   return null;
                      // },
                    )))),
        Row(children: [
          Padding(
              padding: EdgeInsets.only(top: 20, left: 40),
              child: Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value as bool;
                      });
                    },
                  ),
                  Text("Remember me",
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ))
                ],
              )),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 30),
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const registerPage()));
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
              onPressed: () {
                goLogin();
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/home');
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) => const homePage()));
              },
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

  void goLogin() async {
    try {
      final _response = await _dio.post(
        '${_apiUrl}/login',
        data: {
          'email': emailController.text,
          'password': passwordController.text
        },
      );
      print(_response.data);
      _storage.write('token', _response.data['data']['token']);
    } on DioException catch (e) {
      print('${e.response} - ${e.response?.statusCode}');
    }
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
