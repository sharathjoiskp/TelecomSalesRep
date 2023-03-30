import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:tsr_management/functions/call_maker.dart';

import 'package:tsr_management/Pages/full_conversation_page.dart';
import 'package:tsr_management/componet_design/appbar.dart';

class RememberPage extends StatefulWidget {
  const RememberPage({super.key});

  @override
  State<RememberPage> createState() => _RememberPageState();
}

class _RememberPageState extends State<RememberPage> {
  String dailedNumber = '';
  String uid = '';
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

  @override
  Widget build(BuildContext context) {
    var Stream = FirebaseFirestore.instance
        .collection('USER_RESPONSE')
        .doc(uid)
        .collection('userResponse')
        .where('sector', isEqualTo: "Call Later")
        .orderBy('date', descending: true)
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
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("Loading"));
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
                          color: Colors.black,
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
                                  callmaker(data['contactNumber'], uid);
                                }),
                                backgroundColor: Colors.blueGrey,
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
                                              documentId: data['contactNumber'],
                                              UID: uid,
                                            )),
                                  );
                                }),
                                backgroundColor: Colors.blueGrey,
                                icon: Icons.arrow_forward,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black, width: 0.5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              title: Text(
                                data['customerName'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              subtitle: Text(
                                data['contactNumber'],
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data['date'],
                                    style: TextStyle(
                                        color: Colors.blueGrey.shade900,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  Text(
                                    data['time'],
                                    style: TextStyle(
                                        color: Colors.blueGrey.shade700,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
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
}
