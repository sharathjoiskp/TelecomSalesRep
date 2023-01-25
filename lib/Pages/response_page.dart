// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:intl/intl.dart';
// import 'package:tsr_management/componet_design/appbar.dart';

// class ResponsePage extends StatefulWidget {
//   ResponsePage({Key? key, required this.contactNumber}) : super(key: key);
//   final String contactNumber;

//   @override
//   State<ResponsePage> createState() => _ResponsePageState();
// }

// class _ResponsePageState extends State<ResponsePage> {
//   TextEditingController responseController = TextEditingController();
//   void addResponse() async {
//     await FirebaseFirestore.instance
//         .collection('userResponse')
//         .doc('${widget.contactNumber}')
//         .get()
//         .then((docSnapshot) {
//       if (docSnapshot.exists) {
//         FirebaseFirestore.instance
//             .collection('userResponse')
//             .doc('${widget.contactNumber}')
//             .collection('response')
//             .doc()
//             .set({
//           'date': DateFormat.yMd().format(DateTime.now()),
//           'time': DateFormat.jm().format(DateTime.now()),
//           'response': responseController.text
//         });
//       } else {
//         FirebaseFirestore.instance
//             .collection('userResponse')
//             .doc('${widget.contactNumber}')
//             .set({
//           'contactNumber': '${widget.contactNumber}',
//           'sector': selectedValue
//         });
//         FirebaseFirestore.instance
//             .collection('userResponse')
//             .doc('${widget.contactNumber}')
//             .collection('response')
//             .doc()
//             .set({
//           'date': DateFormat.yMd().format(DateTime.now()),
//           'time': DateFormat.jm().format(DateTime.now()),
//           'response': responseController.text
//         });
//       }
//     });
//     Fluttertoast.showToast(msg: "Response is added");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appbarDesign(title: 'Response'),
//       body: Container(
//         decoration: backgroundColour(),
//         child: Text('${widget.contactNumber}'),
//       ),
//     );
//   }

//   String selectedValue = 'App';
//   List responsList = [
//     'Not Intersted',
//     'Call Later',
//     'App',
//     'Web',
//     'Digital Marketing'
//   ];
//   // callConnected() {
//   //   Get.defaultDialog(
//   //     title: "Select the response",
//   //     titleStyle: TextStyle(color: Colors.white),
//   //     backgroundColor: Colors.grey.shade600,
//   //     radius: 30,
//   //     content: Center(
//   //       child: Column(
//   //         children: [
//   //           Container(
//   //             width: 300,
//   //             decoration: BoxDecoration(
//   //               color: Colors.grey.shade300,
//   //               border: Border.all(color: Colors.white, width: 0.5),
//   //               borderRadius: BorderRadius.circular(5),
//   //             ),
//   //             child: Padding(
//   //               padding: const EdgeInsets.all(8.0),
//   //               child: DropdownButton(
//   //                 value: selectedValue,
//   //                 items: responsList
//   //                     .map((e) => DropdownMenuItem(
//   //                           child: Text(e),
//   //                           value: e,
//   //                         ))
//   //                     .toList(),
//   //                 onChanged: ((value) {
//   //                   setState(() {
//   //                     selectedValue = (value as String?)!;
//   //                   });
//   //                 }),
//   //               ),
//   //             ),
//   //           ),
//   //           SizedBox(
//   //             height: 8,
//   //           ),
//   //           TextField(
//   //             decoration: InputDecoration(
//   //               labelText: 'Summary of the call ',
//   //               labelStyle: TextStyle(color: Colors.white, fontSize: 15),
//   //               enabledBorder: OutlineInputBorder(
//   //                 borderSide: BorderSide(width: 1, color: Colors.white),
//   //               ),
//   //             ),
//   //             style: TextStyle(fontSize: 25, color: Colors.white),
//   //             maxLines: 4,
//   //             minLines: 4,
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //     confirm: Container(
//   //       decoration: BoxDecoration(
//   //         color: Colors.green.shade300,
//   //         border: Border.all(color: Colors.white, width: 0.5),
//   //         borderRadius: BorderRadius.circular(5),
//   //       ),
//   //       width: 200,
//   //       height: 50,
//   //       child: Row(
//   //         mainAxisAlignment: MainAxisAlignment.center,
//   //         children: [Icon(Icons.send), Text('Submit')],
//   //       ),
//   //     ),
//   //     onConfirm: () {
//   //       addResponse();
//   //     },
//   //   );
//   // }
// }
