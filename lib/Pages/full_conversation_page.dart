import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:tsr_management/DatabaseManager/converstion.dart';
import 'package:tsr_management/Pages/customer_profile_page.dart';
import 'package:tsr_management/Pages/dammyPage.dart';
import 'package:tsr_management/componet_design/appbar.dart';

import '../DatabaseManager/database_manager.dart';
import '../sumneprofile_design.dart';

class FullConversationPage extends StatefulWidget {
  FullConversationPage({Key? key, required this.documentId}) : super(key: key);
  var documentId;
  @override
  State<FullConversationPage> createState() => _FullConversationPageState();
}

class _FullConversationPageState extends State<FullConversationPage> {
  TextEditingController conversationController = TextEditingController();
  String conversationId = '';
  void deleteConversation(String conversationId) async {
    await FirebaseFirestore.instance
        .collection('userResponse')
        .doc('${widget.documentId}')
        .collection('response')
        .doc(conversationId)
        .delete();

    Navigator.pop(context, true);
    Fluttertoast.showToast(msg: "Conversation Deleted");
  }

  void editConversation(String conversationId) async {
    await FirebaseFirestore.instance
        .collection('userResponse')
        .doc('${widget.documentId}')
        .collection('response')
        .doc(conversationId)
        .update({
      'date': DateFormat.yMd().format(DateTime.now()),
      'time': DateFormat.jm().format(DateTime.now()),
      "response": conversationController.text
    });
    Navigator.pop(context, true);
    Fluttertoast.showToast(msg: "Conversation Updated");
  }

  void addConversation() async {
    await FirebaseFirestore.instance
        .collection('userResponse')
        .doc('${widget.documentId}')
        .collection('response')
        .doc()
        .set({
      'date': DateFormat.yMd().format(DateTime.now()),
      'time': DateFormat.jm().format(DateTime.now()),
      "response": conversationController.text
    });
    Navigator.pop(context, true);
    Fluttertoast.showToast(msg: "Conversation Added");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundColour(),
      child: Scaffold(
        appBar: appbarDesign(title: 'Converstion'),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 310,
                  child: CustomerProfilePage(
                    documentId: '${widget.documentId}',
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Conversation',
                  style: TextStyle(
                      color: Colors.white24,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    height: 500,
                    child: Conversation(
                      documentId: '${widget.documentId}',
                    )),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.defaultDialog(
              title: "Add Conversation",
              titleStyle: TextStyle(color: Colors.white),
              backgroundColor: Colors.grey.shade600,
              radius: 30,
              content: Center(
                child: Column(
                  children: [
                    TextField(
                      controller: conversationController,
                      decoration: InputDecoration(
                        labelText: 'Edit Conversation',
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 15),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.white),
                        ),
                      ),
                      style: TextStyle(fontSize: 25, color: Colors.white),
                      maxLines: 4,
                      minLines: 4,
                    ),
                  ],
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
                      addConversation();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green.shade400,
                    ),
                  ),
                ),
              ],
            );
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
