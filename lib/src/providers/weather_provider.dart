import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tennis_court_schedule/src/models/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  Weather? _weather;

  Weather? get weather => _weather;

  Future<void> fetchWeather(String city, DateTime date) async {
    final apiKey = '37cd7bc3ec439055d9524583e475f801';
    final url =
        'http://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final list = data['list'] as List<dynamic>;
      final rainProbability = list.firstWhere((element) {
        final dt = DateTime.fromMillisecondsSinceEpoch(element['dt'] * 1000);
        return dt.day == date.day &&
            dt.month == date.month &&
            dt.year == date.year;
      }, orElse: () => null)?.containsKey('rain')
          ? list.firstWhere((element) {
              final dt =
                  DateTime.fromMillisecondsSinceEpoch(element['dt'] * 1000);
              return dt.day == date.day &&
                  dt.month == date.month &&
                  dt.year == date.year;
            })['rain']['3h']
          : 0.0;
      _weather =
          Weather(city: city, date: date, rainProbability: rainProbability);
      notifyListeners();
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
