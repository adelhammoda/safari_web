import 'package:safari_web/models/offices/office.dart';

class TouristOffice extends Office {

  List<String> toursId;


  TouristOffice(
      {required super.id,
      required this.toursId,
        required super.loves,
      required super.country,
        required super.comments,
      required super.stars,
      required super.phone,
      required super.imagesPath,
      required super.description,
      required super.address,
      required super.account,
      required super.name,
      required super.area,
      required super.city});


  factory TouristOffice.fromJson(Map json){
    return TouristOffice(id: json['id'],
        loves: Office.convertListOfString(json['loves']??[]),
        toursId: Office.convertListOfString(json['tours']??[]),
        comments: Office.convertListOfString(json['comments']??[]),
        country: OfficeBase.fromLocation(json['location'], 0),
        stars: Office.convertList(json['stars'] ?? [0,0,0,0,0]),
        phone: Office.convertHashToMap(json['phone']??{}),
        imagesPath: Office.convertListOfString(json['image_path']??[]),
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
      "tours":toursId,
      "location":"$country/$city/$area",
      "stars":stars,
      "phone":phone,
      "images":imagesPath,
      "description":description,
      "account":account,

    };
  }
}
