import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tsr_management/DatabaseManager/database.dart';
import 'package:tsr_management/Pages/call_later.dart';
import 'package:tsr_management/Pages/dailer_page.dart';
import 'package:tsr_management/Pages/home_page.dart';

import 'package:url_launcher/url_launcher.dart';

TextEditingController responseController = TextEditingController();
String selectedSector = '';
callConnected(String phoneNumber, String uid) {
  Get.defaultDialog(
      title: "Select the response",
      titleStyle: TextStyle(color: Colors.white),
      backgroundColor: Colors.grey.shade600,
      content: Text(''),
      actions: [
        ElevatedButton(
            onPressed: () {
              selectedSector = 'Not Intersted';
              ShowDialog(selectedSector, phoneNumber, uid);
            },
            child: Text('Not Intersted')),
        ElevatedButton(
            onPressed: () {
              Get.to(CallLater(UID: uid, documentId: phoneNumber));
            },
            child: Text('Call Later')),
        ElevatedButton(
            onPressed: () {
              selectedSector = 'App';
              ShowDialog(selectedSector, phoneNumber, uid);
            },
            child: Text('App')),
        ElevatedButton(
            onPressed: () {
              selectedSector = 'Web';
              ShowDialog(selectedSector, phoneNumber, uid);
            },
            child: Text('Web')),
        ElevatedButton(
            onPressed: () {
              selectedSector = 'Digital Marketing';
              ShowDialog(selectedSector, phoneNumber, uid);
            },
            child: Text('Digital Marketing')),
        ElevatedButton(
            onPressed: () {
              selectedSector = 'Web and Digital Marketing';
              ShowDialog(selectedSector, phoneNumber, uid);
            },
            child: Text('Web and Digital Marketing')),
        ElevatedButton(
            onPressed: () {
              selectedSector = 'App and Digital Marketing';
              ShowDialog(selectedSector, phoneNumber, uid);
            },
            child: Text('App And Digital Marketing')),
        ElevatedButton(
            onPressed: () {
              selectedSector = 'Web and App';
              ShowDialog(selectedSector, phoneNumber, uid);
            },
            child: Text('Web And App')),
        ElevatedButton(
            onPressed: () async {
              selectedSector = 'Profile Sent';
              var url =
                  "https://wa.me//$phoneNumber?text= Thank you for your interest in our company services.This is our company profile .Please go thourh it ";
              await launch(url);
              addResponse(
                  phoneNumber, selectedSector, 'Company Profile Sent', uid);
              Get.to(HomePage());
            },
            child: Text('Send Comapany Profile')),
      ]);
}

void ShowDialog(selectedSector, phoneNumber, String uid) {
  Get.dialog(
    AlertDialog(
      title: Text("Response"),
      //titleStyle: TextStyle(color: Colors.white),
      backgroundColor: Colors.grey.shade600,
      // radius: 30,
      content: Container(
        height: 150,
        child: TextField(
          controller: responseController,
          decoration: InputDecoration(
            labelText: 'Summary of the call',
            labelStyle: TextStyle(color: Colors.white, fontSize: 15),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.white),
            ),
          ),
          style: TextStyle(fontSize: 25, color: Colors.white),
          maxLines: 4,
          minLines: 4,
        ),
      ),
      actions: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 0.5),
            borderRadius: BorderRadius.circular(5),
          ),
          width: 200,
          height: 50,
          child: ElevatedButton.icon(
            label: Text('Submit'),
            icon: Icon(
              Icons.send,
              size: 24.0,
            ),
            onPressed: () {
              addResponse(
                  phoneNumber, selectedSector, responseController.text, uid);
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green.shade400,
            ),
          ),
        ),
      ],
    ),
  );
}
