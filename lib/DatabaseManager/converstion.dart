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

class Conversation extends StatefulWidget {
  Conversation({Key? key, required this.documentId}) : super(key: key);
  var documentId;

  @override
  State<Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
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
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('userResponse')
            .doc('${widget.documentId}')
            .collection('response')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasError) {
            return Text('Something went wrong');
          }

          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index) => Column(
              children: [
                Slidable(
                  startActionPane: ActionPane(
                    motion: StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: ((context) {
                          conversationId = streamSnapshot.data!.docs[index].id;
                          deleteConversation(conversationId);
                        }),
                        backgroundColor: Colors.redAccent,
                        icon: Icons.delete,
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: ((context) {
                          conversationId = streamSnapshot.data!.docs[index].id;
                          Get.defaultDialog(
                            title: "Edit Conversation",
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
                                      labelStyle: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.white),
                                      ),
                                    ),
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                    maxLines: 4,
                                    minLines: 4,
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, width: 0.5),
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
                                    editConversation(conversationId);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green.shade400,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                        backgroundColor: Colors.greenAccent,
                        icon: Icons.edit,
                      ),
                    ],
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: .5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          streamSnapshot.data!.docs[index]['date'],
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Text(
                          streamSnapshot.data!.docs[index]['time'],
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                    title: Text(
                      streamSnapshot.data!.docs[index]['response'],
                      style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
