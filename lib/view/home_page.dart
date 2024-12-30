import 'package:account/constant.dart';
import 'package:account/service/accounting_service.dart';
import 'package:account/service/gemini_service.dart';
import 'package:account/service/invoice_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:account/view/account_list_page.dart';
import 'package:account/view/search_page.dart';
import 'package:account/view/calculate_page.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:account/service/cal_service.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;
  bool loading = true;
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  Map<String, dynamic> result = {};
  final invoiceTextController = TextEditingController();

  String _lastWords = '';
  final _pageList = [
    const SearchPage(),
    const AccountListPage(),
    const CalculatePage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTask();
  }

  Future<void> initTask() async {
    await Provider.of<AccountingService>(context, listen: false)
        .initAccountingService();
    _initSpeech();
    setState(() {
      loading = false;
    });
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      loading = true;
    });
    try {
      result = await GeminiService.handleUserInput(_lastWords);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Confirm Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('項目： ${result['title']}', style: kSecondTextStyle),
              Text('金額： ${result['amount']}', style: kSecondTextStyle),
              Text(
                  '時間： ${DateFormat('yyyy/MM/dd').format(DateTime.parse(result['datetime']))}',
                  style: kSecondTextStyle),
              Text('種類： ${result['type']}', style: kSecondTextStyle),
            ],
          ),
          actions: [
            Row(
              children: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Confirm'),
                  onPressed: () async {
                    Provider.of<AccountingService>(context, listen: false)
                        .reset();
                    Provider.of<AccountingService>(context, listen: false)
                        .setAccountingType(
                      AccountingTypesExtension.fromString(
                        result['type'],
                      ),
                    );
                    Provider.of<AccountingService>(context, listen: false)
                        .setTitle(
                      result['title'],
                    );
                    Provider.of<AccountingService>(context, listen: false)
                        .setDate(
                      DateTime.parse(result['datetime']),
                    );
                    await Provider.of<AccountingService>(context, listen: false)
                        .addNewEvent(
                      amount: double.parse(result['amount'].toString()),
                      mode: CalModesExtension.fromString(
                        result['cal_mode'],
                      ),
                    );
                    Provider.of<AccountingService>(context, listen: false)
                        .reset();
                    Provider.of<CalService>(context, listen: false).reset();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
          ],
        ),
      );
    } catch (e) {
      print(e);
    }
    setState(() {
      loading = false;
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    _lastWords = result.recognizedWords;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: CurvedNavigationBar(
        color: const Color(0xFF121212),
        index: _currentIndex,
        items: const [
          Icon(Icons.format_list_bulleted, size: 30),
          Icon(Icons.home_filled, size: 30),
          Icon(Icons.calculate_outlined, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: Visibility(
        visible: _currentIndex != 2,
        child: FloatingActionButton(
          onPressed:
              _speechToText.isNotListening ? _startListening : _stopListening,
          tooltip: 'Listen',
          child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Account'),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.refresh),
            onPressed: () async {
              setState(() {
                loading = true;
              });
              await Provider.of<AccountingService>(context, listen: false)
                  .resetDatabase();
              setState(() {
                loading = false;
              });
              Navigator.of(context).pop();
            },
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Invoice Number'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: invoiceTextController,
                          decoration: InputDecoration(
                            labelText: 'Enter your Invoice #',
                            labelStyle: kThirdTextStyle,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  invoiceTextController.clear();
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Confirm'),
                            onPressed: () async {
                              await InvoiceService().saveInvoiceNumber(
                                  invoiceTextController.text);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            icon: const Icon(FontAwesomeIcons.fileInvoice),
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : _pageList[_currentIndex],
    );
  }
}
