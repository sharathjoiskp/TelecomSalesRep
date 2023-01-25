// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:http/http.dart' as http;
// import 'package:tsr_management/DatabaseManager/models/user_model.dart';
// import 'package:tsr_management/DatabaseManager/models/user_respository.dart';
// import 'dart:convert';

// import 'package:tsr_management/componet_design/appbar.dart';

// // final userRes = Get.put(userResponseRepository());

// class DammyPage extends StatefulWidget {
//   const DammyPage({super.key});

//   @override
//   State<DammyPage> createState() => _DammyPageState();
// }

// String stringResponse = "";
// Map mapResponse = {};
// Map dataResponse = {};
// List listResponse = [];

// class _DammyPageState extends State<DammyPage> {
//   Future apicall() async {
//     http.Response response;
//     response = await http.get(Uri.parse(
//         'https://millenniumfurnitures.in/Rest_api/index.php/api/student/'));
//     if (response.statusCode == 200) {
//       setState(() {
//         // stringResponse = response.body;
//         mapResponse = json.decode(response.body);
//         // mapResponse = mapResponse['support'];
//         listResponse = mapResponse['data'];
//       });
//     }
//   }

//   void initState() {
//     apicall();
//     super.initState();
//   }

//   Future<void> createUserResponse(userResponseModel user_response) async {
//    await userRes.createUserResponse(user_response);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appbarDesign(title: 'Dammy'),
//       body: ListView.builder(
//         itemBuilder: (context, index) {
//           return SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                     child: ListTile(
//                   title: Text(listResponse[index]['name'].toString()),
//                   subtitle: Text(listResponse[index]['id'].toString()),
//                 )),
//                 ElevatedButton(
//                   onPressed: () {
//                     final userResponse = userResponseModel(
//                       contactNumber: 'abc',
//                       response: 'def',
//                       sector: 'ijk',
//                     );
//                   },
//                   child: Text('ADD'),
//                 ),
//               ],
//             ),
//           );
//         },
//         itemCount: listResponse == null ? 0 : listResponse.length,
//       ),

//       //reading all data'''''''''''''''.........................

//       //  ListView.builder(
//       //   itemBuilder: (context, index) {
//       //     return Container(
//       //       child: Column(
//       //         children: [
//       //           Image.network(listResponse[index]['avatar']),

//       //           Text(listResponse[index]['first_name'].toString()),
//       //         ],
//       //       ),
//       //     );
//       //   },
//       //   itemCount: listResponse == null ? 0 : listResponse.length,
//       // ),

// //Reading single data ................'''''''''''''''''''''''''''

//       //  Container(
//       //   height: 200,
//       //   width: 300,
//       //   color: Color.fromARGB(255, 191, 221, 244),
//       //   child:
//       //       //  dataResponse == null
//       //       //     ? Container(
//       //       //       child: Text('im there'),
//       //       //     )
//       //       //     : Text(dataResponse['text'].toString()),

//       //       // mapResponse == null
//       //       //     ? Container()
//       //       //     : Text(mapResponse['data'].toString()),

//       //   listResponse == null
//       //     ? Text('data')
//       //     : Text(listResponse[1]['first_name'].toString()),
//       //  )
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tsr_management/DatabaseManager/database_manager.dart';

class Dammy extends StatefulWidget {
  const Dammy({super.key});

  @override
  State<Dammy> createState() => _DammyState();
}

class _DammyState extends State<Dammy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter AlertDialog - googleflutter.com'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('userResponse')
            .doc('9449282559')
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
                          // conversationId = streamSnapshot.data!.docs[index].id;
                          // deleteConversation(conversationId);
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
                          //conversationId = streamSnapshot.data!.docs[index].id;
                          Get.defaultDialog(
                            title: "Edit Conversation",
                            titleStyle: TextStyle(color: Colors.white),
                            backgroundColor: Colors.grey.shade600,
                            radius: 30,
                            content: Center(
                              child: Column(
                                children: [
                                  TextField(
                                    //   controller: conversationController,
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
                                    //  editConversation(conversationId);
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
