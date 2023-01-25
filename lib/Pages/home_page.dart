import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tsr_management/Pages/dailer_page.dart';
import 'package:tsr_management/Pages/dammyPage.dart';
import 'package:tsr_management/Pages/dontcall_page.dart';
import 'package:tsr_management/Pages/record_page.dart';
import 'package:tsr_management/Pages/remeber_page.dart';

import '../componet_design/appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final screens = [
    DailerPage(),
    RecordPage(),
    RememberPage(),
    DontCallPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        color: Colors.brown,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: GNav(
              backgroundColor: Colors.brown,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade800,
              gap: 8,
              onTabChange: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              tabs: [
                GButton(
                  icon: Icons.dialpad,
                  text: 'Call',
                ),
                GButton(
                  icon: Icons.history,
                  text: 'Record',
                ),
                GButton(
                  icon: Icons.phone_missed,
                  text: 'Call Later',
                ),
                GButton(
                  icon: Icons.call_outlined,
                  text: 'Dont Call',
                ),
                // GButton(
                //   icon: Icons.not_interested,
                //   text: 'Dammy',
                // ),
              ]),
        ),
      ),
    );
  }
}
