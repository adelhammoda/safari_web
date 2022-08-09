import 'package:flutter/material.dart';
import 'office.dart';

class Restaurant extends Office {


  TimeOfDay timeFrom;
  TimeOfDay timeTo;
  List<String> typeOfFood;
  String foodType;


  Restaurant(
      {required super.id,
      required this.timeFrom,
      required this.timeTo,
      required this.typeOfFood,
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
      required super.city,
      required super.loves,
      required this.foodType});

  factory Restaurant.fromJson(Map json){
    return Restaurant(id: json['id'],
        loves: Office.convertListOfString(json['loves']??[]),
        comments: Office.convertListOfString(json['comments']??[]),
        timeFrom: TimeOfDay.fromDateTime(json['time_from']??DateTime(2001,1,1,8,0)),
        timeTo: TimeOfDay.fromDateTime(json['time_to']??DateTime(2001,1,1,16,0)),
        typeOfFood:Office.convertListOfString(json['type_of_food']??[]) ,
        country: OfficeBase.fromLocation(json['location'], 0),
        stars: Office.convertList(json['stars']?? [0,0,0,0,0] ),
        phone: Office.convertHashToMap(json['phone']??{}),
        imagesPath: Office.convertListOfString(json['images']??[]),
        description: json['description']??'',
        address: Office.convertHashToMap(json['address']??{}),
        account: json['account']??'',
        name: json['name'],
        area: OfficeBase.fromLocation(json['location'], 2),
        city: OfficeBase.fromLocation(json['location'], 1),
        foodType: json['food_type']??'');
  }




  Map<String, dynamic> joJson() {
    return {
      "name":name,
      "location":"$country/$city/$area",
      "stars":stars,
      "phone":phone,
      "images":imagesPath,
      "description":description,
      "account":account,
      "food_type":foodType
    };
  }
}
