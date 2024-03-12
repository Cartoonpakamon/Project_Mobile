import 'package:flutter/material.dart';
import 'package:login/database.dart';
import 'package:login/model.dart';
class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<topicModel>? _topics;
  List<bool> _heartStates = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final db = appDatabase();
    final topics = await db.getAllData();
    setState(() {
      _topics = topics;
      _heartStates = List.generate(topics.length, (_) => false);
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              'Timeline',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 0, 111),
      ),
      body: _topics != null && _topics!.isNotEmpty
          ? ListView.builder(
              itemCount: _topics!.length * 2 -
                  1, // ปรับจำนวนรายการใน ListView เพื่อใส่ Divider
              itemBuilder: (context, index) {
                if (index.isOdd) {
                  // แสดง Divider ระหว่างโพสต์
                  return Divider(
                    thickness: 1,
                    color: Colors.grey[300],
                  );
                }
                final topicIndex = index ~/ 2;
                final topic = _topics![topicIndex];
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topic.title,//แสดงข้อความที่เก็บไว้ในtitle//
                        style: TextStyle(fontWeight: FontWeight.bold), //กำหนดให้เป็นตัวหนา
                      ),
                      Text(
                        topic.conversation, //แสดงข้อความที่เก็บไว้ในconversation//
                      ),
                      Text(
                        'Posted at: ${DateTime.now().toString()}', //--บอกเวลาที่post--//
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [ //
                      IconButton(
                        icon: Icon(Icons.favorite),
                        color: _heartStates[topicIndex]
                            ? Color.fromARGB(255, 255, 0, 0) //กดแล้วสีแดง
                            : Color.fromARGB(255, 73, 73, 73), //ตอนยังไม่กดอะไรสีดำ
                        onPressed: () {
                          setState(() {
                            _heartStates[topicIndex] =
                                !_heartStates[topicIndex];
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            )
            //ถ้ายังไม่มีข้อมูลจะขึ้นว่า "No data"
          : Center(
              child: _topics == null
                  ? CircularProgressIndicator()
                  : Text('No data'),
            ),
    );
  }
}