import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/forgotPasswordPage.dart';
import './registPage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController(); //เอาไว้ใส่email
  final passwordController = TextEditingController(); //เอาไว้ใส่ password

  Future<UserCredential> signInWithGoogle() async {
    // ---------------- ของ Google
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void signUserIn() async {
    showDialog(
        context: context,
        builder: (context) {
          //ให้แอปหมุนๆรอ
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      //try catch ถ้ากรอกถูกไป try กรอกผิดไป catch
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        //e เป็นอะไรก็ได้ เอาไว้เก็บ error .code เอาไว้ดูโค้ดที่แอปส่งกลับมาว่าขึ้นว่าอะไร ถ้าขึ้น user not found (ต้องไปเช็คเอาว่าปัจจุบัน code error มีอะไรบ้าง) แต่ตอนนี้ใช้แบบนี้ก่อน
        print('No user found for this email.');
      } else if (e.code == 'worng password') {
        print('Worng password provided for this user');
      }
    }
    Navigator.pop(
        context); // pop กลับไปหน้า auth แล้วถ้า login เสร็จแล้วหน้า auth จะเปลี่ยนไป
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        hexStringToColor("CB2B93"),
        hexStringToColor("9546C4"),
        hexStringToColor("5E61F4")
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
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
                        image: AssetImage('assets/images/logo2.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: TextFormField(
                      controller: emailController,
                      autofocus: true,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        icon: Icon(Icons.mail, color: Colors.white),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20.0),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return 'กรุณากรอก email';
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0), // ระยะห่างภายนอก
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock, color: Colors.white),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 20.0), // ระยะห่างภายในช่องใส่ข้อความ
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return 'กรุณากรอกรหัสผ่าน';
                      },
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => forgotPasswordPage()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Text('Forgot Password?',
                              style: TextStyle(color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        signUserIn(); //ผู้ใช้กดปุ่ม login แล้วเรียกใช้ signUserIn
                      } //ไว้สำหรับเช็คว่าผู้ใช้กรอกหรือยัง
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 82, 122, 1)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text('Or continue with', style: TextStyle(color: Colors.white)),
            SizedBox(height: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    signInWithGoogle();
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Color.fromRGBO(255, 82, 122, 1),
                    child: Icon(Icons.mail_outline, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => registPage()));
                    },
                    child: Text(
                      'Register now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

//ทั้งหมดนี่คือคำสั่งสีพื้นหลัง3เฉดสีหน้าlogin
hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}
