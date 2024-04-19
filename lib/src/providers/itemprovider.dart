import 'package:flutter/material.dart';
import 'package:tennis_court_schedule/src/models/item.dart';

class ItemProvider with ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items => _items;

  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(int id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void updateItem(Item newItem) {
    int index = _items.indexWhere((item) => item.id == newItem.id);
    if (index != -1) {
      _items[index] = newItem;
      notifyListeners();
    }
  }

  bool isVariableRepeatedMoreThanThreeTimesWithSameDate(
      int variable, DateTime date) {
    DateTime truncatedDate = DateTime(date.year, date.month, date.day);
    int count = _items.where((item) {
      DateTime itemDate =
          DateTime(item.date.year, item.date.month, item.date.day);
      return itemDate == truncatedDate && item.court == variable;
    }).length;
    return count >= 3;
  }
}
