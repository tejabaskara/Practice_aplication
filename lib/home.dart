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
      body: Column(
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
                  hintStyle: TextStyle(color: Color(0xffDDDADA), fontSize: 14),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 150,
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.food_bank, size: 50, color: Color(0xff95D975)),
                    Text('Food', style: GoogleFonts.inter(fontSize: 16)),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 150,
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.local_hospital,
                        size: 50, color: Color(0xffFF0000)),
                    Text('Health', style: GoogleFonts.inter(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
