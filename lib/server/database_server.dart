import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:safari_web/models/components/booking.dart';
import 'package:safari_web/models/offices/hotel.dart';
import '../models/components/quastion.dart';
import '../models/components/replay.dart';
import '../models/components/tour.dart';
import '../models/components/user.dart';
import '../models/components/offers.dart';

class DataBaseServer {

  ///delete office
  ///
  static Future<void> delete({
  required String ref,
}){
    return FirebaseDatabase.instance.ref(ref).remove();
  }

  ///booking
  ///
  ///
  static Future<void> booking({
  required Booking booking
}){
    return FirebaseDatabase.instance.ref('booking').push().set(booking.toJson());
  }

  ///to add question to the form that can have multi answers
  static Future<void> addQuestion({
    required Question question,
  }) async {
    await FirebaseDatabase.instance
        .ref('questions')
        .push()
        .set(question.toJson());
  }

  /// add answer to question
  static Future<void> replayToQuestion(
      {required String questionId, required Replay replay}) {
    return FirebaseDatabase.instance
        .ref('questions')
        .child(questionId)
        .child('replies')
        .push()
        .set(replay.toJson());
  }
  ///
  static Future<void> createUser(User user) async {
    return await FirebaseDatabase.instance
        .ref('users')
        .child(user.email.substring(0, user.email.indexOf('.')))
        .set(user.toJson());
  }

  static Future<UploadTask?> uploadPhoto(File file, String userId) async =>
      FirebaseStorage.instance.ref('users_photos').child(userId).putFile(file);

  static Future<String?> addOffer(Offer offer) async {
    return FirebaseDatabase.instance
        .ref('offers')
        .child('first offers')
        .push() //unique id
        .set(offer.toJson())
        .then((value) {
      debugPrint('Offer Added successfully');
      return null;
    }).catchError((e) {
      print(e);
      return "There is error while adding this object";
    });
  }

  static Future<String?> addTour(Tour tour) async {
    return FirebaseDatabase.instance
        .ref('tours')
        .push()
        .set(tour.toJson())
        .then((value) {
      debugPrint('tours Added successfully');
      return null;
    }).catchError((e) {
      print(e);
      return "There is error while adding this object";
    });
  }




  ///add facility to hotel
///
  static Future<void> addFacility( String hotelId,List<String> facilities,Facility newFacility) async {
    DatabaseReference reference =
    FirebaseDatabase.instance.ref('facilities').push();
    await reference.set(newFacility.toJson());
    facilities.add(reference.path.split('/').last);
    await FirebaseDatabase.instance
        .ref('hotels')
        .child(hotelId)
        .update({'facilities': facilities});
  }
}
