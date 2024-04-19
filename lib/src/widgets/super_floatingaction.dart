import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tennis_court_schedule/src/providers/itemprovider.dart';
import 'package:tennis_court_schedule/src/screens/add_item_page.dart';

class SuperFloatingAction extends StatelessWidget {
  const SuperFloatingAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);
    int _selectedIndex = -1;
    String _name;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddItemPage()),
            );
          },
          backgroundColor: Colors.green,
          child: Icon(Icons.calendar_month_outlined),
        ),
      ],
    );
  }
}
