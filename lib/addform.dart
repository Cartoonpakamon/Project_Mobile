import 'package:login/database.dart';
import 'package:login/model.dart';
import 'package:flutter/material.dart';

class addForm extends StatefulWidget {
  @override
  State<addForm> createState() => _addFormState();
}

class _addFormState extends State<addForm> {
  appDatabase db = appDatabase();

  final titleControllor = TextEditingController();
  final conversationControllor = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //--ตำแหน่งAppbar--//
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 0, 111),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 45),
            child: Text(
              'New Post!',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            child: Column(
              children: [
                Text(
                  "what's in your mind?",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                    controller: titleControllor,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: ' a title',
                      border: InputBorder.none,
                      icon: Icon(Icons.title),
                    ),
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
                  child: TextFormField(//ช่องกรอกข้อความ
                    controller: conversationControllor,
                    maxLines: 15,//จำนวนแถว
                    decoration: InputDecoration(
                      hintText: "what's in your mind?",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //-เมื่อกดปุ่มElevatedButton จะเรียกใช้ฟัง์ชั่นinsertเพื่อเก็บข้อมูล-//
                ElevatedButton(
                  onPressed: () {
                    Map input = {
                      'title': titleControllor.text,
                      'conversation': conversationControllor.text
                    };
                    insert(input);
                    Navigator.pop(context);
                  },
                  child: Text('Post'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
//--ฟ้งก์ชั่นinsert รับข่อมูล--//
  void insert(Map input) async {
    topicModel data = topicModel(
      title: input['title'],
      conversation: input['conversation'],
    );
    await db.insertData(data);
  }
}
