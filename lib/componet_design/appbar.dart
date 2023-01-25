import 'package:flutter/material.dart';

AppBar appbarDesign({required String title}) {
  return AppBar(
    backgroundColor: Colors.brown.shade800,
    title: Row(
      children: [
        Container(
          width: 80,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage('images/ficuslot.jpg'), fit: BoxFit.fill),
          ),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 24),
        ),
      ],
    ),
  );
}

BoxDecoration backgroundColour() => BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.brown.shade800, Colors.brown.shade100]),
    );
