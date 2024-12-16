class EventDetailModel {
  final String title;
  int? id;
  final double amount;
  final DateTime date;
  final String? type;

  EventDetailModel({
    this.type,
    required this.title,
    this.id,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'amount': amount.toString(),
      'date': date.toString(),
    };
  }
}
