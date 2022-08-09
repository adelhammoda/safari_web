import 'package:safari_web/models/components/landmark.dart';
import 'package:safari_web/models/offices/office.dart';

class Car {
  String id,description;
  double costPerHour;
  double mpg;
  List<String> imagePath;
  Map phone;
  String name;
  int capacity;



  Car({
    required this.id,
    required this.name,
    required this.phone,
    required this.capacity,
    required this.costPerHour,
    required this.imagePath,
    required this.description,
    required this.mpg,
  });

  factory Car.fromJson(Map json){
    return Car(
        id: json['id'],
        mpg:convertToDouble(json['mpg']),
        description: json['description'] ,
        name: json['name'],
        phone: Office.convertHashToMap(json['phone']??{}),
        capacity: Landmark.convertToInt(json['capacity']),
        costPerHour: convertToDouble(json['cost']),
        imagePath: Office.convertListOfString(json['images']));
  }

  Map toJson(){
    return {
      'name':name,
      'phone':phone,
      'capacity':capacity,
      'cost':costPerHour,
      'images':imagePath,
    };
  }


  static double convertToDouble(var d){
    if(d is double){
      return d;
    }else if (d is int){
      return d.toDouble();
    }else if (d is String){
      return double.tryParse(d)??0;
    }else {
      return d;
    }
  }


}