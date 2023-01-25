import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';
import 'package:tsr_management/Pages/call_later.dart';
import 'package:tsr_management/Pages/dammyPage.dart';
import 'package:tsr_management/Pages/full_conversation_page.dart';
import 'package:tsr_management/componet_design/appbar.dart';

class RememberPage extends StatefulWidget {
  const RememberPage({super.key});

  @override
  State<RememberPage> createState() => _RememberPageState();
}

class _RememberPageState extends State<RememberPage> {
  String selectedSector = "";
  String dailedNumber = '';
  TextEditingController responseController = TextEditingController();

  void addResponse(String dailedNumber, String selectedSector) async {
    await FirebaseFirestore.instance
        .collection('userResponse')
        .doc(dailedNumber)
        .update({
      'sector': selectedSector,
      
    });
    FirebaseFirestore.instance
        .collection('userResponse')
        .doc('$dailedNumber')
        .collection('response')
        .doc()
        .set({
      'date': DateFormat.yMd().format(DateTime.now()),
      'time': DateFormat.jm().format(DateTime.now()),
      'response': responseController.text
    });

    Fluttertoast.showToast(msg: "Response is added");
  }

  @override
  Widget build(BuildContext context) {
    var Stream = FirebaseFirestore.instance
        .collection('userResponse')
        .where('sector', isEqualTo: "Call Later")
        .snapshots();
    return Scaffold(
      appBar: appbarDesign(title: 'Remainder'),
      body: Container(
        decoration: backgroundColour(),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<QuerySnapshot>(
          stream: Stream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    leading: Icon(
                      Icons.call_missed,
                      color: Colors.redAccent,
                      size: 30,
                    ),
                    title: Text(
                      'Call Later',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.42,
                    child: ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return Slidable(
                          startActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: ((context) {
                                  callmaker(data['contactNumber']);
                                }),
                                backgroundColor: Colors.blueAccent,
                                icon: Icons.call,
                              ),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: ((context) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FullConversationPage(
                                                documentId:
                                                    data['contactNumber'])),
                                  );
                                }),
                                backgroundColor: Colors.greenAccent,
                                icon: Icons.arrow_forward,
                              ),
                            ],
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white, width: 5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            title: Text(
                              data['customerName'],
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            subtitle: Text(
                              data['contactNumber'],
                              style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                            trailing: Column(
                              children: [
                                Text(
                                  data['date'],
                                  style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                Text(
                                  data['time'],
                                  style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  callmaker(String dailedNumber) {
    FlutterPhoneDirectCaller.callNumber('$dailedNumber');
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
        Fluttertoast.showToast(msg: "Response is added");
        Get.back();
      },
      textConfirm: "Yes",
      onConfirm: () {
        dailedNumber = '$dailedNumber';
        callConnected(dailedNumber);
      },
    );
  }

  callConnected(String phoneNumber) {
    dailedNumber = '$phoneNumber';
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
              addResponse(dailedNumber, selectedSector);
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
