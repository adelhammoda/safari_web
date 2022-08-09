import 'package:flutter/material.dart';

class TouristicalMonuments {
  int cost;
  List<int> stars;
  TimeOfDay timeFrom, timeTo;
  String dayFrom, dayTo, description, name, id;

  Map<String, String> location;

  TouristicalMonuments({
    required this.id,
    required this.name,
    required this.cost,
    required this.description,
    required this.stars,
    required this.timeTo,
    required this.timeFrom,
    required this.location,
    required this.dayFrom,
    required this.dayTo,
  });

  factory TouristicalMonuments.fromJson(Map json) {
    return TouristicalMonuments(
        id:json['id'],
        name: json['name'],
        cost: json['cost'],
        description: json['description'],
        stars: convertToList(json['stars']),
        timeTo: timeFromString(json['time_to']),
        timeFrom: timeFromString(json['time_from']),
        location: json['location'],
        dayFrom: json['day_from'],
        dayTo: json['day_to']);
  }

  static TimeOfDay timeFromString(String s) {
    List<String> list = s.split(':');
    int hour = int.tryParse(list[0]) ?? 0;
    int minutes = int.tryParse(list[1]) ?? 0;
    return TimeOfDay(hour: hour, minute: minutes);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cost': cost,
      'description': description,
      'starts': stars,
      'time_to': '${timeTo.hour}:${timeTo.minute}',
      'time_from': '${timeFrom.hour}:${timeFrom.minute}',
      'location': location,
      "day_from": dayFrom,
      'day_to': dayTo
    };
  }

  static List<int> convertToList(List l){
    List<int> res = [ ];
    for(var i in l ){
      if(i is int){
        res.add(i);
      }else if (i is double){
        res.add(i.toInt());
      }else{
        continue;
      }
    }
    return res;
  }
}
