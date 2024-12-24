import 'package:account/service/accounting_service.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:account/view/account_list_page.dart';
import 'package:account/view/search_page.dart';
import 'package:account/view/calculate_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;
  bool loading = true;
  final _pageList = [
    const SearchPage(),
    const AccountListPage(),
    CalculatePage(),
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
    setState(() {
      loading = false;
    });
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Account'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Settings'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        child: const Text('Reset Data'),
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          await Provider.of<AccountingService>(context, listen: false).resetDatabase();
                          setState(() {
                            loading = false;
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: loading
          ? const CircularProgressIndicator()
          : _pageList[_currentIndex],
    );
  }
}
