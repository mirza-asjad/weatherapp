// ignore_for_file: sized_box_for_whitespace, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';

import '../Database/local_database.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  // Open the box
  final Box box = Hive.box('myBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box box, child) {
          // Retrieve data and display it
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              WeatherLocalDatabase weatherData = box.getAt(index)!;
              return Slidable(
                endActionPane:
                    ActionPane(motion: const StretchMotion(), children: [
                  SlidableAction(
                    onPressed: (context) {
                      box.deleteAt(index);
                    },
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  
                ]),
                child: ListTile(
                  title: Text(weatherData.name!),
                  subtitle: Text(weatherData.description!),
                  trailing: Text(weatherData.temp.toString()+'°C'),
                  leading: Container(
                    height: 50,
                    width: 50,
                    child: LottieBuilder.asset(
                        'animations/${weatherData.icon}.json'),
                        
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
