import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/homePage.dart';
import 'loginPage.dart';

class authPage extends StatelessWidget {
  const authPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //Login แล้วไปหน้า homepage
            return homePage();
          } else {
            //Not Login กลับหน้า login
            return loginPage();
          }
        },
      ),
    );
  }
}
