import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:tsr_management/Pages/response_page.dart';
import 'package:tsr_management/componet_design/appbar.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  void login(String email, password) async {
    try {
      Response response = await post(
          Uri.parse('https://reqres.in/api/register'),
          body: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        print('Acc Created');
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarDesign(title: 'Login/Signup'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter mail',
            ),
          ),
          SizedBox(
            height: 25,
          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter password',
            ),
          ),
          SizedBox(
            height: 25,
          ),
          ElevatedButton(
              onPressed: () {
                login(emailController.text.toString(),
                    passwordController.text.toString());
              },
              child: Text('Sign In'))
        ],
      ),
    );
  }
}
