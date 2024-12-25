import 'package:account/service/gemini_service.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'config.dart';

void main() async {
  Gemini.init(apiKey: Config.geminiAPIKey);
  await GeminiService.handleUserInput("我昨天吃了一碗牛肉麵");
}
