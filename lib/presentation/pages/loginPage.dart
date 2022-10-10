import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.deepPurpleAccent,
            ),
            child: Container(
              margin: const EdgeInsets.only(left: 40, right: 30),
              child: Center(
                child: Text('Welcome To Mega',
                    style: GoogleFonts.rubik(
                        fontSize: 54,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
              ),
            ),
          ),
          TextFormField()
        ],
      ),
    );
  }
}
