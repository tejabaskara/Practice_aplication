import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas_login/dataSource/api.dart';

class registerPage extends StatefulWidget {
  const registerPage({super.key});

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isVisible = false;
  bool isVisibleConfirm = false;

  void dispose() {
    emailController.dispose();
    nameController.dispose();
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
          padding: EdgeInsets.only(top: 10),
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
            padding: EdgeInsets.only(top: 30),
            child: Center(
                child: SizedBox(
                    width: 276,
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
                    child: TextField(
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
                          )),
                    )))),
        Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
                child: SizedBox(
                    width: 276,
                    child: TextField(
                      controller: confirmPasswordController,
                      obscureText: !isVisibleConfirm,
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
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisibleConfirm = !isVisibleConfirm;
                              });
                            },
                            icon: (isVisibleConfirm
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                          )),
                    )))),
        Row(children: [
          Padding(
            padding: EdgeInsets.only(top: 10, left: 50),
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const loginPage()));
                },
                child: Text(
                  "Already have an Account ?",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: Color(0xff40B5AE),
                      fontSize: 12,
                    ),
                  ),
                )
                // Text(
                //   "Do have an Account ?",
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
            padding: EdgeInsets.only(top: 10, bottom: 50),
            child: ElevatedButton(
              onPressed: () {
                registerUser(nameController.text, emailController.text,
                    passwordController.text, context);
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) => const homePage()));
              },
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
                  minimumSize: Size(160, 50),
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
              image: AssetImage('assets/images/register_image.jpg'),
              fit: BoxFit.fitHeight,
            ),
          ),
        )));
  }

  // void goRegister() async {
  //   try {
  //     final _register = await _dio.post(
  //       '${_apiUrl}/register',
  //       data: {
  //         'name': nameController.text,
  //         'email': emailController.text,
  //         'password': passwordController.text
  //       },
  //     );
  //     final _login = await _dio.post(
  //       '${_apiUrl}/login',
  //       data: {
  //         'email': emailController.text,
  //         'password': passwordController.text
  //       },
  //     );
  //     _storage.write('token', _login.data['data']['token']);
  //     print(_register.data);
  //     print(_login.data);
  //     final _userInfo = await _dio.get(
  //       '${_apiUrl}/user',
  //       options: Options(
  //         headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
  //       ),
  //     );
  //     _storage.write('id', _userInfo.data['data']['user']['id']);
  //     _storage.write('email', _userInfo.data['data']['user']['email']);
  //     _storage.write('name', _userInfo.data['data']['user']['name']);
  //     print(_storage.read('id'));
  //     print(_storage.read('email'));
  //     print(_storage.read('name'));
  //     Navigator.pop(context);
  //     Navigator.pushReplacementNamed(context, '/home');
  //   } on DioException catch (e) {
  //     print('${e.response} - ${e.response?.statusCode}');
  //   }
  // }
}
