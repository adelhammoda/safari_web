class User {
  String  name, phoneNumber, email, photoUrl;
  bool isVerification,isOwner;

  User({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.photoUrl,
    required this.isOwner,
    required this.isVerification,
  });

  factory User.fromJson(Map json) {
    return User(
        name: json['name'],
        isOwner: json['isOwner']??false,
        isVerification: json['is_Verification']??false,
        email: json['email'],
        phoneNumber: json['phone_number'],
        photoUrl: json['photo_url']);
  }

  Map<String ,dynamic > toJson(){
    return {
      'name':name,
      'phone_number':phoneNumber,
      'photo_url':photoUrl,
      'isVerification':isVerification,
      'isOwner':isOwner,
    };
  }


  String get id => email.split('.').first;
}
