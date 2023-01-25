import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tsr_management/componet_design/appbar.dart';

class NotIntersted extends StatefulWidget {
  const NotIntersted({super.key});

  @override
  State<NotIntersted> createState() => _NotInterstedState();
}

class _NotInterstedState extends State<NotIntersted> {
  @override
  Widget build(BuildContext context) {
    var Stream = FirebaseFirestore.instance
        .collection('userResponse')
        .where('sector', isEqualTo: 'Not Intersted')
        .snapshots();
    return Container(
      decoration: backgroundColour(),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot>(
        stream: Stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white, width: 5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  leading: Icon(
                    Icons.not_interested,
                    color: Colors.redAccent,
                  ),
                  title: Text(
                    data['customerName'],
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    data['contactNumber'],
                    style: TextStyle(
                        color: Colors.greenAccent, fontWeight: FontWeight.bold),
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
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
