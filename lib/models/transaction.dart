class Transaction {
  final String transactionId;
  final double amount;
  final String dateTime;
  final String category;
  final MerchantDetails merchantDetails;

  Transaction({
    required this.transactionId,
    required this.amount,
    required this.dateTime,
    required this.category,
    required this.merchantDetails,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      transactionId: json['transaction_id'],
      amount: json['amount'].toDouble(),
      dateTime: json['date_time'],
      category: json['category'],
      merchantDetails: MerchantDetails.fromJson(json['merchant_details']),
    );
  }
}

class MerchantDetails {
  final String name;
  final String location;

  MerchantDetails({
    required this.name,
    required this.location,
  });

  factory MerchantDetails.fromJson(Map<String, dynamic> json) {
    return MerchantDetails(
      name: json['name'],
      location: json['location'],
    );
  }
}