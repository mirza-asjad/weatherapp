

import 'package:flutter/foundation.dart';
import 'package:weatherapp/Models/weather.dart';

class WeatherModel extends ChangeNotifier
{

  List<Weather> weatherList = [];

  void addWeather(Weather weather)
  {
    weatherList.add(weather);
    ChangeNotifier();
  }


  List<Weather> userFavweatherList = [];

  void userFavaddWeather(Weather weather)
  {
    userFavweatherList.add(weather);
    ChangeNotifier();
  }

   void userFavremoveWeather(Weather weather)
  {
    userFavweatherList.remove(weather);
    ChangeNotifier();
  }


  bool _isLoading = false;

  bool get isLoading => _isLoading;


  set isLoading(bool value)
  {
    _isLoading = value;
    notifyListeners();
  }

  void cleardata()
  {
    weatherList.clear();
    notifyListeners();
  }




}