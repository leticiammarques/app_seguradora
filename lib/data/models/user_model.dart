class UserModel {
  String? id;
  String? name;
  String? email;
  String? phone;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email, 'phone': phone};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
    );
  }
}
