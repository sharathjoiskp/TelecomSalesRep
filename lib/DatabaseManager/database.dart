import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

import 'package:tsr_management/Pages/home_page.dart';

void addResponse(phoneNumber, selectedSector, response, UID) async {
  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(UID)
      .get()
      .then((doc) {
    if (doc.exists) {
      FirebaseFirestore.instance
          .collection('USER_RESPONSE')
          .doc(UID)
          .collection('userResponse')
          .doc(phoneNumber)
          .get()
          .then((docSnapshot) {
        if (docSnapshot.exists) {
          FirebaseFirestore.instance
              .collection('USER_RESPONSE')
              .doc(UID)
              .collection('userResponse')
              .doc(phoneNumber)
              .update({
            'sector': selectedSector,
            'date': DateFormat.yMd().format(DateTime.now()),
            'time': DateFormat.jm().format(DateTime.now()),
          });

          FirebaseFirestore.instance
              .collection('USER_RESPONSE')
              .doc(UID)
              .collection('userResponse')
              .doc(phoneNumber)
              .collection('response')
              .doc()
              .set({
            'date': DateFormat.yMd().format(DateTime.now()),
            'time': DateFormat.jm().format(DateTime.now()),
            'response': response
          }).then((value) => Get.to(HomePage()));

          Fluttertoast.showToast(msg: "Response is added");
        } else {
          FirebaseFirestore.instance
              .collection('USER_RESPONSE')
              .doc(UID)
              .collection('userResponse')
              .doc(phoneNumber)
              .set({
            'contactNumber': phoneNumber,
            'sector': selectedSector,
            'emailId': '',
            'customerName': 'Unknown',
            'organisation': '',
            'website': '',
            'whatsappNo': '',
            'date': DateFormat.yMd().format(DateTime.now()),
            'time': DateFormat.jm().format(DateTime.now()),
          });
          FirebaseFirestore.instance
              .collection('USER_RESPONSE')
              .doc(UID)
              .collection('userResponse')
              .doc(phoneNumber)
              .collection('response')
              .doc()
              .set({
            'date': DateFormat.yMd().format(DateTime.now()),
            'time': DateFormat.jm().format(DateTime.now()),
            'response': response
          }).then((value) => Get.to(HomePage()));

          Fluttertoast.showToast(msg: "Response is added");
        }
      });
    } else {
      FirebaseFirestore.instance.collection('USER_RESPONSE').doc(UID).set({
        'employeeName': 'Your Name',
        'branch': 'Branch Location',
        'number': 'dailing number',
        'uid': UID
      });
      FirebaseFirestore.instance
          .collection('USER_RESPONSE')
          .doc(UID)
          .collection('userResponse')
          .doc(phoneNumber)
          .get()
          .then((docSnapshot) {
        if (docSnapshot.exists) {
          FirebaseFirestore.instance
              .collection('USER_RESPONSE')
              .doc(UID)
              .collection('userResponse')
              .doc(phoneNumber)
              .update({
            'sector': selectedSector,
            'date': DateFormat.yMd().format(DateTime.now()),
            'time': DateFormat.jm().format(DateTime.now()),
          });

          FirebaseFirestore.instance
              .collection('USER_RESPONSE')
              .doc(UID)
              .collection('userResponse')
              .doc(phoneNumber)
              .collection('response')
              .doc()
              .set({
            'date': DateFormat.yMd().format(DateTime.now()),
            'time': DateFormat.jm().format(DateTime.now()),
            'response': response
          }).then((value) => Get.to(HomePage()));

          Fluttertoast.showToast(msg: "Response is added");
        } else {
          FirebaseFirestore.instance
              .collection('USER_RESPONSE')
              .doc(UID)
              .collection('userResponse')
              .doc(phoneNumber)
              .set({
            'contactNumber': phoneNumber,
            'sector': selectedSector,
            'emailId': '',
            'customerName': 'Unknown',
            'organisation': '',
            'website': '',
            'whatsappNo': '',
            'date': DateFormat.yMd().format(DateTime.now()),
            'time': DateFormat.jm().format(DateTime.now()),
          });
          FirebaseFirestore.instance
              .collection('USER_RESPONSE')
              .doc(UID)
              .collection('userResponse')
              .doc(phoneNumber)
              .collection('response')
              .doc()
              .set({
            'date': DateFormat.yMd().format(DateTime.now()),
            'time': DateFormat.jm().format(DateTime.now()),
            'response': response
          }).then((value) => Get.to(HomePage()));

          Fluttertoast.showToast(msg: "Response is added");
        }
      });
    }
  });
}

//conversation ............................................................................
void addConversation(uid, documentId, String conversationController) async {
  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(uid)
      .collection('userResponse')
      .doc(documentId)
      .collection('response')
      .doc()
      .set({
    'date': DateFormat.yMd().format(DateTime.now()),
    'time': DateFormat.jm().format(DateTime.now()),
    "response": conversationController,
  });
  Get.back();
  Fluttertoast.showToast(msg: "Conversation Added");
}

void deleteConversation(uid, documentId, conversationId) async {
  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(uid)
      .collection('userResponse')
      .doc(documentId)
      .collection('response')
      .doc(conversationId)
      .delete();
  Get.back();
  Fluttertoast.showToast(msg: "Conversation Deleted");
}

