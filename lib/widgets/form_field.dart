
import 'package:flutter/material.dart';


class MyFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final void Function(String? value)? onSubmit;
  final Icon? icon;
  final String? hint;
  final int minLine;
  final int maxLine;
  final bool canEdit;
  const MyFormField({
    Key? key,
    this.controller,
    this.minLine=1,
    this.maxLine =1,
    this.hint,
    this.icon,
    this.canEdit = true,
    this.onSubmit,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 5,left: 9.0,right: 9.0),
      child: TextFormField(
        readOnly: !canEdit,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        minLines: minLine,
        maxLines: maxLine,
        controller: controller,
        keyboardType: TextInputType.phone,
        cursorColor:const  Color(0xffF5591F),
        onFieldSubmitted: onSubmit,
        validator:validator,
        decoration: InputDecoration(
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:const BorderSide(
                  color: Colors.red,
                  width: 1
              )
          ),
          errorBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:const BorderSide(
                  color: Colors.red,
                  width: 1
              )
          ) ,
          icon:icon,
          hintText: hint,//S.of(context).pageEnterEmail,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:const BorderSide(
              color: Colors.grey,
              width: 1
            )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:const BorderSide(
                  color: Colors.orange,
                  width: 1
              )
          ),
        ),
      ),
    );
  }
}
