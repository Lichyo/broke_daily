import 'package:account/service/mock_data.dart';
import 'package:account/service/accounting_service.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:account/view/account_list_page.dart';
import 'package:account/view/analysis_page.dart';
import 'package:account/view/calculate_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;
  final _pageList = [
    const AnalysisPage(),
    const AccountListPage(),
    CalculatePage(),
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<AccountingService>(context, listen: false).allEvents =
        MockData.mockEvents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: _pageList[_currentIndex],
    );
  }
}
