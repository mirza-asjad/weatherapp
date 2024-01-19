import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherIconWidget extends StatelessWidget {
  final String iconCode;

  const WeatherIconWidget({super.key, required this.iconCode});

  @override
  Widget build(BuildContext context) {
    IconData weatherIcon = mapOpenWeatherIcon(iconCode);
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Center(
        child: Icon(
          weatherIcon,
          size: 30.0,
          color: Colors.blue, // Customize icon color
        ),
      ),
    );
  }

  IconData mapOpenWeatherIcon(String iconCode) {
    switch (iconCode) {
      case "01d":
        return WeatherIcons.day_sunny;
        case "01n":
        return WeatherIcons.night_clear;
      case "02d":
        return WeatherIcons.day_cloudy;
        case "02n":
        return WeatherIcons.night_cloudy;
      case "03d":
        return WeatherIcons.cloudy;
        case "03n":
        return WeatherIcons.night_cloudy_high;
      case "04d":
        return WeatherIcons.cloudy_windy;
         case "04n":
        return WeatherIcons.night_cloudy_windy;
      case "09d":
        return WeatherIcons.showers;
        case "09n":
        return WeatherIcons.night_showers;
      case "10d":
        return WeatherIcons.rain;
          case "10n":
        return WeatherIcons.night_rain;
      case "11d":
        return WeatherIcons.thunderstorm;
        case "11n":
        return WeatherIcons.night_thunderstorm;
      case "13d":
        return WeatherIcons.snow;
        case "13n":
        return WeatherIcons.night_snow;
      case "50d":
        return WeatherIcons.windy;
         case "50n":
        return WeatherIcons.night_cloudy_windy;
      case "60d":
        return WeatherIcons.barometer;
        case "70d":
        return WeatherIcons.humidity;
         case "80d":
        return WeatherIcons.cloud;
      // Add more cases for other icons if needed
      default:
        return WeatherIcons.na; // Placeholder for unknown icons
    }
  }
}
