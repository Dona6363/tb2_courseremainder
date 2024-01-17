class Student {
  int? id;
  String name;
  String nim;
  String phone;
  String email;

  Student({
    this.id,
    required this.name,
    required this.nim,
    required this.phone,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nim': nim,
      'phone': phone,
      'email': email,
    };
  }
}
