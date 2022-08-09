import 'package:safari_web/models/offices/office.dart';
import 'package:safari_web/models/components/replay.dart';

class Question {
  final String id;
  String txt, userId;
  final DateTime time;
  List<Replay> replies;
  List<String> loves;

  Question({
    required this.id,
    required this.userId,
    required this.time,
    required this.txt,
    required this.replies,
    required this.loves,
  });

  factory Question.fromJson(Map json){
    return Question(
        id: json['id'],
        loves: Office.convertListOfString(json['love']??[]),
        userId: json['user_id'],
        time: DateTime.parse(json['time']),
        txt: json['txt'],
        replies: convertToListOfReplay(json['replies']?? {}));
  }

  Map<String,dynamic> toJson(){
    return{
      'user_id':userId,
      'time':time.toIso8601String(),
      'txt':txt,
      'replies':replies,
    };
  }

  static List<Replay> convertToListOfReplay(Map replay){
    if(replay.isEmpty) return[];
    Map json = {};
    List<Replay> res = [];
    replay.forEach((key, value) {
      json = value as Map ;
      json.addAll({'id':key});
      res.add(Replay.fromJson(json));
    });


    return res;


  }


}