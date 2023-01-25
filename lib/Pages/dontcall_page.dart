import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tsr_management/DatabaseManager/not_intersted.dart';
import 'package:tsr_management/Pages/full_conversation_page.dart';
import 'package:tsr_management/componet_design/appbar.dart';

class DontCallPage extends StatefulWidget {
  const DontCallPage({super.key});

  @override
  State<DontCallPage> createState() => _DontCallPageState();
}

class _DontCallPageState extends State<DontCallPage> {
  @override
  Widget build(BuildContext context) {
    var Stream =
        FirebaseFirestore.instance.collection('notIntersted').snapshots();
    return Scaffold(
      appBar: appbarDesign(title: 'Not Intersted'),
      body: Container(
        decoration: backgroundColour(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Text(
                'Not Intersted',
                style: TextStyle(color: Colors.cyanAccent, fontSize: 23,fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2.6,
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
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white, width: 5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            leading: Icon(
                              Icons.not_interested,
                              color: Colors.redAccent,
                            ),
                            title: Text(
                              data['contactNumber'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            trailing: Column(
                              children: [
                                Text(
                                  data['time'],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                Text(
                                  data['date'],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
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
            Container(
                height: MediaQuery.of(context).size.height / 2.7,
                width: MediaQuery.of(context).size.width,
                child: NotIntersted()),
          ],
        ),
      ),
    );
  }
}
