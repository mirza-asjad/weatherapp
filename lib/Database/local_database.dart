import 'package:hive/hive.dart';

part 'local_database.g.dart';

@HiveType(typeId: 0)
class WeatherLocalDatabase extends HiveObject {
  @HiveField(0)
  String? main;

  @HiveField(1)
  String? description;

  @HiveField(2)
  String? icon;

  @HiveField(3)
  int? id;

  @HiveField(4)
  double? temp;

  @HiveField(5)
  int? pressure;

  @HiveField(6)
  int? humidity;

  @HiveField(7)
  int? clouds;

  @HiveField(8)
  double? speed;

  @HiveField(9)
  String? country;

  @HiveField(10)
  String? name;

   

  WeatherLocalDatabase({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
    required this.temp,
    required this.clouds,
    required this.pressure,
    required this.humidity,
    required this.speed,
    required this.country,
    required this.name,   
  });
}


