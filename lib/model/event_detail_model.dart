class EventDetailModel {
  final String title;
  final int id;
  final double amount;
  final DateTime date;
  final String? type;

  EventDetailModel({
    this.type,
    required this.title,
    required this.id,
    required this.amount,
    required this.date,
  });
}