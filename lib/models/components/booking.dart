class Booking {
  String id;
  String bookingPath, bookingType;
  DateTime? reservedFrom, reservedUntil;
  String reservedId;
  String userId;
  double cost;
  DateTime date;
  String image,name;

  Booking(
      {required this.id,
      required this.cost,
        required this.name,
      required this.reservedFrom,
      required this.bookingPath,
      required this.bookingType,
      required this.date,
      required this.image,
      required this.reservedId,
      required this.reservedUntil,
      required this.userId});

  factory Booking.fromJson(Map json) {
    return Booking(
        id: json['id'],
        cost: convertToDouble(json['cost']),
        name: json['name'],
        image: json['image'],
        reservedFrom: DateTime.tryParse(json['reserved_from']??''),
        bookingPath: json['booking_path'],
        bookingType: json['booking_type'],
        date: DateTime.parse(json['date']),
        reservedId: json['reserved_id'],
        reservedUntil: DateTime.tryParse(json['reserved_until']??''),
        userId: json['user_id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'cost': cost,
      'name':name,
      'reserved_from': reservedFrom?.toIso8601String(),
      'reserved_until': reservedUntil?.toIso8601String(),
      'booking_path': bookingPath,
      'booking_type': bookingType,
      'date': date.toIso8601String(),
      'reserved_id': reservedId,
      'user_id': userId,
      'image':image
    };
  }

  static double convertToDouble(var v){
    if(v is double){
      return v;
    }else if(v is int){
      return v.toDouble();

    }else if (v is String){
      return double.tryParse(v)??0  ;

    }else {
      return 0;
    }
  }
}
