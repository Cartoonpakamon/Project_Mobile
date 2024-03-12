//main
import './authPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MaterialApp(

    debugShowCheckedModeBanner: false, //คำสั่งเอาเครื่องหมายDebugมุมขวาออก
    home: authPage(), //เริ่มrunappพาไปหน้าauthPage

  ));
}



