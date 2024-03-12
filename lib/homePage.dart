
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/addform.dart';
import 'package:login/database.dart';
import 'package:login/model.dart';
import 'package:login/swipe_card_page.dart';
import 'package:login/updateForm.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:login/Timeline.dart';
import 'package:login/Profile.dart';



appDatabase db = appDatabase();

class homePage extends StatefulWidget {

  homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();

}
class _homePageState extends State<homePage> {

   @override
   
  int screenIndex = 0;
  final user = FirebaseAuth.instance.currentUser;

    final mobileScreens = [
    //home(),
    SwipeCardPage(),
    search(),
    Timeline(),
    Profile_user(),
    ];

      void signUserOut() {
      FirebaseAuth.instance.signOut();
  }
void initState() {
  super.initState();
  
}
   @override
  Widget build(BuildContext context) {
    return Scaffold(

      //AppBarอยู่ตรงนี้//
      appBar: AppBar(
        title: Center( //กำหนดให้ข้อความอยู่ตรงกลาง
          child: Padding(
            padding: const EdgeInsets.only(left: 35),//กำหนดให้ขยับไปด้านขวา อยากให้ไปด้านไหนให้ใส่ตรงข้าม
            child: Text(
              'LANITY', //ข้อตวามที่กำหนด
              style: TextStyle(
                color: Color.fromARGB(255, 252, 0, 105), //สีข้อความ
                fontSize: 20, //ขนาดข้อความ
                fontWeight: FontWeight.bold, //ทำให้ข้อความเป็นตัวหนา
                fontFamily: 'MadimiOne'
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              signUserOut();
            },
            icon: Icon(
              Icons.logout, //เมื่อกดIcons logout จะเรียกใช้ฟังก์ชั่นsignUserOut แล้วกลับไปยังหน้าlogin
              color: Color.fromARGB(255, 255, 0, 111), //สีicon
            ),
          ),
        ],
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),

     //floatingActionButton ที่ทำหน้าที่addข้อมูลอยู่นี่//
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: ((context) => addForm()))) //เมื่อกดกแล้วพาไปหน้าaddForm
      .then((_) {
        setState(() {
          screenIndex = 0; // Reset screenIndex after returning from addForm screen
        });
      });
  },
  child: Icon(Icons.add,color: Colors.white,), //ตรงไอคอนรูป + กำหนดให้เป็นสีขาว
  shape: CircleBorder(), //รูปร่างfloatingActionButton กำนหนดให้เป็นวงกลม
  backgroundColor: Color.fromARGB(255, 255, 0, 111), //ใส่สีปุ่มสีชมพู
  mini: true, // ตั้งค่าเป็น true เพื่อลดขนาดของปุ่ม
),

      //ส่วนของBodyอยู่ตรงนี้//
      body: mobileScreens[screenIndex >= mobileScreens.length ? 0 : screenIndex],//กำนหนดว่าถ้ากดปุ่มไหนจะเรียงตามหน้าindexที่กำหนดไว้ในmobileScreensด้านบน
      bottomNavigationBar: CurvedNavigationBar(//ใช้CurvedNavigationBaเมื่อกกดแล้วจะเป็นคลื่น
        backgroundColor: Color.fromARGB(255, 255, 255, 255), //สีของด้านหลังปุ่มที่กดเลือก
        color: Color.fromARGB(255, 255, 0, 111), // สีของ navigation bar
        buttonBackgroundColor: Color.fromARGB(255, 255, 255, 255), // พื้นหลังปุ่มกำหนดให้เป็นสีขาว
        height: 50, // ความสูงของ navigation bar
        items: <Widget>[ //กำนหดไอคอนในbottomNavigationBarว่ามีอะไรบ้าง
          Icon(Icons.home, size: 30), //ไอคอนบ้าน
          Icon(Icons.search, size: 30),//ไอคอนค้นหา
          Icon(Icons.schedule, size: 30),//ไอคอนTiming
          Icon(Icons.person, size: 30),//ไอคอนคน
        ],
        onTap: (index) {
          setState(() {
            screenIndex = index; //เมื่อกดแล้วจะพาไปยังindexที่กำหนดไว้
          });
        },
      ),
    );
  }
}

//หน้าsearch//
class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<topicModel>>(
          future: db.getAllData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: ((context, index) {
                  topicModel topic = snapshot.data![index]; //เรียกtopicModel เพื่อแสดงข้อมูลที่อยู่ในนั้น
                  return GestureDetector(
                    onTap: () {},
                    child: ListTile(
                     leading: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Icon(Icons.person, color: Colors.white),
                      ),// ไอคอนรูปคนในหน้าSearch

                      title: Text('${topic.title}'), //ข้อความที่เก็บในtopic.title
                      subtitle: Container(
                          alignment: Alignment.topLeft,//ชิดซ้าย
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('${topic.conversation}'),//ข้อความที่ถูกเก็บในtopic.conversation
                            ],
                          )),
                      trailing: Container(
                        width: 70,
                        child: Row(
                          children: [
                            Expanded(
                              child: IconButton(
                                    onPressed: () {
                                    Navigator.push( 
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => updateForm(), //พาไปหน้าupdateForm เมื่อกดicon edit
                                          settings:
                                              RouteSettings(arguments: topic)),
                                    ).then((_) {
                                      setState(() {
                                        db.getAllData();
                                      });
                                    });
                                  },
                              icon: Icon(
                                Icons.edit,
                                color: const Color.fromARGB(255, 0, 151, 5),
                               
                              ),
                            ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                                child: IconButton(
                                    onPressed: () {
                                      //---- เรียกฟังก์ชันชื่อ deleteDialog ด้านล่าง ----
                                      deleteDialog(topic); //ลบข้อมูลเมื่อกดปุ่ม
                                      setState(() {
                                        db.getAllData();
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: const Color.fromARGB(255, 255, 17, 0),
                                    ),),
                                    ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              );
            } else {
              return Text('No data');
            }
          }),
    );
  }

  //-------------- ฟังก์ชันแสดง popup เพื่อยืนยันการลบข้อมูล --------------
  deleteDialog(topicModel model) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Are you sure to delete?'), //เมื่อกดจะpop upขึ้นมาถามก่อนว่าจะลบจริงๆใช่มั้ย
            actions: [
              TextButton(
                  onPressed: () {
                    db.deleteData(model);
                    setState(() {
                      db.getAllData();
                    });
                    Navigator.pop(context);
                  },
                  //----- ปุ่ม Delete -----
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  ),
              //----- ข้อความคำว่า Cancle -----
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancle',
                    style: TextStyle(color: Colors.green),
                  ))
            ],
          );
        });
  }
}