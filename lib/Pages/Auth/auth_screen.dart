import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tsr_management/Pages/Auth/auth_verification.dart';
import 'package:tsr_management/componet_design/appbar.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final numberContaroller = TextEditingController();

  bool loading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Authentication'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/auth.png'),
            Padding(
              padding: const EdgeInsets.only(right: 25, left: 25),
              child: IntlPhoneField(
                controller: numberContaroller,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'IN',
              ),
            ),
            SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                auth.verifyPhoneNumber(
                    phoneNumber: '+91' + numberContaroller.text,
                    verificationCompleted: (_) {},
                    verificationFailed: (e) {
                      Fluttertoast.showToast(msg: 'failed');
                    },
                    codeSent: (String verificationId, int? token) {
                      Get.to(AuthVerification(verificationId: verificationId));
                    },
                    codeAutoRetrievalTimeout: (e) {
                      Fluttertoast.showToast(msg: e, timeInSecForIosWeb: 20);
                    });
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
                  'Send OTP',
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
