import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tsr_management/functions/call_maker.dart';
import 'package:tsr_management/Pages/full_conversation_page.dart';
import 'package:tsr_management/componet_design/appbar.dart';

class NotIntersted extends StatefulWidget {
  const NotIntersted({super.key});

  @override
  State<NotIntersted> createState() => _NotInterstedState();
}

class _NotInterstedState extends State<NotIntersted> {
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
        .where('sector', isEqualTo: 'Not Intersted')
        .snapshots();
    return Scaffold(
      appBar: appbarDesign(title: 'Not Intersted'),
      body: Column(
        children: [
          ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white, width: 5),
              borderRadius: BorderRadius.circular(5),
            ),
            leading: Icon(
              Icons.heart_broken,
              color: Colors.redAccent,
              size: 30,
            ),
            title: Text(
              'No need to continue',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),
          Container(
            decoration: backgroundColour(),
            height: MediaQuery.of(context).size.height/1.4,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<QuerySnapshot>(
              stream: Stream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
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
                                              UID: uid)),
                                );
                              }),
                              backgroundColor: Colors.blueGrey,
                              icon: Icons.arrow_forward,
                            ),
                          ],
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black, width: .5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          leading: Icon(
                            Icons.not_interested,
                            color: Colors.redAccent,
                          ),
                          title: Text(
                            data['customerName'],
                            style: TextStyle(
                                color: Colors.blue.shade900,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            data['contactNumber'],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Column(
                            children: [
                              Text(
                                data['time'],
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              Text(
                                data['date'],
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
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
    );
  }
}
