import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function()? onPressed;
  const Button({Key? key,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed:onPressed,
    color: Colors.orange,);
  }
}
