class User {
  final int? id;
  final String fullname;
  final String username;
  final String password;

  User({
    this.id,
    required this.fullname,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullname': fullname,
      'username': username,
      'password': password,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      fullname: map['fullname'],
      username: map['username'],
      password: map['password'],
    );
  }
}
