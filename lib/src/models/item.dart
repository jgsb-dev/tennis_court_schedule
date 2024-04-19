class Item {
  final int id;
  final String name;
  final int court;
  final dynamic date;
  final dynamic rain;

  Item(
      {required this.id,
      required this.name,
      required this.court,
      required this.date,
      required this.rain});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        id: json['id'],
        name: json['name'],
        court: json['court'],
        date: json['date'],
        rain: json['rain']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'court': court, 'date': date, 'rain': rain};
  }
}
