import 'package:account/constant.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class GeminiService {
  static Future<Map<String, dynamic>> handleUserInput(String input) async {
    final response = await Gemini.instance.prompt(parts: [
      Part.text('幫我記帳：${input}。${responseFormat()}'),
    ]);
    Map<String, dynamic> result = {};
    if (response != null && response.output != null) {
      final cleanData =
          response.output!.replaceAll('```json', '').replaceAll('```', '');
      result = jsonDecode(cleanData);
      print(cleanData);
      // result['datetime'] =
      //     DateFormat('yyyy/MM/dd').format(DateTime.parse(result['datetime']));
      print(result);
    } else {
      print('No output received from Gemini API');
    }
    return result;
  }

  static String responseFormat() =>
      '回傳成{ amount: 價格, title: 品項, datetime: ${dataTimeFormat()} , type: 從${types()} 裡面挑, cal_mode: 從${calModes()} 裡面挑 }的格式'
      '，不用回傳其他訊息，只限一次一筆資料，所以不用包成 List。就算你抓不到值，也要把 Map 回傳，只是值是空的。';

  static List<String> types() {
    List<String> types = [];
    for (var type in AccountingTypes.values) {
      types.add(type.name);
    }
    return types;
  }

  static List<String> calModes() {
    List<String> calModes = [];
    for (var calMode in CalModes.values) {
      calModes.add(calMode.name);
    }
    return calModes;
  }

  static String dataTimeFormat() {
    return '如果沒有講明日期則取${DateTime.now()}紀錄，'
        '或是以 ${DateTime.now()} 作為標準做紀錄'
        '，例如：我昨天做了什麼，就變成${DateTime.now()} ';
  }
}
