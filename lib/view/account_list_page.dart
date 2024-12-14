import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/accounting_service.dart';
import '../constant.dart';

class AccountListPage extends StatelessWidget {
  const AccountListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('monthly \nexpenses', style: kThirdTextStyle),
                  Text(
                    '\$${Provider.of<AccountingService>(context, listen: false).getMonthlyExpense()}',
                    style: kThirdTextStyle.copyWith(color: Colors.red),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('monthly \nincome', style: kThirdTextStyle),
                  Text(
                    '\$${Provider.of<AccountingService>(context, listen: false).getMonthlyIncome()}',
                    style: kThirdTextStyle.copyWith(color: Colors.green),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 300,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey, width: 2),
              ),
              child: ListView.builder(
                itemCount:
                Provider.of<AccountingService>(context).getDates().length,
                itemBuilder: (context, index) {
                  final date =
                  Provider.of<AccountingService>(context).getDates()[index];
                  final events = Provider.of<AccountingService>(context)
                      .getEventsGroupedByDate()[date] ??
                      [];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          date,
                          style: kPrimaryTextStyle,
                        ),
                      ),
                      ...events
                          .map((event) => ListTile(
                        title: Text(
                          event.title,
                          style: kSecondTextStyle,
                        ),
                        trailing: Text(
                          '\$${event.amount}',
                          style: kSecondTextStyle.copyWith(
                            color: event.amount < 0
                                ? Colors.red
                                : Colors.green,
                          ),
                        ),
                      ))
                          .toList(),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}