class CardModel {
  final String name;
  final String cardNumber;
  final String date;
  final String cvv;

  CardModel({
    required this.name,
    required this.cardNumber,
    required this.date,
    required this.cvv,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cardNumber': cardNumber,
      'date': date,
      'cvv': cvv,
    };
  }

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      name: json['name'] ?? '',
      cardNumber: json['cardNumber'] ?? '',
      date: json['date'] ?? '',
      cvv: json['cvv'] ?? '',
    );
  }
}
