import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:safari_web/models/offices/tourist_office.dart';
import 'package:safari_web/models/components/car.dart';
import 'package:safari_web/models/components/flight.dart';
import 'package:safari_web/models/components/quastion.dart';
import 'package:safari_web/models/components/replay.dart';
import 'package:safari_web/models/components/tour.dart';
import 'package:safari_web/models/components/landmark.dart';
import 'package:safari_web/models/offices/airplanes.dart';
import 'package:safari_web/models/offices/restaurant.dart';
import 'package:safari_web/models/offices/transportion_office.dart';

import '../models/components/booking.dart';
import '../models/components/comments.dart';
import '../models/components/offers.dart';
import '../models/components/room.dart';
import '../models/components/user.dart';
import '../models/offices/hotel.dart';
import '../models/offices/office.dart';

class DataBaseClintServer {


  ///get allTourist Office
  ///
  static Future<List<TouristOffice>?> getAllTouristOffice()async{
    //
    return await FirebaseDatabase.instance.ref('tourist_office').get().then((value) {
      if (value.value != null && value.exists) {
        List<TouristOffice> tourist_office = [];
        Map response = value.value as Map;
        response.forEach((key, value) {
          Map json = value as Map;
          json.addAll({"id": key} as Map);
          tourist_office.add(TouristOffice.fromJson(json));
        });
        return tourist_office;
      } else {
        return null;
      }
    });
  }
  ///get user favorite from device and load them from database
  ///
  static Future<Map<String,List>?> getUserFavorite(List<String> favorites)async{
    List<Office> offices =  [];
    List<Tour> tours = [];
    List<Offer> offers = [];

    if(favorites.isEmpty){
      return {};
    }
    for(String path in favorites ){
      print(path);
      String type = path.split('/').first;
      switch(type){
        case"hotels":case"restaurants":case"airplanes":case"tourist_office":case"touristical_monuments":
            {
              await FirebaseDatabase.instance.ref(path).get().then((value) {
                var snapshot = value.value;
                if(snapshot != null && snapshot is Map){
                  snapshot.addAll({'id':path.split('/').last});
                  print(snapshot);
                  offices.add(Office.fromJson(snapshot));
                  print('offices is $offices');
                }
              });
              break;
            }
        case"tours":{
          await FirebaseDatabase.instance.ref(path).get().then((value) {
            var snapshot = value.value;
            print(snapshot);
            if(snapshot != null && snapshot is Map){
              snapshot.addAll({'id':path.split('.').last});
              tours.add(Tour.fromJson(snapshot));
            }
          });
          break;
        }
        case"offers":{
          await FirebaseDatabase.instance.ref(path).get().then((value) {
            var snapshot = value.value;
            print(snapshot);
            if(snapshot != null && snapshot is Map){
              snapshot.addAll({'id':path.split('.').last});
              offers.add(Offer.fromJson(snapshot));
            }
          });
          break;
        }
      }

    }
    return {
      'offices':offices,
      'tours':tours,
      'offers':offers
    };
  }
  
  ///load user booking 
  ///
   static Future<List<Booking>?> getUserBooking(String userId){
     print(userId);
     return FirebaseDatabase.instance.ref('booking').orderByChild('/user_id').equalTo(userId).once().then((value) {
       print(value.snapshot.value);
       List<Booking> booking = [];
       Map json ={  };
       var val = value.snapshot.value;
       if(val == null){
         return null;
       }else if (val is Map && val.isNotEmpty){
         val.forEach((key, value) {
           json = value as Map;
           json.addAll({'id':key});
           booking.add(Booking.fromJson(json));
         });
         return booking;
       }else {
         return [];
       }
     });
   }

  
  ///get tourist office where match the id
  ///
  static Future<TouristOffice?> getTouristOfficeWhere({
  required String tourId
}){
    return FirebaseDatabase.instance.ref('tourist_office').once().then((value) {
      var snapshot = value.snapshot.value;
      Map json = {};
      if(snapshot == null){
        debugPrint('snapshot is null there is no result in tourist office query');
        return null;
      }else if(snapshot != null && snapshot is Map  ){
        snapshot.forEach((key, value) {
         var tours = value['tours'];
         print(tours);
         if(tours is List){

          if(tours.contains(tourId.substring(1))){
            json = value as Map;
            json.addAll({'id':key});
          }
         }
        });
        debugPrint('query result is $json');

        return json.isEmpty?null:TouristOffice.fromJson(json);
      }else {
        return null;
      }
    });
  }

