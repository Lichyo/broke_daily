import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:account/service/accounting_service.dart';
import '../constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../model/chart_model.dart';
import 'package:barcode_widget/barcode_widget.dart';

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
          BarcodeWidget(
            height: 100,
            color: Colors.white,
            data: '/5ASUGA2',
            barcode: Barcode.code128(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Selector<AccountingService, double>(
                selector: (context, accountingService) =>
                    accountingService.getMonthlyExpense(),
                builder: (context, monthlyExpense, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('monthly \nexpenses', style: kThirdTextStyle),
                      Text(
                        '\$$monthlyExpense',
                        style: kThirdTextStyle.copyWith(color: Colors.red),
                      )
                    ],
                  );
                },
              ),
              Selector<AccountingService, double>(
                selector: (context, accountingService) =>
                    accountingService.getMonthlyIncome(),
                builder: (context, monthlyIncome, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('monthly \nincome', style: kThirdTextStyle),
                      Text(
                        '\$$monthlyIncome',
                        style: kThirdTextStyle.copyWith(color: Colors.green),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
          const Gap(10),
          Expanded(
            flex: 2,
            child: Selector<AccountingService, List<ChartData>>(
              selector: (context, accountingService) =>
                  accountingService.chartBalanceData,
              builder: (context, chartData, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      "本月收支\n${Provider.of<AccountingService>(context).getMonthlyBalance()}",
                      style: kSecondTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    PieChart(
                      swapAnimationDuration: const Duration(milliseconds: 800),
                      swapAnimationCurve: Curves.easeInQuint,
                      PieChartData(
                        sections: chartData
                            .map(
                              (data) => PieChartSectionData(
                                value: data.amount,
                                color: data.color,
                                titleStyle: kThirdTextStyle,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const Gap(30),
          Selector<AccountingService, List<String>>(
            selector: (context, accountingService) =>
                accountingService.getDates(),
            builder: (context, dates, child) {
              return Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey, width: 2),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: dates.length,
                    itemBuilder: (context, index) {
                      final date = dates[index];
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
                          Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                          ...events.map(
                            (event) => GestureDetector(
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        event.title,
                                        style: kPrimaryTextStyle,
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Amount: \$${event.amount}',
                                            style: kSecondTextStyle,
                                          ),
                                          Text(
                                            'Date: ${DateFormat('yyyy/MM/dd').format(event.date)}',
                                            style: kSecondTextStyle,
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await Provider.of<
                                                        AccountingService>(
                                                    context,
                                                    listen: false)
                                                .deleteEvent(id: event.id!);
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Confirm'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: ListTile(
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
                                subtitle: Text(
                                  event.type.name,
                                  style: kSecondTextStyle,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
