import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../model/event_detail_model.dart';
import '../model/chart_model.dart';

class AccountingService extends ChangeNotifier {
  List<EventDetailModel> allEvents = [];
  String _title = "";
  DateTime _date = DateTime.now();

  List<ChartData> getChartData() {
    final monthlyExpense = getMonthlyExpense().abs();
    final monthlyIncome = getMonthlyIncome();

    return [
      ChartData('Expenses', monthlyExpense, Colors.red),
      ChartData('Income', monthlyIncome, Colors.green),
    ];
  }

  void addNewEvent({
    required double amount,
    String? type,
  }) {
    final newEvent = EventDetailModel(
      type: type ?? "None",
      id: allEvents.length + 1,
      date: _date,
      title: _title,
      amount: amount,
    );
    allEvents.add(newEvent);
    notifyListeners();
  }

  void deleteEvent({required int id}) {
    allEvents.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  double getMonthlyExpense() {
    final now = DateTime.now();
    double sum = 0;
    for (var event in allEvents) {
      if (event.date.month == now.month && event.date.year == now.year) {
        if (event.amount > 0) {
          continue;
        } else {
          sum += event.amount;
        }
      }
    }
    return sum;
  }

  double getMonthlyIncome() {
    final now = DateTime.now();
    double sum = 0;
    for (var event in allEvents) {
      if (event.date.month == now.month && event.date.year == now.year) {
        if (event.amount < 0) {
          continue;
        } else {
          sum += event.amount;
        }
      }
    }
    return sum;
  }

  List<EventDetailModel> getEventsThisMonth() {
    final now = DateTime.now();
    final thisMonth = now.month;
    final thisYear = now.year;
    return allEvents
        .where((element) =>
            element.date.month == thisMonth && element.date.year == thisYear)
        .toList();
  }

  double getMonthlyBalance() {
    return getMonthlyIncome() + getMonthlyExpense();
  }

  Map<String, List<EventDetailModel>> getEventsGroupedByDate() {
    final eventsByDate = <String, List<EventDetailModel>>{};

    for (var event in allEvents) {
      final dateKey = DateFormat('yyyy/MM/dd EEEE').format(event.date);
      if (eventsByDate.containsKey(dateKey)) {
        eventsByDate[dateKey]!.add(event);
      } else {
        eventsByDate[dateKey] = [event];
      }
    }

    return eventsByDate;
  }

  List<String> getDates() {
    final List<String> sortedKeys = getEventsGroupedByDate().keys.toList()
      ..sort((a, b) => b.compareTo(a));
    return sortedKeys;
  }

  void setTitle(String title) {
    this._title = title;
  }

  void setDate(DateTime date) {
    this._date = date;
  }
}
