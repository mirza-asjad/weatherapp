// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';
import 'package:weatherapp/Models/weather.dart';
import 'dart:convert';
import 'package:weatherapp/Models/weather_model.dart';
import 'package:weatherapp/Pages/favourite_page.dart';
import 'package:weatherapp/Pages/weather_page.dart';
import 'package:weatherapp/Utilities/custom_gnav.dart';

class ApiCalling extends StatefulWidget {
  const ApiCalling({super.key});

  @override
  State<ApiCalling> createState() => _ApiCallingState();
}

class _ApiCallingState extends State<ApiCalling> {
  late double lat;
  late double long;

  String location = 'Islamabad';

  Future<void> apiFetch(double lat, double long) async {
    WeatherModel weatherModel =
        Provider.of<WeatherModel>(context, listen: false);

    weatherModel.isLoading = true;

    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=2a300ffc89d89b8a654b8f81b01d12d3'));

    weatherModel.cleardata();

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);

      List<dynamic> weather = responseData['weather'];

      Map<String, dynamic> main = responseData['main'];

      Map<String, dynamic> clouds = responseData['clouds'];

      double tempInFahrenheit = responseData['main']['temp'];

      double tempInCelsius = (tempInFahrenheit - 273.15);

      double temp = double.parse(tempInCelsius.toStringAsFixed(1));

      Map<String, dynamic> wind = responseData['wind'];

      Map<String, dynamic> sys = responseData['sys'];

      String name = responseData['name'] ?? 'unknow';

      for (var weatherData in weather) {
        weatherModel.addWeather(
          Weather(
              id: weatherData['id'],
              main: weatherData['main'] ?? 'unknow',
              description: weatherData['description'] ?? 'unknow',
              icon: weatherData['icon'] ?? 'unknow',
              temp: temp,
              clouds: clouds['all'] ?? 0,
              pressure: main['pressure'] ?? 0,
              humidity: main['humidity'] ?? 0,
              speed: wind['speed'] ?? 0,
              country: sys['country'] ?? 'unknow',
              name: name,
              isLiked: false),
        );
      }
    }

    weatherModel.isLoading = false;
  }

  bool shouldShowSearchBar() {
    // Return true if the selectedindex corresponds to the WallpaperPage
    return selectedindex == 0;
  }

  //Geocoding
  Future<void> convertCityToLatLng(String cityName) async {
    try {
      final query = cityName;
      List<Location> locations = await locationFromAddress(query);

      for (var location in locations) {
        lat = location.latitude;
        long = location.longitude;
        print('Latitude: ${location.latitude}');
        print('Longitude: ${location.longitude}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

   Future<void> refresh() async {
    // Call your API fetch method here
    await apiFetch(lat, long);
  }

  @override
  void initState() {
    super.initState();
    convertCityToLatLng(location).then((_) {
       // Call apiFetch after lat and long are initialized  // learning*
       refresh();
    });
  }

  int selectedindex = 0;

  void bottomchangeitem(int index) {
    setState(() {
      selectedindex = index;
      print(selectedindex);
    });
  }

  final List<Widget> pages = [
    const Weatherpage(),
    const FavouritePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Row(
          children: [
            Icon(
              Icons.cloud,
              color: Colors.blue,
              size: 42,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'W E A T H E R',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomGNav(
        onTabChange: (index) => bottomchangeitem(index),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: refresh,
              child: pages[selectedindex]),
          ),
          if (shouldShowSearchBar())
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    String newLocation = '';

                    return AlertDialog(
                      title: const Text('Change Location'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            onChanged: (value) {
                              newLocation = value;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Enter new location',
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                            ),
                          ),
                          const SizedBox(height: 16), // Add some spacing
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  if (newLocation.isNotEmpty) {
                                    setState(() {
                                      location = newLocation;
                                    });
                                    convertCityToLatLng(newLocation).then((_) {
                                      apiFetch(lat, long);
                                    });
                                  }
                                  Navigator.pop(context);
                                },
                                child: const Text('Change'),
                              ),
                              const SizedBox(width: 12), // Add some spacing
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.location_pin, color: Colors.red),
                    Text('Change Location'),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
