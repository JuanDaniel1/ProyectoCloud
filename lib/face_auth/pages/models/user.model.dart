import 'dart:convert';

class Userface {
  String user;
  String password;
  List modelData;
  bool logged = false;

  Userface({
    required this.user,
    required this.password,
    required this.modelData,
  });

  static Userface fromMap(Map<String, dynamic> user) {
    return new Userface(
      user: user['user'],
      password: user['password'],
      modelData: jsonDecode(user['model_data']),
    );
  }

  toMap() {
    return {
      'user': user,
      'password': password,
      'model_data': jsonEncode(modelData),
    };
  }
}
