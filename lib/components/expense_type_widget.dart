import 'package:flutter/material.dart';
import 'type_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:account/constant.dart';

class ExpenseTypeWidget extends StatelessWidget {
  const ExpenseTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TypeButton(
            text: "Traffic",
            color: Colors.green,
            icon: FontAwesomeIcons.bus,
            type: AccountingTypes.traffic,
          ),
          TypeButton(
            text: "Luxury",
            color: Colors.yellow,
            icon: FontAwesomeIcons.gem,
            type: AccountingTypes.luxury,
          ),
          TypeButton(
            text: "Drink",
            color: Colors.blue,
            icon: FontAwesomeIcons.martiniGlass,
            type: AccountingTypes.drink,
          ),
          TypeButton(
            text: "Food",
            color: Colors.orange,
            icon: FontAwesomeIcons.hamburger,
            type: AccountingTypes.food,
          ),
          TypeButton(
            text: "Daily",
            color: Colors.white,
            icon: FontAwesomeIcons.shop,
            type: AccountingTypes.daily,
          ),
        ],
      ),
    );
  }
}