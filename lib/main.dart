import 'package:account/service/accounting_service.dart';
import 'package:account/service/cal_service.dart';
import 'package:flutter/material.dart';
import 'package:account/view/home_page.dart';
import 'package:provider/provider.dart';
import 'config.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

void main() async {
  Gemini.init(apiKey: Config.geminiAPIKey);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AccountingService()),
        ChangeNotifierProvider(create: (context) => CalService()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: const HomePage(),
      ),
    );
  }
}
