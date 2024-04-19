import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tennis_court_schedule/src/models/item.dart';
import 'package:tennis_court_schedule/src/providers/itemprovider.dart';
import 'package:flutter/material.dart';
import 'package:tennis_court_schedule/src/screens/home_page.dart';

// ignore: must_be_immutable
class AddItemButtom extends StatelessWidget {
  String name;
  DateTime date;
  int court;
  dynamic rain;
  AddItemButtom(
      {Key? key,
      required this.name,
      required this.court,
      required this.date,
      required this.rain})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

    return ElevatedButton(
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
      onPressed: () {
        if (itemProvider.isVariableRepeatedMoreThanThreeTimesWithSameDate(
            court, date)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'The court that you selected is scheduled 3 times on ${DateFormat.yMd().format(date)}, please select another date or court to check avalavility'),
            ),
          );
          print(
              'The court that you selected is scheduled 3 times on ${DateFormat.yMd().format(date)}, please select another date or court to check avalavility');
        } else {
          print(
              'Variable $court is not repeated more than three times on $date');
          itemProvider.addItem(Item(
              id: itemProvider.items.length + 1,
              name: name,
              date: date,
              court: court,
              rain: rain));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      },
      child: Text(
        'Add Item',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
