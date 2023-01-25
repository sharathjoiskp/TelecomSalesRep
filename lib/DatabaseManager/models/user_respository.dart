// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tsr_management/DatabaseManager/models/user_model.dart';

// class userResponseRepository extends GetxController {
//   static userResponseRepository get instance => Get.find();

//   final _db = FirebaseFirestore.instance;

//   createUserResponse(userResponseModel user_response) async {
//     print(
//         'b111111111111111111111111111111111111111111111111111111111!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
//     await _db
//         .collection("userResponse")
//         .add(user_response.toJson())
//         .whenComplete(
//           () => Get.snackbar("Success", "Responses Added",
//               snackPosition: SnackPosition.BOTTOM,
//               backgroundColor: Colors.green.withOpacity(0.1),
//               colorText: Colors.green),
//         )
//         .catchError((error, stackTrace) {
//       Get.snackbar("Error", "Something Went Wrong",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.redAccent.withOpacity(0.1),
//           colorText: Colors.red);
//       print(
//           'b111111111111111111111111111111111111111111111111111111111!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
//     });
//   }
// }
