
import 'package:flutter/material.dart';


class FormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final void Function(String? value)? onSubmit;
  final String? hint;
  const FormField({Key? key,
     this.controller,
    this.hint,
    this.onSubmit,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      cursorColor:const  Color(0xffF5591F),
      onFieldSubmitted: onSubmit,
      validator:validator,
      decoration: InputDecoration(
        icon:const Icon(
          Icons.phone,
          color: Color(0xffef9b0f),
        ),
        hintText: hint,//S.of(context).pageEnterEmail,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
  }
}
