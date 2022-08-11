


import 'package:flutter/material.dart';

AppBar appBar()=>AppBar(
    backgroundColor: Colors.orange,
    title: const Text("Safari"),
    centerTitle: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15))));