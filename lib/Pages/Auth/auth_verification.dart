import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tsr_management/Pages/dailer_page.dart';
import 'package:tsr_management/Pages/home_page.dart';
import 'package:tsr_management/componet_design/appbar.dart';

class AuthVerification extends StatefulWidget {
  final String verificationId;
  AuthVerification({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<AuthVerification> createState() => _AuthVerificationState();
}

class _AuthVerificationState extends State<AuthVerification> {
  final verficationCodeController = TextEditingController();
  final auth = FirebaseAuth.instance;
  String uid = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verification'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/verification.jpg'),
            SizedBox(
              width: 250,
              child: TextFormField(
                maxLines: 1,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 4),
                textAlign: TextAlign.center,
                maxLength: 6,
                keyboardType: TextInputType.phone,
                controller: verficationCodeController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 5)),
                    hintText: 'Verfication Code',
                    hintStyle: TextStyle(fontSize: 15)),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () async {
                final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: verficationCodeController.text.toString());
                try {
                  await auth.signInWithCredential(credential);
                  
                  Get.to(HomePage());
                } catch (e) {
                  Fluttertoast.showToast(msg: "somethig went wrong");
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.indigoAccent.shade100,
                ),
                height: 55,
                width: MediaQuery.of(context).size.width / 2,
                child: Center(
                    child: Text(
                  'Verify Me',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
