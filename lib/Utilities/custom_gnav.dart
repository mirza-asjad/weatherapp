import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';




// ignore: must_be_immutable
class CustomGNav extends StatelessWidget {
  void Function(int)? onTabChange;
  CustomGNav({super.key,required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child:  GNav(
        mainAxisAlignment: MainAxisAlignment.center,


        activeColor: Colors.black,
        color: Colors.grey[700],

        onTabChange: (value) => onTabChange!(value),
        
        
        
        
        tabs: const [

          GButton(icon: Icons.cloud_outlined),
          GButton(icon: Icons.favorite_outline_outlined),





      ]),
    );
  }
}