import 'package:flutter/material.dart';

class page2 extends StatefulWidget {
  const page2({super.key});

  @override
  State<page2> createState() => _page2State();
}

class _page2State extends State<page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
            padding: EdgeInsets.only(top: 64),
            child: Center(
                child: Container(
              width: 280,
              height: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/google_logo.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ))),
      ],
    ));
  }
}
