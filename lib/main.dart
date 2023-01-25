import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tsr_management/Auth/auth.dart';
import 'package:tsr_management/Pages/home_page.dart';
import 'package:tsr_management/Pages/response_page.dart';
import 'package:tsr_management/componet_design/appbar.dart';
import 'package:tsr_management/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TSR',
      theme: ThemeData(
          //primarySwatch: Colors.brown.,
          //scaffoldBackgroundColor: Colors.tealAccent,
          ),
      home:
          //AuthPage(),
          HomePage(),
      // ResponsePage(contactNumber: '7619129190',),
    );
  }
}
