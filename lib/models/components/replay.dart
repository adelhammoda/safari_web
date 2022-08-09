



class Replay{
  final String id,userId;
  String txt;
  DateTime date;


  Replay({
    required this.txt,
    required this.userId,
    required this.id,
    required this.date,
});

  factory Replay.fromJson(Map json){
    return Replay(
      txt:json['txt'],
      userId: json['user_id'],
      date: DateTime.parse(json['time']),
      id:json['id']
    );
  }

  Map<String , dynamic > toJson(){
    return{
      'txt':txt,
      'user_id':userId,
      'time':date.toIso8601String()
    };
  }


}