import 'package:account/service/accounting_service.dart';
import 'package:account/service/cal_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:account/constant.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:account/components/income_type_widget.dart';
import 'package:account/components/expense_type_widget.dart';

class CalculatePage extends StatefulWidget {
  const CalculatePage({super.key});

  @override
  State<CalculatePage> createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  DateTime dt = DateTime.now();
  late TextEditingController titleController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController(
        text: Provider.of<AccountingService>(context, listen: false).title);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, right: 20),
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Provider.of<CalService>(context, listen: false)
                          .setMode(CalModes.income);
                    },
                    icon: Icon(
                      FontAwesomeIcons.moneyBill,
                      color: Provider.of<CalService>(context).mode ==
                              CalModes.income
                          ? Colors.green
                          : Colors.grey,
                      size: 50,
                    ),
                  ),
                  Text(
                    "Income",
                    style:
                        Provider.of<CalService>(context).mode == CalModes.income
                            ? kPrimaryTextStyle
                            : kSecondTextStyle,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20),
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Provider.of<CalService>(context, listen: false)
                          .setMode(CalModes.expense);
                    },
                    icon: Icon(
                      FontAwesomeIcons.moneyCheckDollar,
                      color: Provider.of<CalService>(context).mode ==
                              CalModes.expense
                          ? Colors.red
                          : Colors.grey,
                      size: 50,
                    ),
                  ),
                  Text(
                    "Expense",
                    style: Provider.of<CalService>(context).mode ==
                            CalModes.expense
                        ? kPrimaryTextStyle
                        : kSecondTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
        Provider.of<CalService>(context).mode == CalModes.income
            ? const IncomeTypeWidget()
            : const ExpenseTypeWidget(),
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
            controller: titleController,
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  titleController.clear();
                },
              ),
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
              Provider.of<CalService>(context).expressionResult,
              style: kPrimaryTextStyle,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  dt = dt.subtract(const Duration(days: 1));
                  Provider.of<AccountingService>(context, listen: false)
                      .setDate(dt);
                });
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            Text(
              DateFormat('yyyy-MM-dd').format(dt),
              style: kSecondTextStyle,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  dt = dt.add(const Duration(days: 1));
                  Provider.of<AccountingService>(context, listen: false)
                      .setDate(dt);
                });
              },
              icon: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Provider.of<CalService>(context, listen: false)
                          .setExpression("7");
                    },
                    icon: const Icon(
                      FontAwesomeIcons.seven,
                      color: Colors.grey,
                      // size: 50,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<CalService>(context, listen: false)
                          .setExpression("8");
                    },
                    icon: const Icon(
                      FontAwesomeIcons.eight,
                      color: Colors.grey,
                      // size: 50,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<CalService>(context, listen: false)
                          .setExpression("9");
                    },
                    icon: const Icon(
                      FontAwesomeIcons.nine,
                      color: Colors.grey,
                      // size: 50,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<CalService>(context, listen: false)
                          .setExpression("/");
                    },
                    icon: const Icon(
                      FontAwesomeIcons.divide,
                      color: Colors.grey,
                      // size: 50,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<CalService>(context, listen: false).clear();
                    },
                    icon: const Icon(
                      FontAwesomeIcons.broom,
                      color: Colors.red,
                      // size: 50,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Provider.of<CalService>(context, listen: false)
                          .setExpression("4");
                    },
                    icon: const Icon(
                      FontAwesomeIcons.four,
                      color: Colors.grey,
                      // size: 50,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<CalService>(context, listen: false)
                          .setExpression("5");
                    },
                    icon: const Icon(
                      FontAwesomeIcons.five,
                      color: Colors.grey,
                      // size: 50,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<CalService>(context, listen: false)
                          .setExpression("6");
                    },
                    icon: const Icon(
                      FontAwesomeIcons.six,
                      color: Colors.grey,
                      // size: 50,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<CalService>(context, listen: false)
                          .setExpression("*");
                    },
                    icon: const Icon(
                      FontAwesomeIcons.x,
                      color: Colors.grey,
                      // size: 50,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<CalService>(context, listen: false)
                          .removeLast();
                    },
                    icon: const Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.grey,
                      // size: 50,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Provider.of<CalService>(context, listen: false)
                          .setExpression("1");
                    },
                    icon: const Icon(
                      FontAwesomeIcons.one,
                      color: Colors.grey,
                      // size: 50,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<CalService>(context, listen: false)
                          .setExpression("2");
                    },
                    icon: const Icon(
                      FontAwesomeIcons.two,
                      color: Colors.grey,
                      // size: 50,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<CalService>(context, listen: false)
                          .setExpression("3");
                    },
                    icon: const Icon(
                      FontAwesomeIcons.three,
                      color: Colors.grey,
                      // size: 50,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<CalService>(context, listen: false)
                          .setExpression("+");
                    },
                    icon: const Icon(
                      FontAwesomeIcons.plus,
                      color: Colors.grey,
                      // size: 50,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<CalService>(context, listen: false)
                          .calculate();
                    },
                    icon: const Icon(
                      FontAwesomeIcons.equals,
                      color: Colors.grey,
                      // size: 50,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Provider.of<CalService>(context, listen: false)
                          .setExpression("00");
                    },
                    icon: const Icon(
                      FontAwesomeIcons.creativeCommonsZero,
                      color: Colors.grey,
                      // size: 50,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<CalService>(context, listen: false)
                          .setExpression("0");
                    },
                    icon: const Icon(
                      FontAwesomeIcons.zero,
                      color: Colors.grey,
                      // size: 50,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<CalService>(context, listen: false)
                          .setExpression(".");
                    },
                    icon: const Icon(
                      FontAwesomeIcons.dotCircle,
                      color: Colors.grey,
                      // size: 50,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<CalService>(context, listen: false)
                          .setExpression("-");
                    },
                    icon: const Icon(
                      FontAwesomeIcons.minus,
                      color: Colors.grey,
                      // size: 50,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      try {
                        await Provider.of<AccountingService>(context,
                                listen: false)
                            .addNewEvent(
                          amount:
                              Provider.of<CalService>(context, listen: false)
                                  .result,
                          mode: Provider.of<CalService>(context, listen: false)
                              .mode,
                        );
                        Provider.of<CalService>(context, listen: false).reset();
                        Provider.of<AccountingService>(context, listen: false)
                            .reset();
                        titleController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Event created successfully'),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        );
                      }
                    },
                    icon: const Icon(
                      FontAwesomeIcons.check,
                      color: Colors.grey,
                      // size: 50,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
