import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_court_schedule/src/providers/itemprovider.dart';
import 'package:tennis_court_schedule/src/providers/weather_provider.dart';

import 'package:tennis_court_schedule/src/screens/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => ItemProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WeatherProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Material App',
        initialRoute: 'home',
        routes: {'home': (context) => const HomePage()},
      ),
    );
  }
}