  ///but love on questions
  ///
  static Future<bool> loveQuestion({
    required String userId,
    required List<String> loveList,
    required bool isLove,
    required String questionId,
  }) async {
    print(isLove);
    print(loveList);
    if (!isLove) {
      loveList.add(userId);
      print("adding user to list");
      print(userId);
      print(loveList);
    } else {
      loveList.remove(userId);
    }
    loveList.toSet();
    debugPrint(questionId);
    print(loveList);
    return  FirebaseDatabase.instance
        .ref('questions').child(questionId)
        .update({'love': loveList.toList()}).then((value) {
          print('success');
      return true;
    }).catchError((onError) {
      debugPrint(onError);
      return false;
    });
  }


  /// get all questions
  ///
  static Future<List<Question>?> getAllQuestions() {
    List<Question> res = [];
    Map json = {  } ;
    return FirebaseDatabase.instance
        .ref('questions')
        .get()
        .then((value) {
          var map =value.value ;
      if (value.value == null) {
        return null;
      } else if(map is Map) {
        map.forEach((key, value) {
          json = value as Map;
          print(json);
          json.addAll({'id':key});
          res.add(Question.fromJson(json));
        });
        return res;
      }else {
        return null;
      }
    });
  }


  ///get all replies
  ///
  static Future<List<Replay>?> getReplies(String questionId) {
    List<Replay> res = [];
    Map json = {  } ;
    return FirebaseDatabase.instance
        .ref('questions')
        .child(questionId)
        .get()
        .then((value) {
      var map =value.value ;
      if (value.value == null) {
        return null;
      } else if(map is Map) {
        map.forEach((key, value) {
          json = value as Map;
          json.addAll({'key':key});
          res.add(Replay.fromJson(json));
        });
        return res;
      }else {
        return null;
      }
    });
  }



  ///get specific car
  ///
  static Future<Car?> getCar(String carID) {
    return FirebaseDatabase.instance
        .ref('cars')
        .child('-$carID')
        .get()
        .then((value) {
      if (value.value == null) {
        return null;
      } else {
        Map json = value.value as Map;
        json.addAll({'id': carID});
        return Car.fromJson(json);
      }
    });
  }

  /// fitch all offers and convert them to offers model
  static Future<List<Offer>?> getAllOffers() async {
    return await FirebaseDatabase.instance.ref('offers').get().then((value) {
      if (value.value != null && value.exists) {
        List<Offer> offers = [];
        Map response = value.value as Map;
        response.forEach((key, value) {
          Map json = value as Map;
          json.addAll({"id": key});

          offers.add(Offer.fromJson(json));
        });
        return offers;
      } else {
        return null;
      }
    });
  }

  /// fitch all flights and convert them to flight model
  static Future<List<Flight>?> getAllFlight() async {
    return await FirebaseDatabase.instance.ref('flights').get().then((value) {
      if (value.value != null && value.exists) {
        List<Flight> offers = [];
        Map response = value.value as Map;
        response.forEach((key, value) {
          Map json = value as Map;
          json.addAll({"id": key});

          offers.add(Flight.fromJson(json));
        });
        return offers;
      } else {
        return null;
      }
    });
  }

  /// fitch all tours and convert them to tours model
  static Future<List<Tour>?> getAllTours() async {
    return await FirebaseDatabase.instance.ref('tours').get().then((value) {
      if (value.value != null && value.exists) {
        List<Tour> tours = [];
        Map response = value.value as Map;
        response.forEach((key, value) {
          Map json = value as Map;
          json.addAll({"id": key});

          tours.add(Tour.fromJson(json));
        });
        return tours;
      } else {
        return null;
      }
    });
  }

  ///in tour we add new rate depending on stars count that user provide
  ///we need old rate to increment the old one.
  static Future<void> updateTourRate(
      {required int newRate, required String id, required int oldRate}) async {
    return await FirebaseDatabase.instance
        .ref('tours')
        .child(id)
        .child('rate')
        .child(newRate.toString())
        .set(oldRate + 1)
        .then((value) => null)
        .catchError((e) {
      debugPrint(e);
    });
  }

