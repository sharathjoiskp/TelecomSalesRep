import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dialpad/flutter_dialpad.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:tsr_management/DatabaseManager/database_manager.dart';
import 'package:tsr_management/DatabaseManager/models/user_model.dart';
import 'package:tsr_management/Pages/call_later.dart';
import 'package:tsr_management/Pages/record_page.dart';
import 'package:tsr_management/Pages/response_page.dart';
import 'package:tsr_management/componet_design/appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class DailerPage extends StatefulWidget {
  const DailerPage({super.key});

  @override
  State<DailerPage> createState() => _DailerPageState();
}

class _DailerPageState extends State<DailerPage> {
  String phoneNumber = '';
  String selectedSector = '';
  TextEditingController responseController = TextEditingController();

  void callNotConnected(phoneNumber) async {
    await FirebaseFirestore.instance
        .collection('userResponse')
        .doc(phoneNumber)
        .get()
        .then((docSnapshot) {
      if (docSnapshot.exists) {
        FirebaseFirestore.instance
            .collection('userResponse')
            .doc(phoneNumber)
            .collection('response')
            .doc()
            .set({
          'date': DateFormat.yMd().format(DateTime.now()),
          'time': DateFormat.jm().format(DateTime.now()),
          'response': responseController.text
        });
      } else {
        FirebaseFirestore.instance
            .collection('userResponse')
            .doc(phoneNumber)
            .set({
          'contactNumber': phoneNumber,
          'sector': 'Call Later',
          'emailId': '',
          'customerName': 'Unknow',
          'organisation': '',
          'website': '',
          'whatsappNo': '',
          'date': DateFormat.yMd().format(DateTime.now()),
          'time': DateFormat.jm().format(DateTime.now()),
        });
        FirebaseFirestore.instance
            .collection('userResponse')
            .doc(phoneNumber)
            .collection('response')
            .doc()
            .set({
          'date': DateFormat.yMd().format(DateTime.now()),
          'time': DateFormat.jm().format(DateTime.now()),
          'response': responseController.text
        });
      }
    });
    Fluttertoast.showToast(msg: "Number added to remainder");
  }

  void addResponse(phoneNumber, selectedSector) async {
    if (selectedSector == 'Not Intersted') {
      await FirebaseFirestore.instance
          .collection('notIntersted')
          .doc(phoneNumber)
          .set({
        'contactNumber': phoneNumber,
        'date': DateFormat.yMd().format(DateTime.now()),
        'time': DateFormat.jm().format(DateTime.now()),
      });
      Fluttertoast.showToast(msg: "Number added to Not Intersted");
    } else {
      await FirebaseFirestore.instance
          .collection('userResponse')
          .doc(phoneNumber)
          .get()
          .then((docSnapshot) {
        if (docSnapshot.exists) {
          FirebaseFirestore.instance
              .collection('userResponse')
              .doc(phoneNumber)
              .collection('response')
              .doc()
              .set({
            'date': DateFormat.yMd().format(DateTime.now()),
            'time': DateFormat.jm().format(DateTime.now()),
            'response': responseController.text
          });
        } else {
          FirebaseFirestore.instance
              .collection('userResponse')
              .doc(phoneNumber)
              .set({
            'contactNumber': phoneNumber,
            'sector': selectedSector,
            'emailId': '',
            'customerName': 'Unknow',
            'organisation': '',
            'website': '',
            'whatsappNo': '',
          });
          FirebaseFirestore.instance
              .collection('userResponse')
              .doc(phoneNumber)
              .collection('response')
              .doc()
              .set({
            'date': DateFormat.yMd().format(DateTime.now()),
            'time': DateFormat.jm().format(DateTime.now()),
            'response': responseController.text
          });
        }
      });
      Fluttertoast.showToast(msg: "Response is added");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundColour(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appbarDesign(title: "Dailer"),
        body: DialPad(
          enableDtmf: true,
          backspaceButtonIconColor: Colors.redAccent,
          buttonTextColor: Colors.black,
          dialOutputTextColor: Colors.white,
          makeCall: (dailedNumber) {
            phoneNumber = '$dailedNumber';

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
                callNotConnected(phoneNumber);
                Get.back();
              },
              textConfirm: "Yes",
              onConfirm: () {
                callConnected(phoneNumber);
              },
            );
            FlutterPhoneDirectCaller.callNumber('$dailedNumber');
          },
        ),
      ),
    );
  }

  callConnected(String phoneNumber) {
    Get.defaultDialog(
        title: "Select the response",
        titleStyle: TextStyle(color: Colors.white),
        backgroundColor: Colors.grey.shade600,
        content: Text(''),
        actions: [
          ElevatedButton(
              onPressed: () {
                selectedSector = 'Not Intersted';
                ShowDialog(context, selectedSector);
              },
              child: Text('Not Intersted')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CallLater(
                            documentId: phoneNumber,
                          )),
                );
              },
              child: Text('Call Later')),
          ElevatedButton(
              onPressed: () {
                selectedSector = 'App';
                ShowDialog(context, selectedSector);
              },
              child: Text('App')),
          ElevatedButton(
              onPressed: () {
                selectedSector = 'Web';
                ShowDialog(context, selectedSector);
              },
              child: Text('Web')),
          ElevatedButton(
              onPressed: () {
                selectedSector = 'Digital Marketing';
                ShowDialog(context, selectedSector);
              },
              child: Text('Digital Marketing'))
        ]);
  }

  void ShowDialog(BuildContext context, String selectedSector) {
    Get.defaultDialog(
      title: "Response",
      titleStyle: TextStyle(color: Colors.white),
      backgroundColor: Colors.grey.shade600,
      radius: 30,
      content: Center(
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
              addResponse(phoneNumber, selectedSector);
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green.shade400,
            ),
          ),
        ),
      ],
    );
  }
}
