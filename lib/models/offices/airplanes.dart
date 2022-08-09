import 'package:safari_web/models/offices/office.dart';

class Airplanes extends Office {
  List<String> flightId;

  Airplanes({required super.id,
    required this.flightId,
    required super.loves,
    required super.comments,
    required super.country,
    required super.stars,
    required super.phone,
    required super.imagesPath,
    required super.description,
    required super.address,
    required super.account,
    required super.name,
    required super.area,
    required super.city});

  factory Airplanes.fromJson(Map json){
    return Airplanes(id: json['id'],
        loves: Office.convertListOfString(json['loves']??[]),
        comments: Office.convertListOfString(json['comments']??[]),
        flightId: Office.convertListOfString(json['flight_id']??[]),
        country: OfficeBase.fromLocation(json['location']??{}, 0),
        stars: Office.convertList(json['stars']?? []) ,
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
    "name":name,
    "flight_id":flightId,
    "location":"$country/$city/$area",
    "stars":stars,
    "phone":phone,
    "images":imagesPath,
    "description":description,
    "account":account,

  };
  }
}
