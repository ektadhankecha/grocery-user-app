class TransactionsModel {
  final String title;
  final DateTime transactionDate;
  final double amount;

  const TransactionsModel({
    required this.title,
    required this.transactionDate,
    required this.amount,
  });
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'transactionDate': transactionDate.toIso8601String(),
      'amount': amount,
    };
  }

  factory TransactionsModel.fromJson(Map<String, dynamic> json) {
    return TransactionsModel(
      title: json['title'] ?? '',
      transactionDate: json['transactionDate'] != null ? DateTime.parse(json['transactionDate']) : DateTime.now(),
      amount: json['amount'].toDouble(),
    );
  }
}
