import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_court_schedule/src/models/item.dart';
import 'package:tennis_court_schedule/src/providers/itemprovider.dart';

import 'package:tennis_court_schedule/src/widgets/super_floatingaction.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);
    List<Item> sortedList = List.from(itemProvider.items);
    sortedList.sort((a, b) => a.date.compareTo(b.date));

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Tennis Courts Schedule')),
      body: ListView.builder(
        itemCount: sortedList.length,
        itemBuilder: (context, index) {
          final item = sortedList[index];
          return Dismissible(
            key: Key(item.id.toString()),
            background: Container(color: Colors.red),
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Confirm"),
                    content:
                        Text("Are you sure you want to delete ${item.name}?"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context)
                            .pop(true), // Dismiss with true
                        child: Text("DELETE"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context)
                            .pop(false), // Dismiss with false
                        child: Text("CANCEL"),
                      ),
                    ],
                  );
                },
              );
            },
            onDismissed: (direction) {
              // Remove the item from the provider
              itemProvider.removeItem(item.id);

              // Optionally show a snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${item.name} dismissed"),
                ),
              );
            },
            child: Card(
              color: Colors.green.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 1,
              shadowColor: Colors.black.withOpacity(0.2),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    item.court == 0
                        ? 'assets/images/A-Grass.jpeg'
                        : item.court == 1
                            ? 'assets/images/B-Clay.jpeg'
                            : item.court == 2
                                ? 'assets/images/C-Hard.jpeg'
                                : 'assets/images/C-Hard.jpeg',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(item.name,
                    style: TextStyle(color: CupertinoColors.black)),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${DateFormat.yMd().format(item.date)}',
                      style: TextStyle(color: CupertinoColors.systemGrey),
                    ),
                    Text(
                      item.court == 0
                          ? 'Court type: A (Grass)'
                          : item.court == 1
                              ? 'Court type: B (Clay)'
                              : item.court == 2
                                  ? 'Court type: C (Hard)'
                                  : 'Court type: C (Hard)',
                      style: TextStyle(color: CupertinoColors.systemGrey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Rain probability: ',
                          style: TextStyle(color: CupertinoColors.systemGrey),
                        ),
                        Icon(
                          Icons.water_drop_outlined,
                          size: 16,
                          color: Colors.blue,
                        ),
                        Text(
                          '${(item.rain)}%', // Converting rain probability to percentage
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors
                                .blue, // Using blue color for rain probability
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: SuperFloatingAction(),
    );
  }
}
