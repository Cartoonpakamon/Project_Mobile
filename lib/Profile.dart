import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile_user extends StatelessWidget {
  Profile_user({super.key});
  final user =
      FirebaseAuth.instance.currentUser; //บอกว่าปัจจุบัน user คนไหนใช้งาน

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 0, 111), // สีพื้นหลัง AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.grey[300], // สีพื้นหลังของไอคอนผู้ใช้
              child: Icon(
                Icons.person, // ใช้ Icon แสดงไอคอนผู้ใช้
                size: 150,
                color: Colors.white, // สีไอคอนผู้ใช้
              ),
            ),
            SizedBox(height: 20),
            Text(
              '${user!.email}', // แสดงอีเมลว่ากำลังใช้emailไหนในการlogin
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            // รายละเอียดชื่อ 
            Text(
              'Full Name: John Doe',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54, // ตั้งค่าสีข้อความ
              ),
            ),
            Text(
              // รายละเอียดเบอร์โทร
              'Tel: 012-2345-678',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54, // ตั้งค่าสีข้อความ
              ),
            ),
            
            // รายละเอียดวันเดือนปีเกิด
            Text(
              'Birthday: 20 November 2000',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54, // ตั้งค่าสีข้อความ
              ),
            ),
            Text(    // รายละเอียดอื่นๆ เช่น ชื่อ ที่อยู่ เป็นต้น
              'Address: 123 Street, City, Country',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54, // ตั้งค่าสีข้อความ
              ),
            ),
          ],
        ),
      ),
    );
  }
}