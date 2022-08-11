import 'package:firebase_database/firebase_database.dart';
import 'package:safari_web/models/offices/airplanes.dart';
import 'package:safari_web/models/offices/hotel.dart';
import 'package:safari_web/models/offices/tourist_office.dart';
import 'package:safari_web/models/offices/transportion_office.dart';
import 'package:safari_web/server/database_client.dart';

import '../models/components/user.dart';
import '../models/offices/office.dart';
import '../models/offices/restaurant.dart';

class Server {
  ///get all owner offices
  ///
  static Future<List<Office>?> getAllOwnerOffice(String ownerEmail) async {
    List<Office> offices = [];
    print("airplanes");
   await FirebaseDatabase.instance
        .ref('airplanes')
        .orderByChild('account')
        .equalTo(ownerEmail)
        .once()
        .then((value) {
          if(value.snapshot.exists && value.snapshot.value != null){
            Map map = value.snapshot.value as Map;
           map.forEach((key, value) {
             Map json = value as Map;
             json.addAll({'id':key} as Map);
             offices.add(Airplanes.fromJson(json));
           });
          }
    });
    print("hotels");
    await FirebaseDatabase.instance
        .ref('hotels')
        .orderByChild('account')
        .equalTo(ownerEmail)
        .once()
        .then((value) {
      if(value.snapshot.exists && value.snapshot.value != null){
        Map map = value.snapshot.value as Map;
        map.forEach((key, value) {
          Map json = value as Map;
          json.addAll({'id':key} as Map);
          offices.add(Hotel.fromJson(json));
        });
      }
    });
    print("restaurant");
    await FirebaseDatabase.instance
        .ref('restaurant')
        .orderByChild('account')
        .equalTo(ownerEmail)
        .once()
        .then((value) {
      if(value.snapshot.exists && value.snapshot.value != null){
        Map map = value.snapshot.value as Map;
        map.forEach((key, value) {
          Map json = value as Map;
          json.addAll({'id':key} as Map);
          offices.add(Restaurant.fromJson(json));
        });
      }
    });
    print("tourist_office");
    await FirebaseDatabase.instance
        .ref('tourist_office')
        .orderByChild('account')
        .equalTo(ownerEmail)
        .once()
        .then((value) {
      if(value.snapshot.exists && value.snapshot.value != null){
        Map map = value.snapshot.value as Map;
        map.forEach((key, value) {
          Map json = value as Map;
          json.addAll({'id':key} as Map);
          offices.add(TouristOffice.fromJson(json));
        });
      }
    });
    print("transportation_office");
    await FirebaseDatabase.instance
        .ref('transportation_office')
        .orderByChild('account')
        .equalTo(ownerEmail)
        .once()
        .then((value) {
      if(value.snapshot.exists && value.snapshot.value != null){
        Map map = value.snapshot.value as Map;
        map.forEach((key, value) {
          Map json = value as Map;
          json.addAll({'id':key} as Map);
          offices.add(TransportationOffice.fromJson(json));
        });
      }
    });
    return offices;
  }

  ///get all offices
  ///
  static Future<List<Office>?> getAllOffice() async {
    List<Office> offices = [];
    print('airpplanes');
    offices.addAll(await DataBaseClintServer.getAllAirplanes() ?? []);
    print('restaurant');
    offices.addAll(await DataBaseClintServer.getAllRestaurant() ?? []);
    print('hotels');
    offices.addAll(await DataBaseClintServer.getAllHotels() ?? []);
    print('transportation');
    offices.addAll(await DataBaseClintServer.getAllTransportations() ?? []);
    print('tourist office');
    offices.addAll(await DataBaseClintServer.getAllTouristOffice() ?? []);
    print(offices);
    return offices;
  }

  ///
  ///
  static Future updateUserVerification(String userId, bool value) {
    return FirebaseDatabase.instance.ref('users').child(userId).update({
      'is_verification': value,
    });
  }

  ///get list of Users
  ///
  ///get user details
  ///
  static Future<List<User>?> getAllUser() {
    List<User> users = [];
    return FirebaseDatabase.instance.ref('users').get().then((value) {
      print(value.value);
      var res = value.value;
      if (res is Map) {
        res.forEach((key, value) {
          Map json = value as Map;
          json.addAll({'id': key.toString()} as Map);
          json.addAll({'email': key.toString() + ".com"} as Map);
          users.add(User.fromJson(json));
        });
        return users;
      } else {
        return null;
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
}
