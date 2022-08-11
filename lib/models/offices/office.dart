import 'package:flutter/material.dart';

abstract class OfficeBase {
  String name,id;
  List<String> loves;
  String city;
  String country;
  String area;
  List<int> stars;
  Map<String,String> phone;
  Map<String, String> address;
  String description;
  List<String> imagesPath = List.empty(growable: false)
    ..length = 3;
  String account;
  List<String > comments ;

  OfficeBase({required this.name,
    required this.account,
    required this.id,
    required this.address,
    required this.description,
    required this.imagesPath,
    required this.city,
    required this.country,
    required this.area,
    required this.phone,
    required this.stars,
  required this.loves,required this.comments});

  static String fromLocation(String location,int i){
   return   location.split('/')[i];
  }
}


class Office implements OfficeBase {
  @override
  String account;

  @override
  String id;

  @override
  Map<String, String> address;

  @override
  String area;

  @override
  String city;

  @override
  String country;

  @override
  String description;

  @override
  List<String> imagesPath;

  @override
  String name;

  @override
  Map<String,String> phone;

  @override
  List<int> stars;

  @override
  List<String> loves;

  Office({
    required this.id,
    required this.country,
    required this.stars,
    required this.phone,
    required this.imagesPath,
    required this.description,
    required this.address,
    required this.account,
    required this.name,
    required this.area,
    required this.city,
    required this.loves,
    required this.comments
  });


  factory Office.fromJson(Map json){
    try {
      return Office(
        id:json['id'],
        comments: convertListOfString(json['comments']??[]),
          loves: convertListOfString(json['loves']??[]),
          country: OfficeBase.fromLocation(json['location'], 0),
          stars: convertList(json['stars']??[0,0,0,0,0]),
          phone: convertHashToMap(json['phone']??{}),
          imagesPath: convertListOfString(json['images']??[]),
          description: json['description'],
          address:convertHashToMap( json['address']??{}),
          account: json['account']??'',
          name: json['name']??'',
          area: OfficeBase.fromLocation(json['location'], 2),
          city: OfficeBase.fromLocation(json['location'], 1));
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw "Error happened while trying to decode office";
    }
  }


  Map<String, dynamic> toJson(){
    return {
      'country':comments,
      'phone':phone,
      'images':imagesPath,
      'description':description,
      'address':address,
      'account':account,
      'name':name,
      'area':area,
      'city':city,
      "location":"$country/$city/$area"
    };
  }

  static Map<String,String> convertHashToMap(Map map){
    Map<String,String> res={};
    map.forEach((key, value) { 
      res.addAll({key.toString():value.toString()});
    });
    return res;
  }
  
  static List<int> convertList(List json){
    List<int> res = [];
    for(var i in json){
      if(i is int){
        res.add(i);
      }else if (i is double){
        res.add(i.toInt());
      }else {
        continue;
      }
    }
    return res;
  }


  static List<String> convertListOfString(List json){
    List<String> res = [];
    for(var i in json){
     res.add(i.toString());
    }
    return res;
  }
  int rateAverage(){
    int sum = 0;
    debugPrint(stars.toString());
    List<double> relative = List.filled(5, 0,growable: false);
    double higherRelative = 0.0;
    //to calculate the sum or rate list
    for(int e in stars) {
      sum += e;
    }


    //to calculate relatives
    for(int i =0;i<stars.length;i++){
      relative[i] = stars[i]*100/sum;
      if(relative[i] > higherRelative){
        higherRelative = relative[i];
      }
    }

    return (higherRelative/20).ceil()+1;
  }

  @override
  List<String> comments;

}
