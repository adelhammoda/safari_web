import 'package:firebase_database/firebase_database.dart';
import 'package:safari_web/server/database_client.dart';

import '../models/components/user.dart';
import '../models/offices/office.dart';






class Server {
  ///get all offices
  ///
  static Future<List<Office>?> getAllOffice() async {
    List<Office> offices = [];
    print('airpplanes');
    offices.addAll( await DataBaseClintServer.getAllAirplanes() ?? []);
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
