import 'package:flutter/material.dart';
import 'package:account/constant.dart';
import 'package:provider/provider.dart';
import 'package:account/service/accounting_service.dart';

class TypeButton extends StatelessWidget {
  const TypeButton({
    super.key,
    required this.text,
    required this.icon,
    required this.type,
    required this.color,
  });

  final String text;
  final IconData icon;
  final AccountingTypes type;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            Provider.of<AccountingService>(context, listen: false)
                .setAccountingType(type);
          },
          icon: Icon(
            icon,
            color: Provider.of<AccountingService>(context).accountType == type
                ? color
                : Colors.grey.shade800,
          ),
        ),
        Text(
          text,
          style: kSecondTextStyle,
        ),
      ],
    );
  }
}



