import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../service/cal_service.dart';
import 'package:account/service/accounting_service.dart';
import 'package:account/constant.dart';

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Provider.of<CalService>(context, listen: false)
                      .setResult("7");
                },
                icon: const Icon(
                  FontAwesomeIcons.seven,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<CalService>(context, listen: false)
                      .setResult("8");
                },
                icon: const Icon(
                  FontAwesomeIcons.eight,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<CalService>(context, listen: false)
                      .setResult("9");
                },
                icon: const Icon(
                  FontAwesomeIcons.nine,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<CalService>(context, listen: false)
                      .setResult("/");
                },
                icon: const Icon(
                  FontAwesomeIcons.divide,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<CalService>(context, listen: false).clear();
                },
                icon: const Icon(
                  FontAwesomeIcons.broom,
                  color: Colors.red,
                  size: 50,
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
                      .setResult("4");
                },
                icon: const Icon(
                  FontAwesomeIcons.four,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<CalService>(context, listen: false)
                      .setResult("5");
                },
                icon: const Icon(
                  FontAwesomeIcons.five,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<CalService>(context, listen: false)
                      .setResult("6");
                },
                icon: const Icon(
                  FontAwesomeIcons.six,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<CalService>(context, listen: false)
                      .setResult("*");
                },
                icon: const Icon(
                  FontAwesomeIcons.x,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<CalService>(context, listen: false).removeLast();
                },
                icon: const Icon(
                  FontAwesomeIcons.arrowLeft,
                  color: Colors.grey,
                  size: 50,
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
                      .setResult("1");
                },
                icon: const Icon(
                  FontAwesomeIcons.one,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<CalService>(context, listen: false)
                      .setResult("2");
                },
                icon: const Icon(
                  FontAwesomeIcons.two,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<CalService>(context, listen: false)
                      .setResult("3");
                },
                icon: const Icon(
                  FontAwesomeIcons.three,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<CalService>(context, listen: false)
                      .setResult("+");
                },
                icon: const Icon(
                  FontAwesomeIcons.plus,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<CalService>(context, listen: false).calculate();
                },
                icon: const Icon(
                  FontAwesomeIcons.equals,
                  color: Colors.grey,
                  size: 50,
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
                      .setResult("00");
                },
                icon: const Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.zero,
                      color: Colors.grey,
                      size: 25,
                    ),
                    Icon(
                      FontAwesomeIcons.zero,
                      color: Colors.grey,
                      size: 25,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<CalService>(context, listen: false)
                      .setResult("0");
                },
                icon: const Icon(
                  FontAwesomeIcons.zero,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<CalService>(context, listen: false)
                      .setResult(".");
                },
                icon: const Icon(
                  FontAwesomeIcons.solidCircle,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<CalService>(context, listen: false)
                      .setResult("-");
                },
                icon: const Icon(
                  FontAwesomeIcons.minus,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () async{
                  final bool result = await Provider.of<AccountingService>(context, listen: false).addNewEvent(
                    amount: Provider.of<CalService>(context, listen: false).result,
                    mode: Provider.of<CalService>(context, listen: false).mode,
                  );

                  Provider.of<AccountingService>(context, listen: false).setTitle("");
                  Provider.of<CalService>(context, listen: false).setMode(CalModes.income);
                  Provider.of<CalService>(context, listen: false).clear();

                  if (result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Event created successfully')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Failed to create event')),
                    );
                  }
                },
                icon: const Icon(
                  FontAwesomeIcons.check,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
