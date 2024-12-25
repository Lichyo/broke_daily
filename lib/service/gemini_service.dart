import 'package:account/constant.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'dart:convert';

class GeminiService {
  static Future<void> handleUserInput(String input) async {
    final response = await Gemini.instance.prompt(parts: [
      Part.text('幫我記帳：${input}。${responseFormat()}'),
    ]);
    if (response != null && response.output != null) {
      final cleanedOutput =
          response.output!.replaceAll('```json', '').replaceAll('```', '');
      for (var item in jsonDecode(cleanedOutput)) {
        print(item);
      }
    } else {
      print('No output received from Gemini API');
    }
  }

  static String responseFormat() =>
      '回傳成{ amount: 價格, title: 品項, datetime: ${dataTimeFormat()} , type: 從${types()} 裡面挑 }的格式'
      '，不用回傳其他訊息，並且就算只有一個 item 也要用 list 包起來。';

  static List<String> types() {
    List<String> types = [];
    for (var type in AccountingTypes.values) {
      types.add(type.name);
    }
    return types;
  }

  static String dataTimeFormat() {
    return '如果沒有講明日期則取${DateTime.now()}紀錄，'
        '或是以 ${DateTime.now()} 作為標準做紀錄'
        '，例如：我昨天吃了一碗 120 的牛肉麵，就變成${DateTime.now()} '
        '前一天吃了一碗';
  }
}
