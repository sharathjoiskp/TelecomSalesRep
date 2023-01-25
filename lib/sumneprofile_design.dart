import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: ContactUsBottomAppBar(
        companyName: 'Sharath Jois KP',
        textColor: Colors.white,
        backgroundColor: Colors.teal.shade300,
        email: 'sharathjoiskp@gmail.com',
        // textFont: 'Sail',
      ),
      backgroundColor: Colors.teal,
      body: ContactUs(
          cardColor: Colors.white,
          textColor: Colors.teal.shade900,
          logo: AssetImage('images/ficuslot.jpg'),
          email: 'sharathjoiskp@gmail.com',
          companyName: 'Sharath Jois KP',
          companyColor: Colors.teal.shade100,
          dividerThickness: 2,
          phoneNumber: '+917619129190',
          website: 'https://ficuslot.com',
          githubUserName: 'sharathjoiskp',
          linkedinURL: '',
          tagLine: 'Flutter semi Developer',
          taglineColor: Colors.teal.shade100,
          twitterHandle: 'Sharath Jois KP',
          instagram: 'sharath.jois',
          facebookHandle: 'sharathjoiskp'),
    );
  }
}