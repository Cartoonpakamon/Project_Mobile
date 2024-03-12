import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class registPage extends StatefulWidget {
  const registPage({super.key});

  @override
  State<registPage> createState() => _registPageState();
}

class _registPageState extends State<registPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async {
    showDialog(context: context, builder: (context){
      return new Center(child: CircularProgressIndicator(),
      );
    });
    try { // เข้า try ไปเช็คว่า password กับ confirmPassword ตรงกันไหม ถ้าตรง ก็สร้างแล้ว pop ไม่ตรง print Password dont match ถ้าเกิด error ตรง if เข้า catch แล้ว print e.message 
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email : emailController.text,
          password : passwordController.text,
        );
        Navigator.pop(context);
      } else {
        print('Password Dont\'t match');
      }
    } on FirebaseException catch (e) {
      print(e.message);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //--AppBar อยู่ตรงนี้--//
      appBar: AppBar(
        title: Center(
          child:
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text('REGISTER', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)), //ขอความREGISTERตรงappbarกำหนดให้เป็นตัวหนา
                ),
              ),
        ),
        backgroundColor: Color.fromRGBO(255, 38, 88, 1), //สีappbar
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              Center(
                  child: Text(
                'Create accout',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 237, 0, 75)),
              )),
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    //--ช่องกรอกEmail--//
                    TextFormField(
                      controller: emailController,
                      autofocus: true,
                      decoration:  InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30) //-ทำขอบให้เป็นวงกลม
                        ),
                        labelText: 'Email', //แสดงข้อความemail
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return 'กรุณากรอก email'; //ถ้าไม่กกรอกจะแจ้งเตือนขึ้นมา
                      },
                    ),
                    SizedBox(height: 15),//ระยะห่าง
                    //--ช่องกรอกpassword--//
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration:  InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)//-ทำขอบให้เป็นวงกลม
                        ),
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return 'กรุณากรอกรหัสผ่าน';  //ถ้าไม่กกรอกจะแจ้งเตือนขึ้นมา
                      },
                    ),
                    SizedBox(height: 15),
                    //--ช่องตรวจสอบpassword--//
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)//-ทำขอบให้เป็นวงกลม
                        ),
                        labelText: 'Confirm Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return 'กรุณากรอกรหัสยืนยัน'; //ถ้าไม่กกรอกจะแจ้งเตือนขึ้นมา
                      },
                    ),
                    SizedBox(height: 20),
                    //--เมื่อกดปุ่มElevatedButton จะเรียกใช้ฟังก์ชั่นsign up--//
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signUserUp();
                        }
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(255, 38, 88, 1)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}