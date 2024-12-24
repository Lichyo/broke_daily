import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';
import 'package:account/constant.dart';

class CalService extends ChangeNotifier {
  List<String> _expression = [];
  double _result = 0;
  CalModes mode = CalModes.income;

  double get result => _result;

  String get expressionResult {
    String temp = "";
    for (String val in _expression) {
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
    for (String val in _expression) {
      exp += val;
    }
    final expression = Expression.parse(exp);
    const evaluator = ExpressionEvaluator();
    final result = evaluator.eval(expression, {});
    _expression.clear();
    _result = double.parse(result.toStringAsFixed(2));
    _expression.add(_result.toString());
    notifyListeners();
  }

  void setExpression(String result) {
    _expression.add(result);
    try {
      double val = double.parse(result);
      _result = _result * 10 + val;
    } catch (e) {}
    notifyListeners();
  }

  void clear() {
    _expression.clear();
    notifyListeners();
  }

  void removeLast() {
    if (_expression.isNotEmpty) {
      _expression.removeLast();
      notifyListeners();
    }
  }

  void reset() {
    _expression.clear();
    _result = 0;
    mode = CalModes.income;
    notifyListeners();
  }
}
