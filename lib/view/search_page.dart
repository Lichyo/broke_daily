import 'package:intl/intl.dart';
import 'package:account/constant.dart';
import 'package:flutter/material.dart';
import 'package:account/service/accounting_service.dart';
import 'package:provider/provider.dart';
import '../model/event_detail_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search by Title or Category',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  setState(() {
                    _searchQuery = '';
                  });
                },
              ),
            ),
            onChanged: (query) {
              setState(() {
                _searchQuery = query;
              });
            },
          ),
        ),
        Selector<AccountingService, List<EventDetailModel>>(
          selector: (context, accountingService) =>
              accountingService.searchEvents(_searchQuery),
          builder: (context, filteredEvents, child) {
            filteredEvents.sort((a, b) => b.date.compareTo(a.date));
            return Expanded(
              child: ListView.builder(
                itemCount: filteredEvents.length,
                itemBuilder: (context, index) {
                  final event = filteredEvents[index];
                  return GestureDetector(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(event.title, style: kPrimaryTextStyle,),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  await Provider.of<AccountingService>(
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
                        '${DateFormat('yyyy/MM/dd').format(event.date)} ${event.title}',
                        style: kSecondTextStyle,
                      ),
                      trailing: Text(
                        '\$${event.amount}',
                        style: kSecondTextStyle.copyWith(
                          color: event.amount < 0 ? Colors.red : Colors.green,
                        ),
                      ),
                      subtitle: Text(
                        event.type.name,
                        style: kThirdTextStyle.copyWith(color: Colors.grey),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}