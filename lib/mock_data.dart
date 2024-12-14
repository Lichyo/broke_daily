import 'event_detail_model.dart';

class MockData {
  static List<EventDetailModel> mockEvents = [
    EventDetailModel(title: 'Tutor', id: 0, amount: 1350, date: DateTime.now()),
    EventDetailModel(title: 'Dinner', id: 1, amount: -200, date: DateTime.now()),
    EventDetailModel(title: 'Tutor', id: 2, amount: 1350, date: DateTime.now()),
    EventDetailModel(title: 'Coffee', id: 3, amount: -31, date: DateTime.now()),
    EventDetailModel(title: 'Tutor', id: 4, amount: 1350, date: DateTime.now().subtract(const Duration(days: 1))),
  ];
}
