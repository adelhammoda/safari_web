import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function()? onPressed;
  final Widget? child;
  final double? minWidth;
  final double? height;
  const Button({Key? key,required this.onPressed,
    this.height,
  this.child, this.minWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: minWidth,
      height: height,
      onPressed:onPressed,
    color: Colors.orange,
      child: child,);
  }
}
