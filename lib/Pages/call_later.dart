import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tsr_management/DatabaseManager/database.dart';
import 'package:tsr_management/Pages/home_page.dart';
import 'package:tsr_management/Pages/record_page.dart';
import 'package:tsr_management/componet_design/appbar.dart';

class CallLater extends StatefulWidget {
  CallLater({Key? key, required this.UID, required this.documentId})
      : super(key: key);
  var documentId;
  var UID;

  @override
  State<CallLater> createState() => _CallLaterState();
}

class _CallLaterState extends State<CallLater> {
  var _timeOfDay = TimeOfDay.now();
  var _date1 = DateTime.now();

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((value) {
      setState(() {
        _date1 = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade300,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            color: Colors.grey.shade500,
            height: 250,
            width: 370,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: Text(
                    'Date :',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  title: Text(
                    DateFormat.yMd().format(_date1) +
                        '   (Click here to change)',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.calendar_today),
                  onTap: _showDatePicker,
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Text(
                    'Time :',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                  title: Text(
                    _timeOfDay.format(context).toString() +
                        '   (Click here to change)',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.lock_clock_outlined),
                  onTap: _showTimePicker,
                ),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton.icon(
                  label: Text('Submit'),
                  icon: Icon(
                    Icons.send,
                    size: 24.0,
                  ),
                  onPressed: () {
                    addCallLater(
                      widget.UID,
                      widget.documentId,
                      _timeOfDay.format(context).toString(),
                      DateFormat.yMd().format(_date1),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green.shade400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
