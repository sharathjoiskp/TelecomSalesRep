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
import 'package:tsr_management/DatabaseManager/database.dart';

import 'package:tsr_management/Pages/customer_profile_page.dart';

import 'package:tsr_management/componet_design/appbar.dart';

class FullConversationPage extends StatefulWidget {
  FullConversationPage({Key? key, required this.documentId, required this.UID})
      : super(key: key);
  var documentId;
  String UID;
  @override
  State<FullConversationPage> createState() => _FullConversationPageState();
}

class _FullConversationPageState extends State<FullConversationPage> {
  TextEditingController conversationController = TextEditingController();
  var conversationId = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundColour(),
      child: Scaffold(
        appBar: appbarDesign(title: 'Converstion'),
        backgroundColor: Color.fromARGB(255, 239, 217, 190),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                height: 310,
                child: CustomerProfilePage(
                  documentId: widget.documentId,
                  uid: widget.UID,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Conversation',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('USER_RESPONSE')
                      .doc(widget.UID)
                      .collection('userResponse')
                      .doc(widget.documentId)
                      .collection('response')
                      .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (streamSnapshot.connectionState ==
                        ConnectionState.waiting) {
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
                                    conversationId =
                                        streamSnapshot.data!.docs[index].id;
                                    deleteConversation(widget.UID,
                                        widget.documentId, conversationId);
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
                                    conversationId =
                                        streamSnapshot.data!.docs[index].id;
                                    Get.defaultDialog(
                                      title: "Edit Conversation",
                                      titleStyle:
                                          TextStyle(color: Colors.white),
                                      backgroundColor: Colors.grey.shade600,
                                      radius: 30,
                                      content: Center(
                                        child: Column(
                                          children: [
                                            TextField(
                                              controller:
                                                  conversationController,
                                              decoration: InputDecoration(
                                                labelText: 'Edit Conversation',
                                                labelStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.white),
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
                                                color: Colors.black,
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                              editConversation(
                                                  widget.UID,
                                                  widget.documentId,
                                                  conversationId,
                                                  conversationController.text);
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
                                side:
                                    BorderSide(color: Colors.black, width: .5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    streamSnapshot.data!.docs[index]['date'],
                                    style: TextStyle(
                                        color: Colors.blueGrey, fontSize: 15),
                                  ),
                                  Text(
                                    streamSnapshot.data!.docs[index]['time'],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ],
                              ),
                              title: Text(
                                streamSnapshot.data!.docs[index]['response'],
                                style: TextStyle(
                                    color: Colors.blue.shade900,
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
              ),
            ],
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
                        labelText: 'Add Conversation',
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
                      addConversation(widget.UID, widget.documentId,
                          conversationController.text);
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
