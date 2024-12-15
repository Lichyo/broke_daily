import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

class CalService extends ChangeNotifier {
  List<String> _temp = [];

  String get tempResult {
    String temp = "";
    for (String val in _temp) {
      temp += val;
    }
    return temp;
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
