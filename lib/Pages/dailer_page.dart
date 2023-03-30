import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_dialpad/flutter_dialpad.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:get/get.dart';
import 'package:tsr_management/DatabaseManager/database.dart';

import 'package:tsr_management/functions/call_connected.dart';

import 'package:tsr_management/componet_design/appbar.dart';

class DailerPage extends StatefulWidget {
  const DailerPage({super.key});

  @override
  State<DailerPage> createState() => _DailerPageState();
}

class _DailerPageState extends State<DailerPage> {
  String phoneNumber = '';

  String responseController = '';

  String uid = '';
  @override
  void initState() {
    getuid();
    super.initState();
  }

  getuid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User user = await auth.currentUser!;
    setState(() {
      uid = user.uid;
    });
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundColour(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appbarDesign(
          title: "Dailer",
        ),
        body: SingleChildScrollView(
          child: DialPad(
            buttonColor: Colors.indigo.shade100,
            enableDtmf: true,
            backspaceButtonIconColor: Colors.redAccent,
            buttonTextColor: Colors.black,
            dialOutputTextColor: Colors.blueGrey.shade900,
            makeCall: (dailedNumber) {
              phoneNumber = '$dailedNumber';

              Get.defaultDialog(
                title: "Talked to $dailedNumber",
                titleStyle: TextStyle(
                  color: Colors.white,
                ),
                backgroundColor: Colors.grey.shade800,
                radius: 15,
                content: Icon(
                  Icons.call,
                  color: Colors.white,
                ),
                textCancel: "No",
                onCancel: () {
                  addResponse(
                      phoneNumber, 'Call Later', responseController, uid);

                  Get.back();
                },
                textConfirm: "Yes",
                onConfirm: () {
                  callConnected(phoneNumber, uid);
                },
              );
              FlutterPhoneDirectCaller.callNumber('$dailedNumber');
            },
          ),
        ),
      ),
    );
  }
}
