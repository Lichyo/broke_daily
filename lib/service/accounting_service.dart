import 'package:account/service/database_service.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../model/event_detail_model.dart';
import '../model/chart_model.dart';
import 'package:account/constant.dart';

class AccountingService extends ChangeNotifier {
  final DatabaseService databaseService = DatabaseService.instance;
  String title = "";
  AccountingTypes type = AccountingTypes.nil;
  DateTime _date = DateTime.now();
  List<EventDetailModel> events = [];

  void setAccountingType(AccountingTypes type) {
    this.type = type;
    notifyListeners();
  }

  get accountType => type;

  List<ChartData> get chartBalanceData {
    final monthlyExpense = getMonthlyExpense().abs();
    final monthlyIncome = getMonthlyIncome();
    return [
      ChartData('Expenses', monthlyExpense, Colors.red),
      ChartData('Income', monthlyIncome, Colors.green),
    ];
  }

  List<ChartData> get chartExpenseData {
    Map<AccountingTypes, double> expenseMap = {
      AccountingTypes.food: 0,
      AccountingTypes.traffic: 0,
      AccountingTypes.daily: 0,
      AccountingTypes.drink: 0,
      AccountingTypes.luxury: 0,
    };
    final events = getEventsThisMonth();
    for (var event in events) {
      if (event.amount < 0) {
        expenseMap[event.type] = expenseMap[event.type]! + event.amount;
      }
    }
    return [
      ChartData(AccountingTypes.traffic.name,
          expenseMap[AccountingTypes.traffic]!, Colors.green),
      ChartData(AccountingTypes.drink.name, expenseMap[AccountingTypes.drink]!,
          Colors.blue),
      ChartData(AccountingTypes.food.name, expenseMap[AccountingTypes.food]!,
          Colors.orange),
      ChartData(AccountingTypes.daily.name, expenseMap[AccountingTypes.daily]!,
          Colors.white),
      ChartData(AccountingTypes.luxury.name,
          expenseMap[AccountingTypes.luxury]!, Colors.yellow),
    ];
  }

  List<ChartData> get chartIncomeData {
    Map<AccountingTypes, double> incomeMap = {
      AccountingTypes.salary: 0,
      AccountingTypes.passive: 0,
      AccountingTypes.stock: 0,
    };
    final events = getEventsThisMonth();
    for (var event in events) {
      if (event.amount > 0) {
        incomeMap[event.type] = incomeMap[event.type]! + event.amount;
      }
    }
    return [
      ChartData(AccountingTypes.salary.name, incomeMap[AccountingTypes.salary]!,
          Colors.yellow),
      ChartData(AccountingTypes.passive.name,
          incomeMap[AccountingTypes.passive]!, Colors.grey),
      ChartData(AccountingTypes.stock.name, incomeMap[AccountingTypes.stock]!,
          Colors.red),
    ];
  }

  List<EventDetailModel> searchEvents(String query) {
    if (query.isEmpty) {
      return events;
    }
    return events.where((event) {
      final titleLower = event.title.toLowerCase();
      final typeLower = event.type.name.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower) ||
          typeLower.contains(searchLower);
    }).toList();
  }

  Future<void> addNewEvent({
    required double amount,
    required CalModes mode,
  }) async {
    try {
      inspectEventPara(amount: amount);
    } catch (e) {
      throw Exception(e);
    }
    try {
      await databaseService.insert(
        eventDetailModel: EventDetailModel(
          title: title,
          amount: mode == CalModes.income ? amount : -amount,
          date: _date,
          type: type,
        ),
      );
      await initAccountingService();
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> initAccountingService() async {
    events = await databaseService.getEvents();
  }

  Future<void> deleteEvent({required int id}) async {
    await databaseService.delete(id: id);
    await initAccountingService();
    notifyListeners();
  }

  double getMonthlyExpense() {
    final now = DateTime.now();
    double sum = 0;
    for (var event in events) {
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
    for (var event in events) {
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
    return events
        .where((element) =>
            element.date.month == thisMonth && element.date.year == thisYear)
        .toList();
  }

  double getMonthlyBalance() {
    return getMonthlyIncome() + getMonthlyExpense();
  }

  Map<String, List<EventDetailModel>> getEventsGroupedByDate() {
    final eventsByDate = <String, List<EventDetailModel>>{};

    for (var event in events) {
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
    this.title = title;
    print(title);
    notifyListeners();
  }

  void setDate(DateTime date) {
    _date = date;
  }

  void reset() {
    title = "";
    _date = DateTime.now();
    notifyListeners();
  }

  void inspectEventPara({required double amount}) {
    if (title == "") {
      throw Exception("Title is empty");
    }
    if (amount == 0) {
      throw Exception("Amount is 0");
    }
    if (type == AccountingTypes.nil) {
      throw Exception("Type is nil");
    }
  }
}
