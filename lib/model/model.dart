class UserData {
  final String? id;
  final String name;
  final String phone;
  final String email;
  final String address;

  UserData({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id'], // MongoDB returns _id
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone": phone,
      "email": email,
      "address": address,
    };
  }
}
