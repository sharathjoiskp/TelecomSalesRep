// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/cupertino.dart';

// // class DatabaseManager {
// //   final CollectionReference userResponseList =
// //       FirebaseFirestore.instance.collection('userResponse');

// //   Future<void> createResponse(
// //       String contactNumber, String response, String Sector) async {
// //     return await userResponseList.doc().set({
// //       'contactNumber': contactNumber,
// //       'response': response,
// //       'sector': Sector
// //     });
// //   }

// //   Future getuserResponseList() async {
// //     List userResponseList = [];

// //     try {
// //       // await userResponseList.get().then((querySnapshot) {
// //       //   querySnapshot.documents.forEach((element) {
// //       //     userResponseList.add(element.data);
// //       //   });
// //       // });
// //     } catch (e) {
// //       return Center(
// //        child: Text('Something went Wrong'),
// //       );
// //     }
// //   }
// // }

// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:tsr_management/DatabaseManager/models/user_model.dart';

// // Future createResponse(userResponseModel userResponse) async {
// //   final docResponse =
// //       FirebaseFirestore.instance.collection('userResponse').doc();
// //   userResponse.id = docResponse.id;
// //   final json = userResponse.toJson();
// //   await docResponse.set(json);
// // }

// // Stream<List<userResponseModel>> readResponse() => FirebaseFirestore.instance
// //     .collection('userResponse')
// //     .snapshots()
// //     .map((snapshot) => snapshot.docs
// //         .map((doc) => userResponseModel.fromJson(doc.data()))
// //         .toList());

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:intl/intl.dart';

// class sample {
//   static void _showDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: new Text("Alert!!"),
//           content: new Text("You are awesome!"),
//           actions: <Widget>[
//             ElevatedButton(
//               child: new Text("OK"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class Sample {
//   String phoneNumber = '7619129191';
//   TextEditingController responseController = TextEditingController();

//   static void func() => print('Hello Geeks for Geeks');
//   static void callConnected(String phoneNumber) {
//     Get.defaultDialog(
//       title: "Select the response",
//       titleStyle: TextStyle(color: Colors.white),
//       backgroundColor: Colors.grey.shade600,
//       radius: 30,
//       content: Center(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 8,
//             ),
//             TextField(
//               // controller: responseController,
//               decoration: InputDecoration(
//                 labelText: 'Summary of the call ',
//                 labelStyle: TextStyle(color: Colors.white, fontSize: 15),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(width: 1, color: Colors.white),
//                 ),
//               ),
//               style: TextStyle(fontSize: 25, color: Colors.white),
//               maxLines: 4,
//               minLines: 4,
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.white, width: 0.5),
//             borderRadius: BorderRadius.circular(5),
//           ),
//           width: 200,
//           height: 50,
//           child: ElevatedButton.icon(
//             label: Text('Submit'),
//             icon: Icon(
//               Icons.send,
//               size: 24.0,
//             ),
//             onPressed: () {
//               // print('///////////////////////////////////////////////////');
//               addResponse() async {
//                 await FirebaseFirestore.instance
//                     .collection('userResponse')
//                     .doc(phoneNumber)
//                     .get()
//                     .then((docSnapshot) {
//                   if (docSnapshot.exists) {
//                     FirebaseFirestore.instance
//                         .collection('userResponse')
//                         .doc(phoneNumber)
//                         .collection('response')
//                         .doc()
//                         .set({
//                       'date': DateFormat.yMd().format(DateTime.now()),
//                       'time': DateFormat.jm().format(DateTime.now()),
//                       'response': '',
//                     });
//                   } else {
//                     FirebaseFirestore.instance
//                         .collection('userResponse')
//                         .doc(phoneNumber)
//                         .set({'contactNumber': phoneNumber, 'sector': ''});
//                     FirebaseFirestore.instance
//                         .collection('userResponse')
//                         .doc(phoneNumber)
//                         .collection('response')
//                         .doc()
//                         .set({
//                       'date': DateFormat.yMd().format(DateTime.now()),
//                       'time': DateFormat.jm().format(DateTime.now()),
//                       'response': ''
//                     });
//                   }
//                 });

//                 Fluttertoast.showToast(msg: "Response is added");
//               }

//               // final userResponse = userResponseModel(
//               //     contactNumber: phoneNumber,
//               //     response: responseController.text,
//               //     sector: selectedValue);
//               // createResponse(userResponse);
//               // Fluttertoast.showToast(msg: "Response is added");
//               // Navigator.of(context).popUntil((route) => route.isFirst);
//             },
//             style: ElevatedButton.styleFrom(
//               primary: Colors.green.shade400,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// import '../componet_design/appbar.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80,
//       decoration: backgroundColour(),
//       child: Scaffold(
//         appBar: appbarDesign(title: 'PROFILE'),
//       ),
//     );
//   }
// }


