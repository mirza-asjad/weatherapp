// ignore_for_file: non_constant_identifier_names

class Weather 
{
  String? main;
  String? description;
  String? icon;
  int id;


  double? temp;
  int? pressure;
  int? humidity;
  int? clouds;
  


  double? speed;

  String? country;

  String? name;


  bool isLiked;


  Weather({required this.id,required this.main,required this.description,required this.icon,
  required this.temp,required this.clouds,
  required this.pressure,required this.humidity,required this.speed,required this.country,
  required this.name,required this.isLiked});

}