class Room {


  String id;
  double costPerDay;
  DateTime reservedFrom;
  DateTime reservedUnitl;
  int roomNumber;
  String roomType;
  double size;

  Room({
    required this.id,
    required this.size,
    required this.costPerDay,
    required this.reservedFrom,
    required this.reservedUnitl,
    required this.roomNumber,
    required this.roomType,
  });

  factory Room.fromJson(Map json) {
    return Room(
        id: json['id'],
        size: convertToDouble(json['size']),
        costPerDay: convertToDouble(json['cost']),
        reservedFrom: DateTime.parse(json['reserved_from']),
        reservedUnitl: DateTime.parse(json['reserved_until']),
        roomNumber: json['room_number'],
        roomType: json['room_type']);
  }

  Map<String ,dynamic> joJson(){
    return{
      'size':size,
      'cost':costPerDay,
      'reserved_from':reservedFrom.toIso8601String(),
      'reserved_until':reservedUnitl.toIso8601String(),
      'room_type':roomType,
      'room_number':roomNumber
    };
  }

  static double convertToDouble(var i){
    if(i is double){
      return i ;
    }else if (i is int){
      return i.toDouble();
    }else if (i is String){
      return double.tryParse(i)??0;
    }else {
      return -1;
    }
  }
}
