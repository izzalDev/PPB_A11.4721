class Contact {
  int id = 0;
  String name = "";
  String phone = "";

  Contact({
    required this.id,
    required this.name,
    required this.phone,
  });

  Contact.fromMap(Map<String, dynamic> contact) {
    id = contact['id'];
    name = contact['name'];
    phone = contact['phone'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    return map;
  }
}
