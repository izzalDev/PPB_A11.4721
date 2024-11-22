class User {
  int? _id;
  String? fullname;
  String username;
  String password;

  User({
    this.fullname,
    required this.username,
    required this.password,
    int? id,
  }) : _id = id;

  int? get id => _id;

  set id(int? id) {
    if (_id == null) {
      _id = id;
    } else {
      throw Exception('ID sudah diatur dan tidak bisa diubah lagi.');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'fullname': fullname,
      'username': username,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    final user = User(
      fullname: map['fullname'],
      username: map['username'],
      password: map['password'],
      id: map['id'],
    );
    return user;
  }
}
