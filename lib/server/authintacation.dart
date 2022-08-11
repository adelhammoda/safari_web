import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:safari_web/server/database_server.dart';

import '../models/components/user.dart' as u;
class Authentication {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<void> deleteAccount() async => await auth.currentUser?.delete();

  static User? get user => auth.currentUser;
}

class Login extends Authentication {
  static Future<UserCredential?> login(String email, String password) async =>
      await Authentication.auth
          .signInWithEmailAndPassword(email: email, password: password);
}

class Register extends Authentication {
  static Future<UserCredential?> createAccount(
      {required u.User user,required String password,required File image}) async {
    return await Authentication.auth
        .createUserWithEmailAndPassword(email: user.email, password: password)
        .then((value) async {
      if (value.user != null) {
        debugPrint("Email created successfully");
        debugPrint("uploading photo...");
        UploadTask? s =
            await DataBaseServer.uploadPhoto(image, value.user!.uid);

        await s?.whenComplete(() async {
           debugPrint("Photo uploaded successfully");
           debugPrint("updating user url ... ");
         user.photoUrl = await s.snapshot.ref.getDownloadURL();
         debugPrint("User url updated successfully");
           debugPrint("Creating user...");
           await DataBaseServer.createUser(user);
           debugPrint('user created successfully ${user.toJson()}');
        });

      }
      return value;
    });
  }
}
