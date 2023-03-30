import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tsr_management/functions/call_connected.dart';
import 'package:tsr_management/Pages/call_later.dart';

callmaker(String dailedNumber, String UID) {
  FlutterPhoneDirectCaller.callNumber('$dailedNumber');

  String phoneNumber = '$dailedNumber';
  Get.defaultDialog(
    title: "Talked to $dailedNumber",
    titleStyle: TextStyle(
      color: Colors.white,
    ),
    backgroundColor: Colors.grey.shade800,
    radius: 30,
    content: Icon(
      Icons.call,
      color: Colors.white,
    ),
    textCancel: "No",
    onCancel: () {
      Get.to(CallLater(UID: UID, documentId: phoneNumber));

      Get.back();
    },
    textConfirm: "Yes",
    onConfirm: () {
      callConnected(phoneNumber, UID);
    },
  );
}