  ///here we can add comments to tour the comments is related with use id
  ///so every user have only one comment.
  static Future<void> addCommentToTour(
      {required String userId,
      required String tourId,
      required Comment comment,
      required List<String> comments}) async {
    DatabaseReference reference =
        FirebaseDatabase.instance.ref('comments').push();
    await reference.set(comment.toJson());
    comments.add(reference.path.split('/').last);
    await FirebaseDatabase.instance
        .ref('tours')
        .child(tourId)
        .update({'comments': comments});
  }

  ///add comment to restaurant

  static Future<void> addCommentToRestaurant(
      {required String userId,
      required String rasId,
      required Comment comment,
      required List<String> comments}) async {
    DatabaseReference reference =
        FirebaseDatabase.instance.ref('comments').push();
    await reference.set(comment.toJson());
    comments.add(reference.path.split('/').last);
    await FirebaseDatabase.instance
        .ref('restaurants')
        .child(rasId)
        .update({'comments': comments});
  }

  ///increment tours favorite by adding user id to favorite set in database
  static Future<void> incrementToursFavorite(
      {required String userId,
      required String toursId,
      required Set oldFavorite}) async {
    Set newSet = oldFavorite;
    newSet.add(userId);
    debugPrint(newSet.toString());
    return await FirebaseDatabase.instance
        .ref('tours')
        .child(toursId)
        .child('favorite')
        .set(newSet.toList());
  }

  ///decrement favorite by delete user id from favorite set in database
  static Future<void> decrementToursFavorite(
      {required String userId,
      required String toursId,
      required String index}) async {
    return await FirebaseDatabase.instance
        .ref('tours')
        .child(toursId)
        .child('favorite')
        .child(index)
        .remove();
  }

  ///query section
  ///
  ///
  ///  get all hotel
  static Future<List<Hotel>?> getAllHotels() {
    return FirebaseDatabase.instance.ref('hotels').get().then((value) {
      var response = value.value;
      List<Hotel> result = [];
      if (response == null) {
        return null;
      } else if (response is Map) {
        response.forEach((key, value) {
          Map json = value as Map;
          json.addAll({'id': key} as Map);
          result.add(Hotel.fromJson(json));
        });
        return result;
      } else {
        return <Hotel>[];
      }
    });
  }

  ///
  ///get all rooms
  static Future<List<Room>?> getAllRooms() {
    return FirebaseDatabase.instance.ref('rooms').get().then((value) {
      var response = value.value;
      List<Room> result = [];
      if (response == null) {
        return null;
      } else if (response is Map) {
        response.forEach((key, value) {
          Map json = value as Map;
          json.addAll({'id': key});
          result.add(Room.fromJson(json));
        });
        return result;
      } else {
        return [];
      }
    });
  }

  ///get all restaurant
  static Future<List<Restaurant>?> getAllRestaurant() {
    return FirebaseDatabase.instance.ref('restaurants').get().then((value) {
      var response = value.value;
      List<Restaurant> result = [];
      if (response == null) {
        return null;
      } else if (response is Map) {
        response.forEach((key, value) {
          Map json = value as Map;
          json.addAll({'id': key} as Map);
          result.add(Restaurant.fromJson(json));
        });
        return result;
      } else {
        return [];
      }
    });
  }

  ///get all flight company
  ///
  static Future<List<Airplanes>?> getAllAirplanes() {
    return FirebaseDatabase.instance.ref('airplanes').get().then((value) {
      var response = value.value;
      List<Airplanes> result = [];
      if (response == null) {
        return null;
      } else if (response is Map) {
        response.forEach((key, value) {
          Map json = value as Map;
          json.addAll({'id': key} as Map);
          result.add(Airplanes.fromJson(json));
        });
        return result;
      } else {
        return [];
      }
    });
  }

  ///get all transportation offices
  ///
  static Future<List<TransportationOffice>?> getAllTransportations() {
    return FirebaseDatabase.instance
        .ref('transportation_office')
        .get()
        .then((value) {
      var response = value.value;
      List<TransportationOffice> result = [];
      if (response == null) {
        return null;
      } else if (response is Map) {
        response.forEach((key, value) {
          Map json = value as Map;
          json.addAll({'id': key} as Map);
          result.add(TransportationOffice.fromJson(json));
        });
        return result;
      } else {
        return [];
      }
    });
  }

