import 'package:account/mock_data.dart';
import 'package:account/accounting_service.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:account/view/account_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;

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
        index: _currentIndex,
        color: const Color(0xFF000000),
        backgroundColor: const Color(0xFFD4EBF7),
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
        title: const Text('Account'),
      ),
      body: const AccountListPage(),
    );
  }
}


