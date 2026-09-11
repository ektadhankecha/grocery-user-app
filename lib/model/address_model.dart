class AddressModel {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String zipCode;
  final String city;
  final String country;

  AddressModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.zipCode,
    required this.city,
    required this.country,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'zipCode': zipCode,
      'city': city,
      'country': country,
    };
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      zipCode: json['zipcode'] ?? json['zipcode'] ?? '',
      city: json['city'],
      country: json['country'],
    );
  }
}