  /// get all cars
  ///
  static Future<List<Car>?> getAllCars() {
    return FirebaseDatabase.instance.ref('cars').get().then((value) {
      var response = value.value;
      List<Car> result = [];
      if (response == null) {
        return null;
      } else if (response is Map) {
        response.forEach((key, value) {
          Map json = value as Map;
          json.addAll({'id': key});
          result.add(Car.fromJson(json));
        });
        return result;
      } else {
        return [];
      }
    });
  }

  ///
  static Future<List<Landmark>?> getAllLandMarks() {
    return FirebaseDatabase.instance
        .ref('touristical_monuments')
        .get()
        .then((value) {
      var response = value.value;
      List<Landmark> result = [];
      if (response == null) {
        return null;
      } else if (response is Map) {
        response.forEach((key, value) {
          Map json = value as Map;
          json.addAll({'id': key});
          result.add(Landmark.fromJson(json));
        });
        return result;
      } else {
        return [];
      }
    });
  }

  /// to get facility for hotel
  ///
  ///
  static Future<Facility?> getFacility(String facilityId) {
    return FirebaseDatabase.instance
        .ref('facilities')
        .child(facilityId)
        .get()
        .then((value) {
      var response = value.value;

      if (response == null) {
        return null;
      } else if (response is Map) {
        Facility res =
            Facility(id: 'id', description: 'description', image: 'image');

        Map json = response;

        json.addAll({'id': facilityId});
        res = Facility.fromJson(json);

        if (res.id == 'id') return null;
        return res;
      } else {
        return null;
      }
    });
  }

  ///to get comments fot hotel
  static Future<List<Comment>?> getComment(String commentId) {
    return FirebaseDatabase.instance
        .ref('comments')
        .child(commentId)
        .get()
        .then((value) {
      var response = value.value;
      List<Comment> result = [];
      if (response == null) {
        return null;
      } else if (response is Map) {
        response.forEach((key, value) {
          Map json = value as Map;
          json.addAll({'id': key});
          result.add(Comment.fromJson(json));
        });
        return result;
      } else {
        return [];
      }
    });
  }

  ///get user details
  ///
  static Future<User?> getUser(String userId) {
    return FirebaseDatabase.instance
        .ref('users')
        .child(userId)
        .get()
        .then((value) {
      var res = value.value;
      if (res is Map) {
        res.addAll({'id': userId});
        res.addAll({'email': "$userId.com"});
        return User.fromJson(res);
      } else {
        return null;
      }
    });
  }

  ///add comment to hotel
  ///
  ///add comment for hotel
  ///
  static Future<void> addCommentToHotel(String userId, String hotelId,
      Comment comment, List<String> comments) async {
    DatabaseReference reference =
        FirebaseDatabase.instance.ref('comments').push();
    await reference.set(comment.toJson());
    comments.add(reference.path.split('/').last);
    await FirebaseDatabase.instance
        .ref('hotels')
        .child(hotelId)
        .update({'comments': comments});
  }

  ///add comment to offer

  static Future<void> addCommentToOffer(
      {required String userId,
      required String offerId,
      required Comment comment,
      required List<String> comments}) async {
    DatabaseReference reference =
        FirebaseDatabase.instance.ref('comments').push();
    await reference.set(comment.toJson());
    comments.add(reference.path.split('/').last);
    await FirebaseDatabase.instance
        .ref('offers')
        .child(offerId)
        .update({'comments': comments});
  }

  ///rating function that tack the path to the office and the list of rate user id
  ///
  static Future<void> rate(
      int index, String officeName, String officeId, List<int> stars) async {
    stars[index]++;
    FirebaseDatabase.instance
        .ref(officeName)
        .child(officeId)
        .update({'stars': stars});
  }

  ///get all comments that related to office
  static Future<List<Comment>?> getComments(List<String> commentsId) async {
    List<Comment> res = [];
    for (String id in commentsId) {
      await FirebaseDatabase.instance
          .ref('comments')
          .child(id)
          .get()
          .then((value) {
        var json = value.value;
        if (json is Map) {
          json.addAll({'id': id});
          Comment c = Comment.fromJson(json);
          res.add(c);
        } else {
          return null;
        }
      });
    }
    return res;
  }
}
