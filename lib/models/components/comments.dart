class Comment {
  String id;
  String txt;
  DateTime time;
  String userId;

  Comment(
      {required this.id,
      required this.time,
      required this.txt,
      required this.userId});

  factory Comment.fromJson(Map json) {
    return Comment(
        id: json['id'],
        userId: json['user_id'],
        time: DateTime.tryParse(json['time']) ?? DateTime.now(),
        txt: json['txt']);
  }

  Map<String, dynamic> toJson() {
    return {
      'txt': txt,
      'time': time.toIso8601String(),
      'user_id':userId
    };
  }
}
