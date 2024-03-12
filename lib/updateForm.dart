import 'package:flutter/material.dart';
import 'package:login/model.dart';
import 'package:login/database.dart';

class updateForm extends StatefulWidget {
  @override
  State<updateForm> createState() => _updateFormState();
}

class _updateFormState extends State<updateForm> {
  appDatabase db = appDatabase();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as topicModel;

    final titleController = TextEditingController(text: data.title);
    final conversationController = TextEditingController(text: data.conversation);
    return Scaffold(

      //--   AppBar   --//
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 0, 111),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Text(
              'Edit Conversation',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView( //ทำให้เลื่อนได้
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  "what's in your mind?",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Container(
                  width: 370,
                  padding: EdgeInsets.fromLTRB(30, 0, 50, 0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(219, 216, 216, 1),
                    borderRadius: BorderRadius.circular(10.0), //ปรับมุมขอบให้มน
                  ),
                  child: TextFormField(
                    controller: titleController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Add a title',
                      icon: Icon(Icons.title),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'กรุณากรอกหัวเรื่อง'; //ถ้าเป็นค่าว่างจะแสดงข้อความให้กรอก
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 370,
                  padding: EdgeInsets.fromLTRB(30, 0, 50, 0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(219, 216, 216, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextFormField(
                    maxLines: 15, //จำนวนบรรทัด
                    controller: conversationController,
                    decoration: InputDecoration(
                      hintText: 'Start a new conversation', //ข้อความแสดง
                      border: InputBorder.none,
                    ),
                    //ตรวจสอบการกรอกข้อมูลใน textfield
                    validator: (value) {
                      if (value!.isEmpty) return 'Please add a conversation'; //ถ้าข้อมูลว่างแจ้งให้กรอกข้อความ
                      if (value!.length < 6) //ถ้าความยาวน้อยกว่า6ให้กรอกใหม่่ 
                        return 'Too short, length more than 6';
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(height: 20),

                //-- เมื่อกดปุ่มจะทำการเรียกใช้ฟังก์ชั่นUpdate เพื่ออัปเดทข้อมูล--//
                ElevatedButton(
                  onPressed: () {
                    Map input = {
                      'id': data.id,
                      'title': titleController.text,
                      'conversation': conversationController.text
                    };
                    if (formKey.currentState!.validate()) {
                      update(input);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//--  ฟังก์ชั่น Update --//
  void update(Map input) async {
    topicModel data = topicModel(
        id: input['id'],
        title: input['title'],
        conversation: input['conversation']);
    await db.updataData(data);
  }
}