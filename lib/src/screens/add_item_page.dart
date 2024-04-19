import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tennis_court_schedule/src/models/item.dart';
import 'package:tennis_court_schedule/src/providers/itemprovider.dart';

import 'package:tennis_court_schedule/src/providers/weather_provider.dart';

import 'package:tennis_court_schedule/src/widgets/add_item_button.dart';

class AddItemPage extends StatefulWidget {
  AddItemPage({Key? key}) : super(key: key);

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  List<String> images = [
    'assets/images/A-Grass.jpeg',
    'assets/images/B-Clay.jpeg',
    'assets/images/C-Hard.jpeg',
  ];
  int _selectedIndex = 2;
  String name = '';
  dynamic _selectedDate = DateTime.now();
  final String city = 'Caracas';
  final DateTime date = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  double? _rainProbability;
  String? _text;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      Provider.of<WeatherProvider>(context, listen: false)
          .fetchWeather(city, _selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Schedule a court')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _superName(context),
            _superCourts(context),
            _superDateandWeather(context),
          ],
        ),
      ),
      floatingActionButton: name.isNotEmpty
          ? AddItemButtom(
              name: name,
              date: _selectedDate,
              court: _selectedIndex,
              rain: _rainProbability)
          : Container(),
    );
  }

  Widget _superName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Insert Name',
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
        ),
        onChanged: (value) {
          setState(() {
            name = value;
          });
        },
      ),
    );
  }

  Widget _superCourts(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Please select the court',
              style: TextStyle(color: Colors.black, fontSize: 18)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(images.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 4,
                      color: index == _selectedIndex
                          ? Colors.limeAccent
                          : Colors.transparent),
                  color: _selectedIndex == index
                      ? Colors.blue.withOpacity(0.5)
                      : null, // Color overlay
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Widget _superDateandWeather(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        _selectDate(context);
        setState(() {
          Provider.of<WeatherProvider>(context, listen: false)
              .fetchWeather(city, _selectedDate);
        });
      },
      child: Card(
        color: Colors.green[50],
        elevation: 2,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Date',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                DateFormat.yMMMMd().format(
                    _selectedDate), // Formatting date in 'Month Day, Year' format
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 16),
              Consumer<WeatherProvider>(
                builder: (context, provider, child) {
                  final weather = provider.weather;

                  _rainProbability = weather?.rainProbability;

                  if (weather != null) {
                    return Column(
                      children: [
                        Text(
                          'Rain Probability',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.water_drop_outlined,
                              color: Colors.blue,
                            ),
                            Text(
                              '${(weather.rainProbability).toStringAsFixed(0)}%',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Text('Press the button to get weather data');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
