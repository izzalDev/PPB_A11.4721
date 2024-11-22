class Contact {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? company;

  Contact({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.company,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['phone'] = phone;
    map['email'] = email;
    map['company'] = company;
    return map;
  }

  Contact.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    phone = map['phone'];
    email = map['email'];
    company = map['company'];
  }
}
