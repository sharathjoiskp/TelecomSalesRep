import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:tsr_management/functions/call_connected.dart';

import 'package:tsr_management/functions/call_maker.dart';

import 'package:tsr_management/Pages/full_conversation_page.dart';
import 'package:tsr_management/componet_design/appbar.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
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

  String selectedSector = 'Digital Marketing';
  TextEditingController dailedNumberController = TextEditingController();
  TextEditingController responseController = TextEditingController();
  var _tabTextIndexSelected = 0;

  var _listTextTabToggle = [
    'Digital Marketing',
    'Web',
    'App',
    'Web And DM',
    'App And DM',
    'Web and App',
    'Profile Sent',
  ];

  @override
  Widget build(BuildContext context) {
    var Stream = FirebaseFirestore.instance
        .collection('USER_RESPONSE')
        .doc(uid)
        .collection('userResponse')
        .where('sector', isEqualTo: selectedSector)
        .orderBy('date', descending: true)
        .snapshots();
    return Scaffold(
      appBar: appbarDesign(title: 'Record'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: FlutterToggleTab(
              width: 250,
              borderRadius: 30,
              height: 52,
              selectedIndex: _tabTextIndexSelected,
              selectedBackgroundColors: [Colors.blue, Colors.blueAccent],
              selectedTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
              unSelectedTextStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
              labels: _listTextTabToggle,
              selectedLabelIndex: (index) {
                setState(() {
                  _tabTextIndexSelected = index;
                  switch (index) {
                    case 0:
                      selectedSector = 'Digital Marketing';
                      break;
                    case 1:
                      selectedSector = 'Web';
                      break;
                    case 2:
                      selectedSector = 'App';
                      break;

                    case 3:
                      selectedSector = 'Web and Digital Marketing';
                      break;
                    case 4:
                      selectedSector = 'App and Digital Marketing';
                      break;
                    case 5:
                      selectedSector = 'Web and App';
                      break;
                    case 6:
                      selectedSector = 'Profile Sent';
                      break;
                  }
                });
              },
              isScroll: true,
            ),
          ),
          Container(
            decoration: backgroundColour(),
            height: MediaQuery.of(context).size.height * 0.72,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<QuerySnapshot>(
              stream: Stream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Something went wrong'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
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
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  data['date'],
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  data['time'],
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black, width: .5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            leading: Text(
                              data['customerName'],
                              style: TextStyle(
                                  color: Colors.blue.shade900, fontSize: 20),
                            ),
                            title: Text(
                              data['contactNumber'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            // subtitle: Text(
                            //   data['sector'],
                            //   style: TextStyle(
                            //       color: Colors.green.shade900,
                            //       fontWeight: FontWeight.bold),
                            // ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(
            AlertDialog(
              title: Text(
                "Enter the Dailed Number",
              ),
              //  titleStyle: TextStyle(color: Colors.white),
              backgroundColor: Colors.grey.shade600,
              //  radius: 30,
              content: SizedBox(
                width: 250,
                child: TextFormField(
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 4),
                  textAlign: TextAlign.center,
                  maxLength: 11,
                  keyboardType: TextInputType.phone,
                  controller: dailedNumberController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 5)),
                      hintText: 'Dailed Number',
                      hintStyle: TextStyle(fontSize: 15)),
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
                      callConnected(
                        dailedNumberController.text,
                        uid,
                      );
                     
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green.shade400,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
    );
  }
}
