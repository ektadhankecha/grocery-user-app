class UserModel {
  final String? uid;
  final String name;
  final String email;
  final String phone;
  final String createdAt;

  // Backward compatibility getter
  String get contact => phone;

  UserModel({
    this.uid,
    required this.name,
    required this.email,
    required this.phone,
    this.createdAt = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid ?? '',
      'name': name,
      'email': email,
      'phone': phone,
      'contact': phone,
      'createdAt': createdAt,
      'onboardDate': createdAt,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? json['contact'] ?? '',
      createdAt: json['createdAt'] ?? json['onboardDate'] ?? '',
    );
  }
}