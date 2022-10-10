import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scale_button/scale_button.dart';

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
          const LoginForms(),
        ],
      ),
    );
  }
}

class LoginForms extends StatefulWidget {
  const LoginForms({super.key});

  @override
  State<LoginForms> createState() => _LoginFormsState();
}

class _LoginFormsState extends State<LoginForms> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      child: ListView(
        shrinkWrap: true,
        children: [
          TextFormField(
            decoration: const InputDecoration(
                label: Text('Username'), border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: const InputDecoration(
                label: Text('Password'), border: OutlineInputBorder()),
          ),
          Center(
            child: ScaleButton(
                child: Container(
              margin: const EdgeInsets.only(top: 20),
              height: 50,
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: SmoothBorderRadius(
                      cornerRadius: 10, cornerSmoothing: 0.6)),
            )),
          )
        ],
      ),
    );
  }
}
