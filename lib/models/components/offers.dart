import 'package:flutter/material.dart';
import 'package:safari_web/models/offices/office.dart';

class Offer {
  String id;
  double totalCost;
  String companyID;
  String name;
  String companyType;
  DateTime dateFrom, dateTo;
  String description, offerPath;
  double discount;
  List<String> love;
  List<String> images;
  List<String> comments;
  List<int> stars;

  Offer({
    required this.id,
    required this.name,
    required this.dateTo,
    required this.dateFrom,
    required this.description,
    required this.companyID,
    required this.companyType,
    required this.discount,
    required this.offerPath,
    required this.images,
    required this.totalCost,
    required this.comments,
    required this.stars,
    required this.love ,
  });





  factory Offer.fromJson(Map json){
    return Offer(
        id: json['id'],
        name: json['name'],
        love: convertToListOfString(json['loves']??[]),
        stars: Office.convertList(json['stars']??[0,0,0,0,0]),
        dateTo: DateTime.parse(json['date_to']),
        dateFrom: DateTime.parse(json['date_from']),
        description: json['description'],
        companyID: json['company_id'],
        companyType: json['company_type'],
        discount: json['discount'],
        offerPath: json['offer_path'],
        totalCost: convertToDouble(json['total_cost']),
        images:convertToListOfString(json['images']),
        comments: convertToListOfString(json['comments']??[])
    );
  }

static double convertToDouble(var n){
    if(n is int){
      return n.toDouble();
    }else if (n is double){
      return n;
    }else if(n is num){
      return n.toDouble();
    }else if(n is String){
      return double.tryParse(n)??0.0;
    }else {
      return 0;
    }

}


  static List<String> convertToListOfString(List ls){
    List<String> res=[];
    for(var v in ls){
      if(v is String){
        res.add(v);
      }else{
       res.add(v.toString());
      }
    }
    return res;
  }

  Map toJson(){
    return {
      'date_to':dateTo.toIso8601String(),
      'date_from':dateFrom.toIso8601String(),
      'description':description,
      'company_id':companyID,
      "company_type":companyType,
      'discount':discount,
      'offer_path':offerPath,
      'images':images,
      'name':name,
      'stars':stars,
      'loves':love
    };
  }

  double calculatePriceAfterDiscount()=>totalCost*discount/100;

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

}
