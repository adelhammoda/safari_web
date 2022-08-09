import 'package:flutter/material.dart';

class Tour {
  String id;
  String country;
  int days;
  List<String> images;
  DateTime leavingDate;
  DateTime returningDate;
  String name;
  int nights;
  List<int> rate;
  Map<String, String> phones;
  double cost;
  String program;
  String programInclude;
  Set<String> favorite;
  List<String> comments;

  Tour(
      {required this.id,
      required this.cost,
      required this.country,
      required this.name,
      required this.days,
      required this.images,
      required this.leavingDate,
      required this.nights,
      required this.phones,
      required this.program,
      required this.programInclude,
      required this.returningDate,
      required this.rate,
      required this.favorite,
      required this.comments});

  factory Tour.fromJson(Map json) {
    return Tour(
        id: json['id'],
        comments: convertToListOfString(json['comments'] ?? []),
        favorite: convertToSet(json['favorite']),
        rate: convertToList(json['rate']),
        cost: toDouble(json['cost']),
        country: json['country'],
        name: json['name'],
        days: json['days'],
        images: convertToListOfString(json['images']),
        leavingDate: DateTime.parse(json['leaving_date']),
        nights: json['nights'],
        phones: convertHashToMap(json['phones']),
        program: json['program'],
        programInclude: json['program_include'],
        returningDate: DateTime.parse(json['returning_date']));
  }

  Map<String, dynamic> toJson() {
    return {
      'cost': cost,
      'name': name,
      'country': country,
      'days': days,
      'images': images,
      'leaving_date': leavingDate.toIso8601String(),
      'returning_date': returningDate.toIso8601String(),
      'phones': phones,
      'program': program,
      'program_include': programInclude,
      'nights': nights,
      'rate': rate,
      'favorite': favorite,
    };
  }

  static double toDouble(var cost) {
    if (cost is int) {
      return cost.toDouble();
    } else if (cost is String) {
      return double.tryParse(cost) ?? 0.0;
    } else if (cost is double) {
      return cost;
    } else {
      return 0.0;
    }
  }

  static List<String> convertToListOfString(List ls) {
    List<String> res = [];
    for (var v in ls) {
      if (v is String) {
        res.add(v);
      } else {
        res.add(v.toString());
      }
    }
    return res;
  }

  static Map<String, String> convertHashToMap(Map? map) {
    Map<String, String> res = {};
    if (map != null) {
      map.forEach((key, value) {
        res.addAll({key.toString(): value.toString()});
      });
      return res;
    } else {
      return {};
    }
  }

  static List<int> convertToList(List list) {
    List<int> res = [];
    for (var element in list) {
      if (element is int) {
        res.add(element);
      } else if (element is double) {
        res.add(element.toInt());
      } else {
        res.add(0);
      }
    }
    return res;
  }

  static Set<String> convertToSet(List? l) {
    if (l == null) {
      return {};
    }
    Set<String> res = {};
    for (var v in l) {
      res.add(v.toString());
    }
    return res;
  }

  int rateAverage() {
    int sum = 0;
    int higherIndex = 0;
    debugPrint(rate.toString());
    List<double> relative = List.filled(5, 0, growable: false);
    double higherRelative = 0.0;
    //to calculate the sum or rate list
    for (int e in rate) {
      sum += e;
    }

    //to calculate relatives
    for (int i = 0; i < rate.length; i++) {
      relative[i] = rate[i] * 100 / sum;
      if (relative[i] > higherRelative) {
        higherRelative = relative[i];
        higherIndex = i;
      }
    }

    return ++higherIndex;
  }
}
