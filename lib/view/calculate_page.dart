import 'package:account/cal_service.dart';
import 'package:account/calculator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:account/constant.dart';
import 'package:provider/provider.dart';

class CalculatePage extends StatelessWidget {
  CalculatePage({super.key});

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
        Expanded(
          child: Center(
            child: Text(
              Provider.of<CalService>(context).tempResult,
              style: kPrimaryTextStyle,
            ),
          ),
        ),
        const Calculator(),
      ],
    );
  }
}
