import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tsr_management/Pages/Auth/auth_screen.dart';

AppBar appbarDesign({required String title}) {
  return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.indigo,
      title: Row(
        children: [
          Container(
            width: 80,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('images/tsrLogo.png'), fit: BoxFit.cover),
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.defaultDialog(
                title: "Wanna LogOut 👋 ",
                titleStyle: TextStyle(color: Colors.red),
                backgroundColor: Colors.grey.shade600,
                content: Text(
                  'After logout you can login through OTP',
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('No')),
                  ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Get.to(AuthPage());
                      },
                      child: Text('Yes')),
                ]);
          },
          icon: Icon(Icons.logout),
        )
      ]);
}

BoxDecoration backgroundColour() =>
    BoxDecoration(color: Colors.orangeAccent.withOpacity(0.05));
