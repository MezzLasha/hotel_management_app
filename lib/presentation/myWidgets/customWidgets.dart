// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:scale_button/scale_button.dart';

void showSnackBar(BuildContext context, String message) {
  final snackbar = SnackBar(
    content: Text(message),
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

class CircularButton extends StatelessWidget {
  final Widget icon;
  final void Function() onPressed;

  const CircularButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      bound: 0.07,
      duration: const Duration(milliseconds: 150),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: const Color.fromARGB(12, 0, 0, 0),
        child: SizedBox(
          width: 60,
          height: 60,
          child: IconButton(
            color: Theme.of(context).primaryColor,
            icon: icon,
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
