class Flight {
  String id;
  String from, to;
  double cost;
  DateTime dateFrom;
  DateTime dateTo;
  int numberOfPassengers, passengersCapacity;
  double relax;

  Flight({
    required this.id,
    required this.cost,
    required this.dateFrom,
    required this.dateTo,
    required this.from,
    required this.numberOfPassengers,
    required this.passengersCapacity,
    required this.to,
    required this.relax,
  });

  factory Flight.fromJson(Map json) {
    String dateFromFormat = json['date_from'].toString().replaceAll('T', ' ');
    String dateToFormat = json['date_to'].toString().replaceAll('T', ' ');
    return Flight(
        from: json['from'],
        id: json['id'],
        cost: convertToDouble(json['cost']),
        dateFrom: DateTime.parse(dateFromFormat),
        dateTo: DateTime.parse(dateToFormat),
        numberOfPassengers: convertToInt(json['number_0f_passengers']),
        passengersCapacity: convertToInt(json['passengers_capacity']),
        to: json['to'],
        relax: convertToDouble(json['relax'] ?? 0));
  }

  Map<String, dynamic> joJson() {
    return {
      'from': from,
      'to': to,
      'passengers_capacity': passengersCapacity,
      'number_0f_passengers': numberOfPassengers,
      'date_to': dateFrom.toIso8601String(),
      'date_from': dateTo.toIso8601String(),
      'cost': cost,
    };
  }

  static int convertToInt(var source) {
    if (source is int) {
      return source;
    } else if (source is String) {
      return int.tryParse(source) ?? 0;
    } else if (source is double) {
      return source.toInt();
    } else {
      return 0;
    }
  }

  static double convertToDouble(var source) {
    if (source is int) {
      return source.toDouble();
    } else if (source is String) {
      return double.tryParse(source) ?? 0;
    } else if (source is double) {
      return source;
    } else {
      return 0;
    }
  }
}
