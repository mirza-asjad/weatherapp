// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/Database/local_database.dart';
import 'package:weatherapp/Designs/weathericon_widget.dart';
import 'package:weatherapp/Models/weather_model.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Designs/shimmer.dart';
import '../Models/weather.dart';

class Weatherpage extends StatefulWidget {
  const Weatherpage({super.key});

  @override
  State<Weatherpage> createState() => _WeatherpageState();
}

class _WeatherpageState extends State<Weatherpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        body: Consumer<WeatherModel>(
          builder: (context, weatherModel, child) {
            if (weatherModel.isLoading) {
              return const Center(
                child: ShimmerEffect(),
              );
            } else if (weatherModel.weatherList.isEmpty) {
              return const Center(
                child: Text('No weather report available'),
              );
            } else {
              return Center(
                child: Column(children: [
                  Expanded(
                      child: ListView.builder(
                    itemCount: weatherModel.weatherList.length,
                    itemBuilder: (context, index) {
                      Weather weather = weatherModel.weatherList[index];

                      return Column(
                        children: [
                          LottieBuilder.asset('animations/${weather.icon}.json',
                              height: 100, repeat: true, fit: BoxFit.cover),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                color: Colors.grey.shade500,
                                child: SizedBox(
                                  width: 300,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      //change
                                      IconButton(
                                        onPressed: () {
                                          setState(
                                            () {
                                              Box box = Hive.box('myBox');
                                              weather.isLiked = !weather
                                                  .isLiked;
                                                if(weather.isLiked)
                                                {
                                                   box.put(weather.id, WeatherLocalDatabase(id: weather.id, main: weather.main!, description: weather.description!, icon: weather.icon!, temp: weather.temp!, clouds: weather.clouds!, pressure: weather.pressure!, humidity: weather.humidity!, speed: weather.speed!, country: weather.country!, name: weather.name!));
                                                }
                                                else
                                                {
                                                  box.delete(weather.id);
                                                }
                                             
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          weather.isLiked
                                              ? Icons.favorite
                                              : Icons.favorite_outline_outlined,
                                          color: weather.isLiked? Colors.red : null,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20, bottom: 10),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('${weather.temp!}',
                                                  style: GoogleFonts.raleway(
                                                      color: Colors.white,
                                                      fontSize: 84)),
                                              Text('°C',
                                                  style: GoogleFonts.raleway(
                                                      color: Colors.white,
                                                      fontSize: 34)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      WeatherIconWidget(
                                        iconCode: weather.icon!,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 28),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              weather.main!,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                            const Text(
                                              ',',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Text(
                                              weather.description!,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(weather.name!),
                                            const Text(','),
                                            Text(weather.country!)
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.white,
                                      ),
                                      const Text(
                                        'D E T A I L S',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              const WeatherIconWidget(
                                                iconCode: '50d',
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 12),
                                                child: Text(
                                                    weather.speed!.toString()),
                                              ),
                                              const WeatherIconWidget(
                                                iconCode: '60d',
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 12),
                                                child: Text(weather.pressure!
                                                    .toString()),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const WeatherIconWidget(
                                                iconCode: '70d',
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 12),
                                                child: Text(weather.humidity!
                                                    .toString()),
                                              ),
                                              const WeatherIconWidget(
                                                iconCode: '80d',
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 12),
                                                child: Text(
                                                    weather.clouds!.toString()),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ))
                ]),
              );
            }
          },
        ));
  }
}
