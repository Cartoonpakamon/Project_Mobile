import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class forgotPasswordPage extends StatefulWidget {
  const forgotPasswordPage({super.key});

  @override
  State<forgotPasswordPage> createState() => _forgotPasswordPageState();
}

class _forgotPasswordPageState extends State<forgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  Future passwordReset() async {
    //ส่งข้อมูลสำหรับ ส่ง password
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Text('RESET PASSWORD',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 0, 111), // สีapp bar
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  margin: EdgeInsets.only(top: 30, bottom: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[10],
                    shape: BoxShape.circle, 
                  ),
                  child: ClipOval(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo2.png'), //รูปที่ใส่
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Enter your email to get a password reset link',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    //--เป็นช่องให้กรอกEmailที่ต้องการให้ส่งคำขอลืมรหัสผ่าน--//
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0), //กำหนดให้ขอบปรับเป็นวงกลม
                        ),
                        labelText: 'Your email',
                      ),
                      validator: (value) { 
                        if (value!.isEmpty) return 'กรุณากรอก email'; //ถ้าไม่ใส่อะไรจะแจ้งเตือนให้กรอกกEmail
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        passwordReset(); //เมื่อกดปุ่มแล้วจะใช้ฟังก์ชั่นpasswordResetที่อยู่ด้านบน
                      },
                      child: Text(
                        'Reset Password',
                        style: TextStyle(color: Colors.white), //ข้อความReset Passwordในปุ่มเป็นสีขาว
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Color.fromARGB(255, 255, 0, 111)), //สีปุ่ม
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}