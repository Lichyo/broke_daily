import 'package:account/service/accounting_service.dart';
import 'package:account/service/cal_service.dart';
import 'package:account/component/calculator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:account/constant.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CalculatePage extends StatefulWidget {
  CalculatePage({super.key});

  @override
  State<CalculatePage> createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  DateTime dt = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, right: 20),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesomeIcons.moneyBill,
                  color: Colors.green,
                  size: 50,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesomeIcons.moneyCheckDollar,
                  color: Colors.red,
                  size: 50,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Title',
            ),
            onChanged: (text) {
              Provider.of<AccountingService>(context, listen: false)
                  .setTitle(text);
            },
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              Provider.of<CalService>(context).tempResult,
              style: kPrimaryTextStyle,
            ),
          ),
        ),
        GestureDetector(
          onPanEnd: (details) {
            setState(() {
              if (details.velocity.pixelsPerSecond.dx > 0) {
                dt = dt.add(const Duration(days: 1));
              } else if (details.velocity.pixelsPerSecond.dx < 0) {
                dt = dt.subtract(const Duration(days: 1));
              }
              Provider.of<AccountingService>(context, listen: false)
                  .setDate(dt);
            });
          },
          child: Text(
            DateFormat('yyyy-MM-dd').format(dt),
            style: kSecondTextStyle,
          ),
        ),
        const Calculator(),
      ],
    );
  }
}
