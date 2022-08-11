import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:safari_web/models/offices/airplanes.dart';
import 'package:safari_web/models/offices/hotel.dart';
import 'package:safari_web/screens/add_flight.dart';
import 'package:safari_web/screens/add_room.dart';
import 'package:safari_web/screens/login.dart';
import 'package:safari_web/screens/all_users.dart';
import 'package:safari_web/screens/offices.dart';
import 'package:safari_web/server/authintacation.dart';

const firebaseConfig = {
  "apiKey": "AIzaSyAnuhT2K0xiYUb1TF8TEl7-1xhRFtT86p4",
  "authDomain": "sfari-99e68.firebaseapp.com",
  "databaseURL":
      "https://sfari-99e68-default-rtdb.asia-southeast1.firebasedatabase.app",
  "projectId": "sfari-99e68",
  "storageBucket": "sfari-99e68.appspot.com",
  "messagingSenderId": "648743674689",
  "appId": "1:648743674689:web:ae18eaf5fa017487ecb7c0",
  "measurementId": "G-BV82CT1PYB"
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: firebaseConfig['apiKey']!,
          appId: firebaseConfig['appId']!,
          messagingSenderId: firebaseConfig['messagingSenderId']!,
          projectId: firebaseConfig['projectId']!,
          measurementId: firebaseConfig['measurementId'],
          storageBucket: firebaseConfig['storageBucket'],
          databaseURL: firebaseConfig['databaseURL'],
          authDomain: firebaseConfig['authDomain']));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.orange,
        ),

        home: Authentication.user?.uid==null?const LoginScreen():const Offices(),
        );
  }
}
