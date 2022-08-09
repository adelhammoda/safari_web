
import 'package:safari_web/models/offices/office.dart';



class Facility {
  String id;
  String image;
  String description;

  Facility({
    required this.id,
    required this.description,
    required this.image,
  });

  factory Facility.fromJson(Map json) {
    return Facility(
        id: json['id'], description: json['description'], image: json['image']);
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'description': description,
    };
  }
}

class Hotel extends Office {
  List<String> roomID;
  List<String> facility;

  Hotel(
      {required super.id,
      required this.roomID,
      required this.facility,
      required super.loves,
      required super.country,
      required super.stars,
      required super.phone,
      required super.imagesPath,
      required super.description,
      required super.address,
      required super.account,
      required super.name,
      required super.area, required super.comments,
      required super.city});

  factory Hotel.fromJson(Map json) {
    return Hotel(
        id: json['id'],
        facility: Office.convertListOfString(json['facilities'] ?? []),
        loves: Office.convertListOfString(json['loves'] ?? []),
        comments: Office.convertListOfString(json['comments'] ?? []),
        roomID: (json['room_id'] ?? []),
        country: OfficeBase.fromLocation(json['location'], 0),
        stars: Office.convertList(json['stars'] ?? [0, 0, 0, 0, 0]),
        phone: Office.convertHashToMap(json['phone']??{}),
        imagesPath: Office.convertListOfString(json['images']??[]),
        description: json['description'],
        address: Office.convertHashToMap(json['address']??{}),
        account: json['account'],
        name: json['name'],
        area: OfficeBase.fromLocation(json['location'], 2),
        city: OfficeBase.fromLocation(json['location'], 1));
  }

  Map<String, dynamic> joJson() {
    return {
      "name": name,
      "rooms": roomID,
      "location": "$country/$city/$area",
      "stars": stars,
      "phone": phone,
      "images": imagesPath,
      "description": description,
      "account": account,
      "comments": comments,
      "address": address
    };
  }
}
