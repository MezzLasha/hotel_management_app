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
  final double? radius;
  final Color? backgroundColor;

  const CircularButton(
      {Key? key,
      required this.icon,
      required this.onPressed,
      this.radius,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      bound: 0.07,
      duration: const Duration(milliseconds: 150),
      child: CircleAvatar(
        radius: radius ?? 30,
        backgroundColor: backgroundColor ?? const Color.fromARGB(12, 0, 0, 0),
        child: SizedBox(
          width: radius != null ? radius! * 2 : 60,
          height: radius != null ? radius! * 2 : 60,
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

class ScalingButton extends StatelessWidget {
  final Widget child;
  final Function? onPressed;
  const ScalingButton({super.key, required this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      bound: 0.07,
      onTap: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      duration: const Duration(milliseconds: 150),
      child: child,
    );
  }
}