void editConversation(
    uid, documentId, conversationId, conversationController) async {
  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(uid)
      .collection('userResponse')
      .doc(documentId)
      .collection('response')
      .doc(conversationId)
      .update({
    'date': DateFormat.yMd().format(DateTime.now()),
    'time': DateFormat.jm().format(DateTime.now()),
    "response": conversationController
  });
  Get.back();
  Fluttertoast.showToast(msg: "Conversation Updated");
}

//call later .....................................................................

void addCallLater(UID, phoneNumber, timeTocall, dateToCall) async {
  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(UID)
      .get()
      .then((doc) {
    if (doc.exists) {
      FirebaseFirestore.instance
          .collection('USER_RESPONSE')
          .doc(UID)
          .collection('userResponse')
          .doc(phoneNumber)
          .get()
          .then((docSnapshot) {
        if (docSnapshot.exists) {
          FirebaseFirestore.instance
              .collection('USER_RESPONSE')
              .doc(UID)
              .collection('userResponse')
              .doc(phoneNumber)
              .update({
            'sector': 'Call Later',
            'date': dateToCall,
            'time': timeTocall,
          });
          FirebaseFirestore.instance
              .collection('USER_RESPONSE')
              .doc(UID)
              .collection('userResponse')
              .doc(phoneNumber)
              .collection('response')
              .doc()
              .set({
            'date': DateFormat.yMd().format(DateTime.now()),
            'time': DateFormat.jm().format(DateTime.now()),
            'response':
                'Customer Suggest to Call Later at $dateToCall $timeTocall'
          });
          Fluttertoast.showToast(msg: "Number Added to Call Later");
          Get.to(
            HomePage(),
          );
        } else {
          FirebaseFirestore.instance
              .collection('USER_RESPONSE')
              .doc(UID)
              .collection('userResponse')
              .doc(phoneNumber)
              .set({
            'contactNumber': phoneNumber,
            'sector': 'Call Later',
            'emailId': '',
            'customerName': 'Unknow',
            'organisation': '',
            'website': '',
            'whatsappNo': '',
            'date': dateToCall,
            'time': timeTocall,
          });
          FirebaseFirestore.instance
              .collection('USER_RESPONSE')
              .doc(UID)
              .collection('userResponse')
              .doc(phoneNumber)
              .collection('response')
              .doc()
              .set({
            'date': DateFormat.yMd().format(DateTime.now()),
            'time': DateFormat.jm().format(DateTime.now()),
            'response':
                'Customer Suggest to Call Later at $dateToCall $timeTocall'
          });
          Fluttertoast.showToast(msg: "Number Added to Call Later");
          Get.to(
            HomePage(),
          );
        }
      });
    } else {
      FirebaseFirestore.instance.collection('USER_RESPONSE').doc(UID).set({
        'employeeName': 'Your Name',
        'branch': 'Branch Location',
        'number': 'dailing number',
        'uid': UID
      });
      FirebaseFirestore.instance
          .collection('USER_RESPONSE')
          .doc(UID)
          .collection('userResponse')
          .doc(phoneNumber)
          .get()
          .then((docSnapshot) {
        if (docSnapshot.exists) {
          FirebaseFirestore.instance
              .collection('USER_RESPONSE')
              .doc(UID)
              .collection('userResponse')
              .doc(phoneNumber)
              .update({
            'sector': 'Call Later',
            'date': dateToCall,
            'time': timeTocall,
          });
          FirebaseFirestore.instance
              .collection('USER_RESPONSE')
              .doc(UID)
              .collection('userResponse')
              .doc(phoneNumber)
              .collection('response')
              .doc()
              .set({
            'date': DateFormat.yMd().format(DateTime.now()),
            'time': DateFormat.jm().format(DateTime.now()),
            'response':
                'Customer Suggest to Call Later at $dateToCall $timeTocall'
          });
          Fluttertoast.showToast(msg: "Number Added to Call Later");
          Get.to(
            HomePage(),
          );
        } else {
          FirebaseFirestore.instance
              .collection('USER_RESPONSE')
              .doc(UID)
              .collection('userResponse')
              .doc(phoneNumber)
              .set({
            'contactNumber': phoneNumber,
            'sector': 'Call Later',
            'emailId': '',
            'customerName': 'Unknow',
            'organisation': '',
            'website': '',
            'whatsappNo': '',
            'date': dateToCall,
            'time': timeTocall,
          });
          FirebaseFirestore.instance
              .collection('USER_RESPONSE')
              .doc(UID)
              .collection('userResponse')
              .doc(phoneNumber)
              .collection('response')
              .doc()
              .set({
            'date': DateFormat.yMd().format(DateTime.now()),
            'time': DateFormat.jm().format(DateTime.now()),
            'response':
                'Customer Suggest to Call Later at $dateToCall $timeTocall'
          });
          Fluttertoast.showToast(msg: "Number Added to Call Later");
          Get.to(
            HomePage(),
          );
        }
      });
    }
  });
}

//Employee Profile............................................................
editEmployeeProfile(
    uid, nameController, branchController, phonenumberController) async {
  await FirebaseFirestore.instance.collection('USER_RESPONSE').doc(uid).update({
    'employeeName': nameController,
    'branch': branchController,
    'number': phonenumberController,
  });
  Get.back();
  Fluttertoast.showToast(msg: "Profile edited");
}
