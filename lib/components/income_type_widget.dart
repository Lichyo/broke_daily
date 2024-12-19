import 'package:flutter/material.dart';
import 'type_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:account/constant.dart';

class IncomeTypeWidget extends StatelessWidget {
  const IncomeTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TypeButton(
            text: "salary",
            color: Colors.yellow,
            icon: FontAwesomeIcons.moneyBill1Wave,
            type: AccountingTypes.salary,
          ),
          TypeButton(
            text: "stock",
            color: Colors.red,
            icon: FontAwesomeIcons.chartLine,
            type: AccountingTypes.stock,
          ),
          TypeButton(
            text: "passive",
            color: Colors.grey,
            icon: FontAwesomeIcons.house,
            type: AccountingTypes.passive,
          ),
        ],
      ),
    );
  }
}
