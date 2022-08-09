import 'package:safari_web/models/offices/office.dart';

class TransportationOffice extends Office {

  List<String> carsId;

  TransportationOffice(
      {required super.id,
      required this.carsId,
        required super.loves,
      required super.country,
      required super.stars,
      required super.phone,
      required super.imagesPath,
      required super.description,
      required super.address,
      required super.account,
      required super.name,
        required super.comments,
      required super.area,
      required super.city});


  factory TransportationOffice.fromJson(Map json){
    return TransportationOffice(id: json['id'],
        comments: Office.convertListOfString(json['comments']??[]),
        loves: Office.convertListOfString(json['loves']??[]),
        carsId: Office.convertListOfString(json['cars_id']),
        country: OfficeBase.fromLocation(json['location'], 0),
        stars: Office.convertList(json['stars'] ?? []),
        phone:Office.convertHashToMap(json['phone']??{}),
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
      "cars_id":carsId,
      "address":{
        'country':country,
        'city':city,
        'area':area
      },
      "location":"$country/$city/$area",
      "stars":stars,
      "phone":phone,
      "images":imagesPath,
      "description":description,
      "account":account,

    };
  }
}
