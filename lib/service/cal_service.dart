import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';
import 'package:account/constant.dart';

class CalService extends ChangeNotifier {
  List<String> _temp = [];
  double _result = 0;
  CalModes mode = CalModes.income;

  double get result => _result;

  String get tempResult {
    String temp = "";
    for (String val in _temp) {
      temp += val;
    }
    return temp;
  }

  void setMode(CalModes mode) {
    this.mode = mode;
    notifyListeners();
  }

  void calculate() {
    String exp = "";
    for (String val in _temp) {
      exp += val;
    }
    final expression = Expression.parse(exp);
    const evaluator = ExpressionEvaluator();
    final result = evaluator.eval(expression, {});
    _temp.clear();
    _temp.add(result.toString());
    _result = double.parse(result.toString());
    notifyListeners();
  }

  void setResult(String result) {
    _temp.add(result);
    notifyListeners();
  }

  void clear() {
    _temp.clear();
    notifyListeners();
  }

  void removeLast() {
    if (_temp.isNotEmpty) {
      _temp.removeLast();
      notifyListeners();
    }
  }
}

