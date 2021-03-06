import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final double height;
  final VoidCallback onPressed;

  const CustomRaisedButton(
      {Key key, this.color, this.onPressed, this.child, this.height: 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        child: child,
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.black87,
          primary: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
